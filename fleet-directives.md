# Fleet directives — opencrabs-dev owner rulings

**Owns:** binding owner directives for opencrabs-dev work (sync policy, upstream PR law, builds/carriers, cargo prohibition, telegram surface law, tool logging, gates, editors, triage, cadence). Re-homed here from ops AGENTS.md/MEMORY.md per owner order 2026-09-02. Where a ruling's full text already lives canonically in another skill file, this file carries only a pointer — one concept, one home.

<!-- source: AGENTS block1 (remotes/upstream/source-work/impl-comment) -->
**~/opencrabs remotes** (renamed 2026-08-24, was inverted): `origin` = fork `leshchenko1979/opencrabs` (push target) · `adolfousier` = upstream source — **sync policy (owner 2026-09-02 "Land it"): fork main MERGES `adolfousier/main` when upstream shifts.** Merge, never rebase/reset, on fork main (preserves history + deployed-sha containment for oc-deploy rollback). Guards: (1) **merged ≠ deployed** — a merge lands in git and must pass fork CI (pr-checks) GREEN; the prod binary swap stays a separate, explicit act; (2) **FREEZE** while any carrier chain is between dispatch and swap (query the ledger for open claim/ship events before merging); (3) **detection** = cron `upstream-shift-watch` (`ls-remote adolfousier main` every 4h, reports shifts to the owner DM; detect+report only, merge is owner-gated). "Rebase-port" remains the technique for PR chains only; non-interactive `git merge --ff-only` of upstream into the diverged fork stays forbidden (history diverged by design 2026-08-26); historical: REBASE-PORT procedure (supervisor.md §Upstream sync — re-homed v0.4.80, lens B F3; the compiler role is RETIRED 2026-08-28 — this line updated per Duty-6 lens B, 2026-08-31). Builds fire ONLY via `oc-deploy` (S3 2026-08-28 — compiler role RETIRED; the editor invokes `oc-deploy ship` per editor.md; the ORDER-to-Compiler notify path is deleted) — **direct `gh workflow run quick-build-linux.yml` calls from any editor are FORBIDDEN** (rogue-dispatch rulings 2026-08-26/27; first offense logged vs this lane 01:55Z). The workflow lives ONLY on carrier branch `ci/quick-build-linux`, never on fork main (moved off 2026-08-26); the dispatch `ref` input must be the FULL 40-char sha — carrier Gate 1 SHAPE (3349cf7e, 2026-08-27) rejects branch names and short form. Carrier runs ORDER gates (shape/existence/containment/signature — pure git verification; the cargo test leg REMOVED 2026-08-31 owner word "removing looks good", commit e71dba58 — all-features testing lives on the PR gate, residual risk: straight-to-main hotfix shas ship un-tested) before the build job (`needs: gates`); containment requires the sha already on fork main, so ship path = FF-push main, then dispatch via `tools/oc-deploy` (**S3 LIVE 2026-08-28** — compiler role retired; `swap-execute` mode: sha-bound, AUTO-SWAP on GREEN build (deploy consent ELIMINATED owner 2026-08-28 18:50Z), rollback-drilled, full journal/markers/ledger receipts; pilots 87d3bcb8 11:33Z / 2d643146 12:57Z / 6643cf3c 14:32Z, events 1269/1275/1281. Ledger canonical path = `opencrabs-dev/workers-ledger.json` — since v0.4.38 (2026-08-29) `oc-deploy` + `oc-order-validate` default to it DIRECTLY; `OC_LEDGER` overrides, an explicit `OC_DEPLOY_STATE_DIR` keeps test fixtures isolated; the skill-dir duplicate is DELETED).

**Upstream PR law** (owner 2026-08-27, tightened 2026-08-26) — canonical text: SKILL.md §Upstream relations + §Hard rules rows ("Upstream receives PRs ONLY", "PR SHIPMENT gates on owner approval", "APPROVAL = Alexey's reply or a positive Telegram reaction"). Core: PRs-only upstream, never `Closes #N`, fork-issue link at body end, smoke-PASSED owner word BEFORE PR creation, silence ≠ consent, no ad-hoc PRs, branch namespace `leshchenko1979/<slug>` (SKILL.md §Upstream relations item 7). **Kept here (unique) — #1255 exception (owner 2026-08-28 13:59Z):** the compaction-stall / gateway-timeout class is owner-sanctioned for direct upstream REPORTING — adolfo is actively working that area (#1247, fix `a0954b63` on `fix/session-routing-and-fallback-chain`); field report filed as adolfousier/opencrabs#1255 (ledger 1280); follow-ups on that thread may continue upstream. Nightly cron pulls repo only — never pushes brain changes.

**OpenCrabs source work** (`~/opencrabs`): any code edit, CI build, or binary swap follows the **`/opencrabs-dev`** skill (`skills/opencrabs-dev/SKILL.md`) — fresh-base fetch, fork issue claim via `Issue-Ref` trailer + `oc-ledger claim` row (NO tackling comments on fork issues — owner ban 2026-08-27), per-task worktree, CI lint gate (pr-checks), CI-only evidence gates, sha-verified run, backup + atomic swap, ops-only user-unit restart. Upstream stays PRs-only; this section is just the pointer (procedure canonical in the skill).

**Implementation comment per commit (owner 2026-08-28 22:54Z)** — canonical procedure: editor.md Phase 6 (§Implementation comment per commit); tooling: `oc-commit` folds it in via `oc-issue-log` (SKILL.md §Canonical tooling). Rule: one comment per editor commit, immediately — no batching at the end.


<!-- source: AGENTS block2 (build lane/cargo/surface/logging/gates/editors/cadence) -->
**Build lane directive (owner, 2026-08-27):** prod ORDER builds must carry the FULL feature set — reduced staging subsets are retired; a binary that drops functionality will not be accepted for swap. **AMENDED same day (owner, mermaid lane):** `local-mermaid` is REMOVED FROM THE TREE (owner 2026-08-27, "cleanup sooner, no local mermaid"): render.rs, the feature, cfg gates, `local_fallback` and its test deleted in `346bf3c2`; delivery is remote-only mermaid.ink (natural-size → 1200px width clamp ladder) via `attach://` bytes. Prod ORDER feature set is now `telegram` ONLY (owner 2026-08-27, ~20:07Z: "the only feature you need is telegram now") — supersedes the full-set requirement above for this box; other channels/STT/TTS/browser remain in-tree but are not built into the prod binary. Four optional raster dep declarations linger in Cargo.toml (PENDING REMOVAL marker) — carrier builds `--locked`, lock regen is Compiler-owned (role retired S3 2026-08-28; lock changes ride editor commits, regen verified by CI); they compile to nothing.


**Cargo prohibition (owner, 2026-08-28)** — canonical full law: editor.md §Box law — no local cargo, ever (PATH / login-shell / PATH-prepend / explicit-path bypasses, disabled rustup tree, rustfmt wrapper only, lint evidence = GREEN pr-checks run). Fleet-directives carries no extra text.

## Telegram surface law (owner 2026-08-28, skill v0.4.31)

Canonical full law: SKILL.md §Telegram surface law (v0.4.31). Editor-facing duties: editor.md §Telegram surface law. session_notify is the ONLY inter-role channel; no editor invokes telegram send/edit tools. Fleet-directives carries no extra text — do not restate the law here.

## Tool logging rule (owner 2026-08-28)

Every tool/script we build must be debuggable from its logs alone. Each state-changing step writes a timestamped, append-only journal line (input, action, outcome, exit code) to durable storage BEFORE the next step begins — the journal, not memory, is the record. If a crash or restart can leave a run unreconstructable from durable state (journal line + marker file + ledger event), the tool is NOT DONE. Born from the 03:11Z 71e58ce5 swap: the swap succeeded but left zero receipts because the oc-deploy journal vocabulary stops at `dispatch` (no `swap` line type) and the deployed.sha marker was never written — HQ had to reconstruct the audit trail from binary mtimes and artifact shas. Applies to oc-deploy and every future tool; gap list: swap-leg journal lines + marker write land with S2 wiring.

## Discussion links + fix-approval gate (owner 2026-08-28 14:28Z)

1. **Whenever a PR or issue is discussed, a link must be given.** Every mention of a PR or issue number — chat, reports, ledger entries, rulings — carries the full URL (or an owner/repo#N reference that resolves to one). No bare numbers: a number without a link is an unfinished sentence. If a reference cannot be resolved to a link, say so explicitly.
2. **Before implementing a fix, a solution with a diagram must be approved by the user.** Present the proposed solution WITH a diagram (Mermaid, vertical) in the topic and wait for explicit approval before any code is written. Implementing without an approved solution+diagram is a gate violation, no matter how small the fix.
3. **Multi-actor processes get a sequence diagram (owner 2026-08-28 17:55Z).** Whenever the process under discussion involves SEVERAL ACTORS (roles, tools, external services, humans), the required diagram is a Mermaid `sequenceDiagram` — one participant per actor, messages as labeled arrows. A flowchart is acceptable only when the flow is genuinely single-track.
4. **Bare `#N` with fork issue numbers is forbidden on any upstream surface (owner 2026-08-31, skill v0.4.67, fork [#54](https://github.com/leshchenko1979/opencrabs/issues/54)).** Outside a code span, GitHub autolinks `#N` against adolfo's issue space — the tooltip points at the wrong repo's issue. Required form on PR/issue bodies, titles, comments: `leshchenko1979/opencrabs#N` or full URL. Code spans exempt (no autolinking inside backticks). All live upstream offenders patched 2026-08-31; sweep clean.

## Upstream issue filings — report-only (owner 2026-08-28 15:17Z)

**Offload order — CORRECTED (owner 2026-09-01, "Wait, i was talking about prs only. Revert issues"):** "Offload to upstream" applies to **PRs only** (when we fix OpenCrabs-source bugs, the fix ships as an upstream PR per the existing PRs-only rule). **Issue reports NEVER go upstream** — the fork is the issues home, permanently. The 2026-09-01 issue-migration (adolfousier #1279–#1286 for fork 70/33/38/58/35/60/65 + TEXT_ACCUM) was misread, withdrawn same day: all 8 upstream issues closed as withdrawn, all 7 fork issues reopened, #1255 cross-link deleted. #66 remains not-upstream-eligible (upstream #1260 closed pointing back to the fork; needs owner-level follow-up with adolfo).

When the owner tells us to FILE an issue upstream (adolfousier/opencrabs), the editor does NOT fix it: the filed report is the deliverable, and fixing the upstream-reported defect is adolfo's lane. No editor lane writes fix code or opens a fix PR for an upstream-filed issue unless the owner explicitly orders the fix — follow-up REPORTING on the filed thread stays allowed (per the #1255 exception).

## Stage-entry consent (owner 2026-08-28 16:57Z)

When the owner says to go to a stage ("let's go to S3", "go to Sx"), that word IS the approval for ALL actions defined in that stage's definition (stage table: `~/oc-work/target-process-*.md`). No per-action re-asking for anything inside the stage definition. Gates the stage definition itself spells out (e.g. the sha-bound artifact verify that authorizes each swap) REMAIN — they are part of the stage definition, not exceptions to it.

## No auto-rollback on smoke FAIL (owner 2026-08-28 18:50Z)

Post-swap smoke FAIL → rollback is the OWNER's call, never mechanical. The swap-chain auto-rollback on post-bounce verify fail (crash-integrity: disk==proc mismatch → restore backup) is UNCHANGED — that one stays automatic. With deploy consent eliminated the same day, this is the only human gate left near the deploy pipeline.

## Post-swap notify (LIVE — mechanical fan-out since 2026-08-29)

Mechanics canonical: `oc-deploy fanout` (GREEN leg at the swap_execute tail, RED leg via poll failed-run scan; idempotent `fanout.state`; drills off via `OC_DEPLOY_NOFANOUT=1`) + s2-swap-journal-spec §Fan-out legs. No manual notify steps anywhere. Ledger path is canonical `opencrabs-dev/workers-ledger.json` — the skill-dir duplicate was deleted 2026-08-29 (v0.4.38); fix shipped FIRST, deletion second.

## Attribution guard (post-compaction wakes)

Before disputing the attribution of any shipped artifact (build, deploy, ledger event, commit) — on a `session_notify` wake, after a compaction, or whenever memory and records disagree — re-derive OWN shipped work from durable state FIRST: `opencrabs-dev/workers-ledger.json` claim/fanout events, oc-deploy journal lines + deployed.sha markers. Ledger beats memory; a mismatch is reported, never accused. Origin: post-compaction amnesia made this lane falsely blame oc-attrib/fanout for its own shipped work (retraction logged 2026-08-30, HQ d72bd52d); guard forwarded to owner via HQ topic report — remove on owner order only.

## PR naming convention (owner 2026-08-30)
Every PR this fleet opens carries a type prefix in the title so upstream release triage can split bugfixes from features at a glance:
- `fix:` (or `fix(scope):`) — bug fix; corrects broken behavior
- `feat:` (or `feat(scope):`) — new capability or behavior change
- `chore:` — tooling/CI/docs/deps; zero user-visible behavior change
Applies to upstream (adolfousier/opencrabs) AND fork PRs. New branches mirror the type in the slug: `leshchenko1979/fix/<slug>` / `feat/<slug>` / `chore/<slug>` (existing branches untouched). Retro-check 2026-08-30: upstream PR #1265 already conforms (`fix(plan): …`). Procedure detail: `/opencrabs-dev` skill, editor.md Phase 7.
## CI-wait discipline + actor attribution (owner 2026-08-30 — fix batch)

Canonical: editor.md §CI-wait discipline & actor attribution (items 1–9: gh-watch ban → oc-prchecks, `OC_ACTOR` export on every oc-* call, pr-checks concurrency group, terminal-state gating, rc-at-top-level, waiter self-checks, checkout-ref-is-terminal-truth) + supervisor.md §CI-wait & waiter discipline (W1–W6, oc-waiter arm standard) + SKILL.md §session_notify DELIVERY MODES (notify form, `--interrupt` for mid-turn operational wakes). Fleet-directives carries no extra text.

## Creating new editors (owner order 2026-09-01 21:56Z)

Trigger: a NEW area is discussed and a research/code task needs doing, and NO existing editor lane has done anything in that area. Then HQ creates a fresh editor:

1. `tool_search("tg_mtproto")` (dynamic tool; schema dies at compaction — re-search first).
2. Create the topic (MTProto, methods verified live 2026-09-01): forum methods live under `messages.*`, NOT `channels.*`; pass `resolve: true`; peer = forum chat id.
   - `tg_mtproto` method_full_name=`messages.CreateForumTopic` params_json=`{"peer": -1003936827469, "title": "<Area>", "random_id": <random long>}` → parse envelope (`content[0].text` is escaped JSON, needs second `json.loads`), read the new topic's root message id from the Updates.
   - Read-only probe that works: `messages.GetForumTopicsRequest` {peer, offset_date:0, offset_id:0, offset_topic:0, limit}.
3. `tg_send_message` (dynamic tool) chat `-1003936827469`, `reply_to_id` = the new topic's root message id, message starts EXACTLY with `Load opencrabs-dev skill. You are an editor.` then the task brief.
4. Enroll the new editor in the roster: `oc-ledger roster-enroll` with its session id + `--topic <topic id>` (lesson 2026-09-01: an unrostered actor fails ship with "Session-Id not in workers ledger").

## Tool-problem reports: HQ triage & routing (owner order 2026-09-01 22:2xZ)

Workers/editors report tool failures, inconsistencies, and quirks to **HQ** (this lane) — `QUIRK: <tool> <observed> BECAUSE <expected>` + evidence, same turn (skill: supervisor.md §Duty 7 items 5–6, editor.md lane duty). HQ's duty on receipt:

1. ACK same turn; stamp ledger `idea` event.
2. Verify evidence against disk/logs before routing (reports can be wrong — see fanout refutation, 2026-09-01).
3. Route the FIX: owning editor lane by TOPIC name (session_search, never remembered uuid), briefed via session_notify with the quirk + evidence. No lane covers the area → create a NEW editor (§Creating new editors above).
4. Stamp `idea-verdict` ROUTED (target topic named) or REJECT (reason journaled). The fix ships through the normal editor flow — Duty 7 documents the report, it never bypasses Phase-7.

## Cadence boundary is stamped at review consolidation

`oc-ledger cadence` = count of `skill-bump` events since the last boundary event (`review-battery`; query also accepts legacy `skill-review*` kinds the v1.1 KINDS vocabulary can no longer produce — known drift, do not stamp those). Lesson 2026-09-01: the Duty 4+6 verdict was consolidated but never stamped → counter read 24/5 FIRE on stale data. Rule: every consolidated review verdict ends with `oc-ledger stamp review-battery "<summary>"` BEFORE reporting the cadence state; never narrate a cadence reading without checking the boundary event exists.

<!-- source: MEMORY parked-issues -->
## Parked issues — owner standdown (2026-08-28 16:17Z)

Fork issues [leshchenko1979/opencrabs#20](https://github.com/leshchenko1979/opencrabs/issues/20) (plan auto-approve under `approval_policy=auto-always` — 638µs `created_at`→`approved_at`, design-track promise broken, restart resumes unapproved plans as Active) and [leshchenko1979/opencrabs#16](https://github.com/leshchenko1979/opencrabs/issues/16) (plan-card footer lost in 429 flood) are **PARKED**: owner stood the editor lane down ("It's not your concern anymore — stand down", relayed via ops 329bf3a3). No implementation approval will arrive via ops. Gate stays: no code, no branch, no claim-comment on either issue unless Alexey himself explicitly re-opens and approves the solution+diagram. Do NOT re-ignite these on seeing them open in the fork issue list — filed state IS the deliverable; fixing upstream-reported defects is adolfo's lane.


