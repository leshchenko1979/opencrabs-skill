# EDITOR — commits and error fixes

**Load only after SKILL.md confirmed the role is EDITOR.**

> **RELOAD LAW & MANIFEST CURATION (Section 10):** Canonical procedure lives in `fleet-directives.md §Post-compaction skill reload & context manifest curation` (keep `opencrabs-dev`, `editor.md`, `fleet-directives.md` in `active_skills`; re-read on compaction/spawn).

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

**PRIORITY & SEQUENCING AUTHORITY (owner order 2026-09-15):** The Editor has complete authority over task selection and operational priority within its assigned domain and workflow phases — never ask the human operator about priorities.

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
+ entrypoint walk for exact CI parity). CODE TESTS = CI gate (`pr-checks.yml`, run in
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

## Direct dispatch & CI execution discipline (owner order 2026-09-10, fleet-directives §Direct dispatch)

**Direct dispatch:** work orders go sender → resource-owner directly — never
through an intermediary lane. Address by full uuid from a same-turn roster read;
stamp the dispatch + receipt id via oc-ledger.

1. **Detached command execution (`background: true` — THE standard):** Long-running
   operations (>60s, CI waits, test batteries, multi-step chains) run detached via the
   bash tool parameter `background: true`. Hand-rolled `nohup` scripts, sleep loops,
   and custom background daemons are FORBIDDEN. The daemon harness natively tracks
   detached execution and auto-resumes your session with the result upon exit.
2. **Actor attribution is automatic via ambient `OPENCRABS_SESSION_ID` (v0.4.176):**
   Tools (`oc-log.sh`, `oc-commit`, `oc-ledger`, etc.) automatically derive attribution from
   the ambient session environment variable `$OPENCRABS_SESSION_ID`. Manual `export OC_ACTOR` is
   retired and no longer required on tool calls; `OC_ACTOR` remains supported only as an optional
   override if running outside an agent session.
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
   `tools/oc-drift-check <your-uuid> [--ack]` (canonical, omit-arg — it reads your OWN
   `last_acked` from the roster; the legacy `<claimed-ver>` form still works. mechanical:
   version-shape validated; `--ack` stamps the adoption record directly).
2. Drift → re-read SKILL.md + editor.md in full from disk, then stamp
   `oc-ledger ack <your-roster-uuid> <new-version>` (shape `0.N.N`, `v`
   prefix tolerated — v0.4.55 fixed the N.N-only regex that made every real
   version un-ackable) — **ONLY when step 1 ran WITHOUT `--ack`**. With
   `--ack`, step 1 already wrote the adoption row (`oc-drift-check`'s `--ack` arm
   delegates to `oc-ledger ack`), so stamping here is a SECOND row for ONE
   adoption: **`--ack` IS the ack.** The canonical reload receipt is the
   single `oc-ledger ack` row — written once, by `--ack` if it was passed,
   otherwise by this hand-stamp. The ack row is the mechanical adoption
   record (HQ Duty 3 reads it for skew-chase). **ORDERING — a DRIFT verdict printed
   right after a `--ack` run does NOT mean the ack failed (v0.4.166; lane `329bf3a3`).**
   The `--ack` block runs BEFORE the verdict comparison, so ONE invocation both stamps
   the new version and reports DRIFT against the `last_acked` it read a moment earlier.
   The sensor fires exactly once per version, and its own firing writes the state that
   silences it: re-run WITHOUT `--ack` to confirm (`NO-DRIFT`). Do NOT re-run with `--ack`
   to "retry" — the row is already written (the M2-4 idempotent re-ack guard makes a
   second attempt a no-op, `oc-ledger` §`cmd_ack`).
3. Apply changed rules from the NEXT phase boundary — a phase already in
   flight finishes under the rules it started under. Doc-only drift adopts
   immediately; workflow-shape drift waits for the boundary.
4. `tools/*` need NO reload: every invocation is a fresh process off disk,
   always the newest version — that is also why tool-level fixes (vocabulary,
   sweep lists) never strand a running lane.
5. **Tool discovery (owner order 2026-09-07, v0.4.94):** the table below is
   the role-DAILY subset, not the inventory — the full tool list
   lives in `tools/RC-CONTRACT.md` (every tool: invocation, rc register,
   selftest owner). Before hand-rolling any check, grep
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

When Triage announces a **Decision Rollcall** (full law: triage.md
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

## Tool reference — editor's daily table

Canonical descriptions + selftest contracts: `tools/RC-CONTRACT.md` (full
inventory of tools) + SKILL.md tool table. The
editor-relevant daily subset, invocation forms only (all paths relative to the skill
dir; actor derived automatically from ambient `$OPENCRABS_SESSION_ID`):

| Tool | Invocation | For |
|------|-----------|-----|
| `oc-start` | `tools/oc-start <issue-N> --branch <branch>` | Milestone 1: atomic issue claim + branch + worktree setup |
| `oc-ship-chain` | `tools/oc-ship-chain --sha <sha> --branch <branch>` | Milestone 2: single-invocation gate → comment → ff-merge → carrier build → live swap |
| `oc-smoke` | `tools/oc-smoke <issue-N> [--probe "<cmd>"]` | Milestone 3: unified 4-leg smoke verification & verdict logging |
| `oc-commit` | `tools/oc-commit -m "<msg>" [--issue N]` | Gated SIGNED commit: Session-Id + Issue-Ref trailers derived from session ID + ledger claim |
| `oc-drift-check` | `tools/oc-drift-check <your-uuid> [--ack]` | §Mid-cycle skill drift pull-check on detached resume |
| `oc-issue-sweep` | `tools/oc-issue-sweep '<query>' [--fork R]` | Phase 1 uniqueness gate (fork open+closed + upstream closed) |
| `oc-ledger` | `stamp claim --what "…"` · `ack <uuid> <0.N.N>` | Roster receipts + version ack |

*Note: Underlying plumbing tools (`oc-wt`, `oc-deploy`, `oc-prchecks`, `oc-issue-log`, `oc-attrib`, `oc-pr-fault-scope`) are orchestrated internally by `oc-start`, `oc-ship-chain`, and `oc-smoke`.*

Rules that outlive any table: journal read-back after every `oc-ledger`
claim/stamp (Phase 1 step 4); terminal truth = `gh run view --json conclusion`, never
a tool's exit code alone; the ≥30s detached-poll floor (fleet-directives.md §CI-wait discipline & actor attribution).

## Phase 0 — Fresh base

```bash
git -C ~/opencrabs fetch origin && git -C ~/opencrabs fetch adolfousier
```

- Branch off fresh `origin/main`; merge-sync RETIRED (canonical REBASE model 2026-09-11 —
  SKILL.md §Upstream relations): NEVER `merge --ff-only adolfousier/main` into
  the shared checkout.
- **The shared `~/opencrabs` checkout is NEVER evidence** (v0.4.5): it may sit on any
  session's leftover branch. Verify shipped behavior against `origin/main`
  explicitly (`git fetch origin && git show origin/main:<path>`) or in a fresh
  worktree cut from `origin/main` (lens B F2, v0.4.79 — completed truncated rule).
- Before building on an existing branch: diff it against its merge-base to confirm no
  foreign WIP rode along from parallel agents. Take a backup branch ref before any
  `rebase --onto`. *(SKILL.md §Shared war stories)*
- **Checkable Completion Formula**: `DONE = Remotes origin and adolfousier fetched + origin/main tip verified.`

## Phase 1 — Claim & Worktree Setup (`oc-start`)

0. **Claim-time fresh re-read & Goal Mandate (v0.4.14 / v0.4.149, owner order 2026-09-12)**:
   - **Fresh Re-read**: FIRST action after claiming/waking — re-read `SKILL.md` + `editor.md` + `fleet-directives.md` from disk (never from recalled memory) — SKILL.md and editor.md in FULL, fleet-directives at thematic-index minimum with every `[LANE]`-tagged section in FULL. DONE = all three files re-read THIS turn.
   - **Design-gate precondition (owner order 2026-09-12)**: Issue the goal **ONLY AFTER the owner has confirmed the design** (owner design gate, v0.4.128). While the design is unapproved the editor stays in the design/approval phase — an early `/goal` would carry it past the very gate that requires owner approval BEFORE code. Fixed sequence: design → owner confirms → `/goal` → continuous execution through Phase 6b.
   - **Autonomous Goal Mandate**: After the owner's design confirmation, the editor MUST execute `/goal follow the skill until the smoke test phase` (via `slash_command`). The Editor is mandated to drive autonomously and continuously from Phase 1 through Phase 6b smoke testing (claim → worktree → code → sign → ship via `oc-ship-chain` → live behavioral smoke test on swapped binary → record 4-leg smoke verdict in `smoke-verdicts.log`). **Editors MUST NOT stop or ask for confirmation after Phase 4 (writing code) or after intermediate ship legs.** The task is only complete once the live behavioral smoke test is recorded in `smoke-verdicts.log`.
1. **Uniqueness Gate**: Search existing issues first via `tools/oc-issue-sweep '<query>'` (sweeps fork open/closed + upstream closed).
2. **Issue Creation & Continuous Relationship Linking**:
   - If no issue fits, open ONE issue on the fork: `gh issue create -R leshchenko1979/opencrabs` (symptom + evidence).
   - **Continuous Relationship Linking Mandate (owner order 2026-09-16)**: Whenever parent subsystem relationships, blocker dependencies, or child sub-issues are known at creation or discovered in-flight during implementation, the editor MUST establish native links in the same turn via `gh issue edit <issue> --parent <parent-issue>` and/or `gh issue edit <issue> --add-blocked-by <blocker-issue>`.
3. **Atomic Claim & Worktree (Milestone 1 — `oc-start`)**:
   ```bash
   tools/oc-start <issue-N> --branch <type>/<slug>
   ```
   `oc-start` automatically executes:
   - Uniqueness check and ledger claim (`oc-ledger claim`).
   - Remote fetch and clean branch creation off fresh `origin/main`.
   - Clean worktree mounting at `~/oc-wt-<task>`.
   *(Manual fallback `oc-wt add <task> <branch>` is reserved only for raw non-issue worktrees).*
   - **ZERO-ACK ON DISPATCH (owner order 2026-09-13)**: When receiving a task dispatch (`[ISSUE TRIAGE DISPATCH: #N]`), **NEVER reply with a `session_notify` ack**. Running `oc-start` or stamping `oc-ledger claim` is the sole required action.

DONE = Issue verified/filed, atomically claimed on ledger, and clean worktree mounted at `~/oc-wt-<task>` on branch `<type>/<slug>` tracking fresh `origin/main`.

## Phase 2 — Worktree Lifecycle & Isolation

- **Exclusivity**: ALL edits happen in `~/oc-wt-<task>`, NEVER in the shared checkout. Parallel agents share the repository.
- **Inline Execution**: While holding an active worktree, ALL execution runs inline in the owning session (`isolated=false`). Auto-spawned isolated workers are forbidden.
- **Teardown**: After shipping via `oc-ship-chain` (Phase 5), remove the worktree:
  ```bash
  tools/oc-wt remove <task>
  ```
DONE = Worktree exclusivity maintained, edits isolated to `~/oc-wt-<task>`.

## Phase 3 — Explore before writing (Imperative `memory_search` & DRY Gate)

**Using `memory_search scope="external"` is STRICTLY IMPERATIVE before writing or editing any code.**

1. **Symbol Graph & Call Sites (Structural Mandate)**:
   - `memory_search scope="external"` routes directly to the code symbol graph for `/root/opencrabs/src/**/*.rs`.
   - Run queries like `"who calls <Function>"`, `"where is <Symbol> defined"`, or `"who implements <Trait>"` before touching any file.
   - Enumerate all callers, callees, and consumers to avoid breaking upstream callers or introducing unhandled match arms.
2. **DRY & Shared Abstraction Verification (Mandatory Reuse)**:
   - Always assume a helper, parser, or abstraction already exists in `/root/opencrabs/src/**/*.rs`.
   - Search with `memory_search scope="external"` before writing any new helper function or struct.
   - Copy-pasting, reimplementing, or creating redundant parallel abstractions is a direct violation of the DRY mandate.
3. **Prohibition on Blind Grep**:
   - Plain text `grep` is for literal text matching only.
   - Editing code based solely on literal `grep` without first mapping structural symbol connections via `memory_search scope="external"` is strictly prohibited.
4. **Library APIs & Traits**:
   - Verify external/crate traits and version-specific methods with `grep_docs` (Context7) before calling them.
5. **Module Sizing**:
   - Prefer extracting a clean, modular submodule over growing any existing file past ~1000 lines.

DONE = Full symbol graph & caller tree mapped via `memory_search scope="external"`, DRY reuse verified, and trait/API signatures confirmed via `grep_docs` before the first edit.

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

**Test placement & upstream coding standards (CONTRIBUTING.md policy, Adolfo DM 2026-09-13):**
- Tests live under `src/tests/*_test.rs` registered in `src/tests/mod.rs`, never inline `#[cfg(test)] mod tests { ... }` blocks.
- `mod.rs` is for module declarations and re-exports ONLY — zero function definitions (`fn`) in any `mod.rs`.
- Commit trailers must never include `Co-Authored-By`.
- No `#[allow(dead_code)]` / `#[allow(unused)]` suppression; unused code must be deleted.
- If introducing, renaming, or retiring concepts, update `src/docs/reference/ONTOLOGY.md`. Upstream CI strictly enforces these.

**rustfmt = NON-FATAL diagnostic pre-pass (Duty-4 P6, v0.4.80):** run fmt
before `oc-commit`; a fmt failure is a diagnostic to fix and re-run — never a
hard abort ahead of git (that forces manual trailers + a hand-posted
implementation comment).

**Local fmt drift on files you did NOT touch is EXPECTED — and it is not yours to fix (SKILL.md §Box law; sharpened 2026-09-12, lane `462181e9` re-derived it from scratch because this rule lives in the box-law bullet while the check runs here).** The `/usr/local/bin/rustfmt` wrapper is **NEWER than CI's rustfmt**, so it flags cosmetic diffs on **CI-green committed code**. Rule: **KEEP AS-IS; fix only formatting artifacts you introduced yourself.** Two mechanics that make foreign drift look like your defect — (a) the wrapper **RECURSES through `mod.rs` into child modules**, so `--check src/tests/mod.rs` reports diffs from files your branch never touched; (b) `--skip-children` is **not supported** by this wrapper, and a `mod.rs` copied to /tmp fails to resolve its child modules. Isolation recipe: **check each TOUCHED file as a standalone copy; never `--check mod.rs` itself.** Do not spend three receipts re-deriving this — if fmt reports a file your diff does not contain, the answer is this paragraph.

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
DONE = Target change implemented, formatted via rustfmt, call-site shapes verified, and signed commit landed on branch with Session-Id trailer.

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
1. **Leg 1 (CI Gate):** Dispatches and watches `oc-prchecks` (`pr-checks.yml` on your branch: fmt + clippy + `cargo test --locked --profile ci --all-features`). **Exception — a pure-docs commit SKIPS this leg** (owner ruling 2026-09-12: *"We don't need the pure docs commits to pass through ci on our side."*). "Pure docs" is defined in the law, not by the tool: every changed path ends `.md` **and** is not `include_str!`-compiled into the binary — the 21-path compiled-in exclusion set lives in `fleet-directives.md §Docs-Only LEG1 Gate Skip`. A skip is recorded as **SKIPPED** and is never a passed gate: do not cite a skipped leg as GREEN, and do not count it as a passed leg in a smoke receipt.
2. **Leg 2 (Issue Log):** If `--issue <N>` is supplied, posts the per-commit implementation comment via `oc-issue-log` automatically.
3. **Leg 3 (Fast-Forward Merge):** Fetches fork `main`, verifies fast-forwardability, and pushes `<branch>:main` (serialized via `ship.lock`).
4. **Leg 4 (Carrier Ship):** Dispatches `oc-deploy ship --sha <sha> --execute` to build on `ci/quick-build-linux`.
5. **Leg 5 (Swap & Seal):** Bounded-polls carrier execution (`oc-deploy poll --execute --wait <sec>`) until the binary is live and swapped. The ship wait default is **2700 s** (`OC_SHIPCHAIN_SHIP_WAIT`, tool text `oc-ship-chain:192`) — raised from 900 s at #336 after 11 of 37 carrier successes exceeded 900 s (10 most recent: 942-1344 s, median 1062 s). A shorter budget mislabels a still-building run as INFRA rc 6.

**Carrier Coalescence & Ancestry Matching (v0.4.148):**
Editors do not serialize on a pre-dispatch carrier lock. `oc-deploy` and `oc-ship-chain` accept descendant carrier builds via ancestry verification (`git merge-base --is-ancestor "$SHA" "$CAND_SHA"`). If multiple editors push in quick succession, GitHub Actions concurrency coalesces the queued runs into a single descendant build. Once that build completes GREEN, all merged ancestors are recognized as deployed. Host swaps are strictly serialized and monotonic via `host-swap.lock` and lineage checks.

There is NO legitimate manual exit point between gate verdict and swap. The #134 orphan class (stopping at GREEN without swapping) is structurally closed.

### Failure Modes, Tool Automations & Agent Recovery Protocol (v0.4.145)

When shipping features via `oc-ship-chain` or deploying via `oc-deploy`, failures and interruptions follow the mechanical automation vs. manual resolution contract below:

| Failure Mode | Return Code / Signal | What is Mechanical (Automated by Tool) | What Requires Agent (Semantic Fix) | Tool Output & Communication |
|---|---|---|---|---|
| **1. Non-Fast-Forward Push** | `rc=0` (Auto) / `rc=5` (Conflict) | **100% Automated by tool** on clean rebase: `oc-deploy`/`oc-ship-chain` auto-fetches `origin/main`, rebases topic commits, audits with `oc-rebase-safety audit`, and retries push in 3s. | Only if git hits a **semantic merge conflict**: agent inspects conflicting files (`git status`), resolves diff, re-runs chain. | `REBASE_CLEAN: auto-pushed rebased SHA` (clean) OR `REBASE_CONFLICT: manual diff needed in <file>` (conflict) |
| **2. Carrier Compilation Failure** | `rc=3` (`build-failed`) | **Auto-log extraction**: Tool automatically runs `gh run view <id> --log-failed`, parses `error[E...]` and rustc diagnostic lines, and prints the exact compiler error and file:line in tool stderr. | Agent fixes the Rust syntax, borrow checker, or missing module error in the worktree, commits, and re-runs `oc-ship-chain`. | `CARRIER_BUILD_FAILED (rc=3): Run <id>` followed by extracted compiler error block |
| **3. Daemon Boot Panic / Swap Failure** | `rc=4` (`swap-failed`) | **Auto-rollback & Auto-diag**: `oc-deploy swap-execute` **automatically rolls back** to the previous binary (`/usr/local/bin/opencrabs.bak`), restarts the service, and automatically extracts the panic backtrace from `journalctl -u opencrabs-ops.service -n 30` into tool output. | Agent inspects the auto-extracted panic trace, reproduces/fixes the startup bug or bad unwrap in the worktree, commits, and re-chains. Host remains 100% healthy. | `SWAP_FAILED (rc=4): Auto-rolled back to previous binary. Daemon boot panic: <extracted log>` |
| **4. Daemon Bounce Task Interruption** | Restart signal / `[BACKGROUND TASK INTERRUPTED]` | **State file + recovery re-run** (⚠️ there is **no `--resume` flag** — `oc-ship-chain` dies `rc=2` on an unknown arg): `oc-deploy swap-execute` writes the deployment result to `/root/.opencrabs/profiles/ops/opencrabs-dev/deployed.sha`. Only the `poll --execute` path hands Phase B to a transient `systemd-run` unit, so a **direct** `swap-execute` runs in the caller's cgroup and can be killed by the very restart it performs. | **Recover by state, not by resume**: read `deployed.sha`; if the swap landed, confirm `disk==proc MATCH` and go to Phase 6b. If the chain died before the swap, **re-run the same chain with `--gated-run <id>`** (reuses the GREEN gate run whose job name pins your sha) — see `upstream-merge-runbook.md`. | `SWAP_SUCCESSFUL: running binary matches deployed SHA. Ready for Phase 6b smoke.` |

**Exit codes & Lane action:**
- **Exit 0 — SWAPPED:** The new binary is running live on the host (`opencrabs-ops` user unit). Worktree can now be removed (`tools/oc-wt remove <task>`). Proceed immediately to Phase 6b (Smoke-test-on-notify).
- **Exit 2 — USAGE:** Bad or missing arguments (`--sha`/`--branch` are required; malformed flag). Correct the invocation and re-run — no lane state to resolve.
- **Exit 3 — DIRTY CHECKOUT:** The fork checkout has uncommitted changes (pre-flight refusal). Clean or stash it, then re-run.
- **Exit 4 — GATE-RED / CARRIER-RED:** The CI gate failed or the carrier build failed. Start a fix round (Phase 6c): keep the same branch, fix in a new worktree, commit, push, and re-run `oc-ship-chain`. Triage heuristics live in `SKILL.md §Red-run triage heuristics`. **Also the `--gated-run` / `--gated-sha` pre-verify failure:** the supplied run was not `completed success` on a job pinned to the sha, or `--gated-sha` did not match `--sha`. Do NOT re-dispatch the run — re-verify it with `gh run view <id> --json status,conclusion,jobs` and re-supply the correct id.
- **Exit 5 — NON-FF / MERGE CONFLICT · TIP-MOVED · REBASE-GATE:** THREE distinct causes share this code (tool text `oc-ship-chain:828-829`; full register in `tools/RC-CONTRACT.md`). **(a) NON-FF / MERGE CONFLICT** — the automatic in-tool rebase encountered an actual semantic merge conflict that requires manual diff adjudication:
  ```bash
  git -C ~/oc-wt-<task> fetch origin
  git -C ~/oc-wt-<task> rebase origin/main
  # resolve conflicts in working tree
  git -C ~/oc-wt-<task> push --force-with-lease origin <branch>
  ```
  ⚠️ **`oc-rebase-safety` is NOT the rebase engine** — it is a READ-ONLY safety auditor (`audit` / `overlap`). Use standard git commands to resolve conflicts, verify zero lost edits with `oc-rebase-safety audit`, and re-run `oc-ship-chain`.
  - **(b) TIP-MOVED** — the branch was force-pushed mid-gate, so `$TIP != $SHA`: LEG3 refuses rather than fast-forwarding fork main onto a tip NO GATE VALIDATED. Recovery: re-run the chain against the new tip — do NOT land the ungated tip.
  - **(c) REBASE-GATE** — `oc-deploy`'s in-tool auto-rebase refused the push (`OC_DEPLOY_GATE=rebase-conflict` / `rebase-audit-failed`). Recovery: rebase `$BRANCH` onto fork main yourself, verify with `oc-rebase-safety audit`, then re-run.
- **Exit 6 — INFRA / ORDER-GATE:** dispatch or poll infrastructure failure (`oc-prchecks` rc 4/7/8, or ship rc other) — **or an ORDER-gate rejection post-push.** ⚠️ **The UNSIGNED case lands HERE, and it is NOT an infra fault:** a head commit carrying no `Session-Id` trailer is refused by ORDER gate 4 (`oc-order-validate: UNSIGNED … attribution mandatory`), and the chain exits 6. Read the message before you act — if it says UNSIGNED, do not go hunting for a network or carrier problem. Fix = land an empty trailer-signed marker commit on the head (tree-identical, forward-only; `upstream-merge-runbook.md` step 9) and re-run. Every synthesis/merge head is unsigned **by construction**, so this recurs on every sync. **A lineage-guard refusal ALSO exits 6:** `oc-deploy swap-execute` refusing a post-rewrite swap (`non-monotonic-swap`) surfaces here. Recovery = **re-run the same `oc-ship-chain` leg** — the guard is rebase-aware (v0.4.151) and accepts the swap as `rewrite-equivalent-swap`. **NEVER hand-edit `deployed.sha`** to re-point around a refusal (`fleet-directives.md §Post-Rewrite Swap Recovery`).
- **Exit 7 — GATE IN FLIGHT:** the gate was still running after the chain's budget and resume-polls (`oc-prchecks` rc 5, non-terminal). The run id is printed — do **NOT** re-dispatch (that concurrency-cancels the live run); wait for it and re-run with `--gated-run <id>`, which pre-verifies and skips dispatch.
- **Exit 8 — SHIP-WAIT-TIMEOUT:** the carrier build did not reach a terminal state within the LEG4 `--wait` budget (default 2700 s; `oc-deploy ship` rc 5 with no rebase-gate token). ⚠️ **The run is still BUILDING — do NOT re-dispatch it** (a re-dispatch concurrency-cancels the live run). Wait for it, then resume with `oc-deploy poll --sha <sha> --execute --wait <sec>`, or re-run the chain with a larger `--wait`. This code exists precisely because the Exit 4/6 reflex ("re-run the chain") is the double-dispatch this arm prevents.

**Conflict-quality gate — MANDATORY after any rebase with hand-resolved code:**
*(A hand-resolved merge shipping a crate-alias mismatch is five E0308s and a red CI round-trip)*:
1. Re-read every hand-merged function END-TO-END — not just the conflict hunk.
2. Match crate-wide type aliases: open the alias definition; the error type is usually locked by the alias.
3. Grep the tree for duplicate imports and doubled tests the resolution may have left behind.

**Gate-idle question sweep:** CI gate and carrier build waits are idle time — do not sit silent on open questions. Circle back to the user in your topic with anything unresolved (scope doubts, naming, approach forks) while the chain runs; waiting is never a reason to hold a question or to guess.
DONE = `tools/oc-ship-chain` exited 0 (SWAPPED) with new binary running live on `opencrabs-ops` unit and worktree cleaned.

## Phase 6 — Smoke Verification (oc-smoke)

A post-swap notify announcing a new binary (mechanical fan-out — `oc-deploy
fanout`, [#24](https://github.com/leshchenko1979/opencrabs/issues/24) LIVE
since v0.4.37; `[session-notify from=<uuid>]` header) means your
commits are in it — prove the FEATURE works. This phase produces SMOKE TEST
evidence (SKILL.md Test ontology): behavioral, against the RUNNING binary,
zero cargo. CODE TESTS (fmt/clippy/cargo test) are a different kind, CI-only —
Phase 5 (Phase 7 step 2c reuses it on upstream PR heads). The binary is live
right here (`opencrabs-ops` user unit).

```bash
# Unified 4-leg smoke verification & verdict row logging:
~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-smoke <issue-N> --probe "<command-to-verify-behavior>"
```

1. Read run id + built sha from the notification body. **If the daemon bounced**
   (any restart since your last turn), RE-SURFACE lazy tool schemas via
   `tool_search` BEFORE any smoke invocation — a restart kills activated schemas
   and intents misfire onto wrong tools.
2. **IDENTITY RECEIPT & BEHAVIORAL PROBE:** Run `tools/oc-smoke <issue-N> --probe "<cmd>"`
   (or manual `oc-smoke-evidence`). It verifies unit exe identity vs deployed sha,
   executes the probe command, and writes the canonical row to `smoke-verdicts.log`.
   MISMATCH → STOP: you would be smoking a binary that is not the one that was
   built — report the mismatch to the sender, do not smoke on a stale unit.
3. Drive your feature end-to-end against the RUNNING unit on its normal
   surfaces (Telegram, cron, MCP — whatever the feature touches).
   **Checkable completion criteria (v0.4.170, Finding G-2):**
   DONE = Mechanical proof demonstrating target feature execution against the running binary (command output, log line with PID/timestamp match, or API receipt); confirmed via `tools/oc-smoke` (exit 0) and recorded in `smoke-verdicts.log`.
4. PASS → reply to the sender (`session_notify`, `target_session` = the `from`
   header): feature OK + one line of evidence + the oc-smoke
   IDENTITY-MATCH receipt. Running `oc-smoke <issue-N>` on PASS automatically
   executes `oc-ledger stamp done` (suppressible via `--no-ledger`), mechanically
   closing the worker's in-flight claim in `workers-ledger.json` and unblocking
   `oc-harvest-census` and Triage intake. If the feature is COMPLETE,
   this same evidence goes to your forum topic as the filing notification —
   under the PR SHIPMENT law (SKILL.md §ISSUE ROUTING, PR SHIPMENT row) smoke PASS
   proceeds to upstream PR preparation; no owner wait.
5. FAIL → FILE THE ISSUE FIRST (Phase 1 procedure: symptom + evidence — you
   found it, you file it). Then send raw evidence + the issue link directly to
   the owning editor or Triage lane (`session_notify`) — do NOT attribute, do NOT fix another
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

**Owner-dependent leg → PARK, never wait (v0.4.152, owner order 2026-09-12):**
if the only remaining behavioral evidence needs the OWNER — a visual pass, a tap,
an eye-confirm on a card — the leg is **NOT a blocking gate**. Stamp the legs you
can prove (lineage, identity, CI, any agent-runnable probe), append a
`PARKED-OWNER-EYE` row to `smoke-verdicts.log` naming the owner action required
and the packaging sha, then **RELEASE the lane** and move to your next task. A
lane idling on an owner leg is in violation; a lane that parks and moves on is
compliant. Owner-absent windows (nights) are exactly when this binds. Owner
verdicts must be explicit AND post-hoc — a passing remark made mid-flight is not
a verdict (row 87 → row 90: the owner's "Smoke passed" landed 16 s after their
own discard and 3 m 17 s before the review finished, so it certified a defect
that did not yet exist; the PASS was revoked). If the remark is ambiguous, record
`OWNER-REMARK (not a verdict)` and leave the leg OPEN/PARKED. Full law:
`fleet-directives.md §Owner-Dependent Smoke Legs — Park, Don't Chase`.

**Swap timing is NOT coordinated with smokes** (owner decision, closing editor
proposal #8): NO advance announce, NO swap delay — deploys land whenever the
pipeline is ready, even mid-smoke; loss of in-flight in-memory state is ACCEPTED
until Alexey fixes it otherwise. If a bounce kills your smoke mid-run: re-arm tool
schemas (step 1), re-run from scratch — NEVER report the bounce itself as a feature
FAIL.

## Phase 6-Fix — Fix Loop (Red Carrier Build or Failed Smoke)

A RED `oc-deploy ship`/poll run or a failed smoke attributes the failure (via
`oc-attrib` Session-Id trailers) and routes the fix to the guilty editor WITH evidence.
Your answer is always the SAME sequence:

0. GATE — the bug must already HAVE an issue; the red-run hand-off names
   it. Missing? File it first (Phase 1 procedure). Fixing before filing
   violates the issue-first hard rule (SKILL.md).
1. **MANDATORY EXPLORATION & DRY GATE**: Before editing any files to apply a fix, you MUST run
   `memory_search scope="external"` over `/root/opencrabs/src/**/*.rs` to map callers,
   symbol definitions, and ensure no DRY abstractions are violated.

```bash
# 1. fresh worktree at the relevant sha (worktree lifecycle, Phase 2)
tools/oc-wt add <task> <branch>
# 2. reproduce → fix → SIGNED commit (E1, v0.4.78)
tools/oc-commit -m "<msg>"   # gated wrapper: Session-Id from ambient session ID, Issue-Ref
#    derived from your latest ledger claim, implementation comment folded in
# 3. push branch, then re-run oc-ship-chain (Leg 1 CI gate -> Leg 2 comment -> Leg 3 ff-merge -> Leg 4 carrier build -> Leg 5 swap)
git -C ~/oc-wt-<task> push origin <branch>
tools/oc-ship-chain --sha <NEW-head-sha> --branch <branch> [--issue <issue-n>]
# 4. on exit 0 SWAPPED, remove the worktree — proceed to Phase 6 smoke re-test
tools/oc-wt remove <task>
```

**Per-commit laws live in their phases:** branch-attached HEAD + signing → §Phase 4; worktree-writer exclusivity → §Phase 2. They bind EVERY commit in ANY phase — read them there.
- **Checkable Completion Formula**: `DONE = Bug reproduced + memory_search caller check performed + fix committed with trailers + tools/oc-ship-chain exits 0 (SWAPPED) + worktree removed.`


## Phase 7 + 7b — upstream PR → `editor-upstream-pr.md`

Feature-complete → upstream PR filing (Phase 7) and PR lifecycle / blocker
routing (Phase 7b) are split out of this file — single home:
**`editor-upstream-pr.md`** (loaded on demand at the Phase 7 trigger, not on
every reload). Triggers unchanged; the PR SHIPMENT law's procedure reference
resolves there (law home: SKILL.md §ISSUE ROUTING, PR SHIPMENT row).

## CI Watcher Discipline & Throttling (v0.4.143)

- **`gh run watch` throttling**: Mandatory `--interval 30` (or `60`) on raw `gh run watch` invocations per `editor.md §CI Watcher Discipline & Throttling`. Prefer `tools/oc-prchecks wait`, which throttles mechanically.

## No auto-rollback on smoke FAIL (owner 2026-08-28 18:50Z)

Post-swap smoke FAIL → rollback is the OWNER's call, never mechanical. The swap-chain auto-rollback on post-bounce verify fail (crash-integrity: disk==proc mismatch → restore backup) is UNCHANGED — that one stays automatic. With deploy consent eliminated the same day, this is the only human gate left near the deploy pipeline.

**Smoke-verdict ledger append discipline (owner 2026-09-05, ops relay):** the DRIVING lane appends its verdict to the smoke ledger file (`opencrabs-dev/smoke-verdicts.log` — the canonical state dir; `oc-smoke-evidence` prints the boilerplate row) in the SAME turn as the verdict — posting to topics is visibility, not persistence. Relay/HQ sessions never backfill on the lane's behalf; a late entry is only legal explicitly marked `LATE ENTRY` with the on-record source receipts. Rationale: the theme-3 verdict lived in topics only until a morning audit caught it; the file mtime proved the claimed append never ran.

## Swap-sha test coverage & Split-Gate Pipeline (v0.4.145)

To optimize daytime delivery velocity while maintaining binary safety, shipping follows the **Split-Gate Pipeline**:

1. **Pre-Merge Gate (Fast Lint, ~2.2 min)**: `oc-ship-chain` runs fast pre-merge checks (`fmt` + `clippy`) on the topic branch via `oc-prchecks --fast`.
2. **Merge-First & In-Tool Auto-Rebase**: Feature branches merge sequentially to `main`. If a concurrent merge creates a non-fast-forward push rejection, `oc-deploy` auto-fetches, auto-rebases, audits diff safety via `oc-rebase-safety audit`, and retries the push in 3s.
3. **Post-Merge Carrier Compile (~10.4 min)**: Carrier `quick-build-linux.yml` compiles the unified tip of `main`. Compilation verifies Rust types, syntax, and borrow checker safety before producing a binary.
4. **Immediate Live Swap & Smoke Review**: Binary swaps atomically onto the host (`oc-deploy swap-execute`), and editors execute Phase 6b smoke tests (`oc-smoke-evidence`) during active daytime hours.
5. **Asynchronous / Nightly Full Regression**: Full regression suites (`cargo test --all-features`, ~25 min) execute asynchronously in CI on `main` or run in consolidated batches during the nighttime sync. If asynchronous test runs report regressions, a fix issue is queued for triage.

## Carrier hotfix gates are build-no-tests — expect BASE-FAULT REDs (harvest, A3 lane 2026-09-03)

A green main gate does **not** prove a test-GREEN base: carrier hotfix gates run build-no-tests, so a lane whose branch base is hotfix-fresh may hit its first full-gate RED from base faults it doesn't own. Mitigation that works: triage with `--fault-scope BASE-FAULT`, park, rebase after the main-side repair. (Supersedes nothing; complements the coverage law above — that fixes the process, this prepares the lanes for the window where it isn't applied yet.)
