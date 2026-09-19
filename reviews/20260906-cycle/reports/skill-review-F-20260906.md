# Duty-6 Reviewer F (TOOLS-CODE) — re-dispatch report (re-persisted 2026-09-06; original persist claim was phantom, recovered verbatim via wait_agent id be306274)

Scope: tools/ (+ lib/, tests/run.sh waiter section), cross-checked vs SKILL.md §Tool table, RC-CONTRACT.md, editor.md item 10, supervisor.md W4. Read-only. Note: the lost round's phrasing was imprecise — the silent-orphan JSON that fails to parse is the waiter's own status record + arm journal line (raw printf interpolation), NOT the polled run's JSON (that path fails loud, finding 9).

## Findings

**1. HIGH — oc-waiter arm builds the status record by raw printf interpolation; one JSON metacharacter in --label corrupts the record at birth, waiter silently orphans.** oc-waiter:161-162 printf with "$LABEL" unvalidated/unescaped. `--label 'fix "x"'` → invalid JSON → every downstream jq read returns empty (oc-waiter:184-187) → poll runs with empty args rc 2 → FAILED journal line goes to hidden `.jsonl` (ID empty) → rec_upd can never update → status:"armed" forever; sweep skips (oc-waiter:278-279, .status null), list prints null, owner never woken. Fix: jq -n --arg record build + selftest case with quotes in --label.

**2. HIGH — rec_upd swallows every record-update failure** (lost-round defect b). oc-waiter:253-256: `|| rm -f "$tmp"` — no stderr, no journal, no fallback. Lost write (full disk, corrupt input) leaves running-looking record while child exited 4; every status transition (oc-waiter:193,196,232,238,241,248,291) can be silently lost. Fix: record-update-failed journal line + stderr + retry once.

**3. MED — arm prints success receipt with record write, journal create, and child launch all unchecked — the false-receipt class the header claims is impossible.** oc-waiter:161-170: no || checks; child dies instantly at :182 usage (exit 2, no journal line, no record) while arm printed "armed id=" exit 0. Header oc-waiter:25-27 claim is false via this path; mitigation is prose (:174), not a check. No liveness self-check of the setsid child. Fix: hard-fail arm rc 3 on write errors + kill -0 child before printing receipt.

**4. MED — sweep exits rc 1 "reported" even when the ORPHANED wake failed to deliver.** oc-waiter:293-294 `|| true` on both notify calls; failed delivery = nobody woken, no wake-failed marker. Fix: wake-failed in record+journal + unconditional HQ escalation.

**5. MED — rc-2/4/7 branch continues past LAST_RC=$RC, so stall counter counts non-identical polls as consecutive.** oc-waiter:219-222 vs :227-228: sequence 5,4,5,4,5,5… keeps incrementing LAST5 across lock-busy/transport failures; STALL_K can escalate a waiter whose in-flight reads were not consecutive. Fix: set LAST_RC before the continue.

**6. MED (table divergence) — oc-waiter has no row in SKILL.md §Tool table** (:46-83), while editor.md:128-130 declares it THE standard, supervisor.md W4, RC-CONTRACT.md:54, run.sh:552-558 reference it. Lane reading only SKILL.md sees no detached-wait tool. Fix: add row.

**7. MED (rc collision) — oc-deploy --notify-session missing value exits 2 (oc-deploy:1664), off-register — collides with the rc 2 ship-verdict code** (RC-CONTRACT.md:31; every other usage error is die 1). Fix: die 1.

**8. LOW — jline broken-extra fallback degrades silently, no marker** (oc-waiter:100-102): malformed extra drops payload, journal reads complete. Fix: jq --arg extras + "degraded":true marker.

**9. LOW — selftest gaps vs documented interface** (do_selftest oc-waiter:312-437): no corrupt-record case, no metachar --label, no rec_upd failure, no .status:null sweep — exactly findings 1-2 paths; run.sh:555-558 asserts only usage-rc + list. (Contrast verified clean: oc-prchecks polled-run JSON fails loud — exit 4/7.)

**10. LOW — sweep writes state before journal line, inverting journal-first law** (oc-waiter:291-292). Fix: swap.

**Verified clean:** rc register matches RC-CONTRACT.md:54 in code (arm 0/2/3, _run 0/4, sweep 0/1/3, list 0, --help rc 0); full-sha law, uuid charset gate, dynamic stall-k, --interrupt single-retry all as documented; all tools source lib/oc-log.sh; lib/oc-embed.sh + lib/oc-log.sh sound; SKILL.md rows for oc-prchecks --fault-scope PR, oc-job-verify --identity-only, oc-attrib, oc-deploy poll all match behavior.

## Verdict
Lost round's two oc-waiter defects CONFIRMED and pinned: silent-orphan = quoting defect (finding 1) + unchecked write/launch behind false "armed id=" receipt (finding 3) + swallowed signals (2, 4); update-failures-swallowed = 2. None caught by selftest (9). Two register divergences (6, 7). Spread: 2 HIGH, 5 MED, 3 LOW. Recommendation: findings 1-3 land together (jq-built record + checked writes + launch self-check + selftest cases) before the next waiter-bearing cycle; 4-7 independent small fixes.
