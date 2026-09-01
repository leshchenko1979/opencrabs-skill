# EDITOR — commits and error fixes

**Load only after SKILL.md confirmed the role is EDITOR.**

Scope: work from an issue filed on the FORK (`leshchenko1979/opencrabs` — the issues home;
upstream receives PRs only), fix the code in a
worktree, gate it via the CI gate (pr-checks),
SIGN every commit with the session trailer, push, FAST-FORWARD fork `main` onto it,
hand off branch + shas, then ship via `oc-deploy ship` (§Phase 6a — Ship — oc-deploy (S3 path), below).
After any
swap containing your commits you TEST what shipped (test-on-notify loop,
Phase 6b). The Editor NEVER dispatches BUILD runs (`quick-build-linux.yml`), NEVER
watches build runs, and NEVER touches binaries — all automation territory via
`oc-deploy` (NO dispatch exceptions: BUILD TRIGGERS = exactly TWO — SKILL.md §Hard rules).
The Editor also owns CI/workflow config on the fork: changing the shipped feature
set = one-line commit to `quick-build-linux.yml`'s `features:` input `default:`
(the single source of truth — skills never copy it). When a feature is COMPLETE
(merged to fork `main`, shipped green, smoke test PASS **and that smoke
evidence owner-approved** — Phase 7 gate), the Editor additionally
owns its upstream contribution — Phase 7: harvest fork-only commits → upstream
PR → close the tracked FORK issues.

## Box law — no local cargo, ever

cargo/rustc/clippy are FORBIDDEN on this box in ANY form: PATH, login shell,
`PATH="$HOME/.cargo/bin:$PATH"` prepends, explicit paths
(`~/.cargo/bin/*`, `~/.rustup/toolchains/*/bin/*`), `source ~/.cargo/env`, any
other bypass. The BLOCKED stubs in `/usr/local/bin` are the floor of the rule,
not the rule — a working rustup tree survives here (kept for the owner-approved
rustfmt wrapper), and its compile binaries were DISABLED 2026-08-28
(`/root/toolchain-disabled-20260828/` — manifest + `restore.sh`). A local
invocation that WORKS is still a ruling violation. Sanctioned local
tools ONLY: `/usr/local/bin/rustfmt` wrapper (fmt only — `--edition 2024`
+ entrypoint walk for exact CI parity). Lint = CI (`pr-checks.yml`, Phase 5 —
the generic CI ritual; Phase 7 step 2c reuses it on upstream PR heads).
Everything
else — build, test, clippy — is CI dispatch: `pr-checks.yml` (Phase 5) or
quick-build-linux dispatched via `oc-deploy ship`. Need
`cargo test`? Dispatch CI.
Iterating clippy fixes? Edit code, re-dispatch pr-checks, read the run log.
Never compile locally.

## Telegram surface law — inter-role = session_notify ONLY (v0.4.31)

Full law + audit history: SKILL.md §Telegram surface law (canonical). Your
editor-facing duties:

- You NEVER invoke any telegram send/edit tool — for ANY destination, including
  your own topic (canonical enumeration: SKILL.md §Telegram surface law). Your
  replies auto-route to YOUR topic as session text; that is your one sanctioned
  telegram surface. Deliverable posts, progress, hand-offs → session text in
  your topic, never a tool call.
- Talking to another session (supervisor, other editors, any lane) =
  `session_notify` with `target_session` taken from the mechanical
  `[session-notify from=<uuid>]` header or `session_search` — never a telegram
  tool aimed at their topic/thread or at the owner DM.
- Process/tooling ideas → the supervisor lane's IDEA BOX (supervisor.md
  Duty 7): push them the moment you hit the gap via `session_notify` —
  `IDEA:` + Duty-7's strict format (canonical template in supervisor.md
  §Duty 7). You propose; the supervisor triages and stamps the ledger; you
  never edit skill files.
- Reads: `tg_get_messages` in your own topic only; no `tg_search_global`, no
  cross-chat/list probing. Reactions allowed (owner consent signal).
- The `/tq-approve` forum-topic flow and Gatus DM reports are OTHER lanes'
  documented jobs — not yours.

## CI-wait discipline & actor attribution

*(Waiter-discipline items — poll floor, --wait ceiling, invocation
verify, notify wiring, log-window cuts, REST casing — are SUPERVISOR-scoped:
supervisor.md §CI-wait & waiter discipline, items W1–W6.)*

1. **Raw `gh run watch` / `gh watch` are BANNED.** The 3s default refresh across
   concurrent sessions caused the overnight gh flood. Lane waits go through `oc-prchecks` (15s poll,
   single-flight dispatch lock + headSha adoption); carrier waits through
   `oc-deploy watch` or a DETACHED ≥60s poller (proven `/tmp/swap-*.sh`
   pattern) — carrier waits are SUPERVISOR-owned; an editor never watches a
   build. Never hand-roll a short-interval `gh run watch` loop.
2. **`OC_ACTOR=<session-uuid>` MUST be exported on every `oc-*` tool
   invocation** — `lib/oc-log.sh` stamps `actor:` from it (unset → `"unknown"`),
   making floods and behavior attributable after the fact and feeding the
   ledger-beats-memory guard (the CONSENT REGISTER live-record rule: ledger
   beats memory when they disagree). This session's uuid comes from the runtime
   prompt/session context; a
   lane that cannot recall its own uuid reads it from its Session-Id trailer /
   the supervisor roster before running any tool.
3. Re-running the same CI because the head moved is inherent to a fix loop, but
   only via oc-prchecks re-dispatch (never a second raw watcher) — pr-checks.yml
   now carries a concurrency group (`cancel-in-progress: true`, owner fix) so
   the superseded run is auto-cancelled and minutes stop burning.
4. **Hand-rolled gate watchers must gate the wake on TERMINAL state** (v0.4.71,
   Duty-4 P1): a watcher that
   fires on elapsed time alone reports `status=in_progress` runs as verdicts.
   Gate on `gh run view --json status` == `completed` (then read
   `conclusion`), or use `oc-prchecks --wait`. Verdict fidelity (v0.4.56)
   covers oc-prchecks only — hand-rolled wrappers do not inherit it.
5. **Read detached-waiter rc at TOP level** (v0.4.71, Duty-4 P12): in a pipe,
   (`tail`/`head`), not the tool's. Capture the tool's rc before piping
   (`rc=$?` on the bare invocation, then pipe its output), or use
   `PIPESTATUS`.
6. **Waiter self-check includes pattern-vs-format** (v0.4.71, Duty-4 P7): before ending the turn, confirm the
   waiter's grep/jq pattern matches the tool's ACTUAL journal format
   (oc-prchecks writes `run=<id>`, not `run <id>`) by reading one real log
   line back.
7. **oc-prchecks is invoke-once** (v0.4.71, Duty-4 P11): never re-invoke oc-prchecks in a loop. Exit 5 = in-flight; resume
   via `gh run view <id>` / a read-only poller, `gh run rerun <id>` for a
   dead run. A looping re-invoke is a self-inflicted dispatch storm.
8. **Checkout-ref is terminal truth (Duty-4 P2, v0.4.77):** the job NAME only
   identifies the DISPATCH; the run's checkout log line identifies the TESTED
   TREE — only the checkout-ref is terminal truth for code-level verdicts.
   Verify the run checked out your head sha before reading any verdict as lane
   evidence; a mismatch is a carrier bug against the dispatch path — come
   straight to the supervisor with run id + checkout-ref + ledger incident
   stamp (suspect the single-flight dispatch lock adoption).
9. **Dispatch identity check (Duty-4 P3, v0.4.77):** after dispatching, verify
   the run actually carries your head (job name embeds the head sha) before
   waiting on it — a dispatch that fired on the wrong ref wastes the whole
   wait. oc-prchecks headSha adoption enforces this for its own runs; the
   check covers hand-dispatched `gh workflow run` uses.
## Mid-cycle skill drift — pull-check on every detached resume (v0.4.52)

Claim-time re-read (Phase 1 step 0) covers the START of a task; bumps keep
shipping mid-flight (cadence is FIRE territory). Skill files are plain disk
files read on demand — nothing is cached in-session — so "reload" = re-read:

1. On every turn that resumes from a detached long command (result injection)
   or wakes to a `session_notify`, FIRST run
   `tools/oc-drift-check <your-uuid> <claimed-ver> [--ack]` (mechanical:
   version-shape validated; `--ack` stamps the adoption record directly).
2. Drift → re-read SKILL.md + editor.md in full from disk, then stamp
   `oc-ledger ack <your-roster-uuid> <new-version>` (shape `0.N.N`, `v`
   prefix tolerated — v0.4.55 fixed the N.N-only regex that made every real
   version un-ackable) — the ack row is the
   mechanical adoption record (supervisor Duty 3 reads it for skew-chase).
3. Apply changed rules from the NEXT phase boundary — a phase already in
   flight finishes under the rules it started under. Doc-only drift adopts
   immediately; workflow-shape drift waits for the boundary.
4. `tools/*` need NO reload: every invocation is a fresh process off disk,
   always the newest version — that is also why tool-level fixes (vocabulary,
   sweep lists) never strand a running lane.

No reload volley is owed to you (v0.4.19 disk absorption stands) — the
pull-check is YOUR duty; supervisor notifies stay targeted per Duty 3.

## Tool reference — editor's quick table

Canonical descriptions + selftest contracts: SKILL.md tool table. The
editor-relevant subset, invocation forms only (all paths relative to the skill
dir; `OC_ACTOR=<your full uuid>` on every call):

| Tool | Invocation | For | rc |
|------|-----------|-----|-----|
| `oc-wt` | `tools/oc-wt add <task> <branch>` / `remove <task>` | worktree per task; chains prune→fetch→add→oc-index-worktree | 0 ok / dirty-tree gate on remove |
| `oc-index-worktree` | `tools/oc-index-worktree <worktree-path>` | codegraph index — un-skippable Phase 2 final leg (oc-wt chain) | 0 ok / 4 index-failed / 5 bad-input |
| `oc-prchecks` | `tools/oc-prchecks <branch> --repo leshchenko1979/opencrabs` | dispatch + wait PR gate; exit 5 = run URL to resume | 0 GREEN / 2 usage / 3 RED / 5 resume |
| `oc-issue-sweep` | `tools/oc-issue-sweep '<query>' [--fork R] [--upstream R] [--limit N]` | Phase 1 step 1 uniqueness gate (fork open+closed + upstream closed) | 0 no-candidates / 1 candidates / 2 usage / 3 api |
| `oc-issue-log` | `tools/oc-issue-log <issue-n> <sha>` | Phase 6 per-commit implementation comment (body-file discipline inside) | 0 posted / 2 usage / 3 gh |
| `oc-commit` | `tools/oc-commit -m "<msg>" [--issue N] [--no-comment]` | gated SIGNED commit: Session-Id + Issue-Ref trailers derived from OC_ACTOR + ledger claim; implementation comment folded in (oc-issue-log leg) — Phase 6c step 2 default | 0 committed / 2 usage / 3 gate-fail / 4 git-fail / 5 comment-fail |
| `oc-ledger` | `stamp claim --what "…"` (canonical: `--what`; bare positional also accepted) · `ack <uuid> <0.N.N>` · `commit-pending` · `confirm` | roster + receipts + version ack | 0 ok / 2 usage |
| `oc-drift-check` | `tools/oc-drift-check <your-uuid> <claimed-ver> [--ack]` | §Mid-cycle skill drift step 1–2 | 0 no-drift / 1 DRIFT |
| `oc-deploy` | `ship --execute` · `poll` · `watch` · `fanout` | ship chain (dispatch → watch → swap); ship dispatch is leg 1 ONLY — watch+swap REQUIRED | see SKILL.md |
| `oc-upstream-delta` | `tools/oc-upstream-delta` | fork vs upstream divergence read | 0 ok |
| `oc-attrib` | `tools/oc-attrib --deployed` | who owns the deployed range (fanout targeting) | 0 ok |
| `oc-branch-sweep` | `tools/oc-branch-sweep --repo <path>` | merged/stale branch proof; deletes MERGED only | 0 nothing-deleted / 1 deletions / 2 usage / 3 git |
| `oc-pr-fault-scope` | `tools/oc-pr-fault-scope <pr> --run <id>` | failing-files ∩ PR-files (blame hygiene) | 0 in-scope / base-fault |

Rules that outlive any table: journal read-back after every `oc-ledger`
claim/stamp (Phase 1 step 4); terminal truth = `gh run view --json conclusion`, never
a tool's exit code alone; the ≥60s detached-poll floor (supervisor.md §CI-wait & waiter discipline, item W1).

## Phase 0 — Fresh base

```bash
git -C ~/opencrabs fetch origin && git -C ~/opencrabs fetch adolfousier
```

- Branch off fresh `origin/main`; merge-sync RETIRED (2026-08-26, REBASE-PORT —
  SKILL.md §Upstream relations): NEVER `merge --ff-only adolfousier/main` into
  the shared checkout.
- **The shared `~/opencrabs` checkout is NEVER evidence** (v0.4.5): it may sit on any
  session's leftover branch. Verify shipped behavior against `origin/main`
  explicitly (`git fetch origin && git show origin/main:<path>`) or in a fresh
  worktree cut from `origin/main` (lens B F2, v0.4.79 — completed truncated rule).
- Before building on an existing branch: diff it against its merge-base to confirm no
  foreign WIP rode along from parallel agents. Take a backup branch ref before any
  `rebase --onto`. *(SKILL.md §Shared war stories)*

## Phase 1 — Claim on the fork BEFORE editing

0. **Claim-time fresh re-read (v0.4.14, proposal P2)**: FIRST action after
   claiming — re-read `SKILL.md` + `editor.md` in FULL from disk (never from
   recalled memory). A claim opens a fresh working window; pre-read memory from
   earlier turns carries stale mechanics. DONE = both files re-read in full
   THIS turn.

1. Search existing issues first — MECHANIZED: `tools/oc-issue-sweep '<query>'`
   (closed-issue hygiene sweep: fork open + fork closed + upstream closed,
   harvests `close-reason:` lines from comments, TSV; the raw form is
   `gh search issues ... -R leshchenko1979/opencrabs`
   (the issues home). UNIQUENESS GATE (v0.4.17):
   "no issue covers this" may be asserted only after a CLOSED-state sweep AND
   paginated comments (--paginate) — an open-only page-one check missed entire
   closed-issue families.
   TWO histories to sweep: the fork (open + closed — ours) AND upstream closed
   issues (pre-2026-08-27 issues were filed on `adolfousier/opencrabs`; the
   reason for any close is always in the comments — read with `--paginate`).
2. None fits → open ONE issue ON THE FORK:
   `gh issue create -R leshchenko1979/opencrabs` (symptom + evidence: error
   text, run link, sha). Routing + body rules: SKILL.md §ISSUE ROUTING.
3. **NO CLAIMING ON THE FORK** (SKILL.md §ISSUE ROUTING): no tackling comments, self-assignment, labels/reactions
   on fork issues — the owner's notification surface stays clean. Claim
   record = `Issue-Ref: #N` trailer on commits/PR + your feature row in
   `workers-ledger.json` (first ledger timestamp wins; conflicts are supervisor
   rulings, never GitHub chatter). The uniqueness sweep in step 1 stays
   read-only search.
4. **Claim read-back (Duty-4, v0.4.71):** after EVERY
   `oc-ledger claim`/`stamp`, RE-READ the returned event row and verify it
   carries your uuid + issue + branch + the full non-empty `what` text you
   passed — a glitched argv can silently produce an empty claim the lane cites
   as proof. A read-back mismatch
   = re-stamp + `tools.log` check before anything cites the event number.
5. **Requirement intake — persist processed, not verbatim:** when the editor receives a NEW or MATERIALLY UPDATED requirement
   (owner word, or a clarification that changes scope/shape mid-task), persist
   it in a fork issue BEFORE executing: update the issue already being worked
   when the requirement extends it; open a new one when it is a distinct
   concern. The persisted form is the PROCESSED requirement — normalized into
   the actionable statement (what changes, acceptance, out-of-scope) — never a
   raw chat quote. Subsequent commits/claims carry `Issue-Ref: #N` like any
   other work. Why: a session that dies mid-task must leave the requirement
   recoverable from durable state, not chat memory.

**Issue/PR body claims require code-verified evidence** (v0.4.71, Duty-4).
Before filing or
updating issue/PR text, every causal claim carries `file:line` or executed
command output. AGENTS.md's verify-everything covers actions; this gate
covers WRITTEN ARTIFACT claims.

## Phase 2 — Worktree per task, before any edits

```bash
~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-wt add <task> <branch>
# oc-wt chains prune -> fetch origin -> worktree add -> oc-index-worktree.
# The index step is UN-SKIPPABLE: worktrees inherit NO per-tree index
# (.codegraph is per-tree; a worktree's .git is only a gitdir: pointer), so an
# unindexed tree silently returns empty codegraph queries (the incident class
# oc-wt exists to kill, v0.4.12 -> v0.4.46). Teardown:
#   tools/oc-wt remove <task>   (dirty-tree gate; --force journals the listing)
```

Branch name = `<type>/<slug>` (type ∈ `feat|fix|ci|chore`) per the reserved
namespace rule in SKILL.md. The `leshchenko1979/*` namespace is OFF LIMITS here (reserved
for Phase 7 — its own rules live there).

Worktrees are cut from FRESHLY FETCHED `origin/main`, never from the shared
checkout's current branch state (v0.4.5). After any upstream rebase-port, RELOCATE
your own merged fixes by Session-Id trailer or commit MESSAGE, never by old shas —
porting rewrites history and shas dangle.

ALL edits happen in the worktree, never in the shared checkout. One task = one
worktree = one branch. Parallel agents share the repo; the shared checkout can be
switched under you mid-task at any moment.

Never reuse another live task's path — `oc-wt` prunes stale entries and
validates on every add (lifecycle below).

**Worktree lifecycle — delete early, recreate on demand**

The worktree's job ends the moment your code is committed AND pushed — CI
compiles on GitHub, not here. Proven fixes fast-forward into fork `main`
(Phase 6), so fork main accumulates everything we ship; upstream receives
finished features only via the completion-time PR (Phase 7).

DELETE immediately after a verified clean push:

```bash
git -C ~/oc-wt-<task> status --porcelain   # must be empty — all committed & pushed
tools/oc-wt remove <task>                  # dirty-tree gate + journals the destroyed listing
```

RECREATE whenever a fix round begins (red run handed back, smoke-test fix
request): ALWAYS a NEW tree — same branch, same creation steps as the first
time (`tools/oc-wt add <task> <branch>` — prune/fetch/validate/behind-base
gates chained; continue Phase 3/5):

```bash
tools/oc-wt add <task> <branch>
```

`oc-wt` prunes stale entries on every add — never run bare
`git worktree prune` as a ritual step; `git worktree list` only to view.

**Worktree-writer exclusivity (P6 v0.4.14 + P9 v0.4.17): while holding an
active worktree ALL delegated execution runs INLINE in the owning session —
plan-driven tasks included (isolated=false), never auto-spawned isolated
sub-agents of ANY scope**: auto-spawned isolated workers
report "done" while the diff is still empty, then their edits surface LATE and
UNCOMMITTED in your tree, racing the parent's verification reads. Deliverable
ops (surgical fixes, merge landings) are editor-own.

## Phase 3 — Explore before writing

- **Structure, callers, impact chains:** `grep_code` (codegraph) — who calls this,
  what else breaks when it changes.
- **Library APIs and version behavior:** `grep_docs` (Context7) — verify the method
  EXISTS and which trait provides it BEFORE using it. *(teloxide setters are
  per-payload traits: import every trait whose method you call)*
- **Duplication check (DRY):** assume a helper already exists — find it before
  writing a new one. Reuse beats re-implement.
- **Module size:** prefer extracting a NEW module over growing any file past
  ~1000 lines.
DONE = callers enumerated (or confirmed absent) and every new API call
verified against its trait/docs before the first edit.

## Phase 4 — Shape the change

- One logical change per branch; drive-by refactors go to their own branch + issue.
- Stage only paths YOU changed: `git add <paths>`. Never `git add -A`, never `commit -a`.
- Never revert/reset/amend commits you did not write — report and wait, or branch off.
- **New enum variant → grep ALL matches on it before committing** (v0.4.71,
  Duty-4 P14). `grep -rn '<Variant>::' src/`
  catches both classes pre-commit — box law means they otherwise surface only
  at the CI gate.
- **Revert hygiene (Duty-4 P1, v0.4.77):** after any `git revert`, grep the
  tree for stranded references to the reverted code (callers, args, fields,
  flags) BEFORE committing — a revert that leaves callers is a guaranteed CI
  RED.
- **Read back every `edit_file` result** (v0.4.5): re-read the touched region with
  `read_file` before trusting it — the tool's line report and rendered diff are
  UNTRUSTED UI.


**Branch-attached HEAD before signing (v0.4.14, proposal P5)**: confirm
`git symbolic-ref -q HEAD` resolves (non-empty) BEFORE committing + signing — a
detached HEAD commits silently to a nameless sha, invisible to branch pushes and
unreachable by remote-tracking name. If detached: land the sha to an explicit
ref immediately.

Signing is not optional: an unsigned commit makes you invisible to the
notification loop — your feature ships untested and your failures go
unattributed. Your full session UUID is IN YOUR PROMPT (session/runtime
context) — read it from there when composing the trailer.

**Verify the trailer block parses after ANY amend/rebase/cherry-pick that
touches the trailer area** (v0.4.71, Duty-4 P2). `git interpret-trailers --parse` (or a `gh api`
commit-body scan) must show every expected trailer before the sha enters any
gate or push.

**Test placement (CONTRIBUTING.md policy, from Phase 7 step 2c):** tests live under `src/tests/*_test.rs` registered in
`mod.rs`, never inline `#[cfg(test)]` blocks — upstream CI enforces both.

## Phase 5 — CI gate before every commit (CI-only since v0.4.34)

No local lint tooling on this box. The lint/static-analysis
evidence is the GREEN `pr-checks.yml` run on your branch: fmt + clippy +
`cargo test --locked --profile ci --all-features` (flags VERBATIM from
pr-checks.yml). Iterate on code locally, push the branch,
re-dispatch pr-checks, read the run log — that loop replaces every local lint run.

- **One command (v0.4.46; adoption fixed v0.4.48):** `tools/oc-prchecks <branch> [--repo SLUG-or-PATH]`
  runs the whole ritual — FULL-sha shape gate, LOUD yml-on-carrier check,
  dispatch under a state-dir lock, time-window run adoption
  (`headSha==carrier head + createdAt>=dispatch_ts−5s`, LATEST-wins since
  v0.4.53 — under the lock the newest carrier dispatch IS this lane's own run;
  the old sha-bound filter could never match: workflow_dispatch headSha is the
  carrier ref, not the `-f ref` input), watch, per-step report with the fmt
  soft-fail EXPOSED. `--repo` accepts the slug OR a repo/worktree path
  (resolved via its origin remote — no more slug/path confusion). Exit 0 GREEN /
  3 RED / 5 still-in-flight (prints the run URL for resume). The manual form
  survives as the SKILL.md tool-table fallback row.
- Gate your BRANCH state, not the shared checkout: the run proves what CI saw on
  your branch (your commits on top of the branch base).
- Push after every fix-round; the NEWEST green run URL is the evidence
  (`gh run view` / checks API). A run from before your last push proves nothing.
- Classify every finding delta vs the parent sha: same count = pre-existing (line
  shifts); any genuinely NEW finding must be named and justified or the commit does
  not leave the editor. Zero errors required in YOUR changed lines; pre-existing
  warnings in untouched files ≠ blocker.
- **NEVER chain a gate/push onto another command with `;`** — one command per line,
  verdict checked BEFORE the next command.
- **Gate-idle question sweep:** a gate wait is idle time —
  do not sit silent on open questions. Circle back to the user in your topic
  with anything unresolved (scope doubts, naming, approach forks) while the
  gate runs; waiting is never a reason to hold a question or to guess.

## Phase 6 — Push, merge into fork main, hand off

```bash
git -C ~/oc-wt-<task> push -u origin <branch>
# GATE (decision 2026-08-27, rewired 2026-08-28 per owner "1 ok"): the
# CODE TESTS evidence is the GREEN `pr-checks.yml` CI run on the branch — it
# runs `cargo test --locked --profile ci --all-features` (the CI gate is the
# only test locus — the carrier ship path runs pure-git ORDER gates, no test
# leg since 2026-08-31 `e71dba58`). NO local
# test runs on this box (box law — §Box law, top of this file: cargo
# forbidden in ANY form).
# Read the conclusion via `gh run view` / checks API: GREEN → push to main;
# RED → fix before merge. A gated change can still break other parts — CI is
# where that surfaces now.
git -C ~/oc-wt-<task> push origin <branch>:main   # fast-forward fork main — non-ff rejected
```

EVERY commit's destination is fork `main`: the build (`oc-deploy ship`) compiles
fork `main` — ALL editors' changes together
— an unmerged branch silently
never ships. **Implementation comment per commit:**
after EACH editor commit, post a short summary + commit sha + verification
state (tests/lint) as a gh comment on the tracked issue — one comment per
commit, immediately, no batching. Mechanics: `tools/oc-issue-log <issue-n> <sha>`
posts it (gh `--body-file` discipline + `--edit-last` pitfalls handled inside;
SKILL.md tool table).

Non-ff rejection = another editor landed first; integrate and retry:

```bash
git -C ~/oc-wt-<task> fetch origin
git -C ~/oc-wt-<task> rebase origin/main   # your commits only — safe to rebase
git -C ~/oc-wt-<task> push --force-with-lease origin <branch>
# gate re-applies after any rebase: re-dispatch pr-checks.yml on the rebased
# branch (fmt/clippy/test); the green run URL is the evidence — never local cargo (Box law)
git -C ~/oc-wt-<task> push origin <branch>:main
```

**Conflict-quality gate — MANDATORY before any push carrying hand-resolved code**
*(a hand-resolved merge shipping a crate-alias mismatch is five E0308s and a
red CI round-trip)*:

1. Re-read every hand-merged function END-TO-END — not just the conflict hunk.
2. Match crate-wide type aliases: open the alias definition; the error type is
   usually locked by the alias.
3. Grep the tree for duplicate imports and doubled tests the resolution may
   have left behind.
4. Phase 5 gate once MORE after the final resolution (re-dispatch pr-checks;
   the green run URL is the evidence).

Report to the ops chat: branch name + pushed sha + post-merge `main` tip — code
locations cited STRUCTURALLY (function name + matching pattern, e.g. "stash-empty
warn in agent.rs handle_followup_callback"), never bare line numbers: main moves
hourly under multi-editor concurrency and line anchors rot same-day. The hand-off ends the Editor's part — dispatching,
watching, reading conclusions are automation territory (`oc-deploy ship/poll`;
SKILL.md router).

The hand-off is not silent (v0.4.3): after ff-merge + worktree removal the lane
runs the S3 SHIP PATH below (`oc-deploy ship`) — one call carries BOTH dimensions
(full-40 sha + `features=<comma-set>`; there is NO `--all-features` vocabulary in
the carrier yml; a different-set build of the same sha is a DISTINCT build under
single-flight).
*(Pre-S3 ordering is archived — `oc-deploy ship` runs the gates itself and returns GREEN/RED.)*

## Phase 6a — Ship — oc-deploy (S3 path)

**S3 SHIP PATH — oc-deploy IS the ship path (S3 cutover, live 2026-08-28; compiler retired).**
The lane runs its own ship as an agent-launched BACKGROUND task:

```bash
/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-deploy ship \
  --sha <full-40-sha> --features <comma-set> --execute
```

The script performs the chain Phase 6's push legs feed into (ORDER gates + carrier dispatch) beyond the hand-run fork-main fetch +
fast-forward check → push → 4 ORDER gates (oc-order-validate) → carrier
dispatch on `ci/quick-build-linux` — appends every verdict to the shadow
journal (`oc-deploy-shadow.log` in the state dir), and exits 0 with the
dispatch confirmation (poll discovers the run id) or exit 2 + failing
gate to the invoking session. **Ship semantics: dispatch
is real always; deploys are real from S2 (poll mode, sha-bound, auto-swap on
GREEN — deploy consent eliminated; journaled, auto-rollback on
post-bounce verify fail stays, smoke-FAIL rollback = owner call; ledger `meta.oc_deploy_stage` gates it, exit 4 below
S2 — the stage is S3 since 2026-08-28).** Plan-only
default: omit `--execute` → full delta printed, nothing touched. Brake:
`touch /root/.opencrabs/profiles/ops/opencrabs-dev/oc-deploy.kill` (or
`/root/oc-work/oc-deploy.disabled`) aborts every invocation, exit 9. The
compiler-era ORDER hand-off lifecycle (COALESCED / intake-verify) is superseded — QUEUED…VOID stays live in oc-seal-state order rows — the
gates now run inside `oc-deploy ship` itself (tools/archive/compiler.md archived runbook).

- Red run returned → start a fix round (Phase 6c): NEW worktree every time →
  fix on the SAME branch → commit → push → report the NEW sha. Re-ship via
  `oc-deploy ship --execute`; the RED run lives on until the new green.
  Triage heuristics live in SKILL.md §Red-run triage heuristics (E0425-first,
  brace-depth counting, match-arm narrowing).
- Once the new run is green, post the fix evidence to the upstream
  issue (the Editor owns the issue thread end to end).

## Phase 6b — Smoke-test-on-notify (your features, after any swap)

A post-swap notify announcing a new binary (mechanical fan-out — `oc-deploy
fanout`, [#24](https://github.com/leshchenko1979/opencrabs/issues/24) LIVE
since v0.4.37; `[session-notify from=<uuid>]` header) means your
commits are in it — prove the FEATURE works. This phase produces SMOKE TEST
evidence (SKILL.md Test ontology): behavioral, against the RUNNING binary,
zero cargo. CODE TESTS (fmt/clippy/cargo test) are a different kind, CI-only —
Phase 5 (Phase 7 step 2c reuses it on upstream PR heads). The binary is live right here (`opencrabs-ops` user unit) —
no cargo needed.

1. Read run id + built sha from the notification body. **If the daemon bounced**
   (any restart since your last turn), RE-SURFACE lazy tool schemas via
   `tool_search` BEFORE any smoke invocation — a restart kills activated schemas
   and intents misfire onto wrong tools.
2. **IDENTITY RECEIPT first (C-F3, v0.4.72):** run `oc-smoke-evidence`
   BEFORE driving the feature — it compares the RUNNING unit's exe sha against
   the deployed markers (rc 0 IDENTITY-MATCH / 1 MISMATCH / 3 unit fail).
   MISMATCH → STOP: you would be smoking a binary that is not the one that was
   built — report the mismatch to the sender, do not smoke on a stale unit.
3. Drive your feature end-to-end against the RUNNING unit on its normal
   surfaces (Telegram, cron, MCP — whatever the feature touches). Happy path
   plus one edge case.
4. PASS → reply to the sender (`session_notify`, `target_session` = the `from`
   header): feature OK + one line of evidence + the oc-smoke-evidence
   IDENTITY-MATCH receipt. If the feature is COMPLETE,
   this same evidence goes to your forum topic as the Phase 7 approval
   request — do NOT open any upstream PR until Alexey approves it
   (APPROVAL GATE — Phase 7 step 0).
5. FAIL → FILE THE ISSUE FIRST (Phase 1 procedure: symptom + evidence — you
   found it, you file it). Then send raw evidence + the issue link to the
   supervisor lane (`session_notify`) — do NOT attribute, do NOT fix another
   editor's feature; attribution via Session-Id trailers is MECHANICAL
   (`oc-attrib`; decision 2026-08-25 2a, mechanical fan-out above).
6. SHIPPED UPSTREAM notice (v0.4.0): if the supervisor (or the post-swap
   fan-out) reports your feature was
   absorbed by upstream (maintainer merged or reimplemented it), your fork-side
   duty for it ENDS — no further fork maintenance, no fix rounds. Future work
   on that feature happens upstream only: new claim via Phase 1, normal rules.

**Swap timing is NOT coordinated with smokes** (owner decision, closing editor
proposal #8): NO advance announce, NO swap delay — deploys land whenever the
pipeline is ready, even mid-smoke; loss of in-flight in-memory state is ACCEPTED
until Alexey fixes it otherwise. If a bounce kills your smoke mid-run: re-arm tool
schemas (step 1), re-run from scratch — NEVER report the bounce itself as a feature
FAIL.

## Phase 6c — Fix request from a RED run (red build or failed smoke)

A RED `oc-deploy ship`/poll run or a failed smoke attributes the failure (via
`oc-attrib` Session-Id trailers) and routes the fix to the guilty editor WITH evidence.
Your answer is always the SAME sequence:

0. GATE — the bug must already HAVE an issue; the red-run hand-off names
   it. Missing? File it first (Phase 1 procedure). Fixing before filing
   violates the issue-first hard rule (SKILL.md).

```bash
# 1. fresh worktree at the relevant sha (worktree lifecycle, Phase 2)
tools/oc-wt add <task> <branch>
# 2. reproduce → fix → Phase 5 CI gate → SIGNED commit (E1, v0.4.78)
tools/oc-commit -m "<msg>"   # gated wrapper: Session-Id from OC_ACTOR, Issue-Ref
#    derived from your latest ledger claim, implementation comment folded in
#    (oc-issue-log leg). RAW FALLBACK — rebase/cherry-pick/harvest contexts only:
#    git -C ~/oc-wt-<task> commit --trailer "Session-Id: <full session uuid>" --trailer "Issue-Ref: #<issue-n>"
#    (Session-Id = you; Issue-Ref = the ONE issue this change fixes — atomicity,
#     v0.4.15: every commit links to exactly one issue, matching the PR that will carry it)
# 3. push branch, then fast-forward fork main onto it (non-ff rejected)
git -C ~/oc-wt-<task> push origin <branch>
git -C ~/oc-wt-<task> push origin <branch>:main
# 4. remove the worktree — job done
tools/oc-wt remove <task>
```

**Per-commit laws live in their phases:** branch-attached HEAD + signing → §Phase 4; worktree-writer exclusivity → §Phase 2. They bind EVERY commit in ANY phase — read them there.

5. Re-ship fork `main` via oc-deploy: `oc-deploy ship --sha <NEW-head-sha> --features <comma-set> --execute` (S3 — the compiler role is retired; shipping is the editor's own background task, it dispatches fork `main`, which now carries your fix alongside every other editor's merged work).

## Phase 7 — Feature complete → upstream PR

Trigger: the feature is COMPLETE — merged into fork `main`, shipped inside a
green swapped build, smoke test PASS **and that smoke evidence approved by
Alexey** (APPROVAL GATE, v0.4.1). Development-time contact stays issues-only;
this PR is the ONE sanctioned exception (completed features only) — but it fires
ONLY on owner approval.

```bash
# 0. OWNER APPROVAL GATE (v0.4.1): post the smoke-test EVIDENCE + an explicit
#    approval request in YOUR forum topic (what you drove, what you saw,
#    run id + built sha). Then WAIT. APPROVAL definition = SKILL.md §ISSUE
#    ROUTING (reply or positive reaction counts; silence does NOT).

# 1. list fork-only commits, pick THIS feature's (trailers + touched files)
#    — mechanized: `tools/oc-deploy contributors <old>..<new>` (3-col TSV:
#    session-uuid / issue_refs / sha7s) or `tools/oc-attrib --range` for
#    roster-resolved roles; the raw form:
git -C ~/opencrabs fetch adolfousier
git -C ~/opencrabs log --format='%H%x09%s%x09%(trailers:key=Session-Id,valueonly)' \
  adolfousier/main..origin/main

# 2. harvest onto a branch off UPSTREAM main — NEW worktree, usual hygiene
#    (-b creation is beyond oc-wt: it validates branches, never creates them —
#     so raw add here, then the UN-SKIPPABLE index chain immediately after)
git -C ~/opencrabs worktree add ~/oc-wt-up-<feature> -b leshchenko1979/<feature> adolfousier/main
tools/oc-index-worktree ~/oc-wt-up-<feature>
git -C ~/oc-wt-up-<feature> cherry-pick <sha1> <sha2> ...
# Phase 5 gate: pr-checks GREEN on the PR branch — zero errors in ported lines

# 2-pre. ATOMICITY + BASE check BEFORE the PR opens — standing rule
#     PR-BASE-PRE-OPEN in the Rules list below.

# 2c. CI gate (upstream triad) (v0.4.22 — encodes adolfousier/opencrabs
#     CONTRIBUTING.md: "You MUST pass all three before
#     submitting a PR"). v0.4.28: the triad runs in CI via pr-checks.yml (cargo is
#     FORBIDDEN on this box — box law); a green run URL IS the citation now.
#     FIRST push the head branch (step 3's command — the workflow checks the
#     branch out from the fork), then dispatch:
gh workflow run pr-checks.yml --repo leshchenko1979/opencrabs \
  --ref ci/quick-build-linux -f ref=leshchenko1979/<feature>
#   (v0.4.46: one command does all of it — tools/oc-prchecks leshchenko1979/<feature>;
#    prints the GREEN/RED verdict + run URL for the PR-body citation below)
#   Standing rules PR-GATE-STANDING in the Rules list below (flags verbatim
#   from pr-checks.yml; ANY red = fix cycle + re-dispatch, never a filed PR;
#   cite the green run URL in the PR body prep next to the smoke/run
#   evidence).

# 3. push the head branch to the FORK (PR heads live there)
git -C ~/oc-wt-up-<feature> push -u origin leshchenko1979/<feature>

# 4. open the upstream PR — detailed description; body rules are canonical in
#    the Rules bullet below (fork-issue link at END, `Closes #N` FORBIDDEN).
#    PR TITLE TYPE PREFIX: every upstream
#    AND fork PR title starts with fix: / fix(scope): (bug fix), feat: /
#    feat(scope): (new capability), or chore: (tooling/CI/docs/deps — zero
#    user-visible change). The head-branch slug mirrors the type:
#    leshchenko1979/fix/<slug> | feat/<slug> | chore/<slug> (existing branches
#    untouched).
gh pr create -R adolfousier/opencrabs --base main --head leshchenko1979:leshchenko1979/<feature> \
  --title "<fix:|feat:|chore:> <concise feature title>" \
  --body "<detailed what/why, implementation notes, green run link, smoke-test evidence. Original issue: https://github.com/leshchenko1979/opencrabs/issues/N (exactly one)>"

# 5. close the tracked FORK issue with a pointer comment
gh issue close <issue-n> -R leshchenko1979/opencrabs -c "Implemented in upstream PR adolfousier/opencrabs#<pr-number>"

# 6. remove the worktree — done (dirty-tree gate + journal via oc-wt)
tools/oc-wt remove up-<feature>
```

Rules:
- Fork-only commits means EXACTLY that: no adolfousier sync merges, no other
  feature's commits, no bare CI-config churn unless it IS the feature.
- Cherry-pick conflicts → resolve, re-run the Phase 5 gate (pr-checks), continue. NEVER merge fork
  `main` into the PR branch — upstream gets clean commits only.
- **HARVEST VERIFICATION SWEEP (Duty-4, v0.4.71):** after conflict resolution
  on a harvested branch, BEFORE the first gate dispatch — 4-leg sweep: symbol
  callers in the UPSTREAM tree, fork-side attribute port, foreign-hunk drop,
  `git patch-id` verify of rebase-ported commits. Full checklist:
  `editor-phase7-rules.md` (same dir).
- The PR body MUST reference THE issue as a FULL FORK URL at the END of the
  description (`Original issue: https://github.com/leshchenko1979/opencrabs/issues/N`
  — EXACTLY one, atomicity rule). `Closes #N` is FORBIDDEN on upstream PR bodies:
  it resolves against adolfousier's issue space, not ours (issues live on the
  fork). WE close the fork issue (step 5) right
  after the PR is up — do not wait for the maintainer merge.
- **QUALIFIED FORK REFS (fork [#54](https://github.com/leshchenko1979/opencrabs/issues/54)):**
  no bare `#N` with FORK issue numbers on any upstream surface (PR body,
  PR title, issue body, comment) OUTSIDE a code span — write
  `leshchenko1979/opencrabs#N` or the full URL (GitHub autolinks bare `#N`
  against adolfo's issue space). Code spans exempt. Bare `#N` stays reserved
  for UPSTREAM-local references. Incident + rationale:
  `editor-phase7-rules.md`.
- One feature = one PR; never bundle two features to save a PR.
- **ATOMICITY:** issues, PRs and commits are atomic —
  one problem per issue, one logical change per commit, one issue per PR. Every
  harvested commit carries an `Issue-Ref: #N` trailer matching EXACTLY the single
  issue the PR claims; no commit without one, no PR claiming more than one. A PR
  whose diff mixes fixed and unfixed concerns forces a binary status on a mixed bag
  and mislabels both. Gate with `./tools/oc-pr-atomicity <pr>` (trailer scan + body
  claim cross-check) BEFORE closing the issue. PR LIFECYCLE: one PR = one atomic change; a bug found in review is fixed
  FORWARD on the same PR or the PR is closed — no draft limbo. A MERGED PR is
  closed forever: follow-up work = new branch + new PR, NEVER extend a merged
  branch.
- **BUILD TRIGGERS = exactly TWO, no exceptions (A3 owner ruling 2026-08-29):**
  no direct quick-build PR-head dispatch; ORDER gate 3 (CONTAINMENT,
  oc-order-validate) rejects any PR-head sha — PR-head compile+lint evidence
  = step 2c's pr-checks dispatch (runs on ANY branch ref). The workflow yml
  lives ONLY on the carrier branch `ci/quick-build-linux` — never fork main,
  never the PR-head branch: zero infra commits in Adolfo's diff.
- **PR-BASE-PRE-OPEN (v0.4.71, Duty-4 P6):** an upstream PR head is a harvest
  branch off `adolfousier/main` — NEVER a fork-main-based branch; base +
  atomicity check runs BEFORE the PR opens (a post-open atomicity FALSE
  (fork-divergence commits) means the base was wrong before the PR existed).
- **PR-GATE-STANDING (step 2c):** triad flags VERBATIM from pr-checks.yml
  (fmt soft-fail mirrors upstream; clippy --locked --lib --bins --tests
  --all-features -D warnings; cargo test --locked --profile ci
  --all-features) — green here predicts green on adolfo's full gate. Iterate
  by EDITING CODE and re-dispatching pr-checks — NEVER run cargo locally
  (box law); test-placement policy → §Phase 4.
- Pre-flight gate (step 2c) is MANDATORY (v0.4.0): read the fmt STEP outcome,
  not just the run conclusion — soft-fail hides failures from the run.
- `leshchenko1979/<slug>` is the RESERVED PR-head namespace (`leshchenko1979/…`
  branch names stand out in the upstream branch list): branches with that
  prefix are created ONLY in this phase, never developed on, never merged into
  fork `main` — and NOT deleted while their PR is still open (GitHub needs the
  head alive).

## Phase 7b — PR lifecycle (monitor & unblock, v0.4.0)

Every OPEN upstream PR has an owning editor: the Session-Id trailers of its
harvested commits. When a PR is not mergeable, route by BLOCKER CLASS:

| Blocker | Who acts | Action |
|---|---|---|
| fmt/clippy/test failure in THIS feature's files | Owning editor (notified with log evidence via the mechanical post-swap fan-out — `oc-deploy fanout`) | fresh worktree off the PR head → fix → Phase 5 gate (pr-checks) + conflict-quality gate → signed push to the head |
| Merge conflicts with new upstream `main` | Owning editor | rebase / re-cherry-pick onto fresh `adolfousier/main`, force-push head |
| PRE-EXISTING upstream red (base fails in files we never touched) | ❌ NO editor pings — our code is innocent | housekeeping-PR candidate: issue filed + ledger-registered first (v0.3.8), Alexey decides |
| Maintainer rejects/closes the PR | Owning editor | REOPEN the linked issues with a pointer comment; record the outcome |

Hard rules: verify the failing log names files THIS PR actually touches BEFORE
pinging anyone (identical clippy walls on every PR can live on the upstream base). Soft-fail fmt diffs are
cosmetic — NEVER ping for fmt alone. Absorption ends the lifecycle: if the
maintainer merges/reimplements the feature, the PR story closes with a SHIPPED
UPSTREAM notice (Phase 6b item 5), not more fork-side work.
Two same-turn checks (v0.4.5): (1) BEFORE any push to a gated/frozen head branch,
RE-READ live gate state — latest issue comments + supervisor notifies — session-start
knowledge structurally cannot know what changed mid-turn. (2) Before preparing ANY follow-up
commit targeting an open PR, check its state via API (`gh pr view <n> --json
state,mergedAt`) — it may have been maintainer-merged under you. **The state gate ALSO spans every port /
cherry-pick round toward a PR head (v0.4.14, proposal P4)**: before investing a
round, fresh `gh pr view <n> --json state` — if MERGED/CLOSED, STOP and report,
do not invest the round.
