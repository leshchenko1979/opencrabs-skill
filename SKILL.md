---
name: opencrabs-dev
description: >
  OpenCrabs source ops (~/opencrabs): roles EDITOR (fork issues, per-task
  worktrees, CI lint gate (pr-checks), signed commits, push + sha hand-off, oc-deploy ship,
  smoke-test-on-notify, upstream PR), COMPILER (RETIRED at S3 cutover
  2026-08-28 — quick-build dispatch/swap now automated in tools/oc-deploy;
  compiler.md archived as re-enable runbook), SUPERVISOR (skill set + worker ledger).
  Use when editing/fixing OpenCrabs Rust code, debugging quick-build-linux carrier or other CI runs, fetching CI artifacts, or swapping /usr/local/bin/opencrabs.
  (/opencrabs-dev)
version: 0.4.41
author: leshchenko1979
metadata:
  tags: [opencrabs, rust, ci, quick-build, binary-swap, worktree, session-notify]
  references:
    - https://github.com/adolfousier/opencrabs (upstream — PRs only; new issues NEVER filed here, owner 2026-08-27)
    - https://github.com/leshchenko1979/opencrabs (fork — push target + ISSUES HOME, owner 2026-08-27)
  provenance:
    - "S3 cutover 2026-08-28 (owner msgid 34717: 'let's go to S3'): COMPILER role RETIRED; duties automated into tools/oc-deploy (ship/poll/swap-execute); compiler.md archived as re-enable runbook; ledger meta.oc_deploy_stage = S3, event 1282"
    - "v0.4.32: compiler retirement landing pas (this bump)"
    - "v0.4.33: post-swap editor-notify + attribution duty re-owned to SUPERVISOR (Review B finding B9; compiler retired at S3) — Phase 6b trigger, FAIL routing, session-notify loop retargeted; supervisor.md Duty 7 added"
    - "v0.4.34 (owner 2026-08-28 17:2xZ, two orders): (1) modum RETIRED from the process — lint/static-analysis evidence = GREEN pr-checks.yml only; Phase 5 rewritten CI-only; editor.md scope/box-law/inline mentions, SKILL.md, AGENTS.md synced; rustfmt wrapper stays, modum binary stays installed. (2) The v0.4.33 post-swap-notify rewiring REVERTED per owner ('revert the previous change about post swap notifications') — Phase 6b trigger, FAIL routing, SKILL.md notify loop, supervisor.md Duty 7 back to pre-0.4.33 text; the notify duty is homeless again pending a process-first re-proposal (this bump)"
    - "v0.4.35: self-review 2026-08-28-r2 fixes — stale Compiler-role anchors re-anchored to oc-deploy (editor.md/SKILL.md/supervisor.md/compiler.md); telegram law deduped; PROCESS-TOOL guard S3-rewired; versions listed"
    - "v0.4.36: KERNEL CLI batch (owner 'Go' 2026-08-28 21:16Z) — 5 new tools: oc-carrier-features, oc-issue-sweep, oc-skew-scan, oc-ping-proof, oc-watchdog-check; oc-attrib gains --deployed (range from deployed markers, fan-out compute backend for issue #24); oc-deploy ship/poll resolves EMPTY --features from carrier YAML via oc-carrier-features (loud fail, no silent fallback); unified tools.log via tools/lib/oc-log.sh (JSONL, filterable with jq); battery 64 PASS / 0 FAIL; AGENTS.md interim post-swap notify bridge RETIRED (#23 session-notify verb live in 49125f8c)"
    - "v0.4.37: issue #24 mechanical notify fan-out (owner 'Go' 2026-08-28 22:42Z, design doc oc-work/oc-deploy-fanout-issue24-20260828.md) — oc-deploy gains TWO modes: 'contributors' (thin wrapper over oc-attrib --deployed/--range, TSV session+issue+sha7) and 'fanout --run <id> [--dry-run]' (GREEN leg: notify live-swap contributor sessions via 'opencrabs session notify --profile ops'; RED leg: gh annotations -> git blame -> culprit Session-Id trailer notified as blamed + suspect cc, zero-sites fallback HUMAN-FLAGs all range sessions; dead uuids skipped verb-rc-2, unowned counted, idempotent via fanout.state, per-run JSONL journal under STATE_DIR/oc-deploy/journal/fanout-<run>-*.jsonl); auto-wired: GREEN fires at swap_execute tail after receipt seal + markers, poll gains failed-run RED scan (both OC_DEPLOY_NOFANOUT=1-suppressed, subshell-isolated); selftest 128 cases, battery 76 PASS / 0 FAIL"
    - "v0.4.38: ledger unification + process re-anchoring (owner 'Also fix' + 'Go' 2026-08-29 07:32Z) — oc-deploy + oc-order-validate LEDGER defaults now point DIRECTLY at canonical opencrabs-dev/workers-ledger.json (the old $STATE_DIR default silently kept a second ledger in the skill dir: two-file drift, baseline/orders backup paths at an empty dir, cycle counter reset 25->1; incident 2026-08-29); OC_LEDGER overrides, explicit OC_DEPLOY_STATE_DIR keeps test fixtures isolated; skill-dir duplicate + orphaned lock deleted; oc-deploy --selftest re-exec moved from bare $0 to readlink -f'd $SELF (relative invocations no longer die rc 127); stale 'supervisor bridge until #23/#24' pointers re-anchored to LIVE mechanical fan-out in editor.md/SKILL.md/supervisor.md + AGENTS.md; selftest 128 cases green in all three invocation forms, battery 76 PASS / 0 FAIL"
    - "v0.4.39: feedback-loop completion (owner 'Go' 2026-08-29 08:12Z) — Duty 4 poll-workers gains STANDING cadence (every five shipped version bumps, shared trigger with Duty 6); new Duty 7 IDEA BOX: editors push 'IDEA: ADD|CHANGE <rule/tool> in <file+section> BECAUSE <gap actually hit>' to the supervisor lane via session_notify the moment they hit a gap, supervisor stamps ledger kinds idea (arrival) + idea-verdict (ACCEPT-mechanical / KERNEL-semantic / REJECT), same-turn ack, merges with open Duty-4 proposals; Duty 6 gains Reviewer D — DELETION SAFETY (enumerate stale-looking artifacts, list readers/writers as evidence, classify DELETE-SAFE/ARCHIVE/KEEP, nothing deletes without triple-check + owner word; born from the 2026-08-29 live-ledger deletion incident), closing the dangling (A/B/C/D) parenthetical; editor.md push clause + SKILL.md role-row registration; battery 76 PASS / 0 FAIL"
    - "v0.4.40: Duty-6 four-lens verdict batch (owner 'go' 2026-08-29 10:41Z; lenses A/B/C/D = 15/17/5/24 findings, verdict 30 ACCEPT / 7 KERNEL / 0 REJECT, reports /tmp/skill-review-*-20260829.md). Mechanical: register exit codes corrected (oc-order-validate 0 VALID / 1 invocation / 2 UNMERGED / 3 UNSIGNED / 4 UNKNOWN-REF); archived compiler-step anchors stripped; fanout/notify rows retargeted to §Session-notify loop (canonical, baseline.json path inline); box-law + consent-register bullets condensed; ISSUE ROUTING consolidated as a table (B17); upstream-sync gated on owner word, compiler.md Step 7 archived (B7); STEP ZERO + scope lines drop Compiler (B13/B14); COMPILER INBOX POLICY moved to supervisor.md Duty 3 (B5); AIRBORNE→queued (A14); orphaned/staled editorial notes folded (A1 E0425 pointer, B10 pre-S3 ordering, A12 IDEA template, A8 telegram enumeration, A9 box-law ref); oc-deploy stale compiler-relay echoes → fanout/poll reality + oc-order-validate header (B2/B16). SEMANTIC: A3 owner ruling — BUILD TRIGGERS = exactly TWO, NO exceptions; Phase-7 step-2b quick-build PR-head dispatch RETIRED (carrier Gate 3 containment rejects any sha outside fork main anyway); PR-head compile+lint evidence = step-2c pr-checks dispatch. Drift fix: ledger top-level current_skill_version synced to 0.4.40 in this stamp (n=1313). Lens D executed: 8 tool snapshots + 11 md .baks + oc-work batch history archived; tools/_probe + 10 old /tmp reports + 14 oc-work scratch files deleted (zero-reader verified). Battery 76 PASS / 0 FAIL, exit 0, stderr empty (pre-bump). KERNEL queue (awaiting owner word): B4 provenance move; oc-ledger/oc-review-persist design (design doc only, no code)."
    - "v0.4.41: git-history regime (owner 'Go with your best reasoning' 2026-08-29 13:13Z on the 12:11Z analysis — scope = my best reasoning = BOTH git conversion and ledger-in-git). The skill dir AND the canonical state dir are now GIT REPOS. Skill repo (skills/opencrabs-dev/.git): synthetic history from surviving full snapshots — v0.4.31 (oc-work/archive/opencrabs-skill; a hidden .git clone inside that snapshot was excluded at import), v0.4.38 (skill-bak-20260829T0815Z), v0.4.39 (skill-bak-20260829T1050Z-v040), live v0.4.40 — tagged v0.4.31/38/39/40; gap v0.4.32–37 has no full snapshots (batch docs survive, files do not). State repo (opencrabs-dev/.git): six workers-ledger ancestors imported (n=1266/1267/1271/1284/1285/1304, mtime-dated) + full live state (baseline, orders, tools.log, journal, relics). Discipline landed in supervisor.md bump section: one commit per bump (skill repo), one commit per ledger stamp inside the same flock as the write (state repo). Ledger becomes LOSSLESS: JSON events[] is windowed to the last 100, git history keeps everything; the version-field drift class dies loudly via git log -L. Design-doc addendum (oc-ledger stamp must git add+commit inside flock; NO code yet): oc-work/oc-ledger-design-20260829.md. Off-box durability (private remote or git bundle) = follow-up on owner word. Battery: 76 PASS / 0 FAIL, exit 0, stderr empty (pre-bump, solo run)."
---

# opencrabs-dev — OpenCrabs source procedure

**Owns:** everything touching `~/opencrabs` source, its GitHub Actions runs, or the
installed `opencrabs` binary. This file = shared facts + role router only. Actual
procedures live in TWO role files (`editor.md` / `supervisor.md`) + one
ARCHIVED runbook (`compiler.md` — retired at S3 cutover 2026-08-28, re-enable
= one notify);
load ONLY the one matching the session's role.

## Canonical tooling (v0.4.12, PROCESS-TOOL ownership)

Mechanical rituals the roles once hand-ran are now single commands in `tools/`
(owner-aware: CLI-tool creation/fix is the Supervisor's scope). Canonical
commands run INSIDE `oc-deploy` (ship/poll/swap-execute); this section is the
register + test source of truth (archived compiler-step anchors stripped
2026-08-29 — `compiler.md` carries the old numbering for re-enable context):

| Tool | Slot | Exit-coded |
|---|---|---|
| `./tools/oc-order-validate <sha>` | ORDER gates inside `oc-deploy ship` | 0 VALID / 1 invocation / 2 UNMERGED / 3 UNSIGNED / 4 UNKNOWN-REF |
| `./tools/oc-job-verify <run-id> <source-ref> [--features]` | run identity inside `oc-deploy ship/poll` | 0 VERIFIED / 2 IN-FLIGHT / 3 FAILED / 4 REF-MISMATCH / 5 NOT-FOUND |
| `./tools/oc-artifact-verify <run-id> <bin> <marker>` | EXECUTION SANITY SIGNAL + FEATURE-PRESENCE CHECK inside `oc-deploy` swap path | 0 ok / 3 marker-missing(no swap) / 4 fail |
| `./tools/oc-seal-state <sha> [...]` | baseline/orders seal inside `oc-deploy` swap path; order vocabulary QUEUED…VOID, per-row `--order-evidence`, `--purge-order`; matches legacy `order_sha` rows | 0 ok / 1 invocation / 2 scan-fail / 3 write-fail |
| `./tools/oc-post-receipts ...` | Phase A/B receipts inside `oc-deploy` swap path | 0 ok / 1 no-token / 2 send-failed / 3 bad-args |
| `./tools/oc-index-worktree <path>` | worktree codegraph index (editor Phase 2) | 0 ok / 4 index-failed / 5 bad-input |
| `./tools/oc-ci-parity` | workflows parity fork↔upstream post-merge (live: editor Phase 7 parity) | 0 identical / 4 DRIFT / 5 usage / 6 api |
| `./tools/oc-contributors --repo <path> --range <A..B>` | Session-Id trailer extraction + contributor dedup over a commit range (post-swap fan-out targeting — [#24](https://github.com/leshchenko1979/opencrabs/issues/24) LIVE via `oc-deploy fanout` since v0.4.37; Duty reviews) | 0 ok / 2 usage / 3 git-fail / 4 empty-range |
| `./tools/oc-attrib --repo <path> (--range <A..B> or --deployed) [--ledger <f>]` | commit-range → worker-lane attribution via Session-Id join against roster (`(unsigned)`/`(unmapped)` rows never dropped); `--deployed` composes the range from `deployed.sha` + `deployed.meta.json` `prev_sha` (fan-out compute backend for [issue #24](https://github.com/leshchenko1979/opencrabs/issues/24)) | 0 ok / 2 usage / 3 git-fail / 4 empty-range / 5 marker-missing |
| `./tools/oc-deploy <mode>` | the ship path itself — `ship` (fetch/push + 4 ORDER gates + carrier dispatch), `poll` (watch + RED scan + swap chain), `swap-execute` (Phase B swap), `watch` (stray-commit tripwire), `contributors`/`fanout` (rows below); the editor's S3 ship path: `editor.md` §Phase 6 | 2 usage / per-mode rc — see the mode rows |
| `./tools/oc-deploy contributors (<old>..<new> or --deployed) [--repo <path>]` | [issue #24](https://github.com/leshchenko1979/opencrabs/issues/24): thin wrapper over `oc-attrib` printing 3-col TSV `session-uuid \t issue_refs \t sha7s` for a range (or the deployed range) — the human-readable fan-out target list | 0 ok / 1 usage or range-shape / attrib rc passthrough |
| `./tools/oc-deploy fanout --run <id> [--dry-run]` | mechanical notify fan-out for one carrier run ([#24](https://github.com/leshchenko1979/opencrabs/issues/24) LIVE since v0.4.37): GREEN → contributor notify, RED → blame notify; auto-fired at `swap_execute` tail + on `poll` RED-scan; `OC_DEPLOY_NOFANOUT=1` suppresses — mechanics + journal vocabulary in §Session-notify loop | 0 done-or-noop / 2 usage / 3 gh-or-attrib-fail / 4 run-not-terminal |
| `./tools/oc-carrier-features [--fetch] [--repo <path>] [--ref <branch>]` | reads the `workflow_dispatch` `features` default from `.github/workflows/quick-build-linux.yml` at `origin/<ref>` (default `ci/quick-build-linux`); `oc-deploy ship/poll` resolves EMPTY `--features` through this — carrier read failure aborts the ship loudly, no silent fallback | 0 set-printed / 2 usage / 3 yml-unfetchable / 4 no-or-invalid-features-input |
| `./tools/oc-issue-sweep '<query>' [--fork R] [--upstream R] [--limit N]` | closed-issue hygiene sweep: fork open + fork closed + upstream closed, harvests `close-reason:` lines from comments (falls back to state_reason); pure TSV, no header, deduped by repo#num (supervisor duty) | 0 no-candidates / 1 candidates-listed / 2 usage / 3 api-failure |
| `./tools/oc-skew-scan [--ledger f] [--current v]` | ledger worker-version skew vs current skill version (default: frontmatter `version:`); buckets CHASE (>3 behind) / GRACE (>1) / OK, `-` marks a missing ack field; summary line to stderr (supervisor roster review) | 0 clean / 1 skew / 2 usage / 3 parse-failure |
| `./tools/oc-ping-proof <uuid> <ping-ts> [--ledger f]` | post-swap notify proof: WOKEN / SILENT / UNREACHABLE verdict from ledger `last_acked` + `events[]` stamps (`last_notified` excluded by design — broadcast, not worker activity); evidence stamp to stderr; accepts ISO and bare `HH:MMZ` stamps | 0 WOKEN / 1 SILENT / 2 usage / 3 UNREACHABLE / 4 parse-failure |
| `./tools/oc-watchdog-check [watch]` | thin cron-friendly alias over `oc-deploy watch`: accepts optional leading `watch`, strips no-op `--baseline`, passes verdict + rc through | passthrough: 0 WATCH-CLEAN / 2 WATCH-ALERT |
| `./tools/oc-consent-check` | **RETIRED 2026-08-28 18:50Z** (owner order: deploy consent ELIMINATED — GREEN carrier run + artifact verify IS the authorization). Archived at `tools/archive/oc-consent-check`, audit history only; ledger `consents[]` rows kept as record. Upstream-PR owner-word gate unaffected. | — |
| `./tools/oc-pr-atomicity <pr-number>` | atomicity gate (editor Phase 7 / issue triage) | 0 ok / 2 atomicity-violation / 4 api |
| `gh workflow run pr-checks.yml --ref ci/quick-build-linux -f ref=<branch-or-sha>` | PR-lane gates before an upstream PR (v0.4.28): fmt soft-fail + clippy `-D warnings` + all-features test, flags verbatim from upstream ci.yml; yml lives only on the carrier branch; green run URL = v0.4.22 PR-body citation (editor.md Phase 7 2c) | CI run green/red — dispatch via `gh workflow run`, watch with `gh run watch` |

Tests: `tools/tests/run.sh` — one command, exit 0 only if all pass (incl. the
`oc-seal-state` IFS-join regression guard). Must stay green before any version
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

> **Editor or Supervisor?** (Compiler: archived — say "re-enable compiler" to load `compiler.md`.)

| Role | Owns | Procedure file |
|------|------|----------------|
| **EDITOR** | Commits + error fixes: claim issue → worktree → code → CI gate → sign → push → ff-merge into fork `main` → `oc-deploy ship` → smoke on notify; feature COMPLETE + owner-approved → upstream PR (`editor.md` Phase 7) | `editor.md` |
| **COMPILER** | **RETIRED 2026-08-28 (S3 cutover, owner "let's go to S3" msgid 34717)** — duties now `tools/oc-deploy` (ship/poll/swap-execute) + supervisor watch. Re-enable = one notify per archived runbook | `compiler.md` (ARCHIVED runbook) |
| **SUPERVISOR** | Owning the skill itself: apply owner directives + validated editor proposals, keep the worker-version ledger, publish versions to shared disk (v0.4.19: workers absorb at their own boundaries; targeted pings only), poll workers for input (Duty 4 — STANDING, every five bumps), triage the idea box (Duty 7 — workers push `IDEA:` notifies; ledger kinds `idea` / `idea-verdict`), 4-lens skill review (Duty 6, incl. Reviewer D deletion safety) | `supervisor.md` |

Roles **DO NOT intersect**:

- The Editor NEVER installs/swaps binaries, NEVER restarts daemons, NEVER dispatches
  BUILD runs — shipping goes through `oc-deploy ship` (S3). BUILD TRIGGERS = exactly
  TWO with NO exceptions (§Hard rules, A3 ruling 2026-08-29); the Phase-7 PR-head
  gate is the step-2c pr-checks dispatch — a lint/test gate, not a build trigger.
- (Archived role, pre-S3) The Compiler NEVER wrote, committed, or fixed code, NEVER
  touched editor feature branches or worktrees — two sanctioned touches, both
  bounded in their own steps: the Step 6 integration sweep over fork `main` AND
  Step 7 rebase-port fixups (`compiler.md` Steps 6 + 7).
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
  trailers (`oc-attrib` / `oc-contributors`).
- After a healthy swap the fan-out extracts contributors over
  `<prev-swapped-sha>..<verified-run-headSha>` (right edge = the run's VERIFIED
  headSha, never "current main" — a merge landing mid-build leaves main ahead of
  the binary), notifies each contributing editor's session
  about the new binary, then records `{sha, run_id, contributors}` to the
  baseline state file (`oc-seal-state`; canonical:
  `/root/.opencrabs/profiles/ops/opencrabs-dev/baseline.json`) — its `sha` is
  the left edge of the next attribution range. LIVE since v0.4.37: `oc-deploy
  fanout --run <id>` ([#24](https://github.com/leshchenko1979/opencrabs/issues/24),
  on top of the [#23](https://github.com/leshchenko1979/opencrabs/issues/23)
  session-notify verb `49125f8c`). GREEN leg: git-range → trailers →
  `opencrabs session notify --profile ops`, dead uuid = journal `skip` + note;
  auto-fired at the `swap_execute` tail, idempotent via `fanout.state`;
  `--dry-run` journals but never notifies or marks done. RED leg (`poll` scans
  the latest FAILED run): gh annotations → `git blame` → culprit `Session-Id`
  trailer notified (`role=blamed`), suspect cc on same-file later touchers,
  zero-sites fallback HUMAN-FLAGs all range sessions. Both legs suppressed by
  `OC_DEPLOY_NOFANOUT=1` (drills), subshell-isolated. Journal:
  `STATE_DIR/oc-deploy/journal/fanout-<run>-*.jsonl`, steps `fanout-start /
  contributors / attributed / notified / skip / unowned / fanout-end`.
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
- DELIVERY ≠ QUEUE ACCEPTANCE (2026-08-26, Alexey): a ping counts as delivered
  ONLY with post-ping proof — same-turn live roster check (`session_search`),
  target PINGED-WOKEN (`last_active` > ping time) or PINGED-SILENT. Ledger
  entries saying "pinged" without wake evidence are forbidden (both roles).
- Sender identity is mechanical — deliveries arrive prefixed
  `[session-notify from=<uuid>]`; replies route back with `target_session = from`.
  Neither role can forge or strip identity.
- Delivery drains at the target's next tool-loop boundary and wakes idle
  sessions — no polling anywhere.

### Telegram surface law (v0.4.31, owner directive 2026-08-28)

Inter-role communication is **session_notify ONLY**. No lane ever uses telegram
send/edit tools to talk to another session, another role's topic, the forum
General area, an unrelated chat, or the owner DM. *(2026-08-28 audit: ~1.3k
telegram_send calls/day traced across lanes — every destination belonged to the
sender's own surface, but tool-driven sends that escape the own topic read as
board-wide broadcast and duplicate the session's auto-routed text.)*

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
| Where | live `opencrabs-ops` unit, its real surfaces (Telegram, cron, MCP) | GitHub Actions ONLY — carrier compile pre-flight, upstream Lint/Test checks (fork `ci.yml` removed 2026-08-26) | this box, against the DOWNLOADED artifact + its source tree — nothing running |
| When | after a swap notify (`editor.md` Phase 6b) | pre-flight gate before PRs (Phase 7 step 2c); every CI run | pre-swap, every cycle (`oc-deploy` swap path) |
| Who | owning Editor | Editor dispatches the gate and reads conclusions; `oc-deploy` reads build conclusions | `oc-deploy` swap path (pre-S3: Compiler alone) |
| Toolchain | none — local cargo FORBIDDEN in any form (binaries disabled 2026-08-28; editor.md §Box law) | CI's own — never local | `strings`, `sha256sum`, `git grep` — none compile anything |
| Evidence | one line: drove X, observed Y (+ run id / sha) | job/step conclusions read via API | marker found/not-found + checksum line in baseline.json |
| On FAIL | issue FIRST, then evidence to the supervisor lane (`session_notify`) | fix before merge / PR | NO swap — feature missing from build; regression stated plainly |

The table above carries the content; what remains prose:

- **SMOKE TEST** is the ONLY evidence that may back an upstream PR approval
  request (hard rule + `editor.md` Phase 7 step 0).
- **EXECUTION SANITY SIGNAL** — the swap-path `--version` run (`oc-deploy` swap
  path; archived anchor: `compiler.md` Step 3) — is NONE of the three kinds: it proves only "this file is a
  runnable opencrabs binary". Not behavioral, not analytical, not presence
  evidence; never cite it as any kind of test result.

Rule: never write "tests pass" without naming the kind. A green Lint run is NOT
a smoke pass; a smoke pass says nothing about clippy; a presence hit says
nothing about behavior.

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
  that ARRIVE — the receiver checks. *(2026-08-26 cycle-18: run 32999957533
  concluded `failure` at 18:36:56Z while a Compiler ACK still called it
  in_progress/queued)*

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
- This box has **no sanctioned Rust toolchain** — CI is the compiler (ruling
  2026-06-16, hardened owner-GO 2026-08-28). No cargo/rustc/clippy in ANY form —
  install, PATH-prepend, explicit path, even an invocation that exits 0 is a
  violation. Sanctioned local: `/usr/local/bin/rustfmt` wrapper (fmt only); modum
  RETIRED 2026-08-28; lint evidence = GREEN pr-checks.yml run. Full ban list:
  editor.md §Box law.
- Live binary: `/usr/local/bin/opencrabs`. Daemons run as systemd **user** units
  (`systemctl --user`) — system-scope queries (`systemctl`, `/etc/systemd`) find nothing.
- Daemon PID identity (v0.4.15): NEVER `pgrep | head -1` — three daemons share
  this box (family, default, ops) and pgrep can grab the wrong one. The ops unit's
  PID comes only from `systemctl --user show opencrabs-ops -p MainPID --value`
  *(2026-08-26 cycle-18: pgrep caught the old family daemon 1545179, Aug-25 boot,
  vs the ops unit 1779537 — disk-vs-proc split until MainPID settled it)*.
- Builds are MINIMAL-FEATURE by design: `cargo build --locked --profile ci
  --no-default-features --features "<set>"` *(profile ci = thin LTO /
codegen-units=16 — carrier yml since fork 8994be14)*. Upstream #1186 (missing #[cfg]
  gates) CLOSED 2026-08-25 — feature subsets compile clean.
- The feature set is PARAMETRIZED (`ebf44f69`, 2026-08-25): a workflow_dispatch
  input `features` (comma-separated). Its **`default:` in the workflow yml on the
  CARRIER branch `ci/quick-build-linux` is the SINGLE SOURCE OF TRUTH** for what we
  ship — these skill files NEVER copy the set (drift killed 2026-08-25). Read it live:
  `git -C ~/opencrabs show origin/ci/quick-build-linux:.github/workflows/quick-build-linux.yml | grep -A2 'features:'`
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
  of the SAME sha is a DISTINCT build, serialized by the single-flight invariant
  *(2026-08-26: cycle-19 vs cycle-19b, both ordered on sha 2217191c)*.
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

1. **Watch = supervisor duty (`oc-deploy` watch), every build cycle**
   (archived anchor: Step 1 pre-flight): fetch
   `adolfousier`, compare upstream tip vs fork merge-base. Small clean delta →
   PROPOSE the sync (owner word gates it — see item 2); mass absorption
   (maintainer took our features) or conflicts beyond trivial → notify Alexey
   with the delta and WAIT.
2. **Sync model = REBASE-PORT** (merge-sync retired 2026-08-26): backup ref
   FIRST → classify fork-only commits (absorbed / superseded / survivor) →
   port survivors chronologically onto `adolfousier/main` → pr-checks green
   (zero errors in ported lines) →
   force-push-with-lease. The old procedure home (`compiler.md` Step 7) is
   ARCHIVED — until the port procedure is re-homed as a supervisor duty, the
   sync runs ONLY on owner word.
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
5. **Maintainer behavior (facts, owner briefed 2026-08-26)**: Adolfo AUTO-ASSIGNS
   new upstream issues to himself — that is a CI workflow, NOT intent to work on
   them; an assignee is not a worker. He may also CLOSE our upstream PRs (and any
   legacy upstream issues) — the reason is ALWAYS in the comments. Our NEW issues
   live on the fork (item routing, owner 2026-08-27) where WE are the assigner. An issue/PR that looks "missing" is almost
   always CLOSED: find it among closed ones and read the comments BEFORE
   concluding anything. CLI comment output PAGINATES — later pages may hold the
   decisive comment (`gh api ... --paginate` / `--page N`); never conclude from
   the first page alone.
6. **Fork-local CI = carrier namespace (`ci/*`, v0.4.16)**: local-only workflow
   files live ONLY on `ci/*` branches (workflow_dispatch-shaped), NEVER on fork
   `main` — anything under `.github/workflows/` on main rides the next PR diff
   toward upstream. Dispatch locally via `gh workflow run --ref ci/<name>`.
   After every upstream merge/port verify parity mechanically:
   `./tools/oc-ci-parity` (exit 0 identical / 4 DRIFT listing / 6 api-fail) +
   carrier proof-dispatch (archived: compiler.md Step 7). *(owner order 2026-08-26)* **(c) DRIFT PERMANENT — owner ruling via "Fix all" 2026-08-27:** fork `ci.yml` stays REMOVED (zombie-run risk, order cc100dc6); the carrier branch is the sole build lane; an oc-ci-parity `exit 4` naming `.github/workflows/ci.yml` is ACCEPTED output forever, never repaired by restoring the file.
7. **Fork branch lifecycle (v0.4.24, owner "clean" sweep 2026-08-27)**: the fork carries
   PERMANENT refs only — `main` (sync mirror; pre-S3: compiler rebase-port), `ci/quick-build-linux`
   (carrier), `backup/pre-port-*` (until the port cycle settles) — plus short-lived
   `leshchenko1979/<slug>` work branches. A work branch dies when its PR merges or the task
   dies, and ONLY after its landing is PROVEN by one of: tip sha-reachable from upstream or
   fork `main` · tip contained in `backup/pre-port-*` · exact mirror of a live upstream
   branch · a MERGED PR (either repo) whose head is the branch. Deletion without proof is
   forbidden — unproven branches stay and get reported to the owner. Every sweep archives
   BEFORE deleting: tip tags `archive/<date>/<branch>`, an `--all` bundle, and a manifest,
   so any deletion is reversible in one command. Sweep 2026-08-27: fork remote 92→13 heads,
   53 local counterparts (both with full tag archives); branch heads riding OPEN PRs are
   never deletable.


## Hard rules (both roles)

- Reports to Alexey (owner directive 2026-08-26): every issue/PR reference
  carries the LINK behind the number (issues: `https://github.com/leshchenko1979/opencrabs/issues/N`
  — the fork is the issues home; PRs: `https://github.com/adolfousier/opencrabs/pull/N`) — a bare `#N` is never enough; identify workers by TOPIC NAME
  (Mermaid, Push to session, …), never by session UUID. Applies to every role's
  reports, Supervisor's included.
- ONLY the Supervisor edits skill files (`SKILL.md` / `editor.md` /
  `compiler.md` / `supervisor.md`) — including all worker lanes (decision 7,
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
| Fork issues NEVER claimed on GitHub: no tackling comments, assignment, labels/reactions by any lane — claiming = `Issue-Ref` trailer + workers-ledger row; uniqueness sweeps stay read-only search | ledger | owner 2026-08-27 17:07Z |
| PR SHIPMENT gates on owner approval: feature COMPLETE + smoke evidence OWNER-APPROVED → Editor harvests fork-only commits, opens the upstream PR (procedure: `editor.md` Phase 7) | owner word | 2026-08-25 directive |
| APPROVAL = Alexey's reply or a positive Telegram reaction to the explicit request in the forum topic; silence is NOT consent; spontaneous / ad-hoc PRs remain forbidden | owner word | v0.4.1 |

*Pre-2026-08-27 upstream issues stay readable for uniqueness sweeps and legacy
links; development-time upstream contact is PR-comments only (supersedes the
2026-08-22 issues/comment rule).*
- CONSENT REGISTER — **Never rule from codified memory — grep the live record
  (chat / ledger) before denying any permission** (v0.4.17 lesson, 2026-08-26).
  Deploy consent RETIRED 2026-08-28 (owner 18:50Z): GREEN carrier run + artifact
  verify IS the authorization; `oc-consent-check` archived at `tools/archive/`;
  ledger `consents[]` historical only. Upstream-PR owner-word gate UNTOUCHED:
  silence is NOT consent; ad-hoc PRs forbidden.
- ROLE-SCOPED BROADCASTS: messages reach non-owning roles ONLY when tagged
  [ALL]; otherwise send strictly to the owning role. CC-everyone is noise.
- ONE formal SMOKE verdict per editor-feature lane: exactly one PASS/FAIL;
  duplicate confirmations are noise (#1227 lane double-report, 2026-08-26).
- SMOKE-EVIDENCE PRECEDENCE (v0.4.18, owner directive 2026-08-27): prefer
  smoke tests verifiable from LOGS over those requiring human verification.
  A machine-checkable verdict — CI run conclusion via API, parsed build/test
  logs, captured runtime or endpoint output — outranks "a human said it
  passed"; request human confirmation ONLY where logs genuinely cannot cover
  the claim (visual rendering, interactive UX), and then name EXACTLY what to
  observe. Design smoke captures to be self-sufficient: every claim cites run
  id + sha + step evidence, so any verdict is re-derivable from logs alone. Source-precedence ranks EVIDENCE quality only - it never conflates kinds: a green CI/build log stays CODE-TEST/build evidence and substitutes nothing for a behavioral SMOKE pass.
- UPSTREAM CI GATE (v0.4.22, owner directive 2026-08-27; encodes
  adolfousier/opencrabs CONTRIBUTING.md): NO upstream PR leaves a lane until
  the owning worktree passed the exact CI triad with captured exit codes:
  - `cargo fmt --all -- --check`
  - `cargo clippy --lib --bins --tests --all-features -- -D warnings`
  - `cargo test --all-features --verbose`
  All three rc=0 BEFORE `gh pr create`; one red = fix cycle, not a filed
  PR ("PRs that fail CI will not be reviewed" — their words). Receipts ride
  the PR prep beside smoke evidence. Gate covers shipworthiness only;
  owner approval + SMOKE pass remain separate required conditions.
- Issue-first, no exceptions (2026-08-25): a DISCOVERED problem gets its issue
  FILED before any fix work starts — on the FORK `leshchenko1979/opencrabs`
  (owner directive 2026-08-27: ALL new issues, upstream-code bugs and fork-only
  infra alike; upstream receives PRs only). Discoverer
  files it (symptom + evidence); fixer claims via `Tackling` comment. Covers
  task starts (`editor.md` Phase 1) AND mid-loop finds: red-build bugs, failed
  smoke tests, defects in another editor's feature.
- Restart scope: **`opencrabs-ops` ONLY.** The `family` and default-profile daemons
  require Alexey's explicit approval EVERY time.
- Never trust watcher exit codes alone — read the run's own `conclusion` via API.
- BUILD TRIGGERS = exactly TWO, NO exceptions (v0.4.3, S3-rewired 2026-08-28;
  A3 owner ruling 2026-08-29): an editor's `oc-deploy ship <full-sha>`
  background task, or Alexey's word. No other dispatch — the Phase-7 step-2b
  quick-build PR-head dispatch is RETIRED (superseded by the step-2c pr-checks
  gate; carrier Gate 3 containment rejects any sha outside fork `main` anyway).
  Stray unordered commits get reported by the ~2 h watchdog (`oc-deploy` watch),
  never built autonomously. A SECOND dispatch of the same sha+set is NEVER
  created — `oc-deploy ship` serializes (single-flight). SINGLE FLIGHT enforced
  twice: `oc-deploy`'s dispatch invariant + the carrier-yml concurrency group
  (commit `1ae46000`).

## Shared war stories (why these rules exist)

| Rule | Incident |
|------|----------|
| Inputs from branch YAML, verify headSha | run #4 dispatched blind; run #2 built main |
| Distrust watcher exit codes | watchers reported success on failed runs, 3× |
| Foreign-WIP diff vs merge-base | branch carried another agent's dropped WIP |
| User-unit awareness | system-scope queries found nothing; wrong restart path nearly used |
| Inner-match exhaustiveness | E0004 cost one full CI cycle (run #5 fixed it) |
| Build fork `main`, record headSha at dispatch | 2026-08-25: swapped a binary built from pre-merge `ebf44f69` while the session-notify merge (`10c73644`) landed on fork main mid-build — feature absent from the running bot |
| `source_ref` = FULL 40-char sha, never short | run #32882515561: short sha → checkout fetched a branch literally named `<sha>*`, dead in 51 s |
| Conflict-quality gate before push | run #32879949542: a hand-merge shipped E0308 red CI (full prose: `editor.md` Phase 6) |
| Rebase-port, never resurrect duplicates | 2026-08-26: maintainer absorbed 4 of our PRs overnight (#1207/#1208/#1214/flood-governors); a literal 40-commit rebase would have replayed duplicate implementations against his reviewed rework — classification dropped 20+, ported 9 |
| ORDER-era triggers + bounded ROLE_EXCEPTION | 2026-08-26 07:20 UTC: compiler authored the governor.rs E0308 fix while its author (61161247) slept through the owner's night window — a silent role breach. Now builds fire only via `oc-deploy ship` or owner word (sim-validated — sim = ORDER/queue simulation, paired-seed 600 reps, run 2026-08-26), and the breach is legal only as the bounded ROLE_EXCEPTION (archived: `compiler.md` Step 2) |
| Two-file ledger drift | 2026-08-29: `oc-deploy` default LEDGER hit a skill-dir copy while supervisor stamped canonical; the "stale duplicate" deletion proved LIVE (fresh swap stamp + fan-out reads) — restored in 6 min, zero data lost. Fix A (v0.4.38) points every tool at canonical; Reviewer D born from this |

*Source of truth for procedure = these skill files. AGENTS.md carries only the pointer.*