# EDITOR — commits and error fixes

**Load only after SKILL.md confirmed the role is EDITOR.**

> **RELOAD LAW (v0.4.96, lens B-F2/G-5):** after ANY context compaction or
> session spawn — not only at claim time (Phase 1 step 0) — re-read from disk,
> IN FULL: `SKILL.md` + this file + `fleet-directives.md` (thematic index
> minimum; every `[LANE]`-tagged section in FULL). Same law as the other three
> roles; this header is the in-file trigger a compacted mid-task editor hits
> even when it never re-claims.

Scope: work from an issue filed on the FORK (`leshchenko1979/opencrabs` — the issues home;
upstream receives PRs only), fix the code in a
worktree, SIGN every commit with the session trailer, push the branch, then ship via
`oc-ship-chain` (§Phase 5 — Ship (`oc-ship-chain`), below).
After any
swap containing your commits you TEST what shipped (test-on-notify loop,
Phase 6b). The Editor NEVER dispatches BUILD runs (`quick-build-linux.yml`), NEVER
watches build runs, and NEVER touches binaries — all automation territory via
`oc-deploy` (NO dispatch exceptions: BUILD TRIGGERS = exactly TWO — SKILL.md §Hard rules).
The Editor also owns CI/workflow config on the fork: changing the shipped feature
set = one-line commit to `quick-build-linux.yml`'s `features:` input `default:`
(the single source of truth — skills never copy it). When a feature is COMPLETE
(merged to fork `main`, shipped green, smoke test PASS — filing procedure: `editor-upstream-pr.md`), the Editor
additionally
owns its upstream contribution — Phase 7: harvest fork-only commits → upstream
PR → close the tracked FORK issues (procedure: `editor-upstream-pr.md`).

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
+ entrypoint walk for exact CI parity). Lint = CI (`pr-checks.yml`, run in
Phase 5 via `oc-ship-chain`; Phase 7 step 2c reuses it on upstream PR heads).
Everything
else — build, test, clippy — is CI dispatch: `pr-checks.yml` or
quick-build-linux dispatched via `oc-ship-chain`. Need
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
- Talking to another session (HQ, other editors, any lane) =
  `session_notify` with `target_session` taken from the mechanical
  `[session-notify from=<uuid>]` header or `session_search` — never a telegram
  tool aimed at their topic/thread or at the owner DM.
- Process/tooling ideas (IDEA:) → the TRIAGE lane's IDEA BOX intake —
  `session_notify` to the Triage session, strict format canonical at
  triage.md §Duty T1. You propose; Triage ACKs, stamps the ledger, and routes.
- Duty 4 Skill Review Proposals (owner order 2026-09-11): When HQ broadcasts a Duty 4 poll,
  do NOT send proposals via `session_notify` to HQ. Write your proposal directly to disk at
  `~/.opencrabs/profiles/ops/opencrabs-dev/reviews/<cycle-id>/proposals/<session-uuid>.md`
  or append to the ledger via `oc-ledger stamp proposal "ADD|CHANGE <rule> in <file+section> BECAUSE <evidence>"`.
- Tool PROBLEMS (QUIRK:) → the active **TOOLSMITH** lane directly (v0.4.130 Direct Dispatch Law; v0.4.133):
  `session_notify` (target resolved dynamically — `oc-ledger roster --live --role toolsmith`, never a uuid from memory),
  format `QUIRK: <tool> <observed behavior> BECAUSE <what you expected>` + evidence.
  Never retry-around silently, never self-patch — Toolsmith owns `tools/oc-*` tool code.
  Core daemon bugs go directly to GitHub fork issues. Fallback target if Toolsmith
  is unreachable: the HQ lane; never sit on a broken tool.
- Reads: `tg_get_messages` in your own topic only; no `tg_search_global`, no
  cross-chat/list probing. Reactions allowed (owner consent signal).

## CI-wait discipline & actor attribution

*(Waiter-discipline items — poll floor, --wait ceiling, invocation
verify, notify wiring, log-window cuts, REST casing — live canonically in:
fleet-directives.md §CI-wait discipline & actor attribution.)*

**Direct dispatch (owner order 2026-09-10, fleet-directives §Direct dispatch):
work orders go sender → resource-owner directly — never through an intermediary
lane. Address by full uuid from a same-turn roster read; stamp the dispatch +
receipt id via oc-ledger.**

1. **Detached command execution (`background: true` — THE standard):** Long-running
   operations (>60s, CI waits, test batteries, multi-step chains) run detached via the
   bash tool parameter `background: true`. Hand-rolled `nohup` scripts, sleep loops,
   and custom background daemons are FORBIDDEN. The daemon harness natively tracks
   detached execution and auto-resumes your session with the result upon exit.
2. **`OC_ACTOR=<session-uuid>` MUST be exported on every `oc-*` tool
   invocation** — `lib/oc-log.sh` stamps `actor:` from it (unset → `"unknown"`),
   making floods and behavior attributable after the fact and feeding the
   ledger-beats-memory guard (the CONSENT REGISTER live-record rule: ledger
   beats memory when they disagree). This session's uuid comes from the runtime
   prompt/session context; a
   lane that cannot recall its own uuid reads it from its Session-Id trailer /
   the HQ roster before running any tool.
3. Re-running the same CI because the head moved is inherent to a fix loop, but
   only via oc-prchecks re-dispatch — pr-checks.yml carries a concurrency group
   (`cancel-in-progress: true`, owner fix) so the superseded run is auto-cancelled.
4. **Checkout-ref is terminal truth (Duty-4 P2, v0.4.77):** the job NAME only
   identifies the DISPATCH; the run's checkout log line identifies the TESTED
   TREE — only the checkout-ref is terminal truth for code-level verdicts.
   Verify the run checked out your head sha before reading any verdict as lane
   evidence; a mismatch is a carrier bug against the dispatch path — come
   straight to HQ with run id + checkout-ref + ledger incident
   stamp (suspect the single-flight dispatch lock adoption).
5. **Dispatch identity check (Duty-4 P3, v0.4.77):** after dispatching, verify
   the run actually carries your head (job name embeds the head sha) before
   waiting on it — a dispatch that fired on the wrong ref wastes the whole
   wait. oc-prchecks headSha adoption enforces this for its own runs; the
   check covers hand-dispatched `gh workflow run` uses.
6. **Dispatch-receipt gate (Duty-4 proposal d5863180, owner "All 4 go"
   2026-09-07, semantic):** a dispatch is NOT dispatchable-upon until its
   receipt is IN HAND — the dispatch command returned rc==0 AND an adopted
   run id is witnessed (API run-search/job-name decode for a recovered
   mid-flight invocation).
7. **Full shas from rev-parse only (Duty-4 P8, v0.4.80):** any 40-char sha in
   a command or report is copied from SAME-TURN `git rev-parse` / `gh api`
   output — never completed from a remembered prefix (2026-09-01 incident
   n=1452: a fabricated tail burned two gh dispatches; the first hypothesis
   after a lookup failure following a from-memory sha is SELF-FABRICATION —
   re-derive before blaming GitHub).
8. **Solo-surface rule (Duty-4 proposal d5863180, owner "All 4 go"
   2026-09-07, semantic):** a SIDE-EFFECT command whose output is the only
   receipt of the action it took (`gh pr create`, `gh issue create`, dispatch
   verbs, anything minting an identifier) runs SOLO in its tool call so its
   output is witnessed. Batched inside a multi-command call whose tail output
   was truncated/lost → the identifier is UNFILED until a fresh verification
   call (`gh pr view`, `gh api`) names it in a same-turn receipt. Root cause
   of the #1272 phantom-PR report (2026-09-07) — a `gh pr create` whose
   output the lane never saw got reported as filed; third phantom-family
   instance for that lane.
9. **PR-state claims need a same-turn `gh pr view` receipt (Duty-6/#1431
   lesson, v0.4.91):** any claim that a PR was created, updated, re-pointed,
   or "auto-updated" by a push is UNVERIFIED until `gh pr view <n> --json
   headRefOid,headRefName,state` names the EXPECTED head sha and repo — a
   force-push to a fork branch does NOT move a PR whose head branch lives on
   another repo (#1431, 2026-09-07: "PR head auto-updated" claim dissolved on
   first-hand check; headRefOid was still the old rider sha). Check event +
   branch + head sha ALL match before concluding PR state.
## Mid-cycle skill drift — pull-check on every detached resume (v0.4.52)

Claim-time re-read (Phase 1 step 0) covers the START of a task; bumps keep
shipping mid-flight (cadence is FIRE territory — FIRE = the release window
between version bump and prod swap, defined here lens A8 v0.4.89). Skill files are plain disk
files read on demand — nothing is cached in-session — so "reload" = re-read:

1. On every turn that resumes from a detached long command (result injection)
   or wakes to a `session_notify`, FIRST run
   `tools/oc-drift-check <your-uuid> <claimed-ver> [--ack]` (mechanical:
   version-shape validated; `--ack` stamps the adoption record directly).
2. Drift → re-read SKILL.md + editor.md in full from disk, then stamp
   `oc-ledger ack <your-roster-uuid> <new-version>` (shape `0.N.N`, `v`
   prefix tolerated — v0.4.55 fixed the N.N-only regex that made every real
   version un-ackable) — the ack row is the
   mechanical adoption record (HQ Duty 3 reads it for skew-chase).
3. Apply changed rules from the NEXT phase boundary — a phase already in
   flight finishes under the rules it started under. Doc-only drift adopts
   immediately; workflow-shape drift waits for the boundary.
4. `tools/*` need NO reload: every invocation is a fresh process off disk,
   always the newest version — that is also why tool-level fixes (vocabulary,
   sweep lists) never strand a running lane.
5. **Tool discovery (owner order 2026-09-07, v0.4.94):** the table below is
   the role-DAILY subset, not the inventory — the full tool list (38 tools)
   lives in `tools/RC-CONTRACT.md` (every tool: invocation, rc register,
   selftest owner). Before hand-rolling any check (item 11), grep
   RC-CONTRACT.md for a purpose-built tool — verification, audit, smoke,
   artifact and log work especially: a tool likely already exists.
6. **PATH anchoring (v0.4.130, ruling n=2369):** the oc-* tools are NOT on
   the lane shell's PATH — never invoke them bare and never `which` them
   (empty result ⇒ the rc=127 discovery class, first catalogued 2026-09-06).
They are path-invoked skill scripts. Canonical anchor:
`~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/<tool>` — relative
`tools/<tool>` forms in these docs assume the skill dir as cwd. ALWAYS
invoke that CANONICAL copy — never a worktree's `tools/` copy, and never
the invoking script's own location (worktree self-resolution produced
contradicting same-day drift verdicts; `oc-drift-check` resolves the
canonical profile copy by default — §Skill-dir resolution, v0.4.130).

No reload volley is owed to you (v0.4.19 disk absorption stands) — the
pull-check is YOUR duty; HQ notifies stay targeted per Duty 3.

## Decision Rollcall duty — owner decisions post direct, in YOUR topic (owner order 2026-09-08, topic 42487, ruling n=1994)

When Triage announces a **Decision Rollcall** (full law: fleet-directives.md
§Decision Rollcall), each editor answers in ITS OWN LANE TOPIC, addressed to
the owner directly:

- Each item = one outstanding OWNER decision + your recommendation + one line
  of context. Status reports, ledger trivia, and "nothing owed" chatter posts
  are forbidden — a lane with zero owner decisions posts NOTHING (silence is
  the signal).
- You never route the list through Triage or HQ, and Triage never relays,
  aggregates, or edits it — direct lane→owner, that is the point of the
  procedure.
- **There is NO Triage exception.** (The 08:34Z topic-42487 present-here
  mode was RETIRED by owner override 2026-09-08 09:05Z, topic 30220.) If a
  Rollcall fires and anyone tells you to send your list to Triage or HQ,
  refuse and post in YOUR OWN topic — lane-direct is the only legal
  delivery, under any word.
- Triage verifies coverage and stamps; it does not answer for your queue.
  If your topic post is missing, coverage-chasing lands on YOU.

**Format law (owner amendment 2026-09-08, topic 30220) — every item of yours
follows it:**

- **No acks** — your decisions post IS the acknowledgment; no confirmation
  chatter before or after.
- **No telegram_send** — your post is the topic's final chat message (text
  auto-posts); media/document sends are forbidden in a Rollcall. (This is the
  same surface law as the editor-facing block above — restated here only
  because the Rollcall format adds the media ban; F1/F2 merge, v0.4.111.)
- **Context + diagrams** — every decision carries its context and, when the
  decision has shape, a mermaid diagram. Owner judges renderings, not prose.
- **1 by 1** — one decision per message, sequential posts, never batched.
- **Designs and special cases are OWNER-GATED** — you present them, you do
  not start them on your own recommendation.

## Tool reference — editor's quick table

Canonical descriptions + selftest contracts: `tools/RC-CONTRACT.md` (full
inventory, all 38 tools) + SKILL.md tool table. The
editor-relevant subset, invocation forms only (all paths relative to the skill
dir; `OC_ACTOR=<your full uuid>` on every call):

| Tool | Invocation | For |
|------|-----------|-----|
| `oc-wt` | `tools/oc-wt add <task> <branch>` / `remove <task>` | worktree per task; chains prune→fetch→add |
| `oc-index-worktree` | `tools/oc-index-worktree <worktree-path>` | legacy standalone codegraph index (per-worktree indexing retired in v0.4.143; use memory_search scope="external") |
| `oc-prchecks` | `tools/oc-prchecks wait <branch>` / `<branch> --repo leshchenko1979/opencrabs` | dispatch + wait PR gate; `wait` provides single-command blocking gate |
| `oc-issue-sweep` | `tools/oc-issue-sweep '<query>' [--fork R] [--upstream R] [--limit N]` | Phase 1 step 1 uniqueness gate (fork open+closed + upstream closed) |
| `oc-issue-log` | `tools/oc-issue-log <issue-n> <sha>` | per-commit implementation comment (body-file discipline inside; chained by oc-ship-chain Leg 2) |
| `oc-commit` | `tools/oc-commit -m "<msg>" [--issue N] [--no-comment]` | gated SIGNED commit: Session-Id + Issue-Ref trailers derived from OC_ACTOR + ledger claim; implementation comment folded in (oc-issue-log leg) — Phase 6c step 2 default |
| `oc-ledger` | `stamp claim --what "…"` · `--verbs` · `ack <uuid> <0.N.N>` · `commit-pending` · `confirm` | roster + receipts + version ack; `--verbs` discovers subcommands |
| `oc-drift-check` | `tools/oc-drift-check <your-uuid> <claimed-ver> [--ack]` | §Mid-cycle skill drift step 1–2 |
| `oc-deploy` | `ship --execute` · `poll` · `status [--json]` · `watch` · `fanout` | ship chain (dispatch → watch → swap); `status` verifies running vs disk binary |
| `oc-upstream-delta` | `tools/oc-upstream-delta` | fork vs upstream divergence read |
| `oc-attrib` | `tools/oc-attrib --deployed` | who owns the deployed range (fanout targeting) |
| `oc-branch-sweep` | `tools/oc-branch-sweep --repo <path>` | merged/stale branch proof; deletes MERGED only |
| `oc-pr-fault-scope` | `tools/oc-pr-fault-scope <pr> --run <id>` | failing-files ∩ PR-files (blame hygiene) |

Per-tool rc registers: `tools/RC-CONTRACT.md` (sole register; rows above carry purpose only).

Rules that outlive any table: journal read-back after every `oc-ledger`
claim/stamp (Phase 1 step 4); terminal truth = `gh run view --json conclusion`, never
a tool's exit code alone; the ≥60s detached-poll floor (fleet-directives.md §CI-wait discipline & actor attribution).

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
   claiming — re-read `SKILL.md` + `editor.md` + `fleet-directives.md` from disk
   (never from recalled memory) — SKILL.md and editor.md in FULL, fleet-directives
   at thematic-index minimum with every `[LANE]`-tagged section in FULL. A claim
   opens a fresh working window; pre-read memory from earlier turns carries stale
   mechanics. DONE = all three files re-read THIS turn. **RELOAD LAW (v0.4.95,
   owner order 2026-09-07 19:47Z):** briefing dies at compaction — the binding
   owner law (cadence, PR naming, telegram surface, upstream etiquette) lives in
   fleet-directives.md on disk, not in session memory.

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
   `workers-ledger.json` (first ledger timestamp wins; conflicts are HQ
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
# oc-wt chains prune -> fetch origin -> validate local branch -> behind-base gate -> worktree add.
# Per-worktree indexing is RETIRED (v0.4.143): code-structure exploration is handled
# centrally via core memory_search(query="who calls X", scope="external").
# Teardown:
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
(Phase 5 `oc-ship-chain`), so fork main accumulates everything we ship; upstream receives
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

**rustfmt = NON-FATAL diagnostic pre-pass (Duty-4 P6, v0.4.80):** run fmt
before `oc-commit`; a fmt failure is a diagnostic to fix and re-run — never a
hard abort ahead of git (that forces manual trailers + a hand-posted
implementation comment).

**Post-fmt scope audit BEFORE staging (Duty-4 P7, v0.4.80):** after any fmt
pass, audit the diff before staging — rustfmt can reformat unrelated
pre-existing lines (2026-09-01: flow.rs:418); revert out-of-scope hunks and
keep the commit pure (atomicity law).

**fmt-clean ≠ compiles — audit CALL-SITE SHAPE before you chain (v0.4.141).**
There is no local compile path on this box: `which cargo` prints a path, but
running it prints `BLOCKED` — *the presence of a path is not evidence of a
toolchain*, the same family as "an empty result from a wrong path is not a
verdict". `rustfmt --edition 2024 --check` proves FORMATTING only, so the first
real compile is CI — a full gate dispatch. Before `oc-ship-chain`, mechanically
cross-check every NEW or CHANGED call site against the callee's real definition:
**free fn vs associated fn** (a free-fn path on an associated fn is `E0425`),
the **receiver** (`&self` / `&mut self` / none), and **`Drop`-impl move rules**
(moving a field out of `&mut self` in `drop` is `E0507` — take it with
`Option::take()`). Lane `facd50af` (2026-09-11, #111) burned a whole gate budget
on exactly these two classes after a clean fmt pre-pass.

## Phase 5 — Ship (`oc-ship-chain`)

**`oc-ship-chain` IS the single, exclusive ship path from commit to swapped binary (v0.4.126; manual push-to-main, manual issue-log, and manual oc-deploy sediment retired v0.4.132).**
The Editor runs `oc-ship-chain` in one detached invocation under one chain-id:

```bash
# 1. Push your branch first
git -C ~/oc-wt-<task> push -u origin <branch>

# 2. Run the ship chain (runs in background; resumes session on finish)
tools/oc-ship-chain --sha <commit-sha> --branch <branch> [--issue <issue-n>]
```

`oc-ship-chain` executes the entire 5→swapped stretch mechanically:
1. **Leg 1 (CI Gate):** Dispatches and watches `oc-prchecks` (`pr-checks.yml` on your branch: fmt + clippy + `cargo test --locked --profile ci --all-features`).
2. **Leg 2 (Issue Log):** If `--issue <N>` is supplied, posts the per-commit implementation comment via `oc-issue-log` automatically.
3. **Leg 3 (Fast-Forward Merge):** Fetches fork `main`, verifies fast-forwardability, and pushes `<branch>:main`.
4. **Leg 4 (Carrier Ship):** Dispatches `oc-deploy ship --sha <sha> --execute` to build on `ci/quick-build-linux`.
5. **Leg 5 (Swap & Seal):** Bounded-polls carrier execution (`oc-deploy poll --execute --wait <sec>`) until the binary is live and swapped.

There is NO legitimate manual exit point between gate verdict and swap. The #134 orphan class (stopping at GREEN without swapping) is structurally closed.

### Failure Modes, Tool Automations & Agent Recovery Protocol (v0.4.145)

When shipping features via `oc-ship-chain` or deploying via `oc-deploy`, failures and interruptions follow the mechanical automation vs. manual resolution contract below:

| Failure Mode | Return Code / Signal | What is Mechanical (Automated by Tool) | What Requires Agent (Semantic Fix) | Tool Output & Communication |
|---|---|---|---|---|
| **1. Non-Fast-Forward Push** | `rc=0` (Auto) / `rc=5` (Conflict) | **100% Automated by tool** on clean rebase: `oc-deploy`/`oc-ship-chain` auto-fetches `origin/main`, rebases topic commits, audits with `oc-rebase-safety audit`, and retries push in 3s. | Only if git hits a **semantic merge conflict**: agent inspects conflicting files (`git status`), resolves diff, re-runs chain. | `REBASE_CLEAN: auto-pushed rebased SHA` (clean) OR `REBASE_CONFLICT: manual diff needed in <file>` (conflict) |
| **2. Carrier Compilation Failure** | `rc=3` (`build-failed`) | **Auto-log extraction**: Tool automatically runs `gh run view <id> --log-failed`, parses `error[E...]` and rustc diagnostic lines, and prints the exact compiler error and file:line in tool stderr. | Agent fixes the Rust syntax, borrow checker, or missing module error in the worktree, commits, and re-runs `oc-ship-chain`. | `CARRIER_BUILD_FAILED (rc=3): Run <id>` followed by extracted compiler error block |
| **3. Daemon Boot Panic / Swap Failure** | `rc=4` (`swap-failed`) | **Auto-rollback & Auto-diag**: `oc-deploy swap-execute` **automatically rolls back** to the previous binary (`/usr/local/bin/opencrabs.bak`), restarts the service, and automatically extracts the panic backtrace from `journalctl -u opencrabs-ops.service -n 30` into tool output. | Agent inspects the auto-extracted panic trace, reproduces/fixes the startup bug or bad unwrap in the worktree, commits, and re-chains. Host remains 100% healthy. | `SWAP_FAILED (rc=4): Auto-rolled back to previous binary. Daemon boot panic: <extracted log>` |
| **4. Daemon Bounce Task Interruption** | Restart signal / `[BACKGROUND TASK INTERRUPTED]` | **100% Automated via state file & resume probe**: `oc-deploy swap-execute` runs in an isolated transient `systemd-run` unit and writes deployment result to `/root/.opencrabs/profiles/ops/opencrabs-dev/deployed.sha`. Tool provides `oc-ship-chain --resume` or post-swap status check. | **Zero agent action required**: When agent wakes up post-restart, running `oc-ship-chain --resume` (or checking `deployed.sha`) confirms `disk==proc MATCH` and tells the agent to proceed immediately to Phase 6b smoke testing. | `SWAP_SUCCESSFUL: running binary matches deployed SHA. Ready for Phase 6b smoke.` |

**Exit codes & Lane action:**
- **Exit 0 — SWAPPED:** The new binary is running live on the host (`opencrabs-ops` user unit). Worktree can now be removed (`tools/oc-wt remove <task>`). Proceed immediately to Phase 6b (Smoke-test-on-notify).
- **Exit 2 — USAGE:** Bad or missing arguments (`--sha`/`--branch` are required; malformed flag). Correct the invocation and re-run — no lane state to resolve.
- **Exit 3 — DIRTY CHECKOUT:** The fork checkout has uncommitted changes (pre-flight refusal). Clean or stash it, then re-run.
- **Exit 4 — GATE-RED / CARRIER-RED:** The CI gate failed or the carrier build failed. Start a fix round (Phase 6c): keep the same branch, fix in a new worktree, commit, push, and re-run `oc-ship-chain`. Triage heuristics live in `SKILL.md §Red-run triage heuristics`. **Also the `--gated-run` / `--gated-sha` pre-verify failure:** the supplied run was not `completed success` on a job pinned to the sha, or `--gated-sha` did not match `--sha`. Do NOT re-dispatch the run — re-verify it with `gh run view <id> --json status,conclusion,jobs` and re-supply the correct id.
- **Exit 5 — NON-FF / MERGE CONFLICT:** Automatic in-tool rebase encountered an actual semantic merge conflict that requires manual diff adjudication:
  ```bash
  git -C ~/oc-wt-<task> fetch origin
  git -C ~/oc-wt-<task> rebase origin/main
  # resolve conflicts in working tree
  git -C ~/oc-wt-<task> push --force-with-lease origin <branch>
  ```
  ⚠️ **`oc-rebase-safety` is NOT the rebase engine** — it is a READ-ONLY safety auditor (`audit` / `overlap`). Use standard git commands to resolve conflicts, verify zero lost edits with `oc-rebase-safety audit`, and re-run `oc-ship-chain`.
- **Exit 6 — INFRA / ORDER-GATE:** dispatch or poll infrastructure failure (`oc-prchecks` rc 4/7/8, or ship rc other) — **or an ORDER-gate rejection post-push.** ⚠️ **The UNSIGNED case lands HERE, and it is NOT an infra fault:** a head commit carrying no `Session-Id` trailer is refused by ORDER gate 4 (`oc-order-validate: UNSIGNED … attribution mandatory`), and the chain exits 6. Read the message before you act — if it says UNSIGNED, do not go hunting for a network or carrier problem. Fix = land an empty trailer-signed marker commit on the head (tree-identical, forward-only; `upstream-merge-runbook.md` step 8) and re-run. Every synthesis/merge head is unsigned **by construction**, so this recurs on every sync.
- **Exit 7 — GATE IN FLIGHT:** the gate was still running after the chain's budget and resume-polls (`oc-prchecks` rc 5, non-terminal). The run id is printed — do **NOT** re-dispatch (that concurrency-cancels the live run); wait for it and re-run with `--gated-run <id>`, which pre-verifies and skips dispatch.

**Conflict-quality gate — MANDATORY after any rebase with hand-resolved code:**
*(A hand-resolved merge shipping a crate-alias mismatch is five E0308s and a red CI round-trip)*:
1. Re-read every hand-merged function END-TO-END — not just the conflict hunk.
2. Match crate-wide type aliases: open the alias definition; the error type is usually locked by the alias.
3. Grep the tree for duplicate imports and doubled tests the resolution may have left behind.

**Gate-idle question sweep:** CI gate and carrier build waits are idle time — do not sit silent on open questions. Circle back to the user in your topic with anything unresolved (scope doubts, naming, approach forks) while the chain runs; waiting is never a reason to hold a question or to guess.

## Phase 6b — Smoke-test-on-notify (your features, after any swap)

A post-swap notify announcing a new binary (mechanical fan-out — `oc-deploy
fanout`, [#24](https://github.com/leshchenko1979/opencrabs/issues/24) LIVE
since v0.4.37; `[session-notify from=<uuid>]` header) means your
commits are in it — prove the FEATURE works. This phase produces SMOKE TEST
evidence (SKILL.md Test ontology): behavioral, against the RUNNING binary,
zero cargo. CODE TESTS (fmt/clippy/cargo test) are a different kind, CI-only —
Phase 5 (Phase 7 step 2c reuses it on upstream PR heads). The binary is live
right here (`opencrabs-ops` user unit).

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
   this same evidence goes to your forum topic as the filing notification —
   under the PR SHIPMENT law (SKILL.md §ISSUE ROUTING, PR SHIPMENT row) smoke PASS
   proceeds to upstream PR preparation; no owner wait.
5. FAIL → FILE THE ISSUE FIRST (Phase 1 procedure: symptom + evidence — you
   found it, you file it). Then send raw evidence + the issue link to the
   HQ lane (`session_notify`) — do NOT attribute, do NOT fix another
   editor's feature; attribution via Session-Id trailers is MECHANICAL
   (`oc-attrib`; decision 2026-08-25 2a, mechanical fan-out above).
6. SHIPPED UPSTREAM notice (v0.4.0): if HQ (or the post-swap
   fan-out) reports your feature was
   absorbed by upstream (maintainer merged or reimplemented it), your fork-side
   duty for it ENDS — no further fork maintenance, no fix rounds. Future work
   on that feature happens upstream only: new claim via Phase 1, normal rules.

**Behavioral probe is the smoke PASS GATE (owner order 2026-09-08 12:16Z):**
lineage (is-ancestor), identity (`oc-smoke-evidence` MATCH) and CI gate
evidence do NOT constitute smoke PASS — they are bookkeeping legs. A smoke
verdict of PASS requires step 3 to have TRIGGERED the fix's actual runtime
path on the live box and observed it execute (real message round-trip, real
interrupt, real stamp — not CI test counts). If the fix has no observable
runtime surface, declare the probe N/A with the structural reason in the
smoke evidence (precedent: #92 no-runtime-string finding) — never silent-skip.
A verdict citing only legs 1–3 is INCOMPLETE and gets returned to the lane.
(A stripped binary that compiles the fix but crashes on the path must FAIL —
that is the exact hole this rule closes; origin: ship-38585459 smoke n=2036.)

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
# 2. reproduce → fix → SIGNED commit (E1, v0.4.78)
tools/oc-commit -m "<msg>"   # gated wrapper: Session-Id from OC_ACTOR, Issue-Ref
#    derived from your latest ledger claim, implementation comment folded in
#    (oc-issue-log leg). RAW FALLBACK — rebase/cherry-pick/harvest contexts only:
#    git -C ~/oc-wt-<task> commit --trailer "Session-Id: <full session uuid>" --trailer "Issue-Ref: #<issue-n>"
#    (Session-Id = you; Issue-Ref = the ONE issue this change fixes — atomicity,
#     v0.4.15: every commit links to exactly one issue, matching the PR that will carry it)
# 3. push branch, then re-run oc-ship-chain (Leg 1 CI gate -> Leg 2 comment -> Leg 3 ff-merge -> Leg 4 carrier build -> Leg 5 swap)
git -C ~/oc-wt-<task> push origin <branch>
tools/oc-ship-chain --sha <NEW-head-sha> --branch <branch> [--issue <issue-n>]
# 4. on exit 0 SWAPPED, remove the worktree — job done
tools/oc-wt remove <task>
```

**Per-commit laws live in their phases:** branch-attached HEAD + signing → §Phase 4; worktree-writer exclusivity → §Phase 2. They bind EVERY commit in ANY phase — read them there.
## Phase 7 + 7b — upstream PR → `editor-upstream-pr.md`

Feature-complete → upstream PR filing (Phase 7) and PR lifecycle / blocker
routing (Phase 7b) are split out of this file — single home:
**`editor-upstream-pr.md`** (loaded on demand at the Phase 7 trigger, not on
every reload). Triggers unchanged; the PR SHIPMENT law's procedure reference
resolves there (law home: SKILL.md §ISSUE ROUTING, PR SHIPMENT row).

## CI Watcher Discipline & Throttling (v0.4.143)

- **`gh run watch` throttling**: When invoking raw `gh run watch <run-id>` detached in background, **always specify `--interval 30`** (or `--interval 60`). The default interval is 3s, which saturates CPU loops and GitHub rate limits across parallel lanes.
- **Automated Tool Polling**: `oc-prchecks` defaults to a 30s poll interval (`OC_PRCHECKS_POLL=30`) and 15s resolve poll (`OC_PRCHECKS_RESOLVE_POLL=15`).
