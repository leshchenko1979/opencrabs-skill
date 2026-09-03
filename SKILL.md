---
name: opencrabs-dev
description: >
  OpenCrabs source ops (~/opencrabs): roles EDITOR (fork issues, per-task
  worktrees, CI gate (pr-checks), signed commits, push + sha hand-off, oc-deploy ship,
  smoke-test-on-notify, upstream PR), SUPERVISOR (skill set + worker ledger;
  the Compiler role is retired — re-enable trigger in STEP ZERO).
  Use when editing/fixing OpenCrabs Rust code, debugging quick-build-linux carrier or other CI runs, fetching CI artifacts, or swapping /usr/local/bin/opencrabs.
  (/opencrabs-dev)
version: 0.4.84
author: leshchenko1979
metadata:
  tags: [opencrabs, rust, ci, quick-build, binary-swap, worktree, session-notify]
  references:
    - https://github.com/adolfousier/opencrabs (upstream — PRs only; new issues NEVER filed here)
    - https://github.com/leshchenko1979/opencrabs (fork — push target + ISSUES HOME)
  provenance:
    - "Full release history moved out of the load path at v0.4.43 (B6, Duty-6 run-2) — every v0.4.31+ bump entry lives in CHANGELOG.md (git-tracked, appended newest-last). This pointer replaces the inline list (~3k tokens loaded on every role-file claim). Current version: see CHANGELOG.md."
---

# opencrabs-dev — OpenCrabs source procedure

**Owns:** everything touching `~/opencrabs` source, its GitHub Actions runs, or the
installed `opencrabs` binary. This file = shared facts + role router only. Actual
procedures live in TWO role files (`editor.md` / `supervisor.md`) + one
ARCHIVED runbook (`tools/archive/compiler.md` — retired at S3 cutover 2026-08-28, re-enable
= one notify);
load ONLY the one matching the session's role.

**Binding owner directives** (sync policy, upstream PR law, carriers/builds, cargo
prohibition, telegram surface law, tool logging, gates, editor creation, HQ triage,
cadence) live in `fleet-directives.md` — re-homed from ops AGENTS.md/MEMORY.md per
owner order 2026-09-02. Load it before ANY opencrabs-dev work. Executing procedure for the sync
policy's merge leg: `upstream-merge-runbook.md` (freeze gate, roles, conflict
classes, migration-union rule, semantic-triage defaults).

## Canonical tooling (v0.4.12, PROCESS-TOOL ownership)

Mechanical rituals the roles once hand-ran are now single commands in `tools/`
(owner-aware: CLI-tool creation/fix is the Supervisor's scope). Canonical
commands run INSIDE `oc-deploy` (ship/poll/swap-execute); this section is the
register + test source of truth (archived compiler-step anchors stripped
2026-08-29 — `tools/archive/compiler.md` carries the old numbering for re-enable context).
Fleet-wide rc conventions + FULL per-tool rc register: `tools/RC-CONTRACT.md` — the SOLE register (lens A H1/B F1, v0.4.79; rows below carry purpose only):

| Tool | Slot |
|---|---|
| `./tools/oc-order-validate <sha>` | ORDER gates inside `oc-deploy ship` |
| `./tools/oc-job-verify <run-id> <source-ref> [--features] [--identity-only]` | standalone run-identity gate — oc-deploy poll inlines its own job-name decode; `--identity-only` skips outcome gates (provenance of RED runs; embed decode via shared `lib/oc-embed.sh`, E2 #3) |
| `./tools/oc-artifact-verify <artifact-path> [--source <sha>] [--run-id <id>] [--markers m1,m2] [--expect-sha <sha256>] [--expect-version <v>] [--repo R] [--json]` | EXECUTION SANITY SIGNAL + FEATURE-PRESENCE CHECK |
| `./tools/oc-seal-state [--sha S] [...]` | baseline/orders seal (flag-based interface — no positional `<sha>`); order vocabulary QUEUED…VOID, per-row `--order-evidence`, `--purge-order`; matches legacy `order_sha` rows |
| `./tools/archive/oc-post-receipts ...` | **INTERNAL/ARCHIVED** (E2 #7, v0.4.72 — was compiler-era manual fallback): zero live consumers, raw-bot posting violates the Telegram surface law; kept for archaeology only, do NOT call |
| `./tools/oc-index-worktree <path>` | INTERNAL since v0.4.47 — chained automatically by `oc-wt add` (worktrees inherit NO index; standalone call = legacy fallback) |
| `./tools/oc-ci-parity` | workflows parity fork↔upstream post-merge (live: editor Phase 7 parity) |
| `./tools/oc-attrib --repo <path> (--range <A..B> or --deployed) [--ledger <f>] [--contributors]` | commit-range → worker-lane attribution via Session-Id join against roster (`(unsigned)`/`(unmapped)` rows never dropped); `--contributors` (E6, v0.4.78) projects the 3-col TSV (session/issues/shas) — the oc-deploy `contributors` wrapper delegates here, TSV-only (`--json` combo rejected); `--deployed` composes the range from `deployed.sha` + `deployed.meta.json` `prev_sha` (fan-out compute backend for [issue #24](https://github.com/leshchenko1979/opencrabs/issues/24)) |
| `./tools/oc-deploy <mode>` | the ship path itself — `ship` (fetch/push + 4 ORDER gates + carrier dispatch), `poll` (watch + RED scan + swap chain; `--wait N` bounded wait — timeout dies rc 5 with the run URL + optional `--notify-session <uuid>` wake, `--wait 0` = classic single pass; v0.4.78), `swap-execute` (Phase B swap), `watch [--with-delta]` (stray-commit tripwire; `--with-delta` appends the `oc-upstream-delta` advisory rows — merge B, v0.4.48), `contributors`/`fanout` (rows below); the editor's S3 ship path: `editor.md` §Ship — oc-deploy (S3 path) |
| `./tools/oc-deploy contributors (<old>..<new> or --deployed) [--repo <path>]` | [issue #24](https://github.com/leshchenko1979/opencrabs/issues/24): thin wrapper over `oc-attrib --contributors` (E6, v0.4.78) printing 3-col TSV `session-uuid \t issue_refs \t sha7s` for a range (or the deployed range) — the human-readable fan-out target list |
| `./tools/oc-deploy fanout --run <id> [--dry-run]` | mechanical notify fan-out for one carrier run ([#24](https://github.com/leshchenko1979/opencrabs/issues/24) LIVE since v0.4.37): GREEN → contributor notify, RED → blame notify; auto-fired at `swap_execute` tail + on `poll` RED-scan; `OC_DEPLOY_NOFANOUT=1` suppresses — mechanics + journal vocabulary in `s2-swap-journal-spec.md` §Fan-out legs |
| `./tools/oc-carrier-features [--fetch] [--repo <path>] [--ref <branch>]` | reads the `workflow_dispatch` `features` default from `.github/workflows/quick-build-linux.yml` at `origin/<ref>` (default `ci/quick-build-linux`); `oc-deploy ship/poll` resolves EMPTY `--features` through this — carrier read failure aborts the ship loudly, no silent fallback |
| `./tools/oc-issue-sweep '<query>' [--fork R] [--upstream R] [--limit N]` | closed-issue hygiene sweep: fork open + fork closed + upstream closed, harvests `close-reason:` lines from comments (falls back to state_reason); pure TSV, no header, deduped by repo#num (supervisor duty) |
| `./tools/oc-skew-scan [--ledger f] [--current v]` | ledger worker-version skew vs current skill version (default: frontmatter `version:`); buckets CHASE (>3 behind) / GRACE (>1) / OK, `-` marks a missing ack field; summary line to stderr (supervisor roster review) |
| `./tools/oc-ping-proof <uuid> <ping-ts> [--ledger f]` | post-swap notify proof: WOKEN / SILENT / UNREACHABLE verdict from ledger `last_acked` + `events[]` stamps (`last_notified` excluded by design — broadcast, not worker activity); evidence stamp to stderr; accepts ISO and bare `HH:MMZ` stamps |
| `./tools/oc-pr-atomicity <pr-number>` | atomicity gate (editor Phase 7 / issue triage) |
| `./tools/oc-ledger <verb>` | atomic ledger writes under flock: `stamp <kind> --what ...` (ruling/idea/idea-verdict/design-feedback/design-locked/review-battery/incident/note/ack/roster-enroll/**claim** — v1.1 vocabulary since v0.4.48: `claim` is the fork-issue claiming row, Duty-7 IDEA fix), `sync --version v --why ...` (version-bump sync, battery-gated, commits both repos + tag; **chains `oc-shadow-rotate` as its tail step** — merge A, v0.4.48; **mirror push tail step since v0.4.50** — pushes branch + `v0.4.*` tags to `origin` when one is configured, WARN-only never gates; off-box durability: `leshchenko1979/opencrabs-skill` wired as live mirror of the skill repo per owner Attach 2026-08-30; STATE repo mirrored to `leshchenko1979/opencrabs-dev-state` (private, owner Go 2026-08-30) — both pushed mechanically by this tail step), `check-version`, `cadence`, `ack` (ack rows double as skill-drift adoption records, v0.4.52 — editor.md §Mid-cycle skill drift), `enroll`, `commit-pending [--bundle]` (pending-stamp commit sweep — item-2(b), Duty-3/4 cadence; `--bundle` also sweeps STATE receipts `tools.log`/`baseline.json`/`orders.json`/`journal/` — v0.4.49/51: seal-state and the swap chain write them per swap, never self-commit), `claim-ref <uuid>` (E2 #4, v0.4.72 — prints the `#N` of the actor's latest unconfirmed claim, rc 3 if none; consumption backend for oc-commit Issue-Ref derivation) |
| `./tools/oc-shadow-rotate [--dry-run]` | INTERNAL tail step of `oc-ledger sync` since v0.4.48 (merge A) — appends the live (gitignored) `oc-deploy-shadow.log` to the git-tracked `oc-deploy-shadow.archive.log`, then truncates the live file; bump cadence IS the rotation cadence now. Standalone invocation = manual fallback |
| `./tools/oc-review-persist <lens> <text\|@file\|
| `./tools/oc-smoke-evidence [--unit opencrabs-ops] [--strings m1,m2] [--negative-control <bin>]` | mechanical identity + presence evidence for a Phase 6b smoke verdict: MainPID + exe path + sha256 of the RUNNING daemon vs deployed.meta.json artifact sha + deployed.sha marker; optional strings markers; negative control must hash differently (lens C1, v0.4.64 — replaces hand-assembled smoke-verdicts.log boilerplate). Behavioral judgment stays human |
| `./tools/oc-issue-log <issue-n> <sha> [--state <text>] [--repo <slug>] [--dry-run]` | per-commit implementation comment (owner 2026-08-28 22:54Z) composed from git metadata and posted via gh `--body-file` ONLY — the inline-heredoc substitution class is impossible through this tool (lens C3, v0.4.64) |
| `./tools/oc-commit -m <msg> [--issue N] [--no-comment] [--state <dir>] [--repo <path>]` | gated commit wrapper (lens C5, v0.4.65): refuses detached HEAD, refuses unset `OC_ACTOR`, refuses empty index (NEVER stages anything), derives `Issue-Ref` from the actor's latest ledger claim via `oc-ledger claim-ref` (override `--issue`); adds `Session-Id` + `Issue-Ref` trailers; post-commit implementation comment folded in (E2 #2, v0.4.72) via `oc-issue-log` — `--no-comment`/`OC_COMMIT_COMMENT=0` skips, comment-fail-after-commit = loud rc 5 |
| `./tools/oc-ship-audit [--hours N] [--log f] [--journal-dir d] [--grace min]` | dispatch-WITHOUT-swap alarm (lens C6, v0.4.65): pairs every successful `ship --sha … --execute` tools.log row against swap-journal evidence; dispatches under `--grace` (default 120 min) read IN-FLIGHT; rogue non-JSON log lines are skipped LOUDLY, never truncated into a false clean |
| `./tools/oc-tg-audit <uuid> [--date D] [--days N] [--log-dir P]` | Telegram surface-law evidence scan (lens C7, v0.4.65): TOOL_ACCUM rows by the accused session carrying a banned telegram surface tool (send/edit set, supervisor.md Duty 7 A12); falls back to Executing-tool rows; sanctioned senders remain supervisor judgment |
| `./tools/oc-ledger sync` CHANGELOG gate | sync refuses a version bump whose `## v<v>` CHANGELOG entry is missing (lens C8, v0.4.65, kills the v0.4.54 backfill class) — same rc 6 register as the frontmatter gate |
| `./tools/oc-harvest-sweep <pr-branch> [--base adolfousier/main] [--repo P] [--port-of sha1,sha2]` | pre-gate harvest verification (editor Phase 7 sweep, mechanical legs): Session-Id trailer sweep over base..branch, empty-diff probe, patch-id match per ported sha (lens C4, v0.4.64 — replaces the 3-gate-rounds-burned hand sweep). Leg (c) behavioral judgment stays human |
| `./tools/oc-prchecks <branch-or-sha> [--wait N] [--repo SLUG-or-PATH] [--carrier C] [--fault-scope PR]` | one-command CI gate on a PR-lane branch (editor.md Phase 5): FULL-sha shape gate → LOUD yml-on-carrier check → dispatch under a state-dir dispatch LOCK → **time-window run adoption** (v0.4.48 Duty-7 fix: workflow_dispatch headSha is the carrier ref, never the `-f ref` input, so adoption filters `headSha==carrier head + createdAt>=dispatch_ts−5s`, LATEST-wins (`.[-1]` — v0.4.53; under the lock the newest carrier dispatch IS this lane's own run; selftest fixture 111 proves the old earliest-wins rule decoy-adopts), under the lock — concurrent-lane safe) → watch → per-job/per-step report with the **fmt soft-fail exposed**; wraps the raw `gh` row below; `--repo` accepts a slug or a repo/worktree PATH (resolved via its origin remote); `--fault-scope PR` (E5, v0.4.78) auto-runs `oc-pr-fault-scope` on a RED verdict — IN-SCOPE/BASE-FAULT triage line, RED stays rc 3; identical-arg rc=2 repeats back off 2s..10s within 120s (C-#1, v0.4.78) |
| `./tools/oc-upstream-delta [--repo P] [--fork-origin R] [--upstream R]` | watch-cycle arithmetic for §Upstream relations item 1: fetch + merge-base + `AHEAD`/`BEHIND` TSV + patch-id `ABSORBED-CANDIDATE` rows; READ-ONLY (never merges/pushes/rebases) — PROPOSE/WAIT judgment stays human |
| `./tools/oc-wt add\|remove\|
| `./tools/oc-drift-check <uuid> <claimed-ver> [--ack]` | editor §Mid-cycle skill drift step 1-2, mechanical: claimed vs live SKILL.md version; `--ack` delegates oc-ledger ack on drift |
| `./tools/oc-toolaccum <uuid> [--days N]` | TOOL_ACCUM scan + repeat-offense arithmetic (per-tool failure counts in window, threshold 3) from tools.log |
| `./tools/oc-branch-sweep --repo <p> [--dry-run]` | branch-death proof (MERGED/ABSORBED/STALE/ACTIVE) + archive-then-delete for MERGED only; protected: base/HEAD/--keep regex |
| `./tools/oc-pr-fault-scope <pr#> --run <id>` | failing-files ∩ PR-files = IN-SCOPE/BASE-FAULT (2026-08-26 clippy-wall misattribution lesson, mechanical) |
| `./tools/oc-ledger confirm <uuid>` | lens C #5: verifies the worker's latest claim (#N ref resolvable on the live fork) then flips workers[].confirmed=true — first verb to flip it (was unsanctioned hand-edit) |
| `gh workflow run pr-checks.yml --ref ci/quick-build-linux -f ref=<branch-or-sha>` | **manual fallback — prefer `./tools/oc-prchecks`** (row above). PR-lane gates before an upstream PR (v0.4.28): fmt soft-fail + clippy `-D warnings` + all-features test, flags verbatim from upstream ci.yml; yml lives only on the carrier branch; green run URL = v0.4.22 PR-body citation (editor.md Phase 7 2c) |
| `./tools/oc-log-search <pattern> [--log <f>] [--since <ts>] [--module <re>] [--tail N]` | telemetry-only daemon-log search (owner-ordered via lane 1a63f103, 2026-09-01): filters provider stream-echo (`[TEXT_ACCUM]`/`[TOOL_*]` tags) and DEBUG noise by default; HARD FENCE — a line whose source module is `brain::provider` can never match; `--selftest` built in |

Tests: `tools/tests/run.sh` — one command, exit 0 only if all pass (a CODE
TESTS-class battery; the `oc-seal-state` IFS-join case is one guard inside it).
Must stay green before any version
bump; tools are never edited without re-running it.

### Unified tools log (v0.4.36)

Every tool in `tools/` sources `tools/lib/oc-log.sh` and appends ONE JSONL line
on exit — the fleet-analysis aggregate (per-tool journals remain the per-run
record).

- **Path:** `/root/.opencrabs/profiles/ops/opencrabs-dev/tools.log` (override with `OC_TOOLS_LOG`).
- **Schema:** `{"ts":"…Z","tool":"oc-…","args":"…","exit":N,"secs":N.N,"extra":{}}` — tools add fields via `oc_log_extra key value`.
- **Suppression:** `--selftest` in argv or `OC_TOOLS_NOLOG=1` (the battery exports it — synthetic runs never pollute the log). Missing `jq` → no write; logging NEVER changes the host tool's exit code.

Recipes (verified live):

```bash
# failing invocations (note: rc≠0 is often a VERDICT, not a crash —
# oc-skew-scan 1 = skew found, oc-ping-proof 1 = SILENT; filter .tool first)
jq -r 'select(.exit!=0) | [.ts,.tool,.exit,.args] | @tsv' tools.log
# usage per tool
jq -r '.tool' tools.log | sort | uniq -c | sort -rn
# newest line
tail -1 tools.log | jq -c .
```

## STEP ZERO — establish the role (mandatory on every load)

Ask the operator which role this session employs before doing anything:

> **Editor or Supervisor?** (Compiler: archived — say "re-enable compiler" to load `tools/archive/compiler.md`.)

| Role | Owns | Procedure file |
|------|------|----------------|
| **EDITOR** | Commits + error fixes: claim issue → worktree → code → CI gate → sign → push → ff-merge into fork `main` → `oc-deploy ship` → smoke on notify; feature COMPLETE + owner-approved → upstream PR (`editor.md` Phase 7) | `editor.md` |
| **COMPILER** | RETIRED 2026-08-28 (S3 cutover) — duties absorbed by `tools/oc-deploy` + supervisor watch; re-enable trigger: STEP ZERO | `tools/archive/compiler.md` (ARCHIVED) |
| **SUPERVISOR** | Owning the skill itself: apply owner directives + validated editor proposals, keep the worker-version ledger, publish versions to shared disk (v0.4.19: workers absorb at their own boundaries; targeted pings only), poll workers for input (Duty 4 — STANDING, every five bumps), triage the idea box (Duty 7 — workers push `IDEA:` notifies; **plus `QUIRK:` tool-quirk/failure reports**; ledger kinds `idea` / `idea-verdict`), 7-lens skill review (Duty 6, Reviewers A–G, grouped by target — DOCS A/B/G · TOOLS E/F · EVIDENCE+LIFECYCLE C/D; incl. Reviewer D deletion safety, Reviewer F tools-code, Reviewer G role-file structure — editor.md + supervisor.md + SKILL.md + review-lenses.md) | `supervisor.md` |

Roles **DO NOT intersect**:

- The Editor NEVER installs/swaps binaries, NEVER restarts daemons, NEVER dispatches
  BUILD runs — shipping goes through `oc-deploy ship` (S3). BUILD TRIGGERS = exactly
  TWO with NO exceptions (§Hard rules, A3 ruling 2026-08-29); the Phase-7 PR-head
  gate is the step-2c pr-checks dispatch — a lint/test gate, not a build trigger.
- Hand-off point: the Editor produces (branch pushed AND fast-forwarded into fork
  `main` + reported shas); `oc-deploy ship` takes it from there (dispatch → poll
  → swap-execute, consent eliminated 2026-08-28). If the run is RED, `oc-deploy`
  reports evidence and stops — fixing code is always Editor work.

If the request mixes both (e.g. "fix X and deploy it"), split into two sessions/two
role loads — do not fuse the roles in one pass without Alexey saying so explicitly.

## Session-notify loop (since v0.3.3)

Editors live in a Telegram forum group: one topic = one editor = one live session
= ONE feature.

- Every Editor commit carries a git trailer: `Session-Id: <full session uuid>`
  (`git commit --trailer "Session-Id: <uuid>"`). FULL uuid — the 8-char display
  form cannot drive routing. Each session READS ITS OWN UUID straight from its
  runtime prompt/session context — no lookup tool needed (correction
  2026-08-25); the post-swap fan-out takes notification targets from these
  trailers (`oc-attrib`; `oc-contributors` RETIRED v0.4.72 — E2 #1, subset of oc-attrib, zero live callers).
- After a healthy swap the fan-out is MECHANICAL: `oc-deploy fanout`
  (auto-fired at the `swap_execute` tail since v0.4.37,
  [#24](https://github.com/leshchenko1979/opencrabs/issues/24)) attributes the
  shipped range and notifies each contributing editor — an editor's job on
  notify is the smoke test (bullets below). GREEN/RED leg internals, range
  math, blame attribution, journal vocabulary: `s2-swap-journal-spec.md`
  §Fan-out legs (re-homed v0.4.80, lens B F4).
- Editors own testing THEIR features on notification: SMOKE TESTS against the
  swapped binary running on this box — no cargo, no compile, ever
  (decision 2026-08-25). Failures funnel back through blame attribution
  (issue #24: `oc-attrib` over Session-Id trailers — mechanical via
  `oc-deploy fanout` since v0.4.37),
  which asks the guilty editors for fixes.
- Separation holds inside the loop: the fan-out notifies + attributes but NEVER
  fixes code; Editors fix + re-push but NEVER attribute others' failures.

### session_notify mechanics (upstream #1203, commit 13a24f25)

- Same-process only: pushes into a LIVE session's queue on THIS box. Target must
  have messaged since boot; dead/cross-instance targets error → fall back to
  `a2a_send`, else list UNREACHABLE in the report.
- DELIVERY ≠ QUEUE ACCEPTANCE: a ping counts as delivered
  ONLY with post-ping proof — same-turn live roster check (`session_search`),
  target PINGED-WOKEN (`last_active` > ping time) or PINGED-SILENT. Ledger
  entries saying "pinged" without wake evidence are forbidden (both roles).
- Sender identity is mechanical — deliveries arrive prefixed
  `[session-notify from=<uuid>]`; replies route back with `target_session = from`.
  Neither role can forge or strip identity.
- Delivery drains at the target's next tool-loop boundary and wakes idle
  sessions — no polling anywhere.
- DELIVERY MODES (v0.4.69, binary behavior review 2026-08-31 — owner order):

  | Mode | When | Mechanics | Use for |
  |---|---|---|---|
  | immediate (default) | target idle | plain send wakes it now | FYI / courtesy |
  | failsafe | target mid-turn — `interrupt: true` (CLI `--interrupt`, "#13 failsafe") | message QUEUES, drains at that turn's next tool-loop boundary ("arrived-during-work") | the ONLY reliable operational wake (gate GREEN, build done, action needed) to a working lane: a default send REFUSES mid-turn and the wake is LOST unless retried (2026-08-31: 24 refusals in one day, 19 bounced off a single HQ mid-turn stretch — lanes went comatose) |
  | redirect | target no longer owns its channel | delivery steered AUTOMATICALLY to the occupying session with provenance framing (fork #19); the reply names where it went | follow the redirect — continue with the occupier, never re-send to the dead uuid |
  | no-route | dead/cross-instance target | error → `a2a_send` fallback, else UNREACHABLE in the report | — |

  NOT "deferred mode" (owner correction 2026-08-31): deferred/queued delivery
  is the pattern for ACKs and LOW-URGENCY messages — never spend the failsafe
  on courtesy pings; that is the derail the gate exists to prevent.
- Refusal handling: a mid-turn refusal is NOT delivery. Operational content →
  resend with `interrupt: true` in the same turn; deferrable content → ledger
  skip note + retry at your next boundary.
- CLI form carries `--sender "<lane label>" --title "<topic>"` where supported
  (oc-deploy fanout precedent) — the mechanical `from=<uuid>` header is added
  on top and cannot be forged or stripped.

### Telegram surface law (v0.4.31)

Inter-role communication is **session_notify ONLY**. No lane ever uses telegram
send/edit tools to talk to another session, another role's topic, the forum
General area, an unrelated chat, or the owner DM.

- An Editor's telegram surface is ITS OWN TOPIC and nothing else. Normal replies
  auto-route there as session text — that is the ONLY sanctioned output.
  Editors NEVER invoke send/edit telegram tools (`telegram_send`,
  `tg_send_message`, `tg_edit_message`, `telegram_edit`) — not even into their
  own topic (session text already covers it); no `tg_search_global` /
  cross-chat reads; `tg_get_messages` limited to the own topic. Reactions are
  allowed (owner consent signal).
- Sanctioned senders (NOT editors — none of this is lane-to-lane): the
  task-queue skill's documented `/tq-approve` topic-creation + invitation flow;
  alerting lanes reporting to the owner DM per the ops runbook; the
  supervisor's own session text.
- Violation pattern for the supervisor: a TOOL_ACCUM row showing an editor
  lane calling a telegram send/edit tool → session_notify the rule; second
  offense → review toggled.

## Test ontology (v0.4.2 — three kinds + one sanity signal, NEVER conflate)

| | SMOKE TEST | CODE TESTS | FEATURE-PRESENCE CHECK |
|---|---|---|---|
| Answers | does my feature WORK for a user right now? | is the code correct by analysis standards? | is the feature actually INSIDE the artifact we are about to deploy? |
| What | behavioral drive of ONE shipped feature | compile/run verification: cargo fmt, clippy, cargo test | static markers: binary strings/symbols, sha256 identity vs artifact, source-tree grep |
| Where | live `opencrabs-ops` unit, its real surfaces (Telegram, cron, MCP) | GitHub Actions ONLY — the CI gate (`pr-checks.yml`; upstream's own checks on PRs). Carrier build COMPILES the artifact but runs NO test leg (removed 2026-08-31, `e71dba58`) | this box, against the DOWNLOADED artifact + its source tree — nothing running |
| When | after a swap notify (`editor.md` Phase 6b) | pre-flight gate before PRs/ff-merge (Phase 7 step 2c) — `pr-checks.yml` is the ONLY CODE-TESTS locus | pre-swap, every cycle (`oc-deploy` swap path) |
| Who | owning Editor | Editor dispatches the gate and reads conclusions; `oc-deploy` reads build conclusions | `oc-deploy` swap path (pre-S3: Compiler alone) |
| Toolchain | none — local cargo FORBIDDEN in any form (binaries disabled 2026-08-28; editor.md §Box law) | CI's own — never local | `strings`, `sha256sum`, `git grep` — none compile anything |
| Evidence | one line: drove X, observed Y (+ run id / sha) | job/step conclusions read via API | marker found/not-found + checksum line in baseline.json |
| On FAIL | issue FIRST, then evidence to the supervisor lane (`session_notify`) | fix before merge / PR | NO swap — feature missing from build; regression stated plainly |

The table above carries the content; what remains prose:

- **SMOKE TEST** is the ONLY evidence that may back an upstream PR approval
  request (hard rule + `editor.md` Phase 7 step 0).
- **EXECUTION SANITY SIGNAL** — the swap-path `--version` run (`oc-deploy` swap
  path; archived anchor: `tools/archive/compiler.md` Step 3) — is NONE of the three kinds: it proves only "this file is a
  runnable opencrabs binary". Not behavioral, not analytical, not presence
  evidence; never cite it as any kind of test result.

Rule: never write "tests pass" without naming the kind. A green Lint run is NOT
a smoke pass; a smoke pass says nothing about clippy; a presence hit says
nothing about behavior.

## Glossary — official terms (v0.4.62; one concept = one name)

- **carrier** — the single build lane: branch `ci/quick-build-linux` + its
  `quick-build-linux.yml` + dispatches from it. workflow_dispatch runs record
  the CARRIER ref/head, never the `-f ref` input; the carrier yml is the
  single source of truth for the prod feature set.
- **fan-out** — the automatic GREEN/RED notify fired at the swap_execute tail
  (`oc-deploy fanout`, idempotent via `fanout.state`).
- **state dir vs skill dir** — the v0.4.60 split: skill repo
  (`skills/opencrabs-dev/`, versioned code+docs) vs state dir
  (`opencrabs-dev/`, runtime: ledger, journals, markers, locks, tools.log).
  The state dir has NO tools/ — tools always resolve next to the invoking
  script.
- **single-flight** — the one dispatch/adoption lock serializing concurrent
  oc-prchecks invocations; under it, the newest carrier dispatch is this
  lane's own run.
- **CI gate** — the `pr-checks.yml` dispatch on a worktree/PR head branch:
  fmt (soft-fail) + clippy + all-features test. The ONLY code-test locus.
  Legacy synonyms "CI lint gate" / "lint gate" / "UPSTREAM CI TRIAD GATE"
  all mean THIS gate ("the triad" = fmt/clippy/test); the named rule
  UPSTREAM CI GATE (SKILL.md) is this gate run before any upstream PR.
- **ORDER gates** — the 4 pure-git pre-dispatch checks inside
  `oc-deploy ship` (SHAPE / EXISTENCE / CONTAINMENT / SIGNATURE); no cargo.
- **S2 / S3** — deploy pipeline stages: S2 = sha-bound poll + auto-swap on
  GREEN; S3 = live cutover 2026-08-28 (swap chain mechanical, consent
  eliminated). Rules saying "below S2"/"S3" mean the stage gate.
- **Lane** — one editor session (worker) owning one fork issue + its topic.
- **Roster** — the worker registry in `workers-ledger.json` (enroll / claim /
  ack rows); `oc-attrib` joins Session-Id trailers against it.
- **Lens (Reviewer A–G)** — one Duty-6 read-only review perspective
  (supervisor.md §Duty 6; full briefs: `review-lenses.md`).
- **Selftest** — a tool's built-in test mode (`oc-deploy --selftest` etc.);
  **battery** — `tools/tests/run.sh` across all tools. Both green before
  ANY version bump.
- **GREEN / RED** — a GitHub Actions run conclusion read by terminal truth
  (`gh run view --json conclusion`), never exit-code inference.
- **TOOL_ACCUM** — the per-session tool-usage rows accumulated in the unified
  tools log; the evidence base for `oc-toolaccum` repeat-offense scans and
  Telegram surface-law audits (supervisor.md Duty 7).

## Red-run triage heuristics (shared core, v0.4.10 — moved from editor.md Phase 6)

ONE location: red-run diagnosis reads these (pre-S3: Compiler Step 2; now:
`oc-deploy` RED reports + supervisor triage); the
Editor applies the same ones in its fix round (editor.md Phase 6c). No lane
uses them as a licence to fix outside its scope.

- Fix unresolved-name/import errors FIRST (E0425/E0433...) — later errors are
  usually poisoned fallout. When scopes look shifted, count brace DEPTH, not
  brace counts.
- Match-arm narrowing does not inherit through outer arms — an inner match
  needs its own exhaustive arms regardless of the outer guard.
- **Contradictory INCOMING verdicts → settle via live GH API before acting**
  (v0.4.14, proposal P3): when two claims about the SAME run/sha disagree (e.g.
  a RED report vs an ACK calling that run "in_progress"), resolve with
  `gh run view <id> --json status,conclusion` FIRST — even ACKs can be
  stale. v0.4.6 predicates govern claims WE pass on; nothing sanitizes claims
  that ARRIVE — the receiver checks.

## Shared environment facts (both roles)

- Checkout `~/opencrabs`: remote **`origin`** = fork `leshchenko1979/opencrabs`
  (push target) · remote **`adolfousier`** = sync source (upstream).
- BUILD SOURCE = fork `main`. Editors fast-forward their signed commits into
  `leshchenko1979/opencrabs@main`; `oc-deploy ship` dispatches THAT ref — every
  artifact compiles all editors' merged changes TOGETHER (decision 2026-08-25).
  Building upstream/adolfousier refs is the exception, explicit ask only.
- Branch NAMESPACES are reserved so any role can tell development from upstream
  PR heads at a glance (decision 2026-08-25): `<type>/<slug>` with type ∈
  `feat|fix|ci|chore` = DEVELOPMENT — fork-only, ff-merged into fork `main`
  (editor Phase 6), archived after merge · `leshchenko1979/<slug>` = UPSTREAM PR HEADS ONLY (renamed from `up/*`, decision 2026-08-27)
  — created solely in editor Phase 7 off `adolfousier/main`, never merged into
  fork `main`, never a dispatch source. Any lane reads the prefix and knows
  what it is looking at.
- This box has **no sanctioned Rust toolchain** — CI is the only sanctioned
  compile/test executor (Compiler role RETIRED 2026-08-28). No cargo/rustc/clippy in ANY form —
  install, PATH-prepend, explicit path, even an invocation that exits 0 is a
  violation. Sanctioned local: `/usr/local/bin/rustfmt` wrapper (fmt only) —
  **the wrapper is NEWER than CI's rustfmt: cosmetic diffs it flags on
  CI-green committed code are KEPT AS-IS, not applied; fix only formatting
  artifacts you introduced yourself**; modum RETIRED 2026-08-28; lint evidence =
  GREEN pr-checks.yml run. Full ban list:
  editor.md §Box law.
- Live binary: `/usr/local/bin/opencrabs`. Daemons run as systemd **user** units
  (`systemctl --user`) — system-scope queries (`systemctl`, `/etc/systemd`) find nothing.
- Daemon PID identity (v0.4.15): NEVER `pgrep | head -1` — three daemons share
  this box (family, default, ops) and pgrep can grab the wrong one. The ops unit's
  PID comes only from `systemctl --user show opencrabs-ops -p MainPID --value`.
- Builds are MINIMAL-FEATURE by design: `cargo build --locked --profile ci
  --no-default-features --features "<set>"` *(profile ci = thin LTO /
codegen-units=16 — carrier yml since fork 8994be14)*. Upstream #1186 (missing #[cfg]
  gates) CLOSED 2026-08-25 — feature subsets compile clean.
- The feature set is PARAMETRIZED (`ebf44f69`, 2026-08-25): a workflow_dispatch
  input `features` (comma-separated). Its **`default:` in the workflow yml on the
  CARRIER branch `ci/quick-build-linux` is the SINGLE SOURCE OF TRUTH** for what we
  ship — these skill files NEVER copy the set (drift killed 2026-08-25). Read it
  live with `tools/oc-carrier-features` (the reader oc-deploy itself resolves
  through; raw form:
  `git -C ~/opencrabs show origin/ci/quick-build-linux:.github/workflows/quick-build-linux.yml | grep -A2 'features:'`)
  Changing the pick later = one-line Editor commit to that yml's `default:` —
  skills untouched.
- Dispatch ALWAYS passes the set explicitly: `-f features=<set>` (decision
  2026-08-25), even though a safe default exists. Artifact name carries the set:
  `opencrabs-linux-amd64-<set>`; job: `Linux amd64 (<ref>, <set>)`. The binary
  FILENAME stays `opencrabs-linux-amd64` (swap scripts depend on it). Anything
  outside the set (local-stt/local-tts voice, whatsapp/discord/slack/trello,
  pdfium…) is absent from the swapped binary — missing-feature behavior afterward
  is expected, not a bug.
- ORDER and dispatch carry sha AND feature set (v0.4.15, proposals P7+P8): a bare
  sha cannot identify WHICH build is meant under single-flight. The carrier yml has
  NO `--all-features` path — the build step hardwires `--no-default-features --features "$features"`
  — optional features order ONLY as `features=<comma-set>`, and a different-set build
  of the SAME sha is a DISTINCT build, serialized by the single-flight invariant.
- `source_ref` accepts a branch NAME (`main`) or the FULL 40-char commit sha —
  NEVER an 8-char short form: actions/checkout treats it as a glob and fetches a
  branch literally named `<sha>*` (war story below). PASS THE FULL SHA ALWAYS —
  see next rule for why it is now the only auditable record of what was built.
- The workflow lives ONLY on the carrier branch `ci/quick-build-linux` (moved off
  fork `main` 2026-08-26, Alexey's call — mirrors upstream dropping it from their
  main). Dispatch pattern adds `--ref ci/quick-build-linux`. CONSEQUENCE: the run
  object's `headSha` reports the CARRIER tip, not the built tree — the built
  commit is verified via the JOB NAME, which embeds `(source_ref, features)`.
  Carrier branches NEVER merge to `main` (same reservation discipline as `leshchenko1979/*`).

## Upstream relations (v0.4.0, owner-approved 2026-08-26)

Upstream movement is WATCHED and ABSORBED on a schedule — never improvised:

1. **Watch = supervisor duty, every build cycle**: `./tools/oc-upstream-delta`
   (base/ahead/behind TSV + patch-id ABSORBED-CANDIDATE rows; exit 0 clean,
   1 delta = verdict consumed here). Small clean delta → propose the sync
   (owner word gates it); mass absorption or non-trivial conflicts → notify
   Alexey with the delta and WAIT. Procedure: `supervisor.md` §Upstream sync.
2. **Sync model = REBASE-PORT** (merge-sync retired 2026-08-26): backup ref →
   classify fork-only commits (absorbed / superseded / survivor) → port
   survivors chronologically onto `adolfousier/main` → pr-checks green in
   ported lines → force-push-with-lease. Full procedure: `supervisor.md`
   §Upstream sync (re-homed v0.4.80, lens B F3); the archive keeps a pointer
   only.
3. **Absorption rule**: when upstream merges or reimplements one of OUR
   features, matching fork-only commits auto-classify DROPPABLE at the next
   sync (patch-id match or title-twin against his rework). The owning editor
   gets a "SHIPPED UPSTREAM" notice — fork-side maintenance ends.
4. **PR lifecycle**: every open upstream PR has an owning editor (the
   Session-Id trailers of its harvested commits). PR not mergeable → route by
   blocker class (`editor.md` Phase 7b): our files broken → owning editor;
   conflicts → owning editor rebases onto fresh upstream main; PRE-EXISTING
   upstream red → NO editor pings, housekeeping-PR decision escalates to
   Alexey; maintainer rejects/closes → owning editor reopens linked issues.
5. **Maintainer behavior (facts)**: Adolfo AUTO-ASSIGNS
   new upstream issues to himself — that is a CI workflow, NOT intent to work on
   them; an assignee is not a worker. He may also CLOSE our upstream PRs (and any
   legacy upstream issues) — the reason is ALWAYS in the comments. Our NEW issues
   live on the fork (item routing) where WE are the assigner. An issue/PR that looks "missing" is almost
   always CLOSED: find it among closed ones and read the comments BEFORE
   concluding anything. CLI comment output PAGINATES — later pages may hold the
   decisive comment (`gh api ... --paginate` / `--page N`); never conclude from
   the first page alone.
6. **Fork-local CI = carrier namespace (`ci/*`, v0.4.16)**: local-only workflow
   files live ONLY on `ci/*` branches, NEVER on fork `main` — anything under
   `.github/workflows/` on main rides the next PR diff toward upstream.
   Dispatch via `gh workflow run --ref ci/<name>`. After every upstream
   merge/port verify parity mechanically (`./tools/oc-ci-parity` exit 0
   identical / 4 DRIFT listing / 6 api-fail + carrier proof-dispatch —
   procedure: `supervisor.md` §Upstream sync). **DRIFT PERMANENT (owner
   ruling):** fork `ci.yml` stays REMOVED (zombie-run risk, order cc100dc6);
   the carrier branch is the sole build lane; an oc-ci-parity `exit 4` naming
   `.github/workflows/ci.yml` is ACCEPTED output forever, never repaired by
   restoring the file.
7. **Fork branch lifecycle (v0.4.24)**: the fork carries
   PERMANENT refs only — `main` (sync mirror; pre-S3: compiler rebase-port), `ci/quick-build-linux`
   (carrier), `backup/pre-port-*` (until the port cycle settles) — plus short-lived
   `leshchenko1979/<slug>` work branches. A work branch dies when its PR merges or the task
   dies, and ONLY after its landing is PROVEN by one of: tip sha-reachable from upstream or
   fork `main` · tip contained in `backup/pre-port-*` · exact mirror of a live upstream
   branch · a MERGED PR (either repo) whose head is the branch. Deletion without proof is
   forbidden — unproven branches stay and get reported to the owner. Every sweep archives
   BEFORE deleting: tip tags `archive/<date>/<branch>`, an `--all` bundle, and a manifest,
   so any deletion is reversible in one command. Branch heads riding OPEN PRs are
   never deletable.


## Hard rules (both roles)

- Reports to Alexey: every issue/PR reference
  carries the LINK behind the number (issues: `https://github.com/leshchenko1979/opencrabs/issues/N`
  — the fork is the issues home; PRs: `https://github.com/adolfousier/opencrabs/pull/N`) — a bare `#N` is never enough.
- Refer to workers by TOPIC/CHAT NAME only (owner 2026-08-31): Mermaid, Push to
  session, Vector memory, … — NEVER by session uuid. Applies to EVERY surface:
  owner reports, inter-lane advisories, session_notify text, verdict tables,
  ledger commentary. Uuids are for ROUTING fields only (`target_session`,
  `OC_ACTOR`, `Session-Id` trailers, tool arguments) — never prose. Test: an
  owner reading the message must know WHICH chat to open without a lookup.
- Stick to the OFFICIAL ONTOLOGY (owner 2026-08-31): all roles use the
  vocabulary this SKILL defines — test ontology (§Test ontology: SMOKE TEST /
  CODE TESTS / FEATURE-PRESENCE CHECK), infra terms (§Glossary: selftest /
  battery / CI gate), roles (Editor / Supervisor / Reviewer lenses),
  gate colors (GREEN/RED with run receipt), phases, tool names. No ad-hoc
  synonyms for existing concepts; a NEW concept gets proposed via the poll
  format and named on owner word — never improvised mid-report. Reviewer A
  (REDUNDANCY + ONTOLOGY) enforces this lens-side.
- ONLY the Supervisor edits skill files (`SKILL.md` / `editor.md` /
  `tools/archive/compiler.md` / `supervisor.md` / `review-lenses.md`) — including all worker lanes (decision 7,
  2026-08-26; the Compiler role retired 2026-08-28). Workers propose via poll format or direct notify; they never
  write.
- Relay only PREDICATED claims (v0.4.6, from fabrication deviation #3): any
  build/deploy/artifact claim you pass onward must carry evidence YOU verified
  same-turn — run id against the API, sha against `ls-remote`/job-name embed,
  binary against sha256. A claim verified by someone else's message is
  unverified.
- P1 REJECTED (owner verdict 2026-08-26 — "overengineering, don't do this"):
  NO evidence-parameter mechanism goes into `session_notify` — no mandatory
  evidence fields, no pattern-triggered enforcement, no tool change. The
  relay-predication rule above is the SOLE control for fabrication-class
  claims. Do not re-propose P1 in any form.
- ISSUE ROUTING (owner directives 2026-08-25 → 2026-08-27; consolidated as a
  table 2026-08-29):

| Rule | Applies to | Gate |
|---|---|---|
| NEW issues NEVER upstream — every new issue (upstream-code bugs and fork-only infra alike) is filed on the FORK | `leshchenko1979/opencrabs` | owner 2026-08-27 14:08Z |
| Upstream receives PRs ONLY — body = detailed description ending `Original issue: <full fork URL>`; NEVER `Closes #N` (wrong issue space) | `adolfousier/opencrabs` PR bodies | owner 2026-08-27 |
| Fork issue closed by US right after the PR is filed | fork issue tracker | — |
| Fork issues NEVER claimed on GitHub: no tackling comments, assignment, labels/reactions by any lane — claiming = `Issue-Ref` trailer + workers-ledger `claim` row (kind `claim`, v1.1 vocabulary since v0.4.48); uniqueness sweeps stay read-only search | ledger | owner 2026-08-27 17:07Z |
| PR SHIPMENT gates on owner approval: feature COMPLETE + smoke evidence OWNER-APPROVED → Editor harvests fork-only commits, opens the upstream PR (procedure: `editor.md` Phase 7) | owner word | 2026-08-25 directive |
| APPROVAL = Alexey's reply or a positive Telegram reaction to the explicit request in the forum topic; silence is NOT consent; spontaneous / ad-hoc PRs remain forbidden | owner word | v0.4.1 |

*Pre-2026-08-27 upstream issues stay readable for uniqueness sweeps and legacy
links; development-time upstream contact is PR-comments only (supersedes the
2026-08-22 issues/comment rule).*
- CONSENT REGISTER — **Never rule from codified memory — grep the live record
  (chat / ledger) before denying any permission** (v0.4.17 lesson, 2026-08-26).
  Deploy consent RETIRED 2026-08-28 (owner 18:50Z): GREEN carrier run + artifact
  verify IS the authorization. Upstream-PR owner-word gate UNTOUCHED
  (APPROVAL row above is the single statement of it — silence is NOT consent).
  (Deleted-tool history: CHANGELOG.md.)
- ROLE-SCOPED BROADCASTS: messages reach non-owning roles ONLY when tagged
  [ALL]; otherwise send strictly to the owning role. CC-everyone is noise.
- ONE formal SMOKE verdict per editor-feature lane: exactly one PASS/FAIL;
  duplicate confirmations are noise (#1227 lane double-report, 2026-08-26).
- SMOKE-EVIDENCE PRECEDENCE (v0.4.18): prefer
  smoke tests verifiable from LOGS over those requiring human verification.
  A machine-checkable verdict — CI run conclusion via API, parsed build/test
  logs, captured runtime or endpoint output — outranks "a human said it
  passed"; request human confirmation ONLY where logs genuinely cannot cover
  the claim (visual rendering, interactive UX), and then name EXACTLY what to
  observe. Design smoke captures to be self-sufficient: every claim cites run
  id + sha + step evidence, so any verdict is re-derivable from logs alone. Source-precedence ranks EVIDENCE quality only - it never conflates kinds: a green CI/build log stays CODE-TEST/build evidence and substitutes nothing for a behavioral SMOKE pass.
- UPSTREAM CI GATE (v0.4.22; encodes
  adolfousier/opencrabs CONTRIBUTING.md): NO upstream PR leaves a lane until
  the owning worktree passed the CI gate — and since v0.4.28 CI is the only
  executor, never local (Box law; local cargo in ANY form is a violation;
  Compiler role RETIRED 2026-08-28). The
  evidence is the GREEN `pr-checks.yml` run on the PR head branch (fmt/clippy/
  `cargo test --locked --profile ci --all-features` — flags VERBATIM from
  pr-checks.yml) — canonical procedure:
  editor.md §Phase 7 step 2c. One red = fix cycle, not a filed
  PR ("PRs that fail CI will not be reviewed" — their words). Receipts ride
  the PR prep beside smoke evidence. Gate covers shipworthiness only;
  owner approval + SMOKE pass remain separate required conditions.
- Issue-first, no exceptions (2026-08-25): a DISCOVERED problem gets its issue
  FILED before any fix work starts — on the FORK `leshchenko1979/opencrabs`
  (ALL new issues — upstream-code bugs and fork-only infra alike; upstream
  receives PRs only). Discoverer
  files it (symptom + evidence); fixer claims via a `gh` comment on the issue +
  an `oc-ledger claim` row (the `Tackling`-comment instruction is RETIRED —
  upstream issue comments on OUR fork issues are the owner's lane only,
  2026-08-27). Covers
  task starts (`editor.md` Phase 1) AND mid-loop finds: red-build bugs, failed
  smoke tests, defects in another editor's feature.
- Restart scope: **`opencrabs-ops` ONLY.** The `family` and default-profile daemons
  require Alexey's explicit approval EVERY time. Exception (v0.4.71, lens B2 #3;
  sanctioned v0.4.59 #47): the supervisor may mechanically restart the
  `opencrabs-family.service` SIDECAR (journal-sequence verified) — never the
  default-profile daemon.
- Never trust watcher exit codes alone — read the run's own `conclusion` via API.
- BUILD TRIGGERS = exactly TWO, NO exceptions (v0.4.3, S3-rewired 2026-08-28;
  A3 owner ruling 2026-08-29): an editor's `oc-deploy ship <full-sha>`
  background task, or Alexey's word. No other dispatch — the Phase-7 step-2b
  quick-build PR-head dispatch is RETIRED (superseded by the step-2c pr-checks
  gate; ORDER gate 3 (CONTAINMENT, oc-order-validate) rejects any sha outside fork `main` anyway).
  Stray unordered commits get reported by the ~2 h watchdog (`oc-deploy` watch),
  never built autonomously. A SECOND dispatch of the same sha+set is NEVER
  created — `oc-deploy ship` serializes (single-flight). SINGLE FLIGHT enforced
  twice: `oc-deploy`'s dispatch invariant + the carrier-yml concurrency group
  (commit `1ae46000`).

## Shared war stories (why these rules exist)

Incident histories behind the hard rules live in `war-stories.md`
(disclosed v0.4.80, lens B F6 — history is reference, not procedure; the
version-level record is CHANGELOG.md).
