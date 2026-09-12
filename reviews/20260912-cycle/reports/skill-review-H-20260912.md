# Reviewer H — LEDGER HEALTH · Duty-6 skill-review cycle 20260912 · 2026-09-12

**Lens:** H (ARTIFACTS family) — ledger health: the workers-ledger read **as a whole** for what the slice tools cannot see (receipt completeness · phantom families · claim lifecycle · contradiction pairs · cadence/version sync).
**Artifact under review:** `/root/.opencrabs/profiles/ops/opencrabs-dev/workers-ledger.json` — 20,999 lines (re-verified this turn: `read_file` length report), `updated_at` `2026-09-12T17:54:47Z`, max row `n=4012`.
**Posture:** READ-ONLY. No file was edited, created, or deleted; the ledger was not written to; no shell was used.

## Scope actually covered

| File | Lines | How read |
|---|---|---|
| `review-lenses.md` | 264 | full (H brief + ARTIFACTS family header) |
| `toolsmith.md` | 105 | full |
| `SKILL.md` | 555 | full (SKILL GATE injection) |
| `fleet-directives.md` | 651 | targeted (:422, :633, :638) |
| `hq.md` | 317 | targeted (Duty-3/4/5, backlog assignment) |
| `CHANGELOG.md` | 192,687 B | head (:1–:70: v0.4.162 → v0.4.158) |
| `workers-ledger.json` | **20,999** | structure map, tail n=3956→4012, ~25 targeted reads, 14 greps |
| `tools/oc-ledger` | **1,822** | :1–140, :301–345, :352–440, :526–545, :1283–1310, :1462–1571 |
| `tools/oc-ship-audit` | 176 | header only |
| `tools/tests/battery-last.json` | 5 | full |

**Method caveat (state honestly):** this sub-agent's registry is read-restricted — **no shell, so `wc -l` was never run.** Line counts come from `read_file` length reports (`Start line N exceeds file length M`) and `grep -n`. The two counts that carry weight here (20,999 and 1,822) were re-measured **this turn**. Line numbers for `tools/oc-ledger` quotes are from my reads and are reliable to ±2.
**Ledger layout:** `workers[]` :5–1141 · `meta{}` :1142–1180 · `events[]` :1181–20763 (**max n=4012**) · `consents[]` :20764–20997 · `updated_at` :20998. Note the ledger carries **two** event-shaped arrays: `workers[].events[]` (kind `notify`/`ack`/`claim`/`confirm`) and the top-level `events[]` (the `n` row-space H cites). **They are not the same array, and the difference is finding H-1.**

## Findings

### H-1 · HIGH · CLAIM LIFECYCLE — the closure contract is a dead letter: 4 of its 5 closer kinds cannot exist, and the one that can lands in an array `cmd_claims` never reads
**(a) Severity:** HIGH.
**(b) Law site — `tools/oc-ledger:1551-1553`** (`cmd_claims`, function opens :1542):
> `# A claim on #N is OPEN unless a LATER event for the same uuid closes the`
> `# loop: kind in (close|confirm|reject|done|unclaim) whose what references`
> `# the same #N. Bash-side scan is the single owner — close semantics stay`

The kind register, `tools/oc-ledger:140`:
> `KINDS=" ruling idea idea-verdict design-feedback design-locked review-battery incident lesson note ack roster-enroll roster-retire claim confirm swap-result notify-fanout shipchain proposal "`

The scan itself, `tools/oc-ledger:1563-1566`:
> `case "$ctype" in close|confirm|reject|done|unclaim) case "$cwhat" in *"#${n}"*) closed=1 ;; esac ;; esac`
> `done < <(jq -r --arg u "$uuid" --argjson idx "$cidx" \`
> `'.events | to_entries[] | select(.key > $idx and (.value.by // "" | contains($u)) and .value.kind != "claim") | [(.value.kind // "?"), (.value.what // "")] | @tsv' "$LEDGER" 2>/dev/null)`

The one verb that *writes* a `confirm` kind, `tools/oc-ledger:1500-1502` (`cmd_confirm`):
> `'(.workers[] | select(.uuid==$u) | .confirmed) = true`
> `| (.workers[] | select(.uuid==$u) | .events) += [{t: $t, kind: "confirm", issue: ("#"+$i)}]`
> `| .updated_at = $t' || return $?`

**(c) State/artifact — two independent breaks, both verified in the ledger and the code:**
1. **Four of the five named closers cannot be stamped.** A regex grep for `"kind": "(close|done|unclaim|reject)"` across all 20,999 lines returns **zero matches**, and none of the four appears in `KINDS` (:140). They are named in the contract and unreachable in practice.
2. **The one real closer writes to the wrong array.** `cmd_claims` scans **`.events`** (:1566). `cmd_confirm` appends its `confirm` row to **`.workers[].events`** (:1501). The two arrays never intersect, so the sanctioned confirmation path can never close a claim. Only a hand-issued `stamp confirm "<… #N …>"` (`cmd_stamp` writes `.events` at :340) closes one.

**Live instances (both verified this turn):**
- **#150** — claim `n=2983` (:13553-13558): `"by": "editor 4b4463d5-381c-4458-aa0c-3cf199882084"`, `"kind": "claim"`, `"what": "RE-ATTRIBUTION of claim n=2487 (written unattributed so claim-ref could not link it): Claim fork issue #150 skill glob gate — Cursor-style globs frontmatter, registry chokepoint gate, epoch-carrying seen_skills…"`. Its chain terminal is `n=2988` (:13590-13593) — `"kind": "note"`, `"what": "#150 skill-glob-gate SHIP+SMOKE COMPLETE (lane 4b4463d5). … Claim re-attributed n=2983 (n=2487 was unattributed -> claim-ref now returns 150 rc=0). All 13 commits carry Issue-Ref: #150. Plan task 6 complete."` **`note` is not a closing kind**, and the lane's own "claim-ref now returns 150 rc=0" is true but irrelevant — `claim-ref` reports the *latest claim's issue*, it does not test open/closed. A grep for `#150` returns 39 rows and **not one of them is a `confirm`/`close`/`done`/`unclaim`/`reject` row** (highest match: :18304). → `oc-ledger claims 150` reports OPEN today.
- **#191** — claim `n=3924` (:20144-20145): `"by": "editor 329bf3a3-6299-4173-b991-7ea0427563e3"`, `"kind": "claim"`, `"what": "CLAIM #191 — tasks_list sub-agent rows are unscoped: process-global SubAgentManager leaks other sessions' children into the caller's roster (tasks_list.rs:112-127 iterates unfiltered mgr.list(); manager.rs:390)…"`. A grep for `#191` returns **2 matches total** in the entire ledger — the claim row and a worker `issue` field at :335. **Nothing closes it.** → OPEN today.
- **The window is shut, not just unlucky:** a literal `"kind": "confirm"` grep returns 41 rows (14 in `workers[].events[]` :289–:956, 27 in top-level `events[]` :6274–:17911); the **last** top-level `confirm` is `n=3605` at **:17911** (`2026-09-12T08:53:18Z`, `"what": "claim n=2547 CLOSED: #153 datetime awareness complete…"`). Every top-level closer in the ledger predates the #191 claim, so #191 cannot be closed by any existing row. Closure *does* work when a lane hand-stamps the issue number into a `confirm` text (n=3605 is a clean example) — which is exactly why the contract's prose has survived: the working path is the ad-hoc one, and the advertised one (`oc-ledger confirm <uuid>`) is inert for this purpose.

**(d) Cost already paid:** the consumer is a **gate**: `fleet-directives.md:638` — *"**Verify-unclaimed FIRST** (PHOP stage 2, Verify-Unclaimed & Idle Law): grep the workers-ledger for open claim-refs on that issue before routing — two recorded violations, #106 and #107, were both already held when a fan-out routed them."* With the release path dead, the gate reads **finished work as CLAIMED**: #150 (shipped + smoke PASS + harvest superseded) and #191 (shipped to swap 3 h after the claim) both read as held, and a claim whose lane died reads as held **forever**. The ledger itself records this family's history: `n=10821` — *"oc-ship-chain shipchain journaling was silently dead — kind absent from oc-ledger KINDS (216/216 stamps rc 2 under '|| true', 0 ledger rows)"* — the `KINDS` register has already been the chokepoint of one silent-death defect.
**(e) Remedy:** (i) `cmd_claims` must scan **both** arrays, or `cmd_confirm` must also append a top-level `events` row; (ii) teach the scan the closers lanes actually emit — `shipchain` terminal rows (`LEG3 ff-merge ok`, `DONE SWAPPED`, `SHIP-LOCK released`) and `note` rows whose text says `SHIP+SMOKE COMPLETE`; (iii) preferably make the release **mechanical**: have `oc-ship-chain`'s terminal leg stamp a `claim-release` row for the issue its branch names. Whatever the fix, the closing set must be drawn from `KINDS` — a contract naming four unstampable kinds is a contract that cannot be honoured.

### H-2 · MED · CADENCE/VERSION SYNC — the bump series has a hole at 0.4.160
**(a) Severity:** MED.
**(b) Law site — ledger `n=4011`** (`"by": "oc-ledger sync"`, `"kind": "skill-bump"`, `"t": "2026-09-12T17:53:41Z"`, `what` at **:20754**):
> `"v0.4.161 — catch-up from 0.4.159 (skipped 0.4.160): catch-up 0.4.159 -> 0.4.161: v0.4.160 + v0.4.161 landed in docs while sync was REFUSED by the stray-guard (Toolsmith in-flight tools/oc-ship-chain, defect #20, rc=7). #20 has since landed as ship-chain LAW 16 (d6cb9b9a) and the tree is clean.; battery receipt ts 2026-09-12T16:58:41Z"`

The counting law, `tools/oc-ledger:537` (`cmd_cadence`, opens :526):
> `| ([.events[]? | select(.kind == "skill-bump" and ((.n // 0) > $b))] | length) as $c`

and its threshold, `:540`:
> `if [ "$c" -ge 5 ]; then echo "cadence: $c/5 FIRE (boundary n=$b) — Duties 4+6 due"; return 1`

**(c) State/artifact:** the tool's own row says it **skipped 0.4.160** and wrote **one** row for the 0.4.159→0.4.161 span. Corroboration: `CHANGELOG.md:28` carries `## v0.4.160 (2026-09-12) — The Window Now Names All Three of Its Phases`, and the ledger holds **10 ack rows** for 0.4.160 (e.g. :18962 d5863180 · :18969 d18ce16a · :18976 1a63f103 · :18983 329bf3a3 · :18990 c6b1a539 · :19018, :19207, :19277 462181e9 ×3) plus four `workers[].last_acked.version = "0.4.160"` fields (:89, :194, :250, :361). The cause is in-ledger and legitimate — `n=19165` (what at :19165): *"v0.4.160 sync is UNBLOCKED but HELD per owner pause order 10:36Z (no syncs/bumps/fanouts until resumed)"* — but the catch-up then **jumped over** the missing row instead of emitting it.
**(d) Cost already paid:** `cadence` counts **rows**, so a catch-up that collapses *n* versions into one row undercounts the FIRE arithmetic by *n−1* (in this window: 3 versions 0.4.160/161/162, 2 rows n=4011/n=4012), delaying the Duties-4+6 trigger; the bump series stops being a bijection with the CHANGELOG headings; and `check-version` cannot see it, comparing only four current-value fields.
**(e) Remedy:** a catch-up emits ONE row per skipped version, or the bump row carries an explicit `skipped=[0.4.160]` field that `cadence` adds to its count.

### H-3 · MED · RECEIPT COMPLETENESS — the `LEG3 NON-FF` chain-death mode is chronic and its rows carry no disposition (and none of the 09-11 deaths has a SHIP-LOCK release row)
**(a) Severity:** MED.
**(b) Law site — the ledger's own chain rows**, e.g. `:11227`:
> `"[CHAIN-31d99f57-20260911T084653Z] LEG3 NON-FF — branch not fast-forwardable"`

`:11374` `"[CHAIN-35911f14-20260911T085847Z] LEG3 NON-FF — branch not fast-forwardable"` · `:12669` `"[CHAIN-0f746bc0-20260911T131918Z] …"` · `:12816` `"[CHAIN-d06e0ca8-20260911T131737Z] …"` · `:13243` `"[CHAIN-32c847bd-20260911T140230Z] …"` · `:13250` `"[CHAIN-e033a100-20260911T135746Z] …"` · `:13271` `"[CHAIN-ce4be5a9-20260911T135732Z] …"` · `:13768` `"[CHAIN-93f90058-20260911T150153Z] …"` · `:14202` `"[CHAIN-1f1233ed-20260911T153924Z] …"` · `:14209` `"[CHAIN-94e8add4-20260911T153918Z] …"` · `:14727` `"[CHAIN-e8163b8b-20260911T170527Z] …"`.
The contrast row (the same LEG3 succeeding), `:20701`:
> `"[CHAIN-11fb178e-20260912T164353Z] LEG3 ff-merge ok fork-main=11fb178e"`

**(c) State/artifact:** a literal grep for `NON-FF` returns **16 rows**; of the 15 displayed, **11 are `[CHAIN-…] LEG3 NON-FF — branch not fast-forwardable`** and 4 are prose rows referencing a NON-FF rebase (e.g. `:11514` *"chain CHAIN-35911f14 died rc=5 NON-FF as designed"* — i.e. the mode is sometimes a **designed** staleness stop, which is precisely why the bare rows are unreadable). Each chain row is a one-line `what` with **no disposition, no owner, no reason, no retry, no defect link** — the reader cannot distinguish "designed stop, resolved by rebase" from "abandoned". Second, structural gap: a grep for `SHIP-LOCK released` returns its **earliest match at :16295** (`2026-09-12T01:11:45Z`), so **none of the 11 NON-FF deaths recorded on 2026-09-11 has a SHIP-LOCK-release row.** (The tool lists matches ascending and reports its own total, so the omission is the highest-line match — the earliest release row really is :16295.)
**(d) Cost already paid:** `unpriced` — no incident row exists for the mode. It is invisible to the slice tools: `oc-ship-audit` alarms *dispatch-WITHOUT-swap*, and a NON-FF chain never dispatches, so no alarm fires; whether the 09-11 locks were left held or the `SHIP-LOCK released` vocabulary postdates those chains, **the ledger cannot tell the two apart — that ambiguity IS the receipt gap.**
**(e) Remedy:** every chain exit path stamps a terminal row with a disposition (`ABORTED <reason>` / `NON-FF → rebase-needed <old>..<new>`), and a chain-completeness read is added (START row with no terminal row inside a grace window).

### H-4 · LOW · CADENCE/VERSION SYNC — a skill-bump row with an empty provenance field
**(a) Severity:** LOW.
**(b) Law site — ledger `n=4012`** (`"by": "oc-ledger sync"`, `"t": "2026-09-12T17:54:47Z"`, the newest row; `what` at **:20761**):
> `"v0.4.162 — ; battery receipt ts 2026-09-12T16:58:41Z"`
**(c) State/artifact:** the description between the em-dash and the semicolon is **empty**, unlike `n=4011`. Mechanism, verified in the tool — `tools/oc-ledger:400` (`cmd_sync`):
> `[ -n "$why" ] || die 2 "sync: --catch-up requires --why \"<reason>\" (audit line on the catch-up event)"`
— `--why` is mandatory only on the `--catch-up` arm; the ordinary +1 path accepts an empty reason.
**(d) Cost:** `unpriced`. A version bump whose only recorded reason is the CHANGELOG heading, with nothing cross-checking the two.
**(e) Remedy:** require `--why` on every `sync`, or derive the bump row's text mechanically from the CHANGELOG heading the gate already mandates.

### H-5 · MED · CADENCE/VERSION SYNC — one mutable battery receipt serves every bump, so the citation is unfalsifiable
**(a) Severity:** MED.
**(b) Law site — ledger `n=4011` (:20754) and `n=4012` (:20761)**, both ending:
> `; battery receipt ts 2026-09-12T16:58:41Z`
**(c) State/artifact:** `tools/tests/battery-last.json` (read this turn) is
> `{"path": "…/tools/tests/battery-last.json", "ts": "2026-09-12T16:58:41Z", "pass": 175, "fail": 0, "verdict": "PASS"}`
— the **same** receipt file, at the **same** ts, cited by **both** bumps. The CHANGELOG disagrees with one of them: `CHANGELOG.md:12` (v0.4.162 section, heading at :3) reads `- **BATTERY**: 175 PASS / 0 FAIL (receipt tools/tests/battery-last.json).` while `CHANGELOG.md:26` (v0.4.161 section, heading at :14) reads `- **BATTERY**: 168 PASS / 0 FAIL (receipt tools/tests/battery-last.json).` The v0.4.161 row's own citation therefore corroborates **175**, not the **168** its CHANGELOG claims — and the ledger cannot say which is right.
**(d) Cost already paid:** any audit that re-derives a bump's gate from the cited receipt gets *today's* numbers, not the bump's; `sync`'s `<6h` freshness gate makes that substitution legal exactly when two bumps share one receipt (as here, 17:53:41Z and 17:54:47Z, 66 seconds apart).
**(e) Remedy:** `sync` copies the receipt to a per-version path (e.g. `tools/tests/battery-v0.4.162.json`) and cites that, or records `pass`/`fail` inline in the bump row.

### H-6 · MED · CONTRADICTION PAIR — a ledger row asserts defect #20 landed while the shipped law text says it has not
**(a) Severity:** MED.
**(b) Law site — ledger `n=4011`** (:20754):
> `#20 has since landed as ship-chain LAW 16 (d6cb9b9a) and the tree is clean.`
against `CHANGELOG.md:23` (v0.4.161 section, heading `## v0.4.161 (2026-09-12) — A Docs Commit No Longer Burns the Gate` at :14):
> `- **Scope is law text ONLY; the tool half is Toolsmith's (defect #20).** The section names NO flag — until the \`oc-ship-chain\` LEG1 change lands, a docs-only commit still burns the gate. Law must name only verbs that exist (v0.4.153).`
**(c) State/artifact:** `CHANGELOG.md` + `fleet-directives.md §Docs-Only LEG1 Gate Skip`. No later CHANGELOG entry records the landing; no retraction row qualifies the v0.4.161 sentence. Both statements are same-day (ledger row 17:53:41Z).
**(d) Cost:** `unpriced` in rows; the live cost is a lane reading the v0.4.161 law text and concluding the docs-only skip is not implemented, while the ledger row says it is.
**(e) Remedy:** a bump that lands a defect the previous bump's law text declared pending must record the landing in the CHANGELOG (the v0.4.162 entry does not mention #20).
**Boundary note:** the row-vs-DOC shape sits adjacent to Reviewer A's staleness scope; it is filed here because the **asserting side is a ledger row** and the object is the ledger's coherence with the corpus it cites. Likewise H-1's law sentence borders Reviewer J's territory — but the object here is the ledger's own record plus the tool's closure contract, which is H's.

### H-7 · LOW · PHANTOM FAMILY — a row claiming a live probe with no receipt
**(a) Severity:** LOW.
**(b) Law site — ledger `n=3999`** (`what` at **:20670**):
> `"M2-24 live round-trip probe: the composed '<role> <uuid>' form is now accepted"`
**(c) State/artifact:** a bare assertion — no command line, no output, no receipt, no artifact. The verifiable content of the same ship sits in the adjacent substantive row (`n=3998`, lesson: selftest 267→271, negative control 269/2, receipt `71022cfe`).
**(d) Cost:** `unpriced`; the row is the ledger's own phantom shape in miniature — a claimed live probe whose only citation is the claim.
**(e) Remedy:** fold the probe line into the substantive row, or require the probe's command line in the row text.

## What I checked and found CLEAN

- **Version sync (dimension 5, current values).** `SKILL.md:17` `version: 0.4.162` · `workers-ledger.json:4` `"current_skill_version": "0.4.162"` · `meta.current_skill_version` · `meta.skill_version` · `CHANGELOG.md:3` `## v0.4.162 (2026-09-12) — The Meta-Lens's Own Findings Ship` — all four `cmd_check_version` fields agree.
- **Retraction discipline (dimension 4).** The recent retraction pairs are properly closed, each naming the defect and pointing at the corrected row: n=3973 (malformed `by`) → n=3974 (retraction) → n=3975 (re-stamp); n=3989 → n=3990 → n=3991. I found **no un-retracted contradiction pair** other than H-6. Self-corrections are also live in the corpus: `:17926` (`"#138 INVESTIGATION + CORRECTION to my own n=3570/n=3595 notes… my earlier 'HELD pending #138' framing is SUPERSEDED"`), `:17856` (a lane withdrawing its own over-attribution claim).
- **Anonymous-row class is closed.** `cmd_stamp` now REFUSES rc 2 on a sentinel `by` (`tools/oc-ledger:320-334`: *"an anonymous row IS a defect — it cannot be traced to a lane or a tool, which is the whole point of the `by` field"*). The 61 `(unattributed — pass --by or export OC_ACTOR)` rows are historical (:2394 … :6693 and beyond, the n≈1800–2400 era); the guard postdates them.
- **Actor round-trip is consistent post-fix.** After M2-24 (`n=3998`), rows carry the composed canonical form — `n=3999` (:20670), `n=4001`-`n=4006` and `n=4010` all show `by: "toolsmith 2fae1230-de9e-4fa5-aa24-822cf7188c3e"` / `"329bf3a3-6299-4173-b991-7ea0427563e3"` with no new `unrostered-actor` prefix.
- **Swap rows are corroborated on disk.** `n=4010` cites `run=34707657632`; the state dir holds `fanout.lock.34707657632` (mtime `17:27:08`), and `deployed.sha` / `deployed.meta.json` both mtime `17:26:10` bracket the swap. `n=4010` sha `11fb178e…` matches `n=4004`'s `LEG3 ff-merge ok fork-main=11fb178e` and `n=4006`'s `LEG4 ship GREEN`. Every swap row carries sha + run + features + journal path + auth + fanout rc.
- **The 11fb178e chain is a complete, receipted chain** — `n=4001` `LEG2 issue-log rc=3 (non-fatal)` → `n=4002` done → `n=4003` `SHIP-LOCK acquired immediately (uncontended)` → `n=4004` ff-merge ok → `n=4005` LEG4 ship start → `n=4006` LEG4 ship GREEN → `n=4009` `SHIP-LOCK released` → `n=4010` DEPLOYED. (This is the shape H-3 says the NON-FF chains lack.)
- **Duplicate-ack law is data-backed and pre-fix only.** The v0.4.159 law (`CHANGELOG.md:41`) names lanes `1a63f103` n=3717/3718 and `d18ce16a` n=3713/3714; the ledger confirms the class, and `:19088` is the affected lane's own self-disclosure (`"SELF-DISCLOSURE v0.4.159 duplicate-ack law: … duplicate (uuid,version) pairs = … 4 pairs / 7 redundant rows"`). The 0.4.160 triple-ack by `462181e9` (:19018/:19207/:19277) is the same class, and M2-4's idempotent-`ack` guard (`tools/RC-CONTRACT.md` oc-ledger row) now closes it — all instances predate the guard.
- **Receipt completeness, sampled (dimension 1).** Four recent lesson/incident rows I read are each codified: `n=3998` (M2-24) → the M2-24 paragraph in `tools/RC-CONTRACT.md`; `n=3773` (:19088, duplicate-ack) → `CHANGELOG.md:41` + RC-CONTRACT M2-4; the #19 anonymous-row lesson → RC-CONTRACT `stamp` row; M2-21 (selftest telemetry) → `CHANGELOG.md` v0.4.162. I found no uncoded lesson in the sample — see the scope limit below.

## What I did NOT check

- **No git / gh verification.** This sub-agent has no shell: tags for v0.4.160/161/162, `git ls-remote`, and the existence of commit `d6cb9b9a` (cited at n=4011) are **unverified**. The cadence dimension rests on ledger rows + CHANGELOG + on-disk state-dir artifacts only.
- **Dimension 1 was sampled, not swept.** The ledger holds **26 `"kind": "incident"` rows** (:2311 … :17491) and **25 `"kind": "lesson"` rows** (:3454 … :20662). I read 4. A full row-by-row sweep matching each to a law home (or an explicit owner waiver) was **not** performed, so "lesson-extraction completeness" is reported as **UNSWEPT**, not clean.
- **`workers[]` was sampled, not swept.** A full worker-level `last_acked` skew sweep was not run; the four 0.4.160 `last_acked` fields (:89, :194, :250, :361) are the ones a grep surfaced.
- **The `skill-bump` row population was not counted.** A literal `"kind": "skill-bump"` grep and a bare `skill-bump` grep disagreed (7 vs 61 — the loose pattern also matches rows whose *text* mentions the kind), so I state **no** row count for the series; H-2's argument is structural (n=4011's own "skipped 0.4.160") plus the targeted `0.4.160` grep (21 rows, none a bump row's own version).
- **Two cited ledger rows rest on the pre-compaction snapshot, not a same-turn read**, and are therefore **not** used as findings: the CHAIN-3c2761d4 / CHAIN-de4b0d50 NON-FF pairs (n=3983/3984, n=3996/3997). H-3 stands on 11 NON-FF rows read this turn.
- **`tools.log` (4.16 MB), `smoke-verdicts.log` (183 KB), `harvest-registry.json` (366 KB), `tools/oc-ship-audit`'s body, and `editor.md` were not read.**
- **Brief-correctness note for Reviewer I (not an H finding):** the H brief names `oc-waiter-sweep` as one of the slice tools. **No such file exists** in `tools/` (there is `oc-waiter`); `oc-waiter-sweep` is named in `triage.md` as a law-carrying **cron**. The brief's tool list should be corrected or the name qualified.

## Assumptions stated

1. **`wc -l` was impossible** (no shell). Counts come from `read_file` length reports and `grep -n`; the two load-bearing counts (20,999 / 1,822) were re-measured this turn. The method is named so the numbers are re-derivable.
2. **Only top-level `events[].n` is the row-number space** H cites; `workers[].events[]` is a separate array (H-1 turns on exactly that).
3. **Cycle reports live in two repos.** `CHANGELOG.md` v0.4.162 records that the real Duty-6 cycles live in the STATE repo while `reviews/20260911-cycle` in the SKILL repo is the HQ-side mirror — so this report is emitted as text for HQ to persist via `oc-review-persist`; I write nothing.
4. **`grep` here matches literally unless told otherwise**; every count above names its pattern and whether the result was truncated by the display limit (the ones I relied on were not).
5. **H reviews the journal, never edits it** — no correction in this report was applied to any file; all remedies are proposals for HQ/Toolsmith.

---

**Reviewer H, cycle 20260912 — the ledger's sharpest bite is H-1.** `cmd_claims` promises a claim is OPEN unless a later event's kind is `(close|confirm|reject|done|unclaim)` — but four of those five kinds are absent from `KINDS` and therefore unstampable, and the one that exists (`confirm`) is written by `cmd_confirm` into `.workers[].events`, an array `cmd_claims` never scans. So the `verify-unclaimed` dispatch gate reads #150 and #191 — both shipped — as CLAIMED, and a dead lane's claim reads as claimed forever. Runner-up: the bump series has a hole at 0.4.160 (the tool's own row says "skipped 0.4.160"; ten lanes acked a version the ledger never recorded as published), `cadence` counts rows and so undercounts the FIRE arithmetic, and `n=4012`'s provenance field is literally empty. Three more: one mutable battery receipt serves every bump (so `n=4011`'s citation corroborates 175, not its own CHANGELOG's 168); a ledger row asserts defect #20 landed while the shipped law text says it has not; and eleven `LEG3 NON-FF` chain deaths sit in the ledger with no disposition and no release row.
