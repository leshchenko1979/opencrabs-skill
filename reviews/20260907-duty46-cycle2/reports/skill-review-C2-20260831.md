# Duty 6, Lens C — CLI AUTOMATION GAPS (opencrabs-dev v0.4.63)
Reviewer: sub-agent 55d07e3a (read-only, resumed for full re-emit — first delivery truncated). Supervisor persisted per Duty 6 §3.

## PART 1 — New tool / verb proposals (recurring manual rituals, mechanical)

**C1 — `oc-smoke-evidence` — HIGH**
- Contract: print the mechanical identity + presence evidence line for a smoke verdict against the RUNNING daemon (MainPID, `/proc/<pid>/exe` sha256, disk==proc comparison vs `deployed.sha` / `deployed.meta.json` / seal-state binary-sha, optional strings markers).
- Replaces: the boilerplate every smoke verdict is hand-assembling. Evidence: the state-dir `smoke-verdicts.log` carries 15+ hand-written lines all shaped like "PASS — binary identity + feature presence on live ops daemon (MainPID 2573165, boot 13:45:01Z, exe sha 7fe2334f… = run 33254863156 artifact, source ad6d9505…; deployed.sha marker matches; disk==proc per swap journal seq-8 + independent re-hash)" — each assembled by hand from `systemctl --user show … -p MainPID`, `sha256sum /proc/PID/exe`, marker greps. Phase 6b (`editor.md §Phase 6b`) is the procedure home; `oc-artifact-verify` covers the pre-swap artifact but nothing covers the live-daemon counterpart.
- Shape: `oc-smoke-evidence [--unit opencrabs-ops] [--strings m1,m2] [--negative-control <backup>]` → TSV evidence + verdict; exit 0 IDENTITY-MATCH / 1 MISMATCH / 2 usage / 3 unit-or-proc-fail.

**C2 — `oc-ledger stamp` built-in read-back verification — HIGH**
- Contract: after the flock write, re-read event n from disk and verify `what` is non-empty and not flag-shaped (doesn't start with `--`) and `by` non-empty; fail loud (new rc) on mismatch.
- Replaces: `editor.md §Phase 1 step 4` hand re-read ritual ("a glitched argv (event n=1361 stored what:\"--what\") silently produced an empty claim the lane cited as proof for ~11h"). The manual gate leaks (n=1361/n=1372 incident class).
- Shape: no new verb — self-verify tail in `cmd_stamp`; optionally `oc-ledger readback <n>`.

**C3 — `oc-issue-log` (per-commit implementation comment) — HIGH**
- Contract: post the mandatory one-comment-per-commit implementation note on the tracked fork issue, composed from git metadata, via `--body-file` only.
- Replaces: `editor.md §Phase 6` hand-dance (single-quoted heredoc ONLY; `--edit-last` overwrites the PREVIOUS commit's comment). Recurs on every editor commit; incident-class burn (lane 212b3c83, mangled post).
- Shape: `oc-issue-log <issue-n> <sha> [--state <text>] [--repo R]` — subject + trailers from `git log -1`, temp body file, `gh issue comment --body-file`; exit 0 posted / 2 usage / 3 gh-fail.

**C4 — `oc-harvest-sweep` (pre-gate harvest verification) — HIGH**
- Contract: run the mechanical legs of the harvest verification sweep on a harvested PR branch before the first gate dispatch: (a) `git diff origin/main...HEAD` symbol sweep (fork-renamed/fork-only symbols with live callers in UPSTREAM tree), (b) fork-side-only attribute sweep (`#[allow(clippy::…)]`/cfg gates), (d) `git patch-id` rebase-port verification. Leg (c) stays human.
- Evidence in-file: "4 lanes converged — c6b1a539, d5863180, 7e1ebbb6 ×2; 3 gate rounds burned overnight proving the gap."
- Shape: `oc-harvest-sweep <pr-branch> [--base adolfousier/main] [--repo P] [--port-of s1,s2]` → TSV findings (orphan-symbol / missing-attr / patch-id-match); exit 0 clean / 1 findings / 2 usage / 3 git-fail. Distinct from `oc-pr-fault-scope` (post-gate blame) and `oc-pr-atomicity`.

**C5 — `oc-commit` (gated signed commit) — HIGH/MED**
- Contract: commit wrapper enforcing three per-commit rituals: HEAD-attached check (detached HEAD commits silently to a nameless sha, v0.4.14 P5), Session-Id trailer from `OC_ACTOR`, Issue-Ref trailer from worker's latest ledger claim.
- Replaces: `editor.md §Phase 6c` manual trailer composition + `SKILL.md §Session-notify loop` ("an unsigned commit makes you invisible to the notification loop").
- Shape: `oc-commit -m <msg> [--issue N] [--repo P]` — refuses detached HEAD / unset OC_ACTOR; `--issue` defaults from actor's latest claim; exit 0 committed / 2 usage / 3 gate-fail. Never stages anything.

**C6 — `oc-ship-audit` (dispatch-without-swap alarm) — MED**
- Contract: scan tools.log/journal for `ship` dispatch rows with no matching swap/seal row for the same sha — the orphaned-GREEN-ship class. CHANGELOG v0.4.60: "two orphaned GREEN ships 2026-08-31 … absence of a swap row for the sha is alarmable from the journal alone" — journaling landed, nothing raises the alarm.
- Shape: `oc-ship-audit [--hours N] [--log P]` → TSV: sha, run-id, SWAPPED/ORPHANED, lag; exit 0 clean / 1 orphan-found / 2 usage / 3 log. Watchdog cadence beside `oc-watchdog-check`.

**C7 — `oc-tg-audit` (Telegram surface law evidence scan) — MED**
- Contract: verdict a lane's telegram-law compliance from the ops daily log (telegram send/edit tool calls by session). Replaces supervisor.md §Duty 7 hand grep. Recurs on every suspicion + repeat offense.
- Shape: `oc-tg-audit <uuid> [--date YYYY-MM-DD] [--days N] [--log-dir P]` → TSV rows + CLEAN/VIOLATION; exit 0 clean / 1 violation / 2 usage / 3 log-missing. Distinct from `oc-toolaccum`.

**C8 — `oc-ledger sync` changelog gate — MED**
- Contract: refuse (or WARN-gate) a version sync whose version has no CHANGELOG.md entry, mirroring the SKILL.md-frontmatter gate. Incident: CHANGELOG v0.4.54 "backfilled 08-31 — the bump shipped without one".
- Shape: extend `cmd_sync` (greps SKILL.md version with rc 6): add CHANGELOG grep gate. Tool never writes it first.

**C9 — `oc-waiter` (detached-poller generator) — MED/LOW (largest build, optional)**
- Contract: generate/arm the proven detached ≥60s poller with notify wiring and per-leg invocation verification, instead of hand-writing `/tmp/swap-*.sh`. Replaces editor.md §CI-wait items 1/6/7 manual dance. Incident burns: 2fbfb2f8 (invented --run-id flag, GREEN build sat unswapped), c6b1a539 (lane dark until owner roll call).
- Shape: `oc-waiter --run <id> --interval 60 --on-terminal <cmd…> [--notify <uuid>]` — enforces 60s floor, validates inner argv pre-launch. YAGNI-reviewable.

**C10 — `oc-wt list` verb — LOW**
- Contract: worktrees with task path, branch, dirty bit. Replaces editor.md §Phase 2 / §Worktree lifecycle manual `git worktree list` rituals. Natural verb home (add/remove exist, list doesn't).

**C11 — `oc-logstats` — LOW/optional**
- Contract: fleet-level per-tool usage + failing-invocation TSV from tools.log. Replaces three hand-run jq recipes in SKILL.md §Unified tools log. Borderline YAGNI.

## PART 2 — KERNEL: rituals already mechanized, prose not wired (zero code)

- **K1** `editor.md §Phase 1 step 1` uniqueness gate = `oc-issue-sweep`, but Phase 1 never names it + quick table omits it. Fix: point prose + add row.
- **K2** `editor.md §Phase 7 step 1` hand-formatted git-log trailers listing = `oc-attrib --range` / `oc-deploy contributors` (TSV already). Prose doesn't point at them.
- **K3** `editor.md §Mid-cycle skill drift step 1` manual grep compare; `oc-drift-check` (v0.4.58) mechanizes steps 1–2, quick-table only.
- **K4** `editor.md §Worktree lifecycle` raw `git status --porcelain` + remove; `oc-wt remove` implements the dirty-tree gate.
- **K5** `SKILL.md §Shared environment facts` raw carrier file read; `oc-carrier-features` is the live reader.

## PART 3 — Prose/script mismatches

- **M1 (real)** SKILL.md tool table row for `oc-artifact-verify` documents nonexistent positional shape `<run-id> <bin> <marker>` + wrong exit register. Actual: flag-based `--source/--run-id/--repo/--json`, exits 0/1/2/3/4/5. `oc-deploy` itself uses flags the row doesn't document.
- **M2 (real)** SKILL.md seal-state row documents positional sha; interface is `--sha S` flag-based. Exits match, shape doesn't.
- **M3 (over-claim)** editor quick table says stamp takes "FULL flags, no bare positionals" — `cmd_stamp` accepts bare positionals by design (v0.4.57). Harmless direction.
- **M4 (tension)** CI-wait item 5 mandates `--wait ≤90s` vs `oc-prchecks` default `--wait 600`. Reconcilable via the explicit tool-timeout clause; worth a clarifying sentence.
- Everything else checked out: all five young tools, oc-deploy surface, oc-ledger verbs, oc-prchecks flags, oc-wt, oc-upstream-delta, oc-carrier-features, oc-issue-sweep, oc-skew-scan, oc-ping-proof, oc-watchdog-check, oc-order-validate, oc-job-verify, oc-contributors, oc-attrib, oc-ci-parity, oc-shadow-rotate, oc-review-persist all match documented shapes. v0.4.63 sync full-tree staging live in cmd_sync (selftest-covered).

## Priority summary

HIGH: C1–C4 (incident-backed, high-frequency). MED: C5–C8. LOW/optional: C9–C11. KERNEL wiring: K1–K5 (zero code). Doc fixes: M1, M2 (M3/M4 clarification). No duplicates of existing tools.

EOF-LENS-C2
