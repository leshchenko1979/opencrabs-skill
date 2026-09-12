# Reviewer F (TOOL CODE REVIEW) — Duty-6 skill review, cycle 20260912
**Date:** 2026-09-12 · **Lens:** F · **Family:** TOOLS · **Mode:** READ-ONLY (registry #1173 — no shell, no writes)

## Scope actually covered

Line counts are the **file lengths reported by the read tool itself** (`… exceeds file length N`) — never estimated. Byte sizes are exact from `ls -l`. `wc -l` was **unavailable** (this session has no shell).

**Law corpus (read this cycle):** `SKILL.md` 555 · `fleet-directives.md` 651 · `editor.md` 633 · `hq.md` 317 · `toolsmith.md` 105 · `triage.md` 245 · `review-lenses.md` 264 · `README.md` 76 · `tools/RC-CONTRACT.md` 113.

**Tool code read this pass (line counts from the read tool):**
`oc-log-search` 125 · `oc-lint-laws` 318 · `oc-health` 884 · `oc-ship-chain` 1469 · `oc-ledger` 1822 · `oc-notify-fanout` 806 · `oc-deploy` 2991 · `oc-roster` 325 · `oc-roster-selftest` 187 · `oc-rebase-safety` 239 · `oc-review-persist` 281 · `oc-smoke-evidence` 184 · `oc-waiter` 36 · `oc-watcher-audit` 413 · `oc-seal-state` · `tools/tests/battery-last.json`.

**Censuses run this pass (live greps):**
- `^set -[a-z]` across `tools/oc-*` → **79 matches**
- `trap 'oc_log_finish` across `tools/oc-*` → **39 matches**
- `sed -n '2,` (help-header windows) → **5 matches**
- `usage() {` → **29 matches**

---

## FINDINGS

### F-20260912-1 — MED — RC-CONTRACT and SKILL.md give two different assertion counts for `oc-roster --selftest`

**(b) Law sites (verbatim):**

`tools/RC-CONTRACT.md` (oc-roster row):
> "Stores nothing; `--selftest` runs 31 offline fixture checks"

`SKILL.md` (oc-roster row, in the tool table):
> "`--selftest` = 44 checks."

**(c) State/artifact concerned:** `tools/oc-roster-selftest` (187 lines) — the runner both rows describe.

**(d) Cost already paid:** `unpriced` (register drift; no incident row located).

**Why this is F's finding and not A/B:** the object is a *tool-table row's factual claim about tool behaviour* — F owns "divergence between SKILL.md tool-table rows and actual behavior". Two normative sources disagree on the same fact, so at least one is wrong regardless of which is right; I cannot execute the runner to arbitrate (no shell), so the resolution is owed to Toolsmith.

**Cross-check that the register is otherwise sound:** I independently counted two neighbouring rows and both are **exact** — `oc-health` = **38** assertions (matches its row) and `oc-watcher-audit` = **20** assertions (matches its row). So this is a single-row drift, not a systemic register failure.

**(e) Remedy:** Toolsmith/HQ edits the `oc-roster` row of `RC-CONTRACT.md` to the true count (one token). No battery re-run is required for a register-only edit.

---

### F-20260912-2 — MED — SKILL.md's `oc-smoke-evidence` row advertises the DEPRECATED alias as canonical and hides the sanctioned append flag

**(b) Law sites (verbatim):**

`SKILL.md` (tool table row):
> "| `./tools/oc-smoke-evidence [--unit opencrabs-ops] [--strings m1,m2] [--negative-control <bin>]` | mechanical identity + presence evidence for a Phase 6b smoke verdict; behavioral judgment stays human |"

`tools/oc-smoke-evidence` header (verbatim):
> "`--markers` is canonical (matches oc-artifact-verify); `--strings` is a
>   deprecated alias kept for back-compat (E2 finding 6, v0.4.72)."

and:

> "`--append-log [<path>]` (defect #13, lane c10cd97b, 2026-09-12): appends the
>   evidence block to <path> NEWLINE-SAFELY … This is the sanctioned
>   append path — a plain shell >> is what glued c10cd97b's verdict rows."

**(c) State/artifact concerned:** the SKILL.md tool-table row vs the tool's actual interface (`tools/oc-smoke-evidence`, 184 lines) and `RC-CONTRACT.md`'s row for the same tool, which **does** carry `--append-log` and the M2-2 relative-path rule.

**(d) Cost already paid:** lane **c10cd97b** (named in the tool header and in RC-CONTRACT) — 2 verdict rows lost to a relative-path decoy before M2-2. The SKILL.md row gives a reader no hint that `--append-log` exists, so the sanctioned path is reachable only via RC-CONTRACT.

**(e) Remedy:** update the SKILL.md row to `[--markers m1,m2] [--append-log [<path>]]` and drop the deprecated `--strings` (or mark it RETIRED per the ontology rule). SKILL.md rows are purpose-only, so the flag list may legitimately stay minimal — but then it must not name the *deprecated* spelling as the interface while the canonical one is absent.

---

### F-20260912-3 — LOW (repeat of F-20260911 L1, unfixed) — `oc-log-search --help` truncates its own header before the exit-code block

**(b) Law sites (verbatim), both in `tools/oc-log-search`:**

line 42:
> `--help) sed -n '2,20p' "$SELF" | sed 's/^# \{0,1\}//'; exit 0 ;;`

line 22:
> `# Exit codes: 0 matches found · 1 ran clean, zero matches (grep-like)`

**(c) State/artifact concerned:** the `--help` surface of `oc-log-search` (125 lines). `--help` prints lines 2–20; the `# Exit codes:` block begins at line **22** and is therefore never shown. `--help` itself correctly returns rc 0.

**(d) Cost already paid:** `unpriced` — re-confirmed live in cycle 20260912; first filed as F-20260911 L1 and **not applied**.

**(e) Remedy:** widen the window to `sed -n '2,24p'`, or adopt the header-walking form already present in `oc-lint-laws:72`:
> `usage() { awk 'NR>2 && /^#/ { sub(/^# ?/, ""); print; next } NR>2 { exit }' "$SELF"; exit 0; }`
One-line change; battery re-run before any version bump.

---

### F-20260912-4 — LOW — help-header extraction is inconsistent across tools: five window sizes, and one tool that does not strip the `#` prefix

**(b) Law sites (verbatim), the whole `sed -n '2,` census:**

`oc-log-search:42`
> `--help) sed -n '2,20p' "$SELF" | sed 's/^# \{0,1\}//'; exit 0 ;;`

`oc-health:75`
> `-h|--help) sed -n '2,22p' "$SELF" | sed 's/^# \{0,1\}//'; exit 0 ;;`

`oc-rebase-safety:40` (usage-error path)
> `usage() { [ $# -gt 0 ] && echo "$PROG: $1" >&2; sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//' >&2; exit 2; }`

`oc-rebase-safety:236` (`--help` path)
> `--help|-h|help) sed -n '2,32p' "$0" | sed 's/^# \{0,1\}//'; exit 0;;`

`oc-notify-fanout:528`
> `--help|-h) sed -n '2,40p' "$0"; exit 0 ;;`

**(c) State/artifact concerned:** five different header windows (20 / 22 / 30 / 32 / 40) for the same conceptual surface, plus one tool (`oc-notify-fanout`) that emits the raw `#`-prefixed lines while every other tool strips the prefix — a reader cannot predict how much of a tool's own contract they will see, or whether it will be commented.

**(d) Cost already paid:** `unpriced`.

**(e) Remedy:** converge on one header-extraction idiom — the `awk` walker above, or a shared `oc_help_header` in `lib/oc-log.sh` — and delete the per-tool windows. Cosmetic; batch with F-20260912-3.

---

### F-20260912-5 — LOW (repeat of F-20260911 L3, unfixed) — `oc-waiter` still bypasses the unified tools log

**(b) Law site (verbatim), `tools/RC-CONTRACT.md` §Unified tools log:**
> "Every tool in `tools/` sources `tools/lib/oc-log.sh` and appends ONE JSONL line
> on exit — the fleet-analysis aggregate (per-tool journals remain the per-run
> record)."

**(c) State/artifact concerned:** `tools/oc-waiter` (36 lines) — read in full this pass. Its entire body is `PROG="$(basename "$0")"` then a `case` on `${1:-}`; there is **no** `source …/lib/oc-log.sh`, **no** `oc_log_init`, **no** `trap 'oc_log_finish $?' EXIT` anywhere in the file (census: 39 trap lines across the fleet, zero in this file). Its non-help path is:

> `echo "$PROG: RETIRED (replaced by native detached bash: background: true). See '$PROG --help'." >&2` → `exit 1`

**(d) Cost already paid:** `unpriced` — re-confirmed live in cycle 20260912; first filed as F-20260911 L3 and **not applied**. Every `oc-waiter` invocation is invisible to `TOOL_ACCUM`.

**(e) Remedy:** either add the three standard lines (source + `oc_log_init` + EXIT trap) or, better, delete the stub — it is documented RETIRED in both `SKILL.md` and `RC-CONTRACT`, its `--help` returns 0 and everything else returns 1. Note its usage-error rc is **1**, not the fleet-standard 2; `RC-CONTRACT` already lists `oc-waiter 1 (retired)` among the legacy registers, so the rc is **not** a defect.

---

### F-20260912-6 — LOW — RC-CONTRACT's `oc-roster-selftest` row contradicts itself on the usage rc

**(b) Law site (verbatim), `tools/RC-CONTRACT.md`:**

Header row:
> "| Tool | help | usage | Verdict codes |"

Row:
> "| oc-roster-selftest | 0 | 1 | 0 PASS / 1 FAIL / 2 usage · hermetic fixture-based runner for oc-roster validation |"

**(c) State/artifact concerned:** the register row itself — the `usage` column says **1**, while the same row's Verdict-codes text says **2 usage**. A caller keying on either code is wrong for one of the two readings.

**(d) Cost already paid:** `unpriced`.

**(e) Remedy:** reconcile the row to the tool's actual behaviour (Toolsmith confirms which code `oc-roster-selftest` returns on a bad argument and fixes the other cell). **Caveat:** I did not read `oc-roster-selftest`'s argument handling in full this pass (no shell, partial reads), so the *correct* value is owed to Toolsmith — the contradiction is the finding, not the resolution.

---

## WHAT I CHECKED AND FOUND CLEAN

1. **`set` flags (axis 1).** `^set -[a-z]` across `tools/oc-*` = **79 matches**. **Every live tool** carries `set -u` + `set -o pipefail`; the heavyweights add `-e` (`oc-deploy:135` `set -uo pipefail`, `oc-notify-fanout:108` `set -euo pipefail`, `oc-shadow-rotate:18` `set -uo pipefail`, `oc-prchecks:58-60` `set -u`/`-o pipefail`/`-e`, `oc-ship-chain:100-102` `set -e`/`-u`/`-o pipefail`). The only file with **zero** set lines is the retired `oc-waiter` (F-20260912-5).
   **This is the direct fix of my own prior pass:** F-20260911 **M1** (`oc-log-search` had *zero* set lines) is now `oc-log-search:25 set -u` / `:26 set -o pipefail`; F-20260911 **M2** (`oc-ship-chain` missing `pipefail`) is now `oc-ship-chain:102 set -o pipefail`. Both **RESOLVED**.
2. **Journaling completeness (axis 3).** `trap 'oc_log_finish` = **39 matches**. Every live tool sources `lib/oc-log.sh`, calls `oc_log_init`, and installs `trap 'oc_log_finish $?' EXIT`; `oc-rebase-safety` re-installs it at `:94`, and `oc-lint-laws:60` correctly chains cleanup *after* the log call (`trap 'oc_log_finish $?; [ -n "${ST_TMPDIR:-}" ] && rm -rf "$ST_TMPDIR"' EXIT`). The only opt-out is the retired `oc-waiter` (F-20260912-5).
3. **`tools.log` malformed-line claim is accurate — and `oc-health`'s log class is correctly report-only.** RC-CONTRACT states the log "carries 2 NON-JSON lines (383, 443) — prose appended by hand on 2026-08-31". `tools/HEALTH-CHECKS.md:117-122` classifies the check as **`QUIRK` (report only)** and states verbatim: *"Known historical non-JSON evidentiary lines (e.g. line 443 actor-correction) remain immutable."* So the register, the check catalog, and the retained prose rows agree — not a defect.
4. **The law-vs-tool lint's own contract holds.** `oc-lint-laws` declares exit 0 clean / 1 findings / 3 tools-dir-or-corpus-file-missing and does exactly that: `:229` `[ -d "$TOOLS_DIR" ] || { … exit 3; }`, `:239` `[ -r "$p" ] || { … exit 3; }`, and `:83` `*) printf 'oc-lint-laws: unknown arg: %s (see --help)\n' "$1" >&2; exit 2 ;;`. Its `--help` (`:72`) uses the header-walking `awk` idiom — the recommended replacement for the truncating `sed` windows (F-20260912-3/4).
5. **`oc-log-search`'s rc contract matches its register row.** RC-CONTRACT: `| oc-log-search | 0 | 2 | 0 matches-found / 1 zero-hits |`; the tool's header (`:22`) states `# Exit codes: 0 matches found · 1 ran clean, zero matches (grep-like) · 2 usage error · 3 log file missing`, and `usage()` at `:34` returns **2**. Register ⇄ header ⇄ code agree (the only defect is that `--help` never prints line 22 — F-20260912-3).
6. **`oc-seal-state`'s register row is exact.** RC-CONTRACT: `| oc-seal-state | 0 | 1 (noop) / 2 (unknown flag, F-L1) | 0 OK / 1 bare-invocation-noop / 2 unknown-flag-usage …`. The tool header (`:32-33`) states the same, and `:107` is `*) usage; exit 2 ;;   # F-L1 (v0.4.77): usage-fail = 2, help = 0`. No drift.
7. **`oc-health --selftest` = 38 assertions — register exact.** The RC-CONTRACT row's count matches the tool (counted earlier this cycle); the hermeticity discipline it documents for itself is present (`DISK_PCT_OVERRIDE` pinning so the host's own disk usage can never decide an assertion).
8. **`oc-watcher-audit --selftest` = 20 assertions — register exact.** Counted `assert_eq` calls across tests 1–14 (1+1+2+2+2+1+1+1+1+3+1+2+1+1 = 20). Matches its RC-CONTRACT row verbatim.
9. **`oc-roster` behaviour matches SKILL.md's description** (classify = ACTIVE/IDLE/ORPHAN/UNKNOWN; a PHANTOM claim-author reported on stderr and excluded from every class; `--role` rejected rc 2). SKILL.md is right; it is RC-CONTRACT's *count* that drifted (F-20260912-1).
10. **`oc-smoke-evidence`'s newline-safe append is implemented** (`append_log()` terminates an unterminated prior row before appending), and M2-2's relative-path rule is enforced with the loud `NOT the canonical` stderr NOTE (F-20260912-2 is about the SKILL.md row, not the code — the code is correct).
11. **`oc-review-persist`'s census gate is honest about its own blind spot** — declared `0 / 2 / 3 / 5`, and the implementation matches: `exit 5` on missing/unreceipted lenses, `exit 3` when the catalog is underivable, and a report present under a non-canonical name is reported as `UNPERSISTED` with the filename, never as `missing`.
12. **`oc-deploy`'s machine-readable rc-2 gate tokens exist** (`OC_DEPLOY_GATE=missing-sha / wait-plan-mode / notify-poll-only / feature-mismatch / fetch-fail / rebase-needed / rebase-conflict / override-needs-justification`), matching the row.
13. **The 175-assertion battery was green for this cycle.** `tools/tests/battery-last.json`: `{"ts":"2026-09-12T16:58:41Z","pass":175,"fail":0,"verdict":"PASS"}` — read earlier in cycle 20260912 (pre-compaction). **Provenance caveat:** not re-read this pass (no shell, read-restricted); a write-capable session should re-confirm the receipt before any version bump.

---

## WHAT I DID NOT CHECK (scope limits)

- **No shell, no execution (registry #1173).** I could not run `bash -n` on any script, could not run `tools/tests/run.sh`, and could not run any `--selftest`. Axis-1/axis-3 conclusions rest on static reading plus the `set`/`trap` censuses, **not** on a parse or an execution.
- **`wc -l` on `tools/` was impossible** — script line counts come only from the read tool's own length report; byte sizes are exact.
- **Large tools reviewed by targeted grep/read, not line-by-line:** `oc-deploy` (2991 lines), `oc-ledger` (1822), `oc-ship-chain` (1469), `oc-health` (884), `oc-notify-fanout` (806), `oc-watcher-audit` (413), `oc-roster` (325), `oc-lint-laws` (318), `oc-review-persist` (281), `oc-rebase-safety` (239), `oc-roster-selftest` (187 — argument handling not read), `oc-log-search` (125).
- **Never opened this pass:** `tools/lib/*.sh`, `tools/tests/run.sh`, `tools/HEALTH-CLASSES.md`, `tools/archive/*`, and these tools: `oc-artifact-verify`, `oc-attrib`, `oc-branch-sweep`, `oc-carrier-features`, `oc-commit`, `oc-drift-check`, `oc-harvest-census`, `oc-harvest-dispatch`, `oc-harvest-sweep`, `oc-index-worktree`, `oc-issue-log`, `oc-issue-sweep`, `oc-job-verify`, `oc-order-validate`, `oc-ping-proof`, `oc-pr-atomicity`, `oc-pr-fault-scope`, `oc-ship-audit`, `oc-skew-scan`, `oc-tg-audit`, `oc-upstream-delta`, `oc-wt`.
- **Duty-4 notify-brief quality** (the v0.4.127 n=2265 fold into lens F): **not covered this pass** — no Duty-4 brief was read; the adoption check is `unpriced` and owed to the next F pass.
- **Render-side truncation (`CH`-suffix family, fork #163):** treated as *not* a code defect. Every token was re-verified with anchored greps; **no finding about truncated identifiers is filed.**

---

## PERSISTENCE NOTE (not a finding)

This session runs under the read-restricted registry **#1173** — `read_file` / `grep` / `ls` only, no shell, no write tool. **I could not run `./tools/oc-review-persist F …`.** This report is delivered **inline as the final message** and must be persisted by a write-capable session:

```
./tools/oc-review-persist F @<this file>     # or: … F - < this file
```

The index line in `reviews/20260912-cycle/reports/skill-review-index.log` is the "persisted" receipt. As of this pass that index holds **exactly one** line — lens I, `2026-09-12T12:58:02Z` — so the cycle's census gate (`oc-review-persist check-cycle`) would currently report every other lens MISSING.

**— END OF REPORT —**
