---
name: opencrabs-dev
description: >
  OpenCrabs source ops (~/opencrabs): roles EDITOR (fork issues, per-task
  worktrees, CI gate (pr-checks), signed commits, push + sha hand-off, oc-deploy ship,
  smoke-test-on-notify, upstream PR), HQ (skill set + worker ledger),
  TRIAGE (interrupt lane: idea/QUIRK intake, fix routing, enforcement — carved out of HQ at v0.4.86),
    TOOLSMITH (CLI tool lane: owns tools/ — makes and fixes the CLI tools every other role uses — carved out at v0.4.87); Compiler role retired 2026-08-28).
  Use when editing/fixing OpenCrabs Rust code, debugging quick-build-linux carrier or other CI runs, fetching CI artifacts, or swapping /usr/local/bin/opencrabs.
  (/opencrabs-dev)
globs:
  - ~/opencrabs/**
  - ~/oc-wt-*/**
  - ~/.opencrabs/profiles/*/skills/opencrabs-dev/**
  - ~/.opencrabs/profiles/*/opencrabs-dev/**
  - ~/.opencrabs/profiles/*/projects/opencrabs-dev/**
version: 0.4.240
author: leshchenko1979
metadata:
  tags: [opencrabs, rust, ci, quick-build, binary-swap, worktree, session-notify]
  references:
    - https://github.com/adolfousier/opencrabs (upstream — PRs only; new issues NEVER filed here)
    - https://github.com/leshchenko1979/opencrabs (fork — push target + ISSUES HOME)
  provenance:
    - "Full release history moved out of the load path at v0.4.43 (B6, Duty-6 run-2) — every v0.4.31+ bump entry lives in CHANGELOG.md (git-tracked, prepended newest-first). This pointer replaces the inline list (~3k tokens loaded on every role-file claim). Current version: see CHANGELOG.md."
---

# opencrabs-dev — OpenCrabs source procedure

**Owns:** everything touching `~/opencrabs` source, its GitHub Actions runs, or the
installed `opencrabs` binary. This file = shared facts + role router only. Actual
procedures live in FOUR role files (`editor.md` / `hq.md` / `triage.md` / `toolsmith.md`);
load ONLY the one matching the session's role.

**Binding owner directives** (sync policy, upstream PR law, carriers/builds, cargo
prohibition, telegram surface law, gates, editor creation, tool-problem triage (Triage lane),
cadence) live in `fleet-directives.md` — re-homed from ops AGENTS.md/MEMORY.md per
owner order 2026-09-02. Load it before ANY opencrabs-dev work. Executing procedure for the sync
policy's rebase procedure: `upstream-merge-runbook.md` (freeze gate, roles, conflict
classes, migration-union rule, semantic-triage defaults).

## STEP ZERO — establish the role (mandatory on every load)

Ask the operator which role this session employs before doing anything:

> **Editor, HQ, Triage, or Toolsmith?**

| Role | Owns | Procedure file |
|------|------|----------------|
| **EDITOR** | Commits + error fixes: claim issue → worktree → code → CI gate → sign → push → ff-merge into fork `main` → `oc-deploy ship` → smoke on notify; feature COMPLETE → upstream PR filed on smoke PASS (procedure `editor-upstream-pr.md` Phase 7) | `editor.md` |
| **HQ** | Skill set maintenance, worker ledger, Duty 4 worker polls, Duty 6 periodic lens reviews — count derived from the catalog at gate time (details in `hq.md` and `review-lenses.md`) | `hq.md` |
| **TRIAGE** | Intake & hygiene: issue assignment, repo hygiene patrols, rebase/merge execution delegated from HQ, upstream lifecycle tracking (delta watch, PR census, dependency tracking folded from Harvester v0.4.176) | `triage.md` |
| **TOOLSMITH** | CLI tools author & maintainer: owns `tools/` code, test battery stewardship, direct recipient of tool quirks/defects (v0.4.176) | `toolsmith.md` |

Roles **DO NOT intersect**:

- The Editor NEVER installs/swaps binaries, NEVER restarts daemons, NEVER dispatches
  BUILD runs — shipping goes through `oc-deploy ship` (S3). BUILD TRIGGERS = exactly
  TWO with NO exceptions (§Hard rules, A3 ruling 2026-08-29); the Phase-7 PR-head
  gate is the step-2c pr-checks dispatch — a lint/test gate, not a build trigger.
- Hand-off point: the Editor produces (branch pushed AND fast-forwarded into fork
  `main` + reported shas); `oc-deploy ship` takes it from there (dispatch → poll
  → swap-execute, consent eliminated 2026-08-28). If the run is RED, `oc-deploy`
  reports evidence and stops — fixing code is always Editor work.
- The TRIAGE lane NEVER edits skill files (single-writer law unchanged — the
  HQ is the sole author), NEVER settles protocol disputes (rulings =
  HQ Duty 5), NEVER executes builds/swaps (strict routing, triage.md).
- The TOOLSMITH lane owns `tools/` CODE only (v0.4.87 carve-out) — skill markdown +
  fleet-directives stay HQ-only, daemon/carrier source stays Editor territory,
  NEVER settles protocol disputes (rulings = HQ Duty 5).
- **PRIORITY AUTHORITY (owner order 2026-09-15):** ALL lanes (Editor, HQ, Triage, Toolsmith) have complete, independent authority over priorities, sequencing, and task ordering within their codified scopes — never ask the human operator about priorities.

If the request mixes roles (e.g. "fix X and deploy it"), split into separate
role loads — do not fuse the roles in one pass without Alexey saying so explicitly.

## Canonical tooling (v0.4.12, PROCESS-TOOL ownership)

Mechanical rituals the roles once hand-ran are now single commands in `tools/`
(owner-aware: CLI-tool creation/fix is the TOOLSMITH lane's scope — v0.4.87 carve-out). Canonical
commands run INSIDE `oc-deploy` (ship/poll/swap-execute); this section is the
register + test source of truth (archived compiler-step anchors stripped
2026-08-29 — `tools/archive/compiler.md` carries the old numbering for re-enable context).
Fleet-wide rc conventions + FULL per-tool rc register: `tools/RC-CONTRACT.md` — the SOLE register (lens A H1/B F1, v0.4.79; rows below carry purpose only):

| Tool | Slot |
|---|---|
| `./tools/oc-order-validate <sha>` | ORDER gates inside `oc-deploy ship` |
| `./tools/oc-job-verify <run-id> <source-ref> [--features] [--identity-only]` | standalone run-identity gate (provenance of RED runs) |
| `./tools/oc-artifact-verify <artifact-path> [--source <sha>] [--run-id <id>] [--markers m1,m2] [--expect-sha <sha256>] [--expect-version <v>] [--repo R] [--json]` | EXECUTION SANITY SIGNAL + FEATURE-PRESENCE CHECK |
| `./tools/oc-seal-state [--sha S] [...]` | baseline/orders seal (flag-based interface — no positional `<sha>`) |
| `./tools/oc-attrib --repo <path> (--range <A..B> or --deployed) [--ledger <f>] [--contributors] [--novel\|--no-novel]` | commit-range → worker-lane attribution; `--contributors` projects the 3-col TSV (SINGLE SHAPE); `--deployed` composes the range from `deployed.sha` + `prev_sha` (fan-out compute backend for [issue #24](https://github.com/leshchenko1979/opencrabs/issues/24)) and IMPLIES `--novel` (#407: drops re-sha'd + empty commits; `--no-novel` restores the raw range) |
| `./tools/oc-deploy <mode>` | the ship path itself — `ship` / `poll` / `swap-execute` / `status [--json]` / `watch [--with-delta]` / `fanout` / `contributors` RETIRED (use `oc-attrib --contributors`). Editor S3 path: `editor.md` §Ship. Verdict codes + wait semantics: RC-CONTRACT.md |
| `./tools/oc-deploy fanout --run <id> [--dry-run]` | mechanical notify fan-out for one carrier run ([#24](https://github.com/leshchenko1979/opencrabs/issues/24)); auto-fired at `swap_execute` tail + on `poll` RED-scan; `OC_DEPLOY_NOFANOUT=1` suppresses — mechanics + journal vocabulary in `s2-swap-journal-spec.md` §Fan-out legs |
| `./tools/oc-carrier-features [--fetch] [--repo <path>] [--ref <branch>]` | reads the carrier-yml `features` default at `origin/<ref>`; `oc-deploy ship/poll` resolves EMPTY `--features` through this — carrier read failure aborts the ship loudly |
| `./tools/oc-issue-sweep '<query>' [--fork R] [--upstream R] [--limit N]` | closed-issue hygiene sweep (HQ duty) |
| `./tools/oc-skew-scan [--ledger f] [--current v]` | ledger worker-version skew vs current skill version (HQ roster review) |
| `./tools/oc-ping-proof <uuid> <ping-ts> [--ledger f]` | post-swap notify proof: WOKEN / SILENT / UNREACHABLE verdict |
| `./tools/oc-pr-atomicity <pr-number>` | atomicity gate (editor Phase 7 / issue triage) |
| `./tools/oc-ledger <verb>` | workers-ledger: stamp/sync/check-version/cadence/ack/enroll/roster/commit-pending/claim-ref/confirm/events — `--verbs` lists registered subcommands; unrecognized verbs emit vocabulary hints; `roster --live --role <role>` is the ROLE-RESOLUTION verb; the `oc-roster --role <role>` form delegates to it and returns byte-identical output |
| `./tools/oc-shadow-rotate [--dry-run]` | INTERNAL tail step of `oc-ledger sync` (standalone = manual fallback) |
| `./tools/oc-review-persist <lens> <text\|@file\|-> [--dir DIR]` | persist a Duty-6 review report — the index line IS the "persisted" receipt |
| `./tools/oc-smoke-evidence [--unit opencrabs-ops] [--strings m1,m2] [--negative-control <bin>] [--append-log [<path>]]` | mechanical identity + presence evidence for a Phase 6b smoke verdict; behavioral judgment stays human; `--append-log` is the SANCTIONED writer of the **IDENTITY EVIDENCE BLOCK** in the canonical `smoke-verdicts.log` — the VERDICT ROWS are LANE-AUTHORED (see `upstream-merge-runbook.md` §Upstream-merge cadence · HARVEST LAW · NO-HOLD); bare = the canonical absolute, a wrong path is unrepresentable (M2-2) |
| `./tools/oc-issue-log <issue-n> <sha> [--state <text>] [--repo <slug>] [--dry-run]` | per-commit implementation comment via gh `--body-file` ONLY |
| `./tools/oc-commit -m <msg> [--issue N] [--no-comment] [--state <dir>] [--repo <path>]` | gated commit wrapper: derives `Issue-Ref` from the actor's latest ledger claim, adds Session-Id + Issue-Ref trailers, folds in the post-commit comment |
| `./tools/oc-ship-audit [--hours N] [--log f] [--journal-dir d] [--grace min]` | dispatch-WITHOUT-swap alarm |
| `./tools/oc-tg-audit <uuid> [--date D] [--days N] [--log-dir P]` | Telegram surface-law evidence scan |
| `./tools/oc-ledger sync` CHANGELOG gate | sync refuses a version bump whose CHANGELOG entry is missing |
| `./tools/oc-harvest-census <scan|check|record|sync>` | pre-flight census & lifecycle registry for upstream PR harvests; prevents duplicate/colliding PRs. `record` appends to `manual_records`, which `check` CONSULTS before declaring a unit unharvested — rc 1 `REFUSED … manually recorded as filed in PR #<n> (unit <u>)` — and the registry write MERGES into the loaded dict so foreign keys survive. Use `check`/`scan`, which derive IN_FLIGHT from the live scan |
| `./tools/oc-harvest-dispatch <issue> [--dry-run]` | dispatches automated harvest-to-upstream work order for eligible features |
| `./tools/oc-harvest-sweep <pr-branch> [--base adolfousier/main] [--repo P] [--port-of sha1,sha2]` | pre-gate harvest verification (editor Phase 7 sweep, mechanical legs); behavioral judgment stays human |
| `./tools/oc-health [--class <name>|--all] [--rotate] [--status] [--json] [--reap] [--quiet] [--selftest]` | 8-class rotating fleet health & cleanliness sweep (owner order 2026-09-11); spec + per-check remediation in `tools/HEALTH-CLASSES.md` & `tools/HEALTH-CHECKS.md`. `--reap` applies SAFE remediations only; without it the tool is a pure read |
| `./tools/oc-roster --selftest` | hermetic test runner for roster generation and classification |
| `./tools/oc-watcher-audit [--json] [--notify-orphans]` | detached watcher compliance and sleep-loop audit across active sessions |
| `./tools/oc-start <issue-N> --branch <branch>` | unified entry: claim + branch + worktree initialization |
| `./tools/oc-smoke <issue-N> [--probe <cmd>] [--no-ledger]` | unified 4-leg smoke verification & verdict row logging + automatic ledger done stamp on PASS |
| `./tools/oc-issue-dispatch [--auto] [--issue N] [--lane U]` | mechanized issue triage dispatch to idle editor lanes |
| `./tools/oc-lint-laws [--strict]` | mechanical syntax & tool existence lint of skill markdown laws. **`--strict` known limitation (v0.4.207, measured 2026-09-19):** `flag_known` demands the flag BE the whole case arm (`^[[:space:]]*--flag)`), so ALTERNATION arms (`--role\|--role=*)`, `--selftest\|selftest)`), INLINE tests (`[ "${1:-}" = "--bundle" ]`) and comments are not recognised. On this corpus that yields **5 false-positive PHANTOM-FLAG findings** (SKILL.md:99 `oc-roster --role`; SKILL.md:352 + hq.md:31 `oc-deploy --selftest`; hq.md:108 `oc-ledger --bundle`; tools/RC-CONTRACT.md:55 `oc-ledger --issue`), every one a real working flag: `oc-roster --role hq` rc=0 and `oc-deploy --selftest` rc=0 (283 pass/0 fail) checked live, `--bundle`/`--issue` each covered by passing selftest assertions at `tools/oc-ledger:1275` and `:1415`. Non-strict mode finds all five. **Do not "fix" these five as phantoms** — root fix dispatched to Toolsmith. |
| `./tools/oc-claims-single-source [--scan DIR] [--selftest]` | battery guard: the claim-closure predicate has exactly ONE home (`tools/lib/oc_claims.py`) — fails the battery on a re-added private copy under `tools/`. Keys on the re-implementation SHAPE, never on a name (the two copies it exists to prevent were called `claims_index` and `claim_is_closed`, so a name-keyed guard misses both). Scan units include embedded `python3 -c` / heredoc blobs, not only whole files. rc register: RC-CONTRACT.md |
| `./tools/oc-prchecks <branch-or-sha> [--wait N] [--repo SLUG-or-PATH] [--carrier C] [--fault-scope PR]` · `oc-prchecks resume <run-id>` | one-command CI gate on a PR-lane branch (editor.md Phase 5); `wait <ref> [--budget N] [--poll S]` provides single-invocation blocking gate; **`resume <run-id>` RE-ATTACHES to a run this lane WITNESSED** — no dispatch, no adoption (#74 H2) — and is the recovery for a rc-5 in-flight-timeout, whose stdout carries the run id + URL for exactly this (`extra.run_id` in the journal is the same handle). Full rc/adoption/lock/fmt-soft-fail register: RC-CONTRACT.md |
| `./tools/oc-upstream-delta [--repo P] [--fork-origin R] [--upstream R]` | watch-cycle arithmetic; READ-ONLY — PROPOSE/WAIT judgment stays human |
| `./tools/oc-wt add\|remove\|--force` | editor worktree manager (`--force` journals before removal) |
| `./tools/oc-drift-check <uuid> [--ack]` (omit-arg canonical; legacy `<uuid> <claimed-ver>` accepted) | editor §Mid-cycle skill drift step 1-2, mechanical |
| `./tools/oc-branch-sweep --repo <p> [--dry-run]` | branch-death proof + archive-then-delete for MERGED only |
| `./tools/oc-census` | READ-ONLY pending-branch census (sync runbook Step 7 step 0): decomposes each branch's `git cherry <base> <b>` `+` set into its three arms (own-lane trailer / no trailer / foreign-lane trailer) and ENFORCES the partition identity `plus_total == plus_own + plus_untrailered + plus_other` — a row that fails to add up is an internal error, never a silently-wrong number. A non-zero aggregate `+` is NOT proof of pending work, so it splits the aggregate and runs a CONTENT leg rather than trusting either. Prints counts and the base, never a cut sha. rc register: RC-CONTRACT.md |
| `./tools/oc-pr-fault-scope <pr#> --run <id>` | failing-files ∩ PR-files = IN-SCOPE/BASE-FAULT |
| `./tools/oc-ledger confirm <uuid>` | verifies the worker's latest claim then flips workers[].confirmed=true |
| `gh workflow run pr-checks.yml --ref ci/quick-build-linux -f ref=<branch-or-sha>` | **manual fallback — prefer `./tools/oc-prchecks`** (row above). PR-lane CI gates before an upstream PR; yml lives only on the carrier branch |
| `./tools/oc-log-search <pattern> [--log <f>] [--since <ts>] [--module <re>] [--tail N]` | telemetry-only daemon-log search; HARD FENCE: `brain::provider` lines never match |
| `./tools/oc-ship-chain --sha S --branch B` | CI gate → issue-log → ff-merge → ship → swap in ONE invocation; no-self-ping |
| `./tools/oc-notify-fanout --title T` | per-lane skill-change brief generator; DB-validated forum-scoped targets, receipts + ledger stamp |
| `./tools/oc-rebase-safety overlap\|audit` | re-gate split rule arithmetic |
| `./tools/oc-roster <live\|forum\|claims\|work\|classify> [--detail\|--json]` | the DERIVED in-progress roster — joins ledger claim events + worktree dirty state + session-DB liveness + forum bindings; stores nothing. `live` = the freeze list; `classify` = ACTIVE/IDLE/ORPHAN/UNKNOWN per row; a claim author absent from the session DB is reported PHANTOM and excluded. `--selftest` = 44 checks. **`--role <role>` is a supported delegation to `oc-ledger roster --live --role <role>` — byte-identical output (verified 2026-09-19, `cmp` rc=0); a bare `--role` with no value answers rc 2.** Sync runbook step 0 |

Tests: `tools/tests/run.sh` — one command, exit 0 only if all pass (the
SELFTEST BATTERY — tool selftests, distinct from the CI-gate CODE TESTS
cargo triad; the `oc-seal-state` IFS-join case is one guard inside it).
Must stay green before any version
bump; tools are never edited without re-running it.

### Unified tools log

Every tool in `tools/` appends ONE JSONL line on exit (aggregate; per-run
journals stay per-run). Path, schema, suppression rules, and verified jq
recipes: `tools/RC-CONTRACT.md` §Unified tools log.

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
  swapped binary running on this box (the cargo ban itself = editor.md §Box law, one
  statement). Failures funnel back through blame attribution
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
  entries saying "pinged" without wake evidence are forbidden (all roles).
- Sender identity is mechanical — deliveries arrive prefixed
  `[session-notify from=<uuid>]`; replies route back with `target_session = from`.
  Neither role can forge or strip identity.
- Delivery drains at the target's next tool-loop boundary and wakes idle
  sessions — no polling anywhere.
- DELIVERY MODES (v0.4.69; defaults re-ruled 2026-09-19 03:34:30Z — fleet-directives
  §Cross-lane message delivery discipline is CANONICAL: `turn-end` is THE DEFAULT,
  `quiet` is a deliberate choice, `now` is RETIRED and hard-errors):

  | Mode | Note |
  |---|---|
  | `turn-end` (DEFAULT) / `quiet` / redirect / no-route | full table = fleet-directives.md §Cross-lane message delivery discipline (CANONICAL — this row is a failsafe pointer, lens B-F15 v0.4.96) |
  | `now` | **RETIRED — passing it FAILS the delivery** (`notify_policy.rs` returns `Err`; the schema's `delivery.mode` enum is exactly `[turn-end, interrupt, quiet]`; #373 landed + deployed). It is NOT an available mode. |
  | `interrupt` (urgent tier) | `interrupt: true` is the **LEGACY ALIAS for `delivery.mode: interrupt`** — the URGENT tier (#393, landed + deployed): the SAME delivery point as `turn-end`, carrying a precedence frame so the target yields its current plan and answers in that turn, and never deferred. It is **NOT pre-emption** — no boundary exists inside a running tool call, so a mid-turn target still QUEUES for its next tool-loop boundary. |

  Escalation ladder canonical: fleet-directives.md §Cross-lane message delivery discipline
  (`turn-end` is the default and `interrupt` is the URGENT tier — same boundary plus precedence framing, never pre-emption — lens A5
  v0.4.89: pointer only, no second copy).
- Refusal handling: **the `session_notify` path never refuses.** `interrupt` is
  hardcoded true on this tool's route (`src/brain/tools/subagent/notify.rs:371`),
  so the mid-turn gate (`src/brain/agent/service/session_routes.rs:336`) is
  bypassed and a busy target QUEUES the message for its next tool-loop boundary —
  send `turn-end` (the default) and do nothing else. `interrupt: true` is a
  legacy alias for the urgent tier (precedence framing, never deferred — but still
  not pre-emption); `now` fails the delivery outright.
  A `no wake observed` confirm verdict MEANS the target is mid-turn — never
  re-send on it. Do NOT generalise this to "there is no refusal path": the
  `Delivery::RefusedInFlight` variant is still constructed and reachable from
  other callers that pass `interrupt=false` (`quiet_delivery.rs:199`,
  `a2a/handler/notify.rs:266`, `cron/scheduler.rs:1174`).
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
  HQ's own session text.
- Violation pattern for HQ: a TOOL_ACCUM row showing an editor
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
| Toolchain | none — local cargo FORBIDDEN in any form (binaries disabled 2026-08-28; editor.md §Box law — canonical, other files reference "(box law)") | CI's own — never local | `strings`, `sha256sum`, `git grep` — none compile anything |
| Evidence | one line: drove X, observed Y (+ run id / sha) | job/step conclusions read via API | marker found/not-found + checksum line in baseline.json |
| On FAIL | issue FIRST, then evidence to the HQ lane (`session_notify`) | fix before merge / PR | NO swap — feature missing from build; regression stated plainly |

The table above carries the content; what remains prose:

- **SMOKE TEST** is the ONLY evidence that may back an upstream PR approval
  request (hard rule + `editor-upstream-pr.md` Phase 7 step 0).
- **EXECUTION SANITY SIGNAL** — the swap-path `--version` run (`oc-deploy` swap
  path; archived anchor: `tools/archive/compiler.md` Step 3) — is NONE of the three kinds: it proves only "this file is a
  runnable opencrabs binary". Not behavioral, not analytical, not presence
  evidence; never cite it as any kind of test result.

Rule: never write "tests pass" without naming the kind. A green Lint run is NOT
a smoke pass; a smoke pass says nothing about clippy; a presence hit says
nothing about behavior.

**Corrected-code presence ≠ smoke success (owner order 2026-09-08):** evidence
that the corrected code is merely PRESENT in the swapped binary — strings
marker hit, sha match, deployed.meta identity — can NEVER back a smoke-success
verdict on its own. Presence proves the artifact shipped; it says nothing
about behavior. A smoke verdict of GREEN additionally requires at least one
BEHAVIORAL probe of the corrected path actually executing (a live call, a
forced trigger, an observed output through the new code). If only presence
evidence exists, the verdict is `UNPROVEN (presence-only)` — never GREEN, and
the lane's ledger append must carry that label.

**Live verification stamp required for live-testable UX features (owner order 2026-09-16):**
For any UX, UI, card rendering, button interaction, or user-facing feature that is
live-testable on the running binary, static binary string probes or symbol searches alone
are STRICTLY FORBIDDEN as proof of a smoke PASS. Binary strings prove only compilation
presence, not runtime UI correctness or execution. A smoke PASS for live-testable UX
features requires an explicit live behavioral execution receipt stamped into the stamp system
(`smoke-verdicts.log` / `workers-ledger.json`). If behavioral verification cannot be fully
automated and requires the owner's visual inspection, the lane MUST record `PARKED-OWNER-EYE`
naming the exact owner action and packaging sha — never substitute a binary string probe for a
live UX verification.

**Bookkeeping legs ≠ smoke PASS (owner order 2026-09-08 12:16Z):** lineage
(is-ancestor), identity (artifact==exe sha) and CI gate evidence are
bookkeeping legs — ALL THREE PASSING still does not constitute a successful
smoke test. Smoke PASS requires a live behavioral probe of the corrected
runtime path on the running box (full rule: editor.md Phase 6b). A verdict
citing only bookkeeping legs is INCOMPLETE — returned to the lane, never GREEN.


**Owner-dependent leg → PARK, never wait (v0.4.152, owner order 2026-09-12):** when
the only remaining behavioral evidence requires the OWNER (a visual pass, a tap, an
eye-confirm), the leg is NOT a blocking gate. Stamp the provable legs, append a
`PARKED-OWNER-EYE` row naming the owner action and the packaging sha, and RELEASE
the lane. A lane idling on an owner leg is in violation; a lane that parks and moves
on is compliant. Full law: `fleet-directives.md §Owner-Dependent Smoke Legs — Park,
Don't Chase` (L1–L4: parking, shift exit condition, owner-verdict timing, packaging-sha
stamps).

**Tool-description changes have no log-based probe (lane 1a63f103, 2026-09-12):** the
daemon's provider log records tool ARGS only (`[TOOL_ACCUM] name=bash`) and NEVER tool
schemas — so no log line can prove a description string was served. Smoking a
`Tool::description()`/`input_schema()` change uses **binary strings on the running exe +
the shipped constants in source**; any description fragment found in the log is
self-contamination from the prober's own commands. A "live schema served" receipt from
the log is a FALSE receipt.

**Leg-4 probe hygiene (lane 212b3c83, Duty-4 cycle `20260919-c21`, 2026-09-19) — three ways a leg-4 probe measures
nothing and still reports PASS.** (a) **ARTIFACT BINDING:** a criterion binds to a NAMED artifact —
rendering bytes and delivered bytes are different artifacts, because the delivery path re-encodes
(Telegram converts renders to JPEG) and a re-encode destroys fine-stroke measurements, so a criterion
that holds on the lossless render (colour type, alpha, contrast across a 1 px stroke) is **not**
thereby valid on the delivered artifact. Where both are needed, state **two legs with distinct
criteria** — the renderer leg proves the wire form is right, the delivered leg proves the user
receives the corrected output and binds on a **coarse, codec-surviving discriminator** (a large
contiguous fill region, a presence/absence inversion against a pre-fix control message) — and a
verdict resting on both must say which criterion binds to which artifact. (b) **MEASURE FROM THE
ARTIFACT, NOT THE CONSTANTS:** if every argument to the metric is a literal declared beside the
threshold, the metric measures the source file, not the artifact, and passes on any input — measure
from the loaded bytes. A **bucketing/matching tolerance must be strictly smaller than the separation
between the buckets it distinguishes**: with references `d` apart, any tolerance `>= d` merges them
and the metric silently becomes a count of the union — assign each sample to its NEAREST reference
rather than testing a radius (a merged bucket shows as a ratio that cannot exist, e.g. two bucket
counts summing past the population). (c) **SPILL-DIRECTORY COMPLETENESS:** a probe consuming tool
output must not read the spill directory as if it were complete — results under the inline threshold
are returned inline and produce **no spill file**, so a spill-only harvest has a hole exactly where
the newest evidence sits; force the spill by raising the result size, or parse the tool result inline
in the same turn. Because **expired attachment URLs are skipped silently and the skip reads as
absence**, report the skipped count beside the found count — "0 found, 13 skipped as expired" is a
different verdict from "0 found". **Corollary binding all three: a leg-4 probe reports PASS only if
it would FAIL on the pre-fix artifact — state the input on which it fails.**
**Duty-5 ruling 2026-09-19 (answering lane 4b0990b7, issue #295): for a SINGLE-SIDED probe the corollary IS the sufficiency test -- the discriminating negative half need not be OBTAINED, only NAMED and mechanically shown absent from the pre-fix tree.** A positive half alone backs PASS when all three hold: (1) the falsifying input is STATED explicitly; (2) its absence on the pre-fix artifact is established by a MECHANICAL discriminator run that turn -- `git log -S <string> <fix-sha> -- <pathspec>` returning exactly ONE introduction (the fix's own commit), or the string absent from `git grep` over the pre-fix tree -- never by assertion, never by reasoning about the code; (3) the probe observes the RUNNING artifact's OWN output (a live session's rendered prompt, a real call), and the observing session itself exercises the path under test (a Telegram-bound session, for a Telegram-delivery feature) -- a `strings` dump of the binary stays presence-only and cannot back PASS for a live-testable UX feature. What the corollary forbids is a probe that cannot NAME any input it would fail on: that probe measures its own constants. Where the negative half is STRUCTURALLY unobtainable -- prompts are rendered per turn and never persisted, so a non-Telegram session's prompt cannot be read back -- the mechanical discriminator of (2) stands in for it. **Carry the discriminator's command in the row.** **Scope it, or it proves nothing:** both sanctioned forms silently assume the token is GLOBALLY UNIQUE, which this law never stated. A non-unique token -- `MAX_ATTEMPTS`, `TIMEOUT`, `retry`, `attempts` -- makes form 1 return FOREIGN introductions and form 2 a false PRESENT. Measured on `96b474e` (lane c6b1a539, verified first-hand): `git grep -nEi 'max_attempts|backoff' 96b474e -- src/cli src/a2a` returns rc=1 with ZERO hits -- the correct pre-fix answer, the retry path is absent -- while the SAME grep UNSCOPED returns rc=0 with 265 hits, including a foreign `const MAX_ATTEMPTS: u32 = 3;` at `src/brain/agent/service/compaction.rs:348`. A CORRECT fix therefore FAILS its own discriminator, and the lane may wrongly conclude its probe is unsound. So the discriminator token MUST be PATHSPEC-SCOPED to the subtree the fix changes, the row MUST carry the pathspec, and "exactly ONE introduction" is a claim about a SCOPE -- never about the tree. **Anchor it too, or it proves nothing on a pre-merge tree:** form 1's revision defaults to HEAD, and a lane runs this discriminator on a PRE-MERGE tree where the fix's own commit is not yet reachable from HEAD -- so the bare form returns EMPTY, and empty reads as "no introduction exists": a FALSE NEGATIVE on the one tree the law is about. Form 1 is therefore ANCHORED at the fix's own commit -- `git log -S <string> <fix-sha> -- <pathspec>`. Measured on #450 (lane 2ed8adeb, verified first-hand; HEAD=main, fix `b6389c892` unmerged -- `git merge-base --is-ancestor b6389c892 HEAD` rc=1): the bare form returns EMPTY, the anchored form returns exactly ONE introduction, `b6389c892`. Form 2 is unaffected by this gap and is what established the negative half for #450 -- scoped, `git grep -c 'ProgressEvent::TokenCount' 33b7aecdd -- src/channels/telegram/resume.rs` returns rc=1 with ZERO hits (the correct pre-fix answer), while the SAME grep UNSCOPED returns 19 hits across 6 files, including the fresh-turn twin at `src/channels/telegram/progress.rs:1` -- a false PRESENT.

## Glossary — official terms (v0.4.62; one concept = one name)

- **FIRE** — the release window between version bump and prod swap (editor.md
  usage, lens A8 v0.4.89). In `oc-ledger` cadence output, "FIRE" = the
  Duties-4+6 threshold verdict (≥5 bumps/5 days) — same word, different
  locus; context disambiguates.
- **carrier** — the single build lane: branch `ci/quick-build-linux` + its
  `quick-build-linux.yml` + dispatches from it. workflow_dispatch runs record
  the CARRIER ref/head, never the `-f ref` input; the carrier yml is the
  single source of truth for the prod feature set.
- **fan-out** — the automatic GREEN/RED notify fired at the swap_execute tail
  (`oc-deploy fanout`, idempotent via `fanout.state`).
- **state dir vs skill dir** — the v0.4.60 split: skill repo
  (`skills/opencrabs-dev/`, versioned code+docs) vs state dir
  (`opencrabs-dev/`, runtime). The state dir has NO tools/ — tools always
  resolve next to the invoking script.
  Its content is declared in TWO classes (v0.4.238, a RECOVERABILITY rule: a
  tracked file's only durable record is git):
  - **TRACKED** — `workers-ledger.json` · `journal/` · `oc-deploy/journal/`
    (the deploy audit trail `oc-ledger recover-receipt` reads) · the lane
    `*-state.md` records · `reviews/` · `evidence/` · `tools.log` ·
    `smoke-verdicts.log` · `deployed.sha`/`.meta.json` · `baseline.json` ·
    `fanout.state` · markers (`pacemakers-off`).
  - **GENERATED-IGNORED** — the generated class: `.bak`/`.bak-*` sidecars ·
    `.ledger.*` temps · `__pycache__/` · `*.pyc` · `*.lock`. Never committed,
    reaped on the hygiene cadence WITH a keep-window (a sidecar taken while its
    source was still UNTRACKED is the only copy of that reading).
  A TRACKED class's additions and updates MUST be committed by the state-repo
  commit path. That path has ONE home (#508, 2026-09-22): `STATE_TRACKED_PATHS` +
  `STATE_TRACKED_GLOB` (`tools/oc-ledger:223`/`:230`), consumed by
  `state_sweep_tracked` (`:232`), with a selftest asserting the single source
  (`:1540`). BOTH callers sweep the SAME namespace — the auto-commit tail (`:276`)
  and `commit-pending --bundle` (`:1101`). Before #508 the auto-commit staged
  `workers-ledger.json` ALONE and the sweeping verb was invoked by NO enabled cron:
  measured 2026-09-22, 345 entries had piled up on that split. Consequence for
  authorship: a class named TRACKED above is only actually swept if it is in
  `STATE_TRACKED_PATHS` — naming it here without adding it there leaves it
  accumulating while the law reads as covered.
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
  (v0.4.89, lens A7: extended to any role session — Triage/TOOLSMITH/HQ
  lanes exist too; "lane" ≠ editor-only.)
- **disk absorption** — the v0.4.19 worker-update model: skill files are plain
  disk; workers absorb re-reads at their own boundaries (turn start, role-file
  load), no reload pings are owed or sent (defined here lens A16 v0.4.89;
  used in editor.md/triage.md/toolsmith.md).
- **Triage lane** — the interrupt lane carved out of HQ at v0.4.86
  (idea/QUIRK intake, fix routing, enforcement patrols — `triage.md`); never
  edits skill files. Discover its session via `session_search`, never
  uuid-from-memory.
- **Toolsmith lane** — the CLI tool lane carved out at v0.4.87 (owner "Go toolsmith"
  2026-09-06): owns `tools/` code — makes + fixes the CLI tools every other role
  uses (`toolsmith.md`); never edits skill markdown. Discover its session via
  `session_search`, never uuid-from-memory.
- **Roster** — the worker registry in `workers-ledger.json` (enroll / claim /
  ack rows); `oc-attrib` joins Session-Id trailers against it.
- **Lens (Reviewer A–J)** — one Duty-6 read-only review perspective
  (hq.md §Duty 6; full briefs: `review-lenses.md`).
- **HQ** — the skill-owning lane. The former name *Supervisor* is RETIRED
  (owner order 2026-09-11 folded the term into HQ — one role, one term);
  unofficial variants ("Author lane", "Carrier") seen in lane files are also
  retired — lens A-L3 v0.4.116.
- **Selftest** — a tool's built-in test mode (`oc-deploy --selftest` etc.);
  **battery** — `tools/tests/run.sh` across all tools. Both green before
  ANY version bump.
- **GREEN / RED** — a GitHub Actions run conclusion read by terminal truth
  (`gh run view --json conclusion`), never exit-code inference.
- **TOOL_ACCUM** — the per-session tool-usage rows accumulated in the unified
  tools log; evidence base for Telegram surface-law audits (triage.md Duty T4
  — ex hq.md Duty 7).
- **PARKED-OWNER-EYE** — non-blocking smoke row state (v0.4.152) stamped when
  the sole remaining behavioral evidence requires the human owner (visual pass,
  tap, UI inspection); frees the lane to continue or complete without blocking.
- **4-Leg Smoke Rubric** — the mandatory verification standard (v0.4.104) for
  shipping candidates: (1) Lineage (`git merge-base --is-ancestor`), (2) Identity
  (`oc-smoke-evidence` artifact checksum), (3) CI Gate (GREEN run on head sha),
  (4) Behavioral Probe (executing live binary path or structural N/A). All four
  must pass before an upstream PR leaves a lane.

## Red-run triage heuristics (shared core, v0.4.10 — moved from editor.md Phase 6)

ONE location: red-run diagnosis reads these (pre-S3: Compiler Step 2; now:
`oc-deploy` RED reports + HQ triage); the
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

## Shared environment facts (all roles)

- **Actor attribution is automatic via ambient `OPENCRABS_SESSION_ID` (v0.4.176):**
  `lib/oc-log.sh`, `oc-commit`, `oc-ledger`, and tool scripts derive `actor:` directly
  from `$OPENCRABS_SESSION_ID` (commit `978fe5fe`). Manual `export OC_ACTOR` is retired.
- Checkout `~/opencrabs`: remote **`origin`** = fork `leshchenko1979/opencrabs`
  (push target) · remote **`adolfousier`** = sync source (upstream).
- **`gh` in `~/opencrabs` defaults to UPSTREAM — `-R` is MANDATORY (2026-09-22).**
  The fork remote carries NO `gh-resolved` key while `remote.adolfousier.gh-resolved
  base` does, so gh's resolver selects upstream `adolfousier/opencrabs` for ANY command
  run from that directory without `-R` / `--repo`. It fails SILENTLY in both directions:
  a number that exists upstream returns a REAL but WRONG issue, and one that does not
  404s and reads as "no such issue" — while a write (`gh issue close` / `comment` / `edit`)
  lands on the OWNER'S UPSTREAM REPO. Measured 2026-09-22 from that cwd: unscoped
  `gh issue list --state open` → 9 (upstream), `-R leshchenko1979/opencrabs` → 144;
  `gh issue view 340` 404s unscoped and resolves scoped. Every prescribed `gh` command
  in this corpus already carries `-R` (14 sites) — this bullet states the RULE they were
  silently following. The environment fix (`gh repo set-default`) rewrites shared repo
  config and is the OWNER's call, never a lane's.
- BUILD SOURCE = fork `main`. Editors fast-forward their signed commits into
  `leshchenko1979/opencrabs@main`; `oc-deploy ship` dispatches THAT ref — every
  artifact compiles all editors' merged changes TOGETHER (decision 2026-08-25).
  Building upstream/adolfousier refs is the exception, explicit ask only.
- Branch NAMESPACES are reserved so any role can tell development from upstream
  PR heads at a glance (decision 2026-08-25): `<type>/<slug>` with type ∈
  `feat|fix|ci|chore` = DEVELOPMENT — fork-only, ff-merged into fork `main`
  (editor Phase 5 `oc-ship-chain`), archived after merge · `leshchenko1979/<slug>` = UPSTREAM PR HEADS ONLY (renamed from `up/*`, decision 2026-08-27)
  — created solely in editor Phase 7 off `adolfousier/main`, never merged into
  fork `main`, never a dispatch source. Any lane reads the prefix and knows
  what it is looking at.
- This box has **no sanctioned Rust toolchain** — CI is the only sanctioned
  compile/test executor (Compiler role RETIRED 2026-08-28). No cargo/rustc/clippy in ANY form —
  install, PATH-prepend, explicit path, even an invocation that exits 0 is a
  violation. **No local tool exists at all** — `/root/.rustup` is gone and the
  `rustfmt` wrapper was RETIRED 2026-09-19 (exits 1 `BLOCKED`), so fmt runs only
  in CI as the soft-fail leg of `pr-checks.yml`; **cosmetic diffs it reports on
  CI-green code are KEPT AS-IS, not applied — fix only formatting artifacts you
  introduced yourself**; modum RETIRED 2026-08-28; lint evidence =
  GREEN pr-checks.yml run. Full ban list: editor.md §Box law (canonical;
  "(box law)" tags elsewhere refer to it).
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
  through).
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
  branch literally named `<sha>*`). PASS THE FULL SHA ALWAYS —
  see next rule for why it is now the only auditable record of what was built.
- The workflow lives ONLY on the carrier branch `ci/quick-build-linux` (moved off
  fork `main` 2026-08-26, Alexey's call — mirrors upstream dropping it from their
  main). Dispatch pattern adds `--ref ci/quick-build-linux`. CONSEQUENCE: the run
  object's `headSha` reports the CARRIER tip, not the built tree — the built
  commit is verified via the JOB NAME, which embeds `(source_ref, features)`.
  Carrier branches NEVER merge to `main` (same reservation discipline as `leshchenko1979/*`).

## Upstream relations (v0.4.0, owner-approved 2026-08-26)

Upstream movement is WATCHED and ABSORBED on a schedule per the matrix below:

| Lifecycle Area | Owning Role | Key Tool / Procedure | Canonical Home |
|---|---|---|---|
| **1. Upstream Delta Watch** | Triage | `./tools/oc-upstream-delta` | `triage.md §Duty T4` |

| **2. Sync Model (REBASE)** | Triage | `upstream-merge-runbook.md` | `upstream-merge-runbook.md §Remotes & sync` |
| **3. Absorption & Dropping** | Triage / HQ | Auto-classify DROPPABLE patch-ids | `upstream-merge-runbook.md` |
| **4. Upstream PR Lifecycle** | Editor | Phase 7b / Phase 7c (`oc-harvest-dispatch`) | `editor-upstream-pr.md` |
| **5. Maintainer Interaction** | HQ / Alexey | Track PR comments via gh API & OC Dev chat heads-up | `editor-upstream-pr.md §Deep Core Advance Heads-Up Gate` |
| **6. Fork-local CI (`ci/*`)** | HQ | Carrier namespace `ci/quick-build-linux` | `hq.md §Upstream sync — watch & governance` |
| **7. Fork Branch Lifecycle** | Triage | `./tools/oc-branch-sweep` (archive before delete) | `triage.md §Duty T4` |

## Hard rules (all roles)

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
  battery / CI gate), roles (Editor / HQ / Reviewer lenses),
  gate colors (GREEN/RED with run receipt), phases, tool names. No ad-hoc
  synonyms for existing concepts; a NEW concept gets proposed via the poll
  format and named on owner word — never improvised mid-report. Reviewer A
  (REDUNDANCY + ONTOLOGY) enforces this lens-side.
- **Context Manifest Curation (Compaction Section 10, owner order 2026-09-17):** when context compaction occurs, the compactor MUST explicitly retain `opencrabs-dev`, `opencrabs-dev/fleet-directives.md`, and the active role file (`opencrabs-dev/editor.md`, `opencrabs-dev/hq.md`, `opencrabs-dev/triage.md`, or `opencrabs-dev/toolsmith.md`) in `active_skills`. Only non-active role files are placed in `discard_skills`. Essential tools (`session_notify`, `session_search`, `bash`, `read_file`, `telegram_send`) must stay pre-activated. Canonical: `fleet-directives.md §Post-compaction skill reload & context manifest curation`.
- ONLY HQ edits skill files — census (G7, v0.4.84; `triage.md` added v0.4.86; `toolsmith.md` added + `tools/**` carve-out v0.4.87; `README.md` + `tools/RC-CONTRACT.md` added v0.4.96, lens A15; `CHANGELOG.md` added v0.4.116, lens G-9; `tools/HEALTH-CHECKS.md` + `tools/HEALTH-CLASSES.md` added v0.4.171; `editor-upstream-pr.md` added v0.4.175): `SKILL.md` /
  `editor.md` / `editor-upstream-pr.md` / `hq.md` / `triage.md` / `toolsmith.md` / `review-lenses.md` / `fleet-directives.md` /
  `upstream-merge-runbook.md` / `war-stories.md` /
  `s2-swap-journal-spec.md` / `README.md` / `CHANGELOG.md` / `tools/RC-CONTRACT.md` / `tools/HEALTH-CHECKS.md` / `tools/HEALTH-CLASSES.md` — including all worker lanes AND the TRIAGE lane AND the TOOLSMITH lane (decision 7,
  2026-08-26; the Compiler role retired 2026-08-28). Workers propose via poll format or direct notify; they never
  write. ONE exception: `tools/**` CODE is owned by the TOOLSMITH lane (v0.4.87 carve-out) — every change ships
  with battery receipts (README.md's tool-fleet section and `tools/RC-CONTRACT.md`
count as tools/ surface — toolsmith-writable; the rest of README.md stays
HQ-only). Skill markdown + fleet-directives stay HQ-only.
- Relay only PREDICATED claims (v0.4.6, from fabrication deviation #3): any
  build/deploy/artifact claim you pass onward must carry evidence YOU verified
  same-turn — run id against the API, sha against `ls-remote`/job-name embed,
  binary against sha256. A claim verified by someone else's message is
  unverified.
- ISSUE ROUTING (owner directives 2026-08-25 → 2026-08-27; consolidated as a
  table 2026-08-29):

| Rule | Applies to | Gate |
|---|---|---|
| NEW issues NEVER upstream — every new issue (upstream-code bugs and fork-only infra alike) is filed on the FORK | `leshchenko1979/opencrabs` | owner 2026-08-27 14:08Z |
| Upstream receives PRs ONLY — body = detailed description ending `Original issue: <full fork URL>`; NEVER `Closes #N` (wrong issue space) | `adolfousier/opencrabs` PR bodies | owner 2026-08-27 |
| Fork issue closed by US right after the PR is filed | fork issue tracker | — |
| Fork issues NEVER claimed on GitHub: no tackling comments, assignment, labels/reactions by any lane — claiming = `Issue-Ref` trailer + workers-ledger `claim` row (kind `claim`, v1.1 vocabulary since v0.4.48); uniqueness sweeps stay read-only search | ledger | owner 2026-08-27 17:07Z |
| PR SHIPMENT — **PR SHIPMENT LAW (single home): feature COMPLETE + smoke PASS (v0.4.104 four-leg rubric) → Editor harvests fork-only commits, posts smoke evidence to forum topic, and files the upstream PR. All other references to this law are pointers to THIS row — procedure: `editor-upstream-pr.md` Phase 7; upstream-merge-runbook.md §Upstream-merge cadence (harvest census); triage.md T4.** | mechanical gates | standing process |
| APPROVAL = Alexey's reply or a positive Telegram reaction to the explicit request in the forum topic; silence is NOT consent; spontaneous / ad-hoc PRs remain forbidden | owner word | v0.4.1 |

*Pre-2026-08-27 upstream issues stay readable for uniqueness sweeps and legacy
links; development-time upstream contact is PR-comments only (supersedes the
2026-08-22 issues/comment rule).*
- CONSENT REGISTER — **Never rule from codified memory — grep the live record
  (chat / ledger) before denying any permission** (v0.4.17 lesson, 2026-08-26).
  Deploy consent RETIRED 2026-08-28 (owner 18:50Z): GREEN carrier run + artifact
  verify IS the authorization. Upstream-PR filing follows the PR SHIPMENT law (PR SHIPMENT row, §ISSUE ROUTING above), GATED BY THE MODE REGISTER below. APPROVAL
  definition above governs everything that is owner-gated (silence is NOT consent).
  - **MODE REGISTER — the upstream-PR filing gate is a MODE SWITCH (owner ruling 2026-09-20).** Two modes, ONE declared current, and the switch is the OWNER's alone. Owner's words: *"we basically have two modes: 1. High-trust mode, when I'm sure that the factory is working so that the quality allows autonomous harvesting. 2. Degraded, like now, when I want to gate every PR group."*

    | Dimension | HIGH-TRUST MODE | DEGRADED MODE |
    |---|---|---|
    | Condition (owner's words) | "the factory is working ... quality allows autonomous harvesting" | "I want to gate every PR group" |
    | Upstream PR filing | lane files on the 4-leg smoke PASS; filing NOTICE to its own topic | **the PR GROUP is HELD for explicit owner approval before the PR leaves the lane** |
    | Approval form | not required — SMOKE PASS is the gate | owner reply, or a positive Telegram reaction to the explicit request; **silence is NOT consent** |
    | Filing unit | one feature PR, per lane | **PR GROUP** — related PRs approved together |
    | Smoke rubric / CI gate / rollback | 4 legs / unchanged / owner's call | 4 legs / unchanged / owner's call |

    **CURRENT MODE: DEGRADED.** Resolution is LIVE, never remembered: read the newest `MODE:` row via `oc-ledger events --kind note`; **if NO `MODE:` row exists the default is DEGRADED** (fail closed — holding a filing costs nothing, an unapproved filing is a public act). The owner switches by word, receipted by `oc-ledger stamp note "MODE: <HIGH-TRUST|DEGRADED> — <provenance>" --by "hq <uuid>"`. Procedure: `editor-upstream-pr.md` §Phase 7 step 0a.
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
  editor-upstream-pr.md §Phase 7 step 2c. One red = fix cycle, not a filed
  PR ("PRs that fail CI will not be reviewed" — their words). Receipts ride
  the PR prep beside smoke evidence. Gate covers shipworthiness only;
  the SMOKE pass remains a required condition in BOTH modes, and owner approval
  is required under **DEGRADED MODE** and waived under **HIGH-TRUST MODE**
  (§CONSENT REGISTER — MODE REGISTER).
- Issue-first, no exceptions (2026-08-25): a DISCOVERED problem gets its issue
  FILED before any fix work starts — on the FORK `leshchenko1979/opencrabs`
  (ALL new issues — upstream-code bugs and fork-only infra alike; upstream
  receives PRs only). Discoverer
  files it (symptom + evidence); fixer claims via an `oc-ledger claim` row +
  an `Issue-Ref` trailer on the commit — NO `gh` comment, assignment or label
  on the fork issue (fork-issue comments are the owner's lane only,
  2026-08-27). Covers
  task starts (`editor.md` Phase 1) AND mid-loop finds: red-build bugs, failed
  smoke tests, defects in another editor's feature.
- Continuous Issue Relationship Linking (owner order 2026-09-16): whenever a parent
  subsystem relationship, blocker dependency, or child sub-issue is established or discovered
  at ANY point in the lifecycle (creation, triage intake, editor in-flight discovery, decomposition,
  or upstream PR staging), the lane identifying it MUST establish native links in the same turn
  via `gh issue edit <issue> --parent <parent-issue>` and/or `gh issue edit <issue> --add-blocked-by <blocker-issue>`.
- Restart scope: **`opencrabs-ops` ONLY.** The `family` and default-profile daemons
  require Alexey's explicit approval EVERY time. Exception (v0.4.71, lens B2 #3;
  sanctioned v0.4.59 #47): HQ may mechanically restart the
  `opencrabs-family.service` SIDECAR (journal-sequence verified) — never the
  default-profile daemon.
- Never trust watcher exit codes alone — read the run's own `conclusion` via API.
- BUILD TRIGGERS = exactly TWO, NO exceptions (v0.4.3, S3-rewired 2026-08-28; A3 owner ruling 2026-08-29): an editor's `oc-deploy ship <full-sha>` background task, or Alexey's word. No other dispatch — the direct PR-head dispatch is retired (superseded by `oc-prchecks`; ORDER gate 3 containment rejects any sha outside fork `main` anyway). All builds serialize under single-flight.

## Shared war stories (why these rules exist)

Incident histories behind the hard rules live in `war-stories.md`
(disclosed v0.4.80, lens B F6 — history is reference, not procedure; the
version-level record is CHANGELOG.md).