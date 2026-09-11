*Bwoo-bip.* Rebooting from a compaction is like waking up with someone else's notes taped to your visor — and mine said "catastrophic source corruption, HIGH severity, headline finding." Reader: it was bollocks. One grep with a positive control and the whole thing fell over. Good thing I checked before filing a false defect against TOOLSMITH's code.

Here is the deliverable.

---

# Reviewer F (TOOLS CODE) — Duty 6, OpenCrabs Dev Cycle 5

**Scope:** all shell scripts in `~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/`
**Axes:** (1) quoting + dash/bash compat · (2) error trapping + rc consistency · (3) journaling completeness
**Registry:** read-restricted (#1173) — `read_file` / `grep` / `glob` / `ls` only. No shell, no writes, no notify.

**Assumption (stated as required):** *I could not run `oc-review-persist` — the read-restricted registry has no shell and no write tool. This report is therefore delivered **inline as the final message** rather than persisted to the review index. It needs to be persisted by whoever holds a write-capable session.*

---

## 0. FALSE-POSITIVE RETRACTION — the pre-compaction "HIGH" was a read-back render artifact

My pre-compaction self (and the continuation document it wrote) was one step from filing **"eleven variables truncated mid-name across four files — catastrophic source corruption"** as the headline HIGH finding. **That finding is false.** The bytes on disk are correct; the truncation existed only in what the tool *rendered back to me*.

The claim was that `oc-job-verify`, `oc-deploy`, `oc-carrier-features` and `oc-prchecks` had lost a shared 2-char suffix, e.g. `MATCH`→`MAT`, `FETCH`→`FET`, `DISPATCH`→`DISPAT`. I tested it with a `\b`-anchored regex — which **matches a bare `MAT` and provably cannot match `MATCH`** — computed inside the grep tool, on raw bytes:

| Probe (in-tool regex) | Result | Meaning |
|---|---|---|
| `grep "PV_MATCH"` on `oc-deploy` | **10 matches, incl. 1530, 1539, 1543** — the exact lines that rendered as `PV_MAT` | disk holds `PV_MATCH` |
| `grep "PV_MAT\b"` on `oc-deploy` | **0 matches** | no bare `PV_MAT` exists |
| `grep "REF_MAT\b\|FEAT_MAT\b"` on `oc-job-verify` | **0 matches** | disk holds `REF_MATCH` / `FEAT_MATCH` |
| `grep "FET\b"` on `oc-carrier-features` | **0 matches** | disk holds `FETCH` |
| `grep "FETCH"` on `oc-carrier-features` | matches 29, 34, 70 | the `--fetch` path is intact |
| `grep "MATCH"` on `oc-job-verify` | matches **130, 131, 133, 136, 139** | the "corrupted" lines all carry `MATCH` |

**Positive control (the decisive one).** `grep "DISPAT\b"` on `oc-prchecks` returned **exactly two** matches — lines 61 and 599 — and **not** line 603. Those two are the source comments that deliberately *quote* the old typo'd name (`# old OC_PR_SKIPPED_DISPAT line (n=2226 batch) must abort the`; `` # `OC_PR_SKIPPED_DISPAT` — a typo'd NAME (missing CH) executing a ``), where a bare `DISPAT` genuinely exists followed by a space. So the *same pattern, in the same batch*, demonstrably matched a real bare `DISPAT` and demonstrably failed on line 603. Had line 603 truly held bare `DISPAT`, it would have matched too. It did not ⇒ line 603 is `OC_PR_SKIPPED_DISPATCH`.

**The clincher that a file-level defect cannot explain:** `oc-job-verify:133` rendered as
`[ "$REF_MATCH" = 0 ] && [ "${E_REF:0:12}" = "${REF:0:12}" ] && REF_MAT`
— the *same token, on the same line*, one instance intact and one truncated. Corruption of file bytes cannot spare one occurrence and eat its twin.

**Conclusion:** this is the documented render-side truncation family (fork issue **leshchenko1979/opencrabs#163**, the `branix/`-signature family), here manifesting as `CH`-suffix loss. The tool code is **sound**. The comment at `oc-prchecks:60-64` corroborates it — `set -e` was added precisely because the `OC_PR_SKIPPED_DISPATCH` typo was a *real historical* bug ("n=2226 batch"), and line 603 is the fix, not a re-corruption.

**Action owed (I cannot perform it — no `gh`, no `session_notify`):** a comment on **#163** recording that the artifact now bites `CH`-suffixed identifiers (`MATCH`/`FETCH`/`DISPATCH`), so a future reviewer doesn't repeat my near-miss. Route to the fork issue tracker (core-daemon fault), not Toolsmith.

**Meta-lesson for the parent:** my own continuation document asserted this as verified fact. A compaction summary is a snapshot of *claims*, not of *checks* — the two independent greps the summary cited had been run with an **unanchored OR pattern**, which cannot distinguish `MAT` from `MATCH`. Anchored discrimination is the only read-back-immune proof, exactly as AGENTS.md §"Defect claims about file/ledger content" demands.

---

## HIGH

**None.** No finding in the tool code meets HIGH. The one candidate was the false positive retracted above.

---

## MEDIUM

### M1 — `oc-log-search` is the only *live* tool with no `set` line at all
`grep '^set '` across `tools/oc-*` returns 74 lines covering 36 files. `oc-log-search` has **zero**. Its body goes straight from the `PROG=oc-log-search` assignment into sourcing the log lib:

- `oc-log-search:24` → `PROG=oc-log-search`
- (no `set -u`, no `set -o pipefail`, no `set -e` anywhere in the file)

**Why it matters.** Without `set -u`, an unbound/mis-spelled variable silently expands to empty instead of erroring. This tool's stated reason to exist (`oc-log-search:6-10`) is to kill *false log-derived claims* — and its declared contract is grep-like (`oc-log-search:22`: `# Exit codes: 0 matches found · 1 ran clean, zero matches (grep-like)`). A silently-empty filter variable converts a mis-wired query into a **false "no matches" (rc 1)** that looks authoritative. That is the precise hazard `oc-prchecks:60-64` names when it added `set -e`: *"silent no-op on unbound var/typos is the #124 time-bomb class."* The fleet's F7 convention (`set -u` + `set -o pipefail`, v0.4.72, present in 36 tools) exists for this; `oc-log-search` is the one live tool still exposed.
**Caveat:** I could not exercise it (no shell), so I assert the *deviation* and the *class*, not a live unbound read.

### M2 — `oc-ship-chain` omits `set -o pipefail`
- `oc-ship-chain:66` → `set -e`
- `oc-ship-chain:67` → `set -u`
- `grep "pipefail"` on `oc-ship-chain` → **No matches found.**

`oc-ship-chain` is the single-invocation ship path (CI gate → issue-log → ff-merge → ship → swap). Every other multi-stage tool carries pipefail (`oc-deploy:65` `set -uo pipefail`; `oc-notify-fanout:79` `set -euo pipefail`; `oc-prchecks:59` `set -o pipefail`). `set -e` covers a failing *simple* command but **not** a failing left-hand command inside a pipeline. Practical exposure is softened by the tool's heavy `|| true` usage, but the omission is a genuine deviation from an explicit prior-lens fix (F7) on the most safety-critical script in the fleet.

---

## LOW

### L1 — `oc-log-search --help` truncates its own header, dropping the exit-code block
- `oc-log-search:30` → `--help) sed -n '2,20p' "$SELF" | sed 's/^# \{0,1\}//'; exit 0 ;;`
- `oc-log-search:22` → `# Exit codes: 0 matches found · 1 ran clean, zero matches (grep-like)`

`--help` prints lines 2–20 only; the `# Exit codes:` block starts at line 22, so it is never shown. (`--help` itself correctly returns rc 0.) Compounded by a three-way inconsistency in help-header extraction: `oc-log-search:30` uses `sed -n '2,20p'`, `oc-rebase-safety:40` uses `sed -n '2,30p'`, and `oc-ship-chain:97` prints the whole header via `awk 'NR==1{next} /^#/{sub(/^# ?/,""); print; next} {exit}'`. Low impact — `RC-CONTRACT.md` is the sole register.

### L2 — `echo -e` (bash-ism) used 28× in 3 tools while the rest of the fleet emits TSV via `printf`
Sites: `oc-rebase-safety:135,137,139,142,181` · `oc-smoke-evidence:66-73,78,80,83,85,98,100,110,112` · `oc-harvest-sweep:75,77,81,83,100,101,102`.
Quote — `oc-smoke-evidence:78`: `echo -e "identity\tMATCH (running exe == run $RUN_ID artifact)"`

All three carry `#!/usr/bin/env bash`, so it works today. But `echo -e` is non-portable: dash's `echo` prints `-e` literally and `echo`'s backslash handling is otherwise implementation-defined. If any of these is ever sourced or run under `sh`, the `\t` separators become literal. Hygiene/consistency only.

### L3 — `oc-waiter` (RETIRED) is the only tool that bypasses the unified tools log
`oc-waiter` sources no `lib/oc-log.sh`, installs no `trap … EXIT`, and returns rc 0 for `-h|--help` / rc 1 otherwise. The SKILL law states every tool in `tools/` appends one JSONL line on exit; a retired stub is not exempt, so `oc-waiter` invocations are invisible to TOOL_ACCUM. Its usage-error path also returns rc 1 where the fleet contract is 2 (it is not one of the seven legacy registers). Low — it is retired and should never be invoked.

---

## INFO (recorded so a future pass doesn't re-flag them)

### I1 — `#!/bin/sh` appears only in selftest fixture stubs, never in a tool body
Sites: `oc-ledger:956,957` · `oc-artifact-verify:57` · `oc-pr-fault-scope:66,67,68`.
Quote — `oc-pr-fault-scope:68`: `printf '#!/bin/sh\nexit 1\n' > "$T/gh-dead.sh"`
These are printf-generated fake `gh` binaries; `#!/bin/sh` is correct there, and `printf` (not `echo`) is used, so the `\n` escapes are interpreted safely.

### I2 — quoting / dash-compat axis is clean
`grep '\[\[ '` → **0 matches** (no bash-only `[[ ]]` anywhere). Every tool body's shebang is `#!/usr/bin/env bash`. No unquoted-glob or `$0`-in-harness hazards surfaced in the files read.

### I3 — rc contract is uniformly honored where checked
Spot-checked `usage()` bodies → rc 2 in `oc-log-search:31`, `oc-commit:34`, `oc-attrib:34`, `oc-ship-audit:29`, `oc-tg-audit:27`, `oc-smoke-evidence:25`, `oc-ping-proof:23`, `oc-carrier-features:26`, `oc-wt:54`, `oc-issue-sweep:27`, `oc-harvest-sweep:23`, `oc-issue-log:22`, `oc-skew-scan:23`, `oc-rebase-safety:40`, `oc-seal-state:107`, `oc-health:53`. The `--help`-returns-0 idiom is handled explicitly, e.g. `oc-smoke-evidence:47`: `-h|--help) (usage); exit 0 ;;   # F-L1 (v0.4.77): --help = 0 (subshell absorbs usage's exit 2)`. `oc-ship-chain` routes `--help|-h) usage ;;` (→ rc 0, correct) and `*) die "unknown arg: $1 (see --help)" 2 ;;` (→ rc 2, correct) — I checked this specifically and **there is no violation**; my initial suspicion was wrong.

### I4 — journaling axis: structurally complete
Every live tool sources `lib/oc-log.sh`, calls `oc_log_init`, and installs `trap 'oc_log_finish $?' EXIT` (64 `trap … EXIT` sites). `oc_log_extra` carries structured extras (`oc-branch-sweep`, `oc-drift-check`, `oc-prchecks`); per-run journals live under `oc-deploy/journal/` and `oc-ship-chain` (`kind=shipchain`). Only `oc-waiter` opts out (L3). Note (data, not tool): `tools.log` carries 2 hand-appended non-JSON lines (383, 443) — recipes must use `jq -Rr 'fromjson?'`.

---

## Coverage & limitations (honest)

- **Read in full:** `RC-CONTRACT.md`, `lib/oc-log.sh`, `lib/oc-notify.sh`, `lib/oc-embed.sh`, `lib/oc-snap.sh`, `tests/run.sh`, `tests/battery-last.json`, `review-lenses.md` (partial), and tools: `oc-artifact-verify`, `oc-attrib`, `oc-branch-sweep`, `oc-carrier-features`, `oc-commit`, `oc-drift-check`, `oc-harvest-sweep`, `oc-index-worktree`, `oc-issue-log`, `oc-issue-sweep`, `oc-job-verify`, `oc-log-search`, `oc-order-validate`, `oc-ping-proof`, `oc-review-persist`, `oc-waiter`.
- **Partial / targeted only:** `oc-deploy` (138 KB), `oc-prchecks` (50 KB), `oc-ship-chain`, `oc-seal-state`, `oc-wt`.
- **NOT reviewed (coverage gap — flag for a follow-up pass):** `oc-ledger` (95 KB), `oc-health`, `oc-notify-fanout`, `oc-harvest-dispatch`, `oc-harvest-census`, `oc-roster`, `oc-roster-selftest`, `oc-upstream-delta`, `oc-pr-atomicity`, `oc-pr-fault-scope`, `oc-rebase-safety`, `oc-ship-audit`, `oc-skew-scan`, `oc-tg-audit`, `oc-shadow-rotate`, `archive/oc-post-receipts`, `HEALTH-CHECKS.md`.
- **Not executable from here:** `bash -n` syntax check, the battery (`tools/tests/run.sh`), and `oc-review-persist`. Axis-2 conclusions therefore rest on the `set`-flag census and static reading, not on a parse. The battery's own last result (`tests/battery-last.json`: `pass 162, fail 0, verdict PASS @ 2026-09-11T17:34:10Z`) is green — and, per the retraction, is green **legitimately**; the pre-compaction claim that it gave "false confidence over a swap path that can't assign `PV_MATCH`" was itself a consequence of the false positive and is withdrawn.

## Next
1. **Persist this report** via `./tools/oc-review-persist F <text|@file|->` from a write-capable session — I cannot (read-restricted). The index line is the "persisted" receipt.
2. **Comment on fork issue #163** recording the `CH`-suffix manifestation of the render artifact (owner: fork issue tracker / core daemon).
3. **Toolsmith** to consider M1 (`oc-log-search` `set -u`/`pipefail`) and M2 (`oc-ship-chain` `set -o pipefail`); both are one-line fixes and require a battery re-run before any version bump.
4. A follow-up reviewer pass should cover the ~16 unread tools above; my axes are clean only over the subset I read.
