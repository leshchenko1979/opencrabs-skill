# Fleet directives — opencrabs-dev cross-role law

**Owns:** the binding owner directives that apply to EVERY opencrabs-dev lane — the `[LANE]` law every worker reads in full at spawn and at compaction reload, plus a residual of cross-cutting rulings that belong to no single role. 

**Shape after the 2026-09-18 split.** Role- and topic-scoped law no longer lives here: 25 sections were relocated byte-exact into the file that owns them, and this file keeps a pointer only — one concept, one home. Read scoped law THERE:

| Kind of law | Canonical file |
|---|---|
| sync model & rebase, seam resolution, harvest cadence / HARVEST LAW / NO-HOLD, PHOP | `upstream-merge-runbook.md` |
| editor phases, smoke procedure, carrier hotfix gates, swap-sha coverage, no auto-rollback | `editor.md` |
| upstream PR lifecycle, deep-core heads-up gate, dependent PRs law, cross-fork PR inspection, upstream issue filings | `editor-upstream-pr.md` |
| intake & assignment, dispatch hygiene, parked issues, creating new editors, night-shift cadence (Phase 3, Idle-Lane Issue Triage) | `triage.md` |
| tool-problem reports | `toolsmith.md` |
| HQ duties, cadence boundary, rule-text provenance | `hq.md` |
| Duty-6 lens briefs (A–J families + brain-scrub) | `review-lenses.md` |
| post-swap notify / fan-out vocabulary | `s2-swap-journal-spec.md` |

**Thematic index** (lens B-17/G-F9 v0.4.90 — file is flat; jump via section name). **[LANE] tag (v0.4.95):** sections every worker MUST read in full at spawn/compaction reload (editor.md/triage.md/toolsmith.md/hq.md RELOAD LAW v0.4.95). EXCEPTION (v0.4.96, lens B-F1): HQ re-reads THIS ENTIRE FILE IN FULL — it owns and rules on the directives; the other three roles may use this thematic-index minimum for non-[LANE] sections.

**Owner holds & gates:** **Owner Push Freeze** (soaking groups held from upstream harvest) · **Discussion links + fix-approval gate** · **Stage-entry consent** · **Guard-Flag Escalation Law** · **Full-Gate Pre-PR Testing Law** · **Docs-Only LEG1 Gate Skip** · **Owner-Dependent Smoke Legs**

**Roles & authority:** **Autonomous Priority Authority Law** · **Autonomous Editor Goal & Continuous Phase Execution Law** · **Claim Release & Superseded Plans** · **Early Claim** · **Designated Domain Affinity & Topic Context Focus Law** · **Strict Atomicity & Zero Bundling** · **PR naming convention**

**Channels & messaging:** **Telegram surface law** · **telegram_send addressing rule** · **Cross-lane message delivery discipline** · **Direct dispatch** · **Receiver-side dedupe of reload demands** · **Attribution guard** · **Unified Event Capture**

**Ships & carriers:** **Features-compat gate** · **Carrier Concurrency & Coalescence Law** · **Post-Rewrite Swap Recovery** · **Upstream PR filing — base CI gate pre-claim** · **Upstream Coding & Testing Standards** · **LLM Ergonomics & Efficiency Law**

**Smoke & dispatch:** **Out-of-Feature-Set Issues** · **Dispatch Eligibility** · **Attribution & Goal Hygiene** · **Verification during a truncated-output window is not verification** · **External lanes**

**Pulled back to fleet-directives (tier C, 2026-09-19):** **Tool logging rule** · **CI-wait discipline & actor attribution** · **Swap-head signature for rebase/synthesis/merge-derived binaries** · **Decision Rollcall** · **Inherited-claim three-pillar verification** · **Topic domain alignment & rename authority** · **HQ does not execute lane work — refuse and reroute**

**Reload & orientation:** **Post-compaction skill reload & context manifest curation** · **Every turn ends with a "what now/next?" answer** · **Explain open questions & re-anchor context** · **Daemon no-reap**

## Owner Push Freeze — soaking groups held from upstream harvest (owner order 2026-09-18) [LANE]

**Owner order, verbatim:** *"freeze all these groups from pushing - I want to review them first and will release them later"* (2026-09-18 17:33Z), followed by the first and only release so far: *"Telegram flow cluster T6 - release for harvesting"* (18:01Z).

**What "these groups" are.** The owner was reading the delivered live-test plan (`/tmp/live-test-plan-2026-09-18.md`, board topic 30220, `msg=67358`) — the soak/test surface of the deployed binary (50 `feat` commits landed since 09-16 00:00). Its groups are the frozen set: **18 T-groups (T1–T18) + 7 Tier-3 items**. One group is released.

| State | Groups |
|---|---|
| **FROZEN** — no upstream push / harvest | **17 T-groups:** T1 (#299), T2 (#286), T3 (#291), T4 (#295), T5 (#285), T7 (#280/#289/#258), T8 (#234/#155), T9 (#1629/#233), T10 (#317), T11 (#247), T12 (#208/#228), T13 (#278), T14 (#298), T15 (#241), T16 (`[agent] default_provider`), T17 (#256), T18 (#150) · **7 Tier-3 items:** #290, #271, cron per-job in-flight guard, #264, #273, repeated-bash nudge, #345 |
| **RELEASED** — harvest eligible | **T6 — Telegram flow cluster** (#250 🎯 telemetry marker, 🌐/🧠 tool classes, ⏰ cron icon, compact event labels, #232 telemetry bar, queued-message roll tag) |

**Machine-readable source of truth (the #358 shape — HQ ruling 2026-09-19).** The block below is the ONLY home of the frozen/released data. Tools read it from HERE — never from the prose table, and never from a second file: a separate state-dir copy would be a second home for law data and would drift, which is precisely the contradiction this block exists to end (see the T3 ruling below). **`law_version` = the `SKILL.md` version at which this block last CHANGED; it is not re-stamped on every bump.**

**Reader status (2026-09-19): the fail-loud reader does NOT exist yet — this machinery leg is OPEN, not done.** `tools/**` is Toolsmith-owned, so this leg belongs to the Toolsmith lane and the build sits in their queue — the gap was reported to them by the #352 harvest lane on 2026-09-19, and HQ neither wrote the reader here nor dispatched a second copy of the report, because a duplicate report to the same owner is noise, not diligence. **Until it lands, the block is read by humans and the freeze rests on this law text plus lane discipline.** Required behaviour when built: extract the block from HERE and fail LOUD (`OWNER_PUSH_FREEZE_UNREADABLE`) when it is absent or malformed — never fall through to "nothing is frozen", because that direction silently releases all 18 groups. A tool that cannot read the block is NOT a tool that found nothing frozen.

```json
{
  "law_version": "0.4.207",
  "owner_order": "2026-09-18 17:33Z",
  "released": ["T6"],
  "frozen": {
    "T1": ["#299"], "T2": ["#286"], "T3": ["#291"], "T4": ["#295"], "T5": ["#285"],
    "T7": ["#280", "#289", "#258"], "T8": ["#234", "#155"], "T9": ["#1629", "#233"],
    "T10": ["#317"], "T11": ["#247"], "T12": ["#208", "#228"], "T13": ["#278"],
    "T14": ["#298"], "T15": ["#241"], "T16": ["[agent] default_provider"],
    "T17": ["#256"], "T18": ["#150"],
    "TIER3": ["#290", "#271", "#264", "#273", "#345", "cron per-job in-flight guard", "repeated-bash nudge"]
  },
  "disputed_not_released": ["T3"]
}
```

**T3 (#291) — a claimed release that is NOT a release (HQ ruling 2026-09-19).** Ledger `n=8670` (lane `63d775f9`, 2026-09-19T01:41:34Z) reads the owner's three-word message *"Overrule T3 release"* (2026-09-18 21:45:27Z) as READING (a) — "the freeze does not apply to T3, #291 released for harvest" — and is contradicted by the table above, which still shows T3 FROZEN. The ruling:

- **The law text is authoritative; a ledger `note` is not.** A release is an OWNER action recorded in law, and Rule 2's bar is an *explicit* owner message naming the group "exactly as T6 did" (*"Telegram flow cluster T6 - release for harvesting"*). A lane's reading of an ambiguous message cannot meet that bar, so `n=8670` is an interpretation, not a release, and **T3 remains FROZEN**.
- **The message is genuinely ambiguous — it parses two OPPOSITE ways** — and the lane's own note says so ("could be read as 'overrule the T3 release' (i.e. deny the release)"). Parsed as an object, "Overrule **T3 release**" annuls the release; parsed as an imperative, it annuls the freeze. The context cuts both ways: the owner had already approved filing at 10:20Z and pushed back on being asked ("What in the rules makes you ask me?"), yet the 17:33Z freeze came *after* that approval, and the question put to him was framed as a binary in which *silence* was the keep-frozen answer.
- **Cost asymmetry fixes the standing state while it is open.** A wrongly-frozen group costs a delayed harvest — recoverable. A wrongly-released group files an upstream PR for a group the owner said he wanted to review first — not recoverable in the same sense. **Frozen is the only safe default.** Reinforcing it: T3 is the group the owner himself found defective on 2026-09-18 (the tool-roll header), and its fix is still soaking under lane `2ed8adeb`.
- **The ambiguity is escalated to the owner** as a one-tap (keep frozen / release), and until he answers, **no harvest of #291 or its 21-target set may be staged or filed** — a green census does not change this (Rule 1: soak maturity elapsing is not a release). Whoever holds the owner's answer updates this block, the table above, and `disputed_not_released` in one commit.

**The rule:**

1. **No upstream push of a frozen group.** No upstream PR is filed for a frozen group's commits, and no lane stages one, until the owner releases that group by name. Soak maturity elapsing is not a release.
2. **Release is an OWNER action, never a lane decision.** A group leaves the freeze only on an explicit owner message naming it — exactly as T6 did. Silence, a green census, a lane's own confidence, an idle editor, **or a lane's reading of an ambiguous owner message** never release a group. The released set grows one named group at a time, and currently holds exactly one member: **T6**. **The record of that action is the `json` block above, not a ledger `note`** — the T3 ruling below is the worked example of a note claiming a release the law does not grant.
3. **The freeze binds the machinery, not just the prose.** Triage's 4h harvest patrol (`oc-harvest-dispatch-4h`, job id `73158e43-3b04-4464-bf82-8d9065a191bb`) must not dispatch a frozen group; `oc-harvest-census` / `oc-harvest-dispatch` must read a frozen group as NOT harvest-eligible **by reading the `json` block above through the fail-loud reader — which DOES NOT EXIST YET (see the reader-status note above).** Verified 2026-09-19: neither tool contains any freeze awareness, so **a green `oc-harvest-census check <N>` is NOT evidence that a frozen group may be dispatched** — the census does not read the block, and until the reader lands this leg rests on lane discipline alone. An editor holding a frozen group's work stops short of Phase 7 (upstream PR filing).
4. **This is NOT the carrier FREEZE of `upstream-merge-runbook.md §Remotes & sync` (2).** That one is mechanical (no sync while a carrier chain sits between dispatch and swap). This one is an owner hold on a feature group's harvest. Same word, different concept — write **owner push freeze (harvest hold)** when you mean this one.
5. **Scope boundary — the freeze holds HARVEST, not development.** Lanes keep fixing, committing, shipping and smoking inside fork `main`; what is withheld is the upstream push of a frozen group. A defect found in a frozen group (e.g. the owner's 2026-09-18 finding that #291 puts the compaction result, not the latest thought, in the tool-roll header) is fixed and re-soaked normally — it stays frozen only at the harvest boundary.

**Rationale (owner's own words):** *"I want to review them first"* — the soak groups ARE his live-test surface, and harvesting one before he has exercised it upstreams a feature he has not yet accepted.



## Discussion links + fix-approval gate (owner 2026-08-28 14:28Z)

1. **Whenever a PR or issue is discussed, a link must be given.** Every mention of a PR or issue number — chat, reports, ledger entries, rulings — carries the full URL (or an owner/repo#N reference that resolves to one). No bare numbers: a number without a link is an unfinished sentence. If a reference cannot be resolved to a link, say so explicitly.
2. **Owner gates EVERY implementation design (owner order 2026-09-09 ~20:03Z, supersedes the fix-scoped version).** No implementation of ANY design — fix, feature, tool, refactor, process change, any size — begins code work before the owner approves the design. The design is presented to the owner in CANONICAL TERMS (the project's codified ontology — fleet-directives.md vocabulary, exact codified names, no invented shorthand; owner order 2026-09-07 09:34Z) WITH a process diagram (Mermaid, vertical; multi-actor processes get a sequenceDiagram per item 3; no backticks/angle-brackets in labels). The diagram is part of the gate: a design presented without its diagram is not presented. Implementing an unapproved or un-diagrammed design is a gate violation at any size. Owner's approval must be explicit (message or 👍 reaction); silence is NOT approval. HQ/lane work that produces a design — including Duty-4 accepted proposals that change law or tooling behavior — passes through this gate before implementation.
3. **Multi-actor processes get a sequence diagram (owner 2026-08-28 17:55Z).** Whenever the process under discussion involves SEVERAL ACTORS (roles, tools, external services, humans), the required diagram is a Mermaid `sequenceDiagram` — one participant per actor, messages as labeled arrows. A flowchart is acceptable only when the flow is genuinely single-track.
4. **Bare `#N` with fork issue numbers is forbidden on any upstream surface (owner 2026-08-31, skill v0.4.67, fork [#54](https://github.com/leshchenko1979/opencrabs/issues/54)).** Outside a code span, GitHub autolinks `#N` against adolfo's issue space — the tooltip points at the wrong repo's issue. Required form on PR/issue bodies, titles, comments: `leshchenko1979/opencrabs#N` or full URL. Code spans exempt (no autolinking inside backticks). All live upstream offenders patched 2026-08-31; sweep clean.

## External lanes — fork issue reporting vs dev non-participation (owner order 2026-09-13) [LANE]

**The fork issues STAND.** External/side lanes (e.g. `inferhub-watch`) may open fork issues on
`leshchenko1979/opencrabs` for runtime anomalies they observe during their own operation. That
reporting is sanctioned, and the resulting issues are legitimate: an issue filed by an external lane
is **not** to be closed, re-filed, or discounted merely because an external lane filed it.

**Reporting is the whole of that licence.** An external lane is strictly barred from the OpenCrabs
**development process**: no PRs, no code edits in `/root/opencrabs`, and no participation in dev
triage or review. Dev-process participation belongs exclusively to **rostered OpenCrabs editor lanes
and HQ**. Opening a fork issue confers no claim on it, no slot in the fix queue, and no voice in its
disposition — a report is an input to Triage, not an assignment.

Origin: owner ruling 2026-09-13 — *"The fork issues stand. The law should be amended. You are allowed
to fork to open fork issues, but not allowed to participate in the development process."* **This section IS
the canonical home** — forwarded by lane `1122b15e` and codified HERE. The ops brain
(`~/.opencrabs/profiles/ops/AGENTS.md`) carries a duplicate of this law; where the two drift, THIS
section governs and the brain copy yields. Brain-file text is always-loaded but is never the
dev-process authority — the skill is.

## Stage-entry consent (owner 2026-08-28 16:57Z)

When the owner says to go to a stage ("let's go to S3", "go to Sx"), that word IS the approval for ALL actions defined in that stage's definition (stage table: `~/oc-work/target-process-*.md`). No per-action re-asking for anything inside the stage definition. Gates the stage definition itself spells out (e.g. the sha-bound artifact verify that authorizes each swap) REMAIN — they are part of the stage definition, not exceptions to it.

## Post-compaction skill reload & context manifest curation (owner 2026-09-04, updated 2026-09-17) [LANE]

After ANY context compaction or spawn, the first action before any opencrabs-dev work is reloading this skill (`/opencrabs-dev`, or SKILL.md + your role file + fleet-directives.md — role files and toolsmith.md: [LANE]-tagged sections IN FULL; RELOAD LAW v0.4.95). Editor spawn briefs must carry this rule; the ops AGENTS.md § "OpenCrabs dev" carries the always-loaded anchor.

**Context Manifest Curation (Compaction Section 10, owner order 2026-09-17):**
When context compaction occurs, the compactor generates a context manifest YAML block. The compactor MUST explicitly curate the manifest as follows:
1. `active_skills`: Keep `opencrabs-dev`, `opencrabs-dev/fleet-directives.md`, and the specific active role file (`opencrabs-dev/editor.md`, `opencrabs-dev/hq.md`, `opencrabs-dev/triage.md`, or `opencrabs-dev/toolsmith.md`).
2. `discard_skills`: Discard only non-active role files that do not apply to this lane's role.
3. `required_tools`: Keep key operational tools (`session_notify`, `session_search`, `bash`, `read_file`, `telegram_send`) pre-activated.
Empirical production data (778 compactions) confirms the compactor honors manifest guidance (>93% retention when guided; 0.00% contradictory aux retention when root discarded). Standardizing Section 10 manifest curation prevents skill amnesia post-compaction without binary modifications.

## Receiver-side dedupe of reload demands (HQ ruling 2026-09-10, anomaly: duplicate v0.4.130 fanout wave)

If an identical reload demand (same skill version + same skill sha) arrives and you have already run drift-check + stamped ack for THAT version: drop it silently — no re-execute, no re-ack (a blind re-run double-stamps the ledger and corrupts ack counts); optional one-line dup-notice to sender. Receiver-side defense only; sender-side single-wave discipline is HQ's (process check before launching a wave). Model behavior: c2ba4ef2 detected the duplicate by (version, sha) match and did not re-execute.

## Attribution guard (post-compaction wakes)

Before disputing the attribution of any shipped artifact (build, deploy, ledger event, commit) — on a `session_notify` wake, after a compaction, or whenever memory and records disagree — re-derive OWN shipped work from durable state FIRST: `opencrabs-dev/workers-ledger.json` claim/fanout events, oc-deploy journal lines + deployed.sha markers. Ledger beats memory; a mismatch is reported, never accused. Origin: post-compaction amnesia made this lane falsely blame oc-attrib/fanout for its own shipped work (retraction logged 2026-08-30, HQ d72bd52d); guard forwarded to owner via HQ topic report — remove on owner order only.

## PR naming convention (owner 2026-08-30) [LANE]
Every PR this fleet opens carries a type prefix in the title so upstream release triage can split bugfixes from features at a glance:
- `fix:` (or `fix(scope):`) — bug fix; corrects broken behavior
- `feat:` (or `feat(scope):`) — new capability or behavior change
- `chore:` — tooling/CI/docs/deps; zero user-visible behavior change
Applies to upstream (adolfousier/opencrabs) AND fork PRs. New branches mirror the type in the slug: `leshchenko1979/fix/<slug>` / `feat/<slug>` / `chore/<slug>` (existing branches untouched). Retro-check 2026-08-30: upstream PR #1265 already conforms (`fix(plan): …`). Procedure detail: `/opencrabs-dev` skill, editor-upstream-pr.md Phase 7.

## Strict Atomicity & Zero Bundling (owner order 2026-09-13; lane 1a63f103 proposal) [LANE]

**1 Intent = 1 Unit.** Features and bug fixes MUST NEVER be bundled into the same issue, branch, or PR.
- Never mix `feat:` and `fix:` in one PR: a feature PR must carry exclusively feature commits, and a bugfix PR must carry exclusively fix commits.
- If a bug is uncovered while working on a feature: do NOT fix it inline on the feature branch. File a separate fork issue, claim it in a clean worktree/branch (or hand it to Triage), fix and smoke it independently, and land it atomically.
- Bundling a "convenient small fix" into an active feature PR forces binary review on a mixed diff, poisons git bisect, muddles changelogs, and breaches upstream PR atomicity rules. Gate: `./tools/oc-pr-atomicity <pr>` enforces issue and trailer boundaries. Canonical procedure: `editor-upstream-pr.md §Phase 7`.

## LLM Ergonomics & Efficiency Law (owner order 2026-09-13) [LANE]

Every tool, schema, hint, error message, and prompt designed for agents must prioritize **LLM ergonomics and operational efficiency**. LLMs have limited context horizons, suffer amnesia across compactions, struggle with mental list arithmetic, and hallucinate when forced to reconstruct hidden state. Designing for agents means eliminating these failure modes at the interface:

1. **Contextual & Relative Anchors Over Mental Arithmetic:** Never force an agent to compute, track, or predict numeric array indices, line numbers, or offsets across turns. Prefer semantic anchors (title substring/fuzzy matching) or relative keywords (`"current"`, `"next"`, `"tail"`).
2. **Actionable, Self-Healing Feedback:** Tool error messages are inline prompts. Never emit bare rejections (`"Invalid index"`, `"Task not found"`). When validation fails, the error output MUST provide the active state snapshot and the exact valid candidate options so the agent can self-correct in a single follow-up turn without blind exploration.
3. **Turn Consolidation & Immediate State Delivery:** Mutating tool operations should return confirmation along with the resulting state summary (e.g. `add_tasks` returning the updated plan summary). Eliminate redundant round-trips whose sole purpose is inspecting what the previous action produced.
4. **Information Saliency & Token Discipline:** Hints, schemas, and descriptions must maximize signal-to-noise. Eliminate verbose boilerplate; state constraints and contracts explicitly; keep prompt payloads tight to prevent context window bloat and compaction pressure.

## Upstream Coding & Testing Standards (CONTRIBUTING.md & Adolfo DM 2026-09-13) [LANE]
**Dry-run is quoted, never hand-written.** An ad-hoc test or cleanup script MUST genuinely respect `--dry-run`: mutating actions stay strictly behind flags, or the dry-run proof is invalid. The `--dry-run` form is quoted verbatim from the tool's own `--help`, never hand-written.

**LOC metric on every law change (owner order 2026-09-19):** the lines-of-code check is a MANDATORY part of every law change — one of the main metrics. Every law/process edit carries an explicit before/after LOC delta table for each file touched, and law files stay under the 500-line budget (compaction degradation). A law change with no LOC delta is incomplete.


Mandatory standards for any code slated for upstream harvest (`adolfousier/opencrabs`) or developed in the fork:

1. **Test Isolation (NO inline tests in `src/`):** ALL tests must live under `src/tests/*_test.rs` registered in `src/tests/mod.rs`. Absolutely **NO inline `#[cfg(test)] mod tests { ... }`** blocks at the bottom of source files in `src/`. Inline tests hide behind source files in IDE outlines and grow unbounded. If an existing inline test block is found while working on a file, move it to `src/tests/` as part of the change.
2. **`mod.rs` Declarations-Only:** A `mod.rs` file may contain exactly: module doc comments, `mod`/`pub mod` declarations, and `pub use` re-exports. **Zero function definitions (`fn`) inside `mod.rs`. Ever.** When a function grows in `mod.rs`, move it to a cohesive named submodule and re-export it. **This is FORK discipline, not a gate** (corrected 2026-09-19, lane 52058a75): upstream's own tree carries counterexamples — `src/channels/telegram/mod.rs` at `adolfousier/main` tip `b6e200a1` holds a top-level `pub(crate) async fn record_topic_created` — so do not cite this standard as a CI obligation when triaging a pre-existing `mod.rs` function. Apply it to code you write or touch.
3. **Commit Trailers (Zero `Co-Authored-By`):** Never add `Co-Authored-By` lines to commit messages. Upstream project policy rejects them.
4. **Real Tests Over Mocks:** Write tests that fail without the fix and pass with it. Exercise real structs and SQLite rather than artificial mocks.
5. **Zero Error / Warning Suppression:** No `#[allow(dead_code)]`, `#[allow(unused)]`, or warning suppression duct tape. Unused code must be deleted, not annotated.
6. **`ONTOLOGY.md` Synchronization:** Shared vocabulary lives in `src/docs/reference/ONTOLOGY.md`. If your change introduces, renames, or retires a concept, update `ONTOLOGY.md` in the same PR.
7. **No Clock-Bomb Fixtures in Tests (v0.4.170, Finding H-1 / row n=2123):** Never write test fixtures with hardcoded absolute future timestamps or recency horizons (e.g. `2026-09-08` in a recency-gated query test). Such fixtures inevitably fail when real calendar time advances past the hardcoded timestamp. Tests must either anchor to simulated/mock time, derive timestamps dynamically relative to `Utc::now()`, or test invariant logic independently of real-world dates.
8. **Cross-Boundary Unit Test Requirement (No Tautological Helper Assertions, Owner Order 2026-09-17):** Unit tests asserting paths, contracts, file operations, or data formats in upstream PRs must test real cross-boundary interaction (e.g. writing through a real file writer and reading back via the target reader in a tempdir) rather than asserting helper equality against its own internal delegate function. Tautological unit tests (where a function merely tests its own internal implementation helper) provide zero regression protection across module boundaries and are strictly rejected.

## Unified Event Capture: Urgent Routing vs. Batched Evolution (v0.4.145)

All observed runtime events, anomalies, proposals, and feature ideas MUST follow the strict taxonomy below. Urgent execution items route directly to the owning substrate without relay hops; non-urgent evolution items persist to disk/ledger to prevent context bloat and memory compaction at HQ.

| Event Class | Trigger & Scope | Destination / Owner | Ingestion Method | HQ Turn Impact |
|---|---|---|---|---|
| **Active Tool Anomaly** | `tools/oc-*` broken, syntax error, failed invocation | **TOOLSMITH** | Direct `session_notify` (target = Toolsmith UUID) | **0 turns** (direct dispatch, no HQ relay) |
| **Daemon Anomaly** | Rust panic, API bug, core runtime fault | **GitHub Issues** | `gh issue create` on `leshchenko1979/opencrabs` | **0 turns** |
| **Host / Infra Outage** | Host unreachable, disk full, systemd unit down | **Alexey** | Escalate via `telegram_send` (Bot API) | **0 turns** |
| **Duty 4 Skill Gap** | Process rule ambiguity, runbook edge case | **Cycle Inbox** | Write to `reviews/<cycle-id>/proposals/<uuid>.md` OR `oc-ledger stamp proposal` | **0 turns** (processed in 1 turn at Duty 6 review) |
| **Idea Box (`/tq-idea`)** | Feature idea, architectural optimization | **State Repo / Backlog** | `oc-ledger stamp idea` or queue file | **0 turns** (processed during task planning / triage) |



## Autonomous Priority Authority Law (owner order 2026-09-15) [LANE]

- **Complete Priority Authority**: Every active lane (Editor, Triage, Toolsmith, HQ) has **complete, independent authority over task ordering, execution sequencing, and operational priorities** within the boundaries of their respective codified laws.
- **No Human Priority Gates**: Lanes MUST NOT ask the human operator (Alexey) for priority determinations, sequence approvals, or "what should I work on next?" scheduling decisions.
- **Autonomous Execution**: If multiple valid tasks, issues, or patrol duties are open and eligible, the lane selects and executes the highest-value eligible item autonomously, applies codified sorting criteria (e.g. FIFO, severity, dependency order), and drives to completion.

## Autonomous Editor Goal & Continuous Phase Execution Law (v0.4.149, owner order 2026-09-12) [LANE]

- **Autonomous Goal Mandate**: Every editor claiming or waking on an issue MUST issue `/goal follow the skill until the smoke test phase` (or set its session goal) to ensure unbroken continuous execution across all lifecycle phases.
- **Design-gate precondition (owner order 2026-09-12)**: The goal is issued **ONLY AFTER the owner has confirmed the design** (owner design gate, v0.4.128). Until that confirmation lands, the editor stays in the design/approval phase and MUST NOT open the autonomous run: issuing the goal early would carry the editor straight past the gate that exists to require owner approval BEFORE code. Sequence is fixed — design → owner confirms → `/goal` → continuous execution to the smoke test phase.
- **No Early Halts**: Editors MUST NOT stop, ask for confirmation, or stall after writing code (Phase 4), after pushing, or after intermediate ship legs. Work continues uninterrupted through Phase 5 (`oc-ship-chain`) to live host deployment and Phase 6b behavioral smoke testing.
- **Completion Definition**: A task is complete ONLY when the live behavioral smoke test on the swapped binary has executed and its 4-leg receipt is recorded in `smoke-verdicts.log`.

## Full-Gate Pre-PR Testing Law (v0.4.149, owner order 2026-09-12) [LANE]

- **Full CI Suite Mandatory for Upstream PRs**: The `--fast` flag (`fast=true`, lint/clippy only) is strictly permitted for internal Daytime Split-Gate merging (`oc-ship-chain`), but is **STRICTLY PROHIBITED** for final pre-PR verification.
- **Upstream Triad Verification**: Before opening any upstream PR (`editor-upstream-pr.md` Phase 7 / 7c), editors MUST run the full test suite (`cargo test --all-features` + fmt + clippy) via `oc-prchecks` full gate:
  ```bash
  # Single-invocation blocking full gate:
  tools/oc-prchecks wait leshchenko1979/fix/<slug>

  # Standard full gate dispatch:
  tools/oc-prchecks leshchenko1979/fix/<slug>
  ```
- **PR Citation**: The resulting GREEN run URL from the full CI run MUST be cited in the upstream PR body alongside the behavioral smoke test evidence.

## Docs-Only LEG1 Gate Skip (v0.4.161, owner ruling 2026-09-12 11:04Z) [LANE]

**Owner ruling (verbatim, 2026-09-12 11:04Z):** *"We don't need the pure docs commits to pass through ci on our side."* Origin: lane `6630dc9a`'s docs commit `eee36027` (ONTOLOGY.md + CONTRIBUTING.md, zero code) burned LEG1 run `34688939568` in full before the ruling landed.

- **The law.** A commit whose changed paths are ALL **pure docs** SKIPS the LEG1 CI gate on the fork ship chain. A skip is neither PASS nor RED — it is a **SKIP**, and it MUST be recorded as one — the SKIP is recorded in the ship chain journal, never left implicit.
- **"Pure docs" is DEFINED HERE, in the law — never left to a tool's discretion.** A commit is pure docs iff **every** changed path (a) ends in `.md`, **and** (b) is **NOT compiled into the binary** via `include_str!` / `include_bytes!`. Clause (b) is load-bearing: a `.md` compiled into the binary changes COMPILED OUTPUT, so a commit touching it is a code change and MUST run the gate. When a chain ships a RANGE rather than a single commit, every commit in the range must be pure docs for the skip to apply.

- **The exclusion set is DERIVED BY THE TOOL at gate time — never by hand, never carried in a lane's context.** The 21 paths listed above are **illustrative, not normative**: that list rots the moment a template is added or removed, and a lane reproducing it by hand is the defect this clause exists to prevent (owner ruling 2026-09-12: *"that should be purely mechanical"*). The gate computes the set from the tree itself, at the moment it runs, by resolving the compiled-in `include_str!` targets against `src/**/*.rs`. **Mechanical evaluation (Finding J-2, v0.4.170):** Lanes must verify qualification directly using `tools/oc-ship-chain --eval-docs-skip <sha>` instead of manual path inspection or hand-derived checks.
- **Recording is MANDATORY — an absent gate is NEVER a passed gate.** A skipped LEG1 MUST be recorded in the ship journal **and** in a ledger row naming the sha (kind `shipchain`, the leg stated as SKIPPED). The v0.4.109 CI-run identity + verdict laws apply unchanged: GREEN may be stated only for a gate that actually ran and returned `completed success`; a skipped leg is cited as SKIPPED, never as GREEN, and is never counted as a passed leg in a smoke receipt.
- **Upstream precedent — and why this law does NOT copy its shape.** Upstream `.github/workflows/ci.yml:23-27` already paths-ignores `**.md` / `docs/**` / `LICENSE*` / `.gitignore` on push ("Docs-only commits are skipped via paths-ignore so they don't burn the matrix"). That shape is **extension-based**, so it would happily skip a commit editing a compiled-in template. This law states the compiled-in exclusion EXPLICITLY rather than inheriting that hole.
- **Enforcement split.** The law text is HQ's (this section). The mechanical LEG1 behavior in `tools/oc-ship-chain` is Toolsmith's (defect #20). That change LANDED in `d6cb9b9a` — **the same tag as this law (v0.4.161)**, 24 min after this text — so the earlier "until it lands a docs-only commit still burns LEG1" is SUPERSEDED (v0.4.163): a pure-docs commit now SKIPS LEG1, the exclusion set is DERIVED at gate time (`shipchain_docs_only()` in `tools/oc-ship-chain` — cite by function name, never by line: tool line numbers drift on every edit), the skip is recorded in the journal (`GATE-SKIPPED-DOCS`) plus a `shipchain` ledger row, it applies to a FRESH dispatch only (`--gated-run`/`--gated-sha` still gate), and the force flag `OC_SHIPCHAIN_NO_DOCS_SKIP=1` exists. Never claim a skip the tool has not recorded.

## Owner-Dependent Smoke Legs — Park, Don't Chase (v0.4.152, owner order 2026-09-12) [LANE]

**Origin (owner, 2026-09-12 ~08:0xZ, verbatim):** *"I saw you stranded on waiting for a smoke — that shouldn't happen, no human smoke will be confirmed as I was away. Why not just leave these PRs for the next cycle?"* Worked example: a verdict-only lane (#155) sat ~4 h because its 4th smoke leg was an owner visual pass, and that leg was treated as a blocking gate in an owner-absent window. Waiting bought nothing — the candidate was verdict-only and excluded from harvest, so no PR was ever going to be filed off it.

### L1 — An owner-dependent leg is NEVER a blocking gate (park, don't chase)

A smoke leg that only the OWNER can satisfy (a visual pass, a tap, an eye-confirm on a Telegram card) MUST NOT block a lane. The owning lane:

1. stamps the legs it CAN prove — lineage, identity, CI gate, and any agent-runnable behavioral probe (a live call, a forced trigger, an observed output through the new code);
2. appends a **`PARKED-OWNER-EYE`** row to `smoke-verdicts.log` naming the exact owner action required AND the packaging sha;
3. **RELEASES the lane** and moves to its next task.

`PARKED-OWNER-EYE` is a lane-release, NOT a hold: the lane goes idle and claimable, the candidate is deferred. This does not contradict the NO-HOLD law (`upstream-merge-runbook.md §Upstream-merge cadence`) — NO-HOLD forbids a *waiting state*; parking is the mechanism that keeps a lane OUT of one. A lane idling on an owner leg is in violation; a lane that parks and moves on is compliant.

### L2 — Shift exit condition: receipts or an explicit park

A shift (night or day) is COMPLETE only when every workstream sits in exactly one of two terminal states:

- **RECEIPTED** — the work landed and its receipts are stamped (PR filed, swap verified, ledger row, smoke row); or
- **PARKED** — an explicit `PARKED-OWNER-EYE` row (or an equivalently named park, with its reason) exists, naming the next-cycle action and the owner.

A workstream in state "waiting for X" is NOT terminal and blocks any completion claim. Candidates not closed inside the window **roll to the next cycle** — never chased across it. Report format: `receipted=N · parked=M · waiting=0`; any non-zero `waiting` means the shift is not done.

### L3 — An owner verdict must be explicit AND post-hoc

An owner verdict on a behavioral leg counts ONLY when it is (a) an explicit confirmation and (b) given AFTER the behaviour has finished. A passing remark made mid-flight is NOT a verdict — the behaviour may still be in progress, or about to fail in a way not yet visible.

Worked example (row 87 → row 90, 2026-09-12): the owner's "Smoke passed" landed **16 s AFTER** their own discard and **3 m 17 s BEFORE** the review subagent finished — the defect (headerless card after discard) did not yet exist on screen. The PASS was stamped, then revoked. **Rule:** if the owner's remark is not unambiguously a verdict, record `OWNER-REMARK (not a verdict)` and leave the leg OPEN/PARKED — never convert a passing remark into a PASS row.

### L4 — Smoke stamps cite the PACKAGING sha

Every `smoke-verdicts.log` verdict row's `sha=` MUST be the sha actually under test — for a harvest candidate that is the **packaging tip** (the branch head being filed), never an ancestor it was built from. A row citing an ancestor does not cover the packaging sha and cannot back a PR filing. For `CORRECTION` or `RETRACTION` rows (proposal n=4175), `sha=` names the sha of the row under correction/retraction (or the refreshed packaging sha if a fresh smoke was performed), and the retracted row identity is documented explicitly in `evidence=`.

Worked example: the #172 row at 01:56:01Z cited `3b095f27` while the packaging tip was `f45d6323` — the stamp never covered the candidate, so a fresh row was required after the full gate. When the packaging sha moves, the row is SUPERSEDED: append a new row, never edit the old one.

## Out-of-Feature-Set Issues — Dispatchable, Ceiling Labeled (v0.4.202, HQ ruling 2026-09-18) [LANE]

**Origin:** Triage asked whether an issue whose deliverable lies outside the carrier feature set is dispatchable at all under the 4-leg rubric — raised after #319 was wired 3× across two lanes with zero claims at the time of the read (ledger n=8161, n=8234, n=8261). The churn was real. The answer is YES: the defect was an **unlabeled smoke ceiling**, not an undispatchable issue.

### F1 — Dispatchability never depends on the carrier feature set

The existing classification bucket governs — `DISPATCHABLE = unclaimed AND vetted AND NOT landed`, stated once and canonically in §Dispatch Eligibility below (the 4-bucket law). The carrier set gates the **binary**, never the **codebase**: a feature-gated module is still compiled and unit-tested by the CI gate, whose flags are `--all-features` (both the clippy and the test step of `pr-checks.yml`). Work on such an issue is therefore verifiable work and MUST NOT be parked, blocked, or skipped for being outside the built set.

### F2 — The ceiling is `structural N/A`, and the verdict MUST read `UNPROVEN (structural N/A)`

Leg 4 (behavioral probe) is unreachable when the deliverable's modules are absent from the shipped set. `structural N/A` is a legal leg-4 substitute under the 4-leg rubric — but per the corrected-code presence rule, presence is not behavioral proof: the verdict reads **`UNPROVEN (structural N/A)`** and is **NEVER GREEN**. The ceiling is determined mechanically, not by judgment: read the live set with `tools/oc-carrier-features` and compare it against the deliverable's feature-gated modules.

### F3 — Harvest stays blocked; the lane parks and releases

A smoke PASS is required to file upstream (PR shipment law). `UNPROVEN (structural N/A)` is not a PASS for a live-testable UX feature, so the issue **stays OPEN** under the harvest-gated closure law, and its upstream filing is blocked on the carrier set. **The set stays as-is — owner ruling 2026-09-18 ("Leave the carrier set as-is")**, which answers the widening question this section originally left open: the ceiling is **permanent and intentional**, not a pending decision. A lane therefore NEVER chases a widening request or re-raises the question — the blocker is a STANDING CONSTRAINT. The lane stamps the legs it can prove, names the blocker, and **RELEASES** (§Owner-Dependent Smoke Legs L1, applied to a non-owner blocker). It never idles on the blocker.

### F4 — Dispatch carries the ceiling label and the native blocker link

The churn cure — both operational (Triage-owned; no new tooling, no new class):

1. When `oc-carrier-features` shows the deliverable's modules outside the set, the dispatch note carries `SMOKE CEILING: UNPROVEN (structural N/A) — <feature> absent from carrier set`, so wire 1 behaves like wire N.
2. The issue is linked natively — `gh issue edit <issue> --add-blocked-by 338` (leshchenko1979/opencrabs#338, the carrier-set **decision record** and the blocker anchor) — per the Continuous Issue Relationship Linking order. A wire carries the RELATION, so the anchor's own state never unblocks it: #338 is a RECORD whose decision is MADE (owner ruling 2026-09-18), not a live question. Its closure is Triage's call under `triage.md §Autonomous closure` (c) owner-confirmed-withdrawn; no lane re-raises the question while the close is pending.

**Worked example (2026-09-18):** #319 (post-delivery re-entry for failed image delivery on Slack / Discord / WhatsApp) — carrier set `telegram,code-graph,browser`; the three channels are feature-gated modules in `Cargo.toml [features]`, compiled only under `--all-features`. The CI gate covers them; the shipped binary does not. Verdict ceiling `UNPROVEN (structural N/A)`; harvest blocked on the carrier set — **permanently**, per the owner's 2026-09-18 ruling that the set stays as-is (leshchenko1979/opencrabs#338, the decision record); lane released. The 4th wire landed a claim (n=8274) — the issue was dispatchable on wire 1.

## Dispatch Eligibility — the 4-bucket predicate, with the LANDED term (v0.4.204, HQ ruling 2026-09-18) [LANE]

**Canonical statement — THIS section is the one home; every other reference (`triage.md` T4/T5) points here.**

`DISPATCHABLE = unclaimed AND vetted AND NOT landed`

| Bucket | Predicate | Action |
|---|---|---|
| **CLAIMED** | an open claim-ref exists | no action — the owning lane's chain holds it |
| **PARKED** | owner standdown | never re-ignite |
| **UNVETTABLE** | no acceptance criteria | park, naming the reason |
| **DISPATCHABLE** | unclaimed AND vetted AND **NOT landed** | wire it |

### D1 — "landed" is `LANDED_KINDS`, NEVER `CLOSING_KINDS`

`landed` := a ledger row of kind `done` or `close` addressing the issue, **OR** a commit referencing the issue on fork `main` (git arm). Either arm marks it landed. Implementation: `tools/oc-issue-dispatch` — `ledger_landed_issues()` (imports `oc_claims.LANDED_KINDS`) + `fetch_landed_issues()` (git arm). Tool side: leshchenko1979/opencrabs#337.

`tools/lib/oc_claims.py` is the ONE canonical predicate — no lane re-inlines it. It carries BOTH sets, and their distinction is load-bearing:

- `LANDED_KINDS = ("close", "done")` — evidence the WORK landed.
- `CLOSING_KINDS = ("close", "confirm", "reject", "done", "unclaim")` — the kinds that can close a CLAIM. A strict superset; **NOT interchangeable**.

**Using `CLOSING_KINDS` as the landing test STARVES real work.** The module's own docstring records the measurement: over the live ledger on 2026-09-18, `CLOSING_KINDS` reaches 228 issues, 125 of them ONLY via the three non-landing kinds — and 48 were reachable by `unclaim` ALONE (a released claim whose work was still unbuilt), suppressed purely because a claim had been RELEASED. A `confirm` row flips a bookkeeping flag and ships nothing; an `unclaim` row returns the issue to the pool, unbuilt; a `reject` row means no work was done at all. **None of the three is evidence the work shipped**, and a released-but-unbuilt issue is legitimately re-dispatchable.

### D2 — Landed-but-unharvested issues are HARVEST QUEUE, not editor dispatch

The closure law (`triage.md §Autonomous closure`) deliberately keeps DONE work **OPEN** until its own upstream PR files. Without the landed term every such issue reads `unclaimed AND vetted` → DISPATCHABLE, so the sweep re-wires exactly the issues the closure law forbids closing. **With the term present the two sets are disjoint by construction:** an OPEN issue whose work already landed in fork `main` waits on a PR, not on code — it routes to the harvest queue and NEVER to an editor lane.

### D3 — Live instance, receipted (2026-09-18)

One T5 sweep (ledger n=8331–8341) wired 8 issues; **5 of the 8 were OPEN AND carried a ledger `done` row** — #330 (n=8317), #324 (n=8192), #302 (n=8267), #299 (n=8325), #297 (n=8266). GitHub state OPEN for all five, verified the same turn. #302's `done` row is Triage's own and says verbatim: *"Issue STAYS OPEN under the harvest-gated closure law until its own upstream PR files"* — and the sweep wired #302 anyway. A second surface, the `oc-harvest-dispatch-4h` cron (session c32f43ee), wired the same issue from the same root cause: `done` + zero claims satisfies the old predicate. Editor 127429e6 claimed #297 (n=8345) then stood it down (n=8353, "dispatch was stale, no work owed") — one wasted claim, real churn.

## Claim Release & Superseded Plans — the mechanisms exist; use them (v0.4.202, HQ ruling 2026-09-18) [LANE]

**Origin:** the #299 duplicate-dispatch incident (lane 329bf3a3, 2026-09-18) reported two process gaps to HQ. Both were investigated against the live tooling, and NEITHER is a missing mechanism — each is a **discoverability** defect, so the cure is law text plus one doc fix in `oc-ledger`, not a new verb.

### C1 — Releasing a claim is a KIND, not a note

A lane that stands down from a claim MUST release it with `oc-ledger stamp unclaim "#N — <reason>"` — never a `note` row.

- `unclaim` is one of the five `CLOSING_KINDS` in `tools/lib/oc_claims.py` (`close`, `confirm`, `reject`, `done`, `unclaim`). That module is the ONE canonical claim-closure predicate every consumer imports; no lane re-inlines it.
- A claim on `#N` closes when a LATER event is a closing kind AND either (1) it is the claimant's own row referencing `#N`, or (2) it is ADDRESSED to `#N` — its `what` BEGINS with the reference. The module's own worked example is the standdown form: `UNCLAIM #264 — stood down in favour of editor lane X`.
- A `note` row closes NOTHING: the claim keeps reading OPEN, so `oc-ledger claim-ref <uuid> --open` still returns the released issue and a dispatch sweep still reads it as held.
- `oc-ledger sweep-closed-claims [--dry-run]` is the mechanical backstop, but it fires ONLY for issues CLOSED on the fork. It cannot release a claim on an OPEN issue — which is exactly the #299 shape, since the issue stays open until its upstream PR files.
- **Live instance, receipted:** claim n=8041 (#299, 329bf3a3); the release was written as `note` n=8324, and `oc-ledger claim-ref 329bf3a3 --open` still answered `299`. HQ stamped the addressed `unclaim` n=8326; the same read then answered CLOSED.
- Tool-side defect — **filed as leshchenko1979/opencrabs#340** (Toolsmith-owned, `tools/**` scope): the `oc-ledger` header KINDS block carries 16 of the live 22 kinds, omitting `close`, `done`, `unclaim`, `reject`, `lesson`, `proposal` — so the vocabulary a lane reads in the file itself is a strict SUBSET of what the code accepts, and the four claim-closing kinds are invisible.

### C2 — A superseded approved plan is retired LANE-SIDE

An approved design plan whose work is superseded — another lane ships it first — is retired by the LANE, not by the owner.

- Record the supersession in the ledger (the durable record).
- Retire the plan lane-side by marking its tasks `skip` with the supersession reason; the plan tool archives a plan once its last task completes.
- `plan discard` is USER-ONLY (refused unless the session holds plan autonomy). Do NOT idle on the owner for a plan whose question is already settled, and do NOT leave a 0/N approved plan live as if its work were still pending.
- **Live instance:** lane 329bf3a3's approved plan (0/11 tasks) was superseded by lane 9fa7c71a's ship `5003c295` (#299) with no lane-side retirement path recorded.

## Guard-Flag Escalation Law (v0.4.152, owner order 2026-09-12) [LANE]

**A guard flag is an EVENT, not a log line.** When any tool guard refuses or flags an action — `phantom_blocked`, a receipt/law guard, an attribution refusal — the owning surface MUST be surfaced in the SAME TURN to (a) the lane whose work it concerns and (b) HQ, carrying the guard's own machine-readable reason. A flag that exists only in a guard log or a journal row is an UNFILED defect.

Origin (2026-09-12): the #172 lane's 03:44Z turn announced *"Upstream PR #1514 Filed & Smoked!"*; the guard correctly set `phantom_blocked=1` — and nothing escalated it. The lane went idle believing it had filed, and **~3 h** elapsed before a manual re-verification (`gh pr view 1514` → *"Could not resolve to a PullRequest"*) caught it. The guard was right; the routing was missing. The real PR (#1524) followed only after a re-dispatch.

Sibling of the receipt laws (phantom #6, `fleet-directives.md §Cross-lane message delivery discipline`): a blocked claim is never silently dropped — the guard's verdict is itself the receipt that something must be routed.

## Attribution & Goal Hygiene (v0.4.152, owner order 2026-09-12) [LANE]

### A1 — Ledger rows carry an actor, by tool default (v0.4.176)

Tools (`lib/oc-log.sh`, `oc-commit`, `oc-ledger`, etc.) automatically derive the actor from `$OPENCRABS_SESSION_ID` (commit `978fe5fe`). Manual `export OC_ACTOR` is retired. Sharpened: tools default the actor to the ambient session rather than writing an unattributed row — an `(unattributed — pass --by or export OC_ACTOR)` row is a TOOL defect, not lane sloppiness, and is dispatched to Toolsmith.

Worked examples (2026-09-12): 34 `shipchain` rows written unattributed by `oc-ship-chain` while the tool held the owning session id (n=3515 class); and an actor string that is not a rostered role (a lane stamping its factory label instead of its roster role) trips `unrostered-actor` — **stamp as your ROSTER ROLE**.

### A2 — A shift-length goal must fit its turn budget, and its death must notify

An autonomous `/goal` issued for a shift MUST carry a turn budget that covers the shift; a 20-turn default on a multi-hour window expires mid-flight. When a goal ends — budget exhausted, or any terminal state — its death MUST be surfaced. A silently expired goal leaves the loop running on standing orders with no judge, and every "goal clock is running" claim after that is false.

Worked example: goal `eefd9a20` ("don't stop until the entire night shift is done") was set with 20 turns and died `state=failed` at 03:18Z; the shift ran a further ~4.5 h with no goal active while reports still described the clock as running.

## Post-Rewrite Swap Recovery (v0.4.151, Toolsmith brief 2026-09-12) [LANE]

**After a fork-main rebase, RE-RUN the same `oc-ship-chain` leg — never hand-edit `deployed.sha` to re-point around a refusal.**

A rebase orphans the deployed sha (it stops being an ancestor of `main`), and the pre-v0.4.151 guard refused **every** such swap with `non-monotonic-swap`. The guard is now rebase-aware: when the incoming lineage carries the deployed change under a new sha (patch-id match) it journals `rewrite-equivalent-swap` with the twin sha and admits the swap. A guard refusal surfaces as **`rc 6`** from `oc-ship-chain`; the recovery is a re-run, not a marker edit.

`oc-deploy lineage-check --prev <deployed> --sha <incoming>` returns the verdict (`ok` / `rewritten` / `absent`) read-only, without touching gate state. Re-pointing `deployed.sha` by hand leaves a false audit trail for a sha that was never built as a run and is **prohibited** (HQ ruling 2026-09-12, lane `2fbfb2f8` incident). A genuinely-absent change refuses until the audited `--allow-rewritten-lineage` override is passed with a mandatory justification.

## Carrier Concurrency & Coalescence Law (v0.4.148, Toolsmith brief 2026-09-12) [LANE]

- **Workflow Concurrency Semantics:** The GitHub Actions carrier workflow `ci/quick-build-linux` uses `concurrency: group: quick-build-linux` with default queuing semantics (1 active run, 1 pending run; additional dispatches cancel and replace the pending run).
- **Non-blocking Push:** Editors pushing to `origin/main` do not serialize on a pre-dispatch carrier lock; they push their fast-forwarded commits immediately.
- **Ancestry Matching & Coalescence:** `oc-deploy` and `oc-ship-chain` accept descendant builds via ancestry matching (`git merge-base --is-ancestor "$SHA" "$CAND_SHA"`). If Editor B pushes while Editor A's carrier build is running, and Editor C pushes right after, GitHub Actions coalesces B and C into a single build. When that build succeeds, both Editor B and Editor C recognize their commits as deployed without running redundant builds.
- **Host Swap Mutex & Monotonicity:** Host binary swaps remain strictly serialized and monotonic via `host-swap.lock` (`flock -x $STATE_DIR/host-swap.lock`) and lineage verification (`git merge-base --is-ancestor "$PREV_SHA" "$SHA"`), preventing stale binary overwrites.
- **Merge Serialization:** `oc-ship-chain` serializes Leg 3 (fast-forward merge) via `ship.lock`.

```mermaid
flowchart TD
    E1["Editor 1 (Push A)"] -->|Dispatches| R1["Carrier Build 1 (Active on A)"]
    E2["Editor 2 (Push B)"] -->|Queues| R2["Carrier Build 2 (Pending on B)"]
    E3["Editor 3 (Push C)"] -->|Replaces Pending| R3["Carrier Build 3 (Pending on C)"]
    R1 -->|Build 1 Finishes| S1["Swap A to Host"]
    R3 -->|Build 3 Finishes on C| S2["Swap C to Host (Coalesced B+C)"]
    S2 -.->|Ancestry Match| ACK2["Editor 2 Acknowledged (B in C)"]
    S2 -.->|Direct Match| ACK3["Editor 3 Acknowledged (C)"]
```

## Features-compat gate — no silent feature-loss swaps (HQ ruling 2026-09-04, MANDATORY) [LANE]

`oc-deploy swap-execute` **refuses** any artifact whose feature set drops a feature present in `deployed.meta.json` (exit 4, journal `features-drop-gate`, markers untouched) unless the operator passes `--allow-features-drop` explicitly. Feature *additions* pass freely; *drops* are the failure class. Enforced in-code (selftest 17p/17q). Rationale: the 06:36:06Z rogue swap (run `33844429519`, `features="telegram"` over a live `telegram,code-graph` binary) killed structural memory for 12h — and the 18:57Z f3c03269 swap was the same class (no-tests artifact, auto-consumed). The gate would have refused both.

## Cross-lane message delivery discipline (owner order 2026-09-04 22:31Z) [LANE]

Lane-to-lane and lane-to-HQ `session_notify` traffic MUST default to deferred delivery; immediate delivery is the exception, not the default. Evidence: 2026-09-04 logs show 1267 `now`-mode deliveries vs 7 deferred — most were status receipts that interrupted working lanes mid-task.

**MODE SEMANTICS — re-ruled by owner order 2026-09-19 03:34:30Z / 03:36:54Z** (*"the factories should use end-turn delivery"* · *"session delivery mode `now` needs to retire — `turn-end` delivery to become the new default. for an idle session `turn-end` = `now`. for a busy session `now` will be a noop"*). This supersedes the quiet-default table that stood here:

- **`turn-end` — THE DEFAULT for ALL lane traffic.** The message queues and lands at the target's next tool-loop boundary; for an IDLE target that boundary is immediate, so `turn-end` loses nothing `now` ever delivered. Use it for status receipts, progress pings, scope confirmations, verdict relays, ACKs, un-park signals, approval rulings, corrections to in-flight work, AND urgent wake-ups — the single default removes the mode-choice decision that produced the 1267-vs-7 skew this section was written about.
- **`quiet` — retained, no longer the default.** For traffic that must not interrupt a working turn and whose ack contract is the ledger rather than a reply (batch/fan-out notices). It is a deliberate choice now, never the fall-through.
- **`now` — RETIRED, and now a HARD ERROR in code (owner order 2026-09-19 03:36:54Z).** Its case is subsumed: an idle target wakes on `turn-end` exactly as it did on `now`, and a busy target treated `now` as a noop anyway. **The code-side retirement LANDED and is DEPLOYED** (fork issue [#373](https://github.com/leshchenko1979/opencrabs/issues/373) — commits `9dffa5632` + `6db34e1fd`, swapped sha `6db34e1fd…`, run `35423208985`, deployed per `oc-deploy status --json`): `notify_policy.rs` returns `Err` for `Some("now")`, and the tool schema's `delivery.mode` enum is exactly `[turn-end, quiet]`. So the mode is **removed-and-erroring, NOT available-but-discouraged** — passing it FAILS the delivery outright. Drop the mode; `turn-end` is the default. (A lane that read this clause between 03:37Z and 05:5xZ would have learned the weaker, wrong fact: see the "until X lands" clause below, whose third instance this was.)
- **Escalation path (rewritten for the retired mode):** send `turn-end` (the default). If the target is mid-turn and the content is genuinely time-critical, the escalation is `interrupt: true` — the failsafe that queues and drains at the next boundary. See the delivery-verdict bullet below.
- **Ack expectation line (owner order 2026-09-08; A-L8 v0.4.116 rename — "ack contract" now means only the retired-worker registry policy in hq.md):** every `session_notify` states its ack contract IN the message body — end with a line like `No ack needed` / `ACK by <date>: <what>` / `Reply required: <question>`. Silence-ambiguous traffic ("fyi" that secretly wants confirmation) forces the receiver to guess and breeds unattributed-ACK incidents. When no ack is needed, SAY SO; when one is, name what a valid ack contains. Lanes must not send pure-ack replies to messages marked `No ack needed`.
- **The LEDGER is the ACK channel (owner order 2026-09-11 — "why don't the editors just write the freeze ack to the ledger instead of spending tokens on notifications? And you can just check the ledger"):** For any wave/fan-out whose ack contract is "confirm you received X" (freeze, unfreeze, skill-change reload, rebase notices), the ack is an `oc-ledger stamp note "…"` row — **not** a `session_notify` reply. The sender reads acks ONCE with `oc-ledger events --n N` and counts them; no per-lane reply traffic, no reply-tracking state. A lane that answers such a wave with a `session_notify` reply has spent tokens on the wrong surface: the ledger row IS the receipt, and a row absent from the ledger means the ack did not happen. Origin: the 2026-09-11 unfreeze wave — **36 UNFREEZE-ACK rows from 17 lanes** were read in a single `oc-ledger events` call, where per-lane notify replies would have been 36 interrupts of working lanes.
- **Task & Harvest Dispatches are ZERO-ACK (owner order 2026-09-13 — "Why do you need all these acks?"):** Task dispatches (`[ISSUE TRIAGE DISPATCH: #N]`) and harvest dispatches (`[HARVEST DISPATCH: #N]`) are strictly one-way work directives. **The receiving lane MUST NOT reply with a conversational `session_notify` ack** (e.g. `[ack] Received dispatch...`, `Starting now...`). Conversational acks interrupt the dispatching lane, pollute session queues, and waste tokens on the wrong surface. The **ONLY** valid receipt for a task dispatch is the lane's ledger claim: `oc-ledger claim <issue>` (or for a harvest dispatch, the upstream PR filing link). Senders verify task receipt by querying `workers-ledger.json` (`oc-ledger events --kind claim`), never by waiting for a message. Every dispatch wire envelope MUST conclude with: `Ack contract: NONE — claim on ledger (oc-ledger claim) and proceed.` **Stalled Claim Nudge Exception (owner order 2026-09-16 08:54 UTC)**: Triage or patrol lanes MAY send a progress check nudge via `session_notify` (`delivery.mode="turn-end"`) to an active claim holder if expected work has not arrived or progress has stalled beyond the patrol window. **Design-gated exemption (owner order 2026-09-19 03:49:33Z — *"if a lane is design-gated, don't nudge it anymore, just mark it in the ledger"*): a lane parked on the OWNER design gate is NOT stalled and MUST NOT be nudged — stamp the park in the ledger and let the patrol continue past it. Full rule + the counterexample evidence: `triage.md §Duty T5`.**
- **Skill-change notification policy — JIT turn-start hints vs Proactive waves (v0.4.172, advisory n=5322; owner order 2026-09-14):**
  - **Routine version bumps:** Shift from proactive `PUSH-ALL-QUIET` broadcast waves to **JIT / pull-absorption**. The daemon harness automatically evaluates and injects a JIT turn-start skill hint whenever an active skill diffs on disk (shipped in `#210`, commit `acb8c5e6`). Routine version bumps do NOT emit mass fanout pings across dormant lanes; lanes absorb the diff and reload at their own natural turn boundaries without session churn.
  - **Proactive `oc-notify-fanout` waves:** Strictly reserved for **breaking process shifts**, **fleet-wide safety halts**, or **explicit owner-ordered fleet reloads**.
- **Skill-change notifies MUST carry the reload instruction (owner order 2026-09-09):** a notify announcing a skill version bump / law change ends with an explicit reload line — `RELOAD: run oc-drift-check <your-uuid> --ack, re-read changed files.` — this line is EMITTED BY THE TOOL (`tools/oc-notify-fanout`), omit-arg since v0.4.166. **`--ack` IS the ack — never prescribe a second `oc-ledger ack` or note row after it (v0.4.159, proposal n=4055):** `oc-drift-check --ack` delegates directly to `oc-ledger ack`, so the brief phrase `ACK after drift-check — a ledger note row is the receipt` is RETIRED. Running `oc-drift-check --ack` completely fulfills both the drift check and the ledger acknowledgment in one step; prescribing an additional note or separate ack row wastes ledger spend and generates duplicate rows. **HISTORY CORRECTED in v0.4.163 after a full ledger audit (68 duplicate `(uuid, version)` groups, 27 lanes, 75 extra rows):** the cause is a RE-ACK, not a double-write — a lane re-reads the skill at its next boundary and stamps hours later (median gap 16 min; 0.4.137's 23 lanes median 3.6 h; only 19 of 68 pairs fall within 5 min), and the family goes back to 0.4.118, not 0.4.143. Heaviest lanes: `61161247`, `462181e9`, `d5863180` ×5 each; `aaa8d8ae`, `2fbfb2f8`, `127429e6`, `7e1ebbb6` ×4 (the earlier "`d18ce16a` n=3713/3714" was rows `d5863180` actually wrote). **CLOSED:** the M2-4 idempotent re-ack guard landed at `a36224ad` (2026-09-12 15:50:14Z) — zero duplicate rows since (latest n=3800 @ 11:09:03Z; 28 acks since, no dup). The live half is the hand-stamp path: re-ack remains possible wherever a lane stamps WITHOUT `--ack`. Stamp `oc-ledger ack <uuid> <new-version>` **ONLY when drift-check ran WITHOUT `--ack`**. A brief that states what changed without the reload verb leaves lanes running the old law in-context (v0.4.120 notify-wave lesson, 2026-09-09).
- **The RELOAD line's version token is the lane's OWN CLAIM, not the announced version (v0.4.165; defect filed by lane `212b3c83`, reproduced first-hand by HQ).** `oc-drift-check <uuid> <claimed>` compares ARGV to the live `SKILL.md` version and nothing else (`cmd_drift`), so a brief that prescribes the NEW version — `oc-drift-check <uuid> <new-ver> --ack` — makes argv == live BY CONSTRUCTION and the verdict is ALWAYS `NO-DRIFT`: the sensor cannot fire on the invocation every brief prescribes. Reproduced on a SYNTHETIC uuid that has never acked anything: `oc-drift-check deadbeef-…-5555 0.4.164` → rc 0 `NO-DRIFT`, while the same uuid with its true (non-existent) claim → rc 1 `DRIFT`. `tools/oc-notify-fanout` auto-appended the same vacuous form (it substituted the live `${version}`), so the wrong form reached every lane automatically, while `editor.md` §Mid-cycle skill drift and the `SKILL.md` tool row prescribed `<claimed-ver>` — **two canonical teaching surfaces disagreeing, the same cold-reader failure one layer down**. The fix was therefore a TOOL fix, not a brief fix: v0.4.166 makes the OMIT-ARG form canonical on every teaching surface AND in the emitter, so there is no token left to get wrong. **On the legacy `<uuid> <claimed-ver>` form the lane must pass the version IT last adopted** — the one it holds from the previous brief — or the check verifies nothing. A `NO-DRIFT` obtained by passing the announced version is NOT evidence of compliance and must never be cited as a receipt. The `--ack` arm is unaffected and CORRECT: it stamps the LIVE version on both paths. Tool half (omit-arg mode reading `last_acked` from the roster, making the check a pure function of state on disk instead of an argv echo) **LANDED at `38e417af`** (2026-09-13, HQ D-5) — `oc-drift-check <uuid> [--ack]` now reads the lane's OWN `last_acked`; a uuid with no history returns `NO-HISTORY` as its OWN verdict (rc 0, "treat as DRIFT"), never folded into `NO-DRIFT`. The legacy `<uuid> <claimed-ver>` form still works. Selftest: `omit-arg-uses-last-acked-not-argv`, `omit-arg-no-history-is-not-no-drift`. Cite a tool by COMMIT + subcommand, never by line.
- **A law clause that says "until X lands" is stale the moment X lands, and MUST be revisited in the SAME version window (v0.4.166; found by lane `d18ce16a` against this very clause).** The omit-arg tool half above landed at `38e417af` — **3 min 32 s** after the clause itself was committed (`e13bef5e` 08:10:38Z → `38e417af` 08:14:10Z) — yet the clause still read "is DISPATCHED to Toolsmith". The BRIEF was corrected and the LAW was not, because a tool commit touches `tools/**` and a law commit touches the law files, and nothing makes the two meet. A cold reader therefore learned the mode did not exist and fell back to the version-arg form the same clause warns can be vacuous. Precedent: the same class was caught at the ship-chain docs-only LEG1 skip and recorded as SUPERSEDED in v0.4.163, not amended in place. **When law text dispatches a tool change, the tool's landing commit must be matched by a law-text edit in the same version window** — check `git log --oneline` for the landing before closing the version.

  - **A clause's own text is not evidence of its currency.** Before emitting any skill-change brief, re-read `git log --oneline` for the landing and `oc-deploy status --json` for the swap: a stale law is copied into every brief generated from it, so one un-rechecked clause propagates fleet-wide in a single wave.

- **A brief written during a blocked state carries that state as fact unless re-verified at broadcast (v0.4.168; v0.4.167 brief incident).** The v0.4.167 brief written during a blocked sync stated that the lock defect was dispatched and in flight — but Toolsmith had already landed `06c12689` before the wave fired, so the durable brief told lanes an already-fixed defect was still broken. Re-read the git log and active dispatch receipts right before firing the wave; never emit a brief from an unverified draft snapshot.

- **The reload line's ack verb is POSITIONAL and must be quoted exactly (v0.4.155).** The canonical form is `oc-ledger ack <uuid> <0.N.N version>` — `ack` takes **no `--by` flag** (that flag belongs to `stamp` — see the `stamp <kind> "<what>" [--by <label>]` usage line in `tools/oc-ledger`), so the invented form `oc-ledger ack --by <uuid> <ver>` dies `rc 2` with `uuid shape invalid (want 8-4-4-4-12 hex): '--by'`. **Never hand-write the ack form into a brief body** — `oc-notify-fanout` auto-appends the canonical RELOAD line (the emitted `RELOAD: run oc-drift-check <uuid> --ack` line in `tools/oc-notify-fanout` (omit-arg since v0.4.166)), and a hand-written second ack line is exactly how the malformed form reached every lane in the v0.4.152 wave (lane `127429e6` hit `rc 2`; corrected form `oc-ledger ack <uuid> 0.4.153` landed `n=3576`). Same family as the `oc-ship-chain --resume` phantom: **law and briefs name only invocations that exist and are quoted verbatim from the tool.**
- **Forum-scope & Process-Owner Delivery guard (owner order 2026-09-10 03:16Z, clarified 15:33Z):** ALL opencrabs-dev work happens ONLY in the opencrabs-dev forum chat (-1003936827469). Automated dev cron alerts and watchdogs MUST deliver directly to the process owner's session via `session_notify` (mode: turn-end), NEVER to a Telegram topic or the owner's private DM. When human-facing Telegram posts are required by protocol, they route exclusively to forum topic 30220 (`reply_to_message_id=30220`), NEVER to private DMs. Skill-change fanout (oc-notify-fanout) MUST NOT wake sessions outside the forum: every target is verified bound to the forum chat (session_bindings.chat_id in the profile session DB) before any send; out-of-scope targets are skipped with a visible `SKIP <uuid> <role> SCOPE(...)` receipt. Fail-closed: an unbound session is out of scope even if it is a known lane — a freshly spawned lane receives fanout only after it has exchanged messages in the forum (binding rows are created lazily on first exchange). Override for drills: `--forum-chat` / `OC_FANOUT_FORUM_CHAT`. Enforced in oc-notify-fanout law 6 (v0.4.130); selftest proves both leak paths (bound-elsewhere, unbound) receive no send.
- **Reading a delivery verdict — `no wake observed` is NOT a failure (Toolsmith correction 2026-09-12).** A `session_notify` confirm verdict of `routed … no wake was observed within 10s` means the **TARGET IS MID-TURN**: the message is injected at its next tool-loop boundary. It is not a drop, and it does not justify a re-send — a re-send on that verdict is a duplicate, not a fix. Corollary: **`session-notify.journal` absence is not evidence of failure.** `journal_line` has exactly one caller, the CLI path (`src/cli/session_notify.rs:344`); in-agent `session_notify` tool calls (`src/brain/tools/subagent/notify.rs`) never journal, so journal rows exist for CLI sends only. Confirm delivery from the daemon log (`Stamped N notify receipt(s) injected for session <uuid>`) before declaring anything lost. Origin: a Toolsmith lane read its own confirm verdict as "did not wake you", re-sent a handover that had already been delivered, and then read the source before filing the journal gap as a defect — the check that kept it off the defect board.

## Direct dispatch — no relay hops (owner order 2026-09-10 ~02:4xZ "Go", discussion 02:30Z) [LANE]

Work notifications go **sender → resource-owner directly**. No intermediary lane re-sends, forwards, or "relays" work to a third lane. Evidence (2026-09-09): the Triage→TOOLSMITH hop silently died twice (v0.4.129 needed an owner "Go" to move; v0.4.130 stalled until the owner asked HQ to check TOOLSMITH); a spawn-nudge was mis-addressed from a remembered prefix; a frankenstein uuid existed because a dispatch was queued through an intermediary. Every relay hop is a silent-failure surface; direct delivery fails loudly at the sender instead.

- **Rule 1 — Direct dispatch:** the sender of a work order notifies the lane that owns the resource directly. An intermediary may name the target, never carry the payload.
- **Rule 2 — Address by receipt:** the target's full uuid comes from a same-turn roster/ledger read — never from memory or a remembered prefix. The v0.4.129 livecheck (session-DB full-id match) enforces this mechanically: dead/frankenstein ids refuse at send.
- **Rule 3 — Ledger stays the record:** every direct dispatch stamps dispatch + delivery-receipt id via oc-ledger. No send exists that isn't on the ledger; DM history is not the record.
- **Rule 4 — Triage re-roles to auditor:** Triage no longer relays work between lanes. It runs periodic ledger sweeps for unclaimed/stale dispatches and escalates orphans **directly to the sender** (not through HQ). Verify-unclaimed (grep open claim-refs before dispatch) STAYS with Triage — it is an audit, not a relay.
- **Rule 5 — Escalation is direct too:** a dispatch unacked past its stated ack deadline is escalated by the sender straight to HQ. No third-lane relay. (Task/harvest dispatches are ZERO-ACK — the receipt is the ledger claim, never a reply; see §Cross-lane message delivery discipline.)
- **Exceptions (not relays):** skill-change broadcast waves (oc-notify-fanout) and HQ rulings/broadcasts are fanout, not relayed work. The owner's design gate (v0.4.128) and roster authority stay with HQ.


## Designated Domain Affinity & Topic Context Focus Law (owner order 2026-09-17) [LANE]

**Dispatching to a random lane with no regard for its designated domain/feature area mixes up topic history for the human operator and wastes the lane's existing in-context focus.**

1. **Domain Affinity Gating**: When dispatching issues via Triage patrols or `tools/oc-issue-dispatch`, dispatches MUST route to an idle editor lane whose designated feature or topic domain matches the issue domain (e.g., Telegram/UI, Mermaid/Diagrams, DB/Persistence, Bash/Subshell, Cron/Scheduler, Memory/Search).
2. **Negative Affinity & Misallocation Refusal**: Mismatched dispatches to specialized feature lanes (e.g. dumping a DB/persistence issue onto a Mermaid or Photo lane) are strictly forbidden. Specialized lanes receive a severe negative affinity penalty (-50) and refuse fallback dispatch.
3. **No Random Fallbacks**: If no idle lane matches the issue's domain affinity, the issue remains queued as `CAPACITY_EXHAUSTED: No available lane with matching domain affinity` until a matching lane becomes idle or Triage commissions a dedicated topic lane. Random fallbacks across unrelated topics are blocked.
4. **Override Gate**: Bypassing domain affinity requires explicit `--force` and owner authorization.

## Early Claim — claim at domain recognition, not at dispatch (owner order 2026-09-18) [LANE]

**Owner order, verbatim:** *"I think the claim shoud happen sooner - when the lane decides that the issue is within it's area of expertise. then the double dispatch problem may be solved."* (2026-09-18 17:38Z)

**The rule — the claim is a LOCK, and it is taken EARLIER than the dispatch:**

1. **Claim at recognition, not at dispatch.** The moment a lane reads an issue and judges it inside its designated domain (see §Designated Domain Affinity above), it claims it — `oc-ledger claim <issue>` — BEFORE it starts work, and independently of whether a dispatch wire has arrived. The dispatch is a notification; the claim is the lock.
2. **First claim wins, and it is exclusive.** A lane that finds an OPEN claim-ref for an issue does not start it, does not dispatch it, and does not "help" — the owning lane holds it. The claim row is the fleet's mutual-exclusion primitive; nothing else is. This is the recognition-side twin of the dispatch-side rule already in force (verify-unclaimed before dispatch, §Dispatch Eligibility).
3. **Why earlier closes the double-dispatch window:** double dispatch happens because routing decides BEFORE any lane holds the issue — two dispatchers reading the same free backlog can each pick a lane, and both start. Moving the claim to the recognition instant puts the lock on the issue before a second dispatcher can read it as free, which is also what makes `DISPATCHABLE = unclaimed AND vetted AND NOT landed` honest rather than aspirational.
4. **An early claim carries an early release duty.** A lane that claims and then cannot proceed releases with `oc-ledger unclaim` — a `note` row closes nothing and leaves the issue reading CLAIMED. An early claim left stale is a hold on the work, not a safety net.

**Honest limit — what this does NOT fix (the owner's own words):** *"as for releasing the lanes - we have lots of them. the problem is throughput and human gate. but there is currently no way to make the human work faster. today was a one-time when I was busy with other stuff."* The early claim removes duplicate **work**; it does nothing for **owner-gate throughput**, which is the real ceiling on the harvest cadence. Two corollaries a lane must not get wrong:

- **Never present the early claim as a fix for owner-gate latency**, and never report the fleet as unblocked because of it.
- **The owner's 2026-09-18 gate delay was exceptional, not a new normal.** His absence from the gate is not licence to relax it, bypass it, or self-approve anything the gate reserves.

## Every turn ends with a "what now/next?" answer (owner order 2026-09-05 ~07:29Z)

The fleet runs many lanes; the owner cannot track them all. Therefore EVERY lane and HQ turn — channel replies, reports, acks — MUST end with a short **What now/next** block answering: what is in flight, what happens next and by whom, and what (if anything) is blocked on the owner. No turn ends on bare receipts or a bare ack without orientation. Keep it to 1-3 lines; a "nothing pending" answer is valid and required too. This is report discipline, not status spam — it replaces the owner having to ask "What now?" every time.

## Explain open questions & re-anchor context (owner order 2026-09-13) [LANE]

Due to high information volume across many factory lanes, the owner naturally forgets the details of past dialogues with individual lanes.

When engaging the owner — especially when time has elapsed since the dialogue occurred, or when re-raising a parked issue or decision:
- **Never merely mention or index open questions:** A bare note stating that *"open questions Q1–Q5 remain"* or *"requires owner answers to the 5 design questions"* provides zero actionable context, forces the owner to reconstruct context, and wastes a turn prompting *"explain open questions"*.
- **Explain the most important open question:** The lane MUST explain the most critical open question directly in the message — stating its core dilemma, the trade-off, and the lane's recommended default — so the owner can decide immediately without digging through past history.

## Upstream PR filing — base CI gate pre-claim (Duty-4 proposal, theme-1 lane, owner-approved 2026-09-06) [LANE]

Before filing an upstream PR, read base-main CI gate state with the owning
tool rather than polling by hand (lens J / F28): `tools/oc-pr-fault-scope
<pr#> --run <id>` returns **IN-SCOPE** (the PR owns the failure) or
**BASE-FAULT** (zero intersection — do NOT chase), and `tools/oc-harvest-sweep`
runs the mechanical pre-gate legs. Pre-claim any OWNERLESS red files by
carrying a sweep commit in the PR itself (Session-Id-only trailer, no
Issue-Ref). Do NOT rely on sequencing comments or separate base-repair PRs
landing first — the 2026-09-05 #1394/#1393/#1395 out-of-order merge (fork #103
incident) proved sequencing comments don't protect merge order.

## Verification during a truncated-output window is not verification (Duty-4 proposal, owner-approved 2026-09-06; sharpens AGENTS.md truncated-output law)

When the earlier run's output was truncated, VERIFICATION ITSELF must be
re-run fresh OUTSIDE that window — a compat check performed during the
truncated window counts as unverified, not as evidence (2026-09-05 #1398:
compat check in a truncated window missed the subject function was deleted
upstream; restoration shipped E0432, retracted same day).

## Daemon no-reap — ruling 1273 (landed in skill 2026-09-06, brain-scrub F5; law previously only in MEMORY.md)

Ops-unit (`opencrabs-ops`) restarts/reaps ONLY that unit — family and default
daemons are never touched by ops/dev work. Default-profile `opencrabs.service`
running an old binary is EXPECTED, not an incident (ruling 1273, owner).

## telegram_send addressing rule (owner ruling 2026-09-07, telegram_send error audit) — AS-IS law [LANE]

`telegram_send` calls must ALWAYS carry the full id set: explicit `chat_id`
AND explicit `thread_id` (for forum-enabled chats). Never omit either.

- Omission is not a routing mode — it silently falls back to session-origin
  or last-seen-topic memory, which is how the dominant tool failure
  (`Bad Request: message thread not found`, 2026-09-07 audit) happens.
- Source the ids from the `[Channel: Telegram (chat_id, thread_id)]` header
  of the message being replied to; if absent, resolve via `list_topics`
  before sending.
- `thread_id: null` (explicit General) is the only sanctioned way to target
  General; blind omission is not.

## Topic domain alignment & rename authority (owner order 2026-09-10 03:48Z, updated 2026-09-14) [LANE]

- **Topic domain alignment (owner order 2026-09-14):** Factory forum topics are organized around **persistent functional domain subsystems** (e.g. `Telegram: Host & Session Guards`, `Core: Streaming & Loop`, `Memory: Search & Indexing`, `Config: Typings & Writers`, `Upstream: Harvest Fleet`, `Governance: Role Architecture`) rather than ephemeral issue numbers or short-lived task names. Topics serve as dedicated domain centers for issues within that area and cross-area issues touching their domain.
- **Continuous topic alignment:** Auditor (Triage) and HQ actively rename topics whenever a lane's scope shifts or drifts to ensure topics remain strictly connected to their subsystem contents.
- **Rename authority:** Auditor (Triage) and HQ are free to rename chats and forum topics — no owner approval needed. Keep titles descriptive (3–8 words, reflect actual domain/subsystem per the topic domain alignment policy); renames are bookkeeping, not surface-law sends, so this is not an editor carve-out — editors still never touch Telegram tools.

## Tool logging rule (owner 2026-08-28) [LANE]

Every tool/script we build must be debuggable from its logs alone. Each state-changing step writes a timestamped, append-only journal line (input, action, outcome, exit code) to durable storage BEFORE the next step begins — the journal, not memory, is the record. If a crash or restart can leave a run unreconstructable from durable state (journal line + marker file + ledger event), the tool is NOT DONE. Born from the 03:11Z 71e58ce5 swap: the swap succeeded but left zero receipts because the oc-deploy journal vocabulary stops at `dispatch` (no `swap` line type) and the deployed.sha marker was never written — HQ had to reconstruct the audit trail from binary mtimes and artifact shas. Applies to oc-deploy and every future tool. **The oc-deploy journal VOCABULARY (line types, required fields, per-leg rows) is maintained in `s2-swap-journal-spec.md`** — this section carries the RULE, that file carries the vocabulary. 

## CI-wait discipline & actor attribution (owner 2026-08-30 — fix batch) [LANE]

**Canonical Waiter Discipline Standards (W1–W6):**
1. **W1 (Detached execution standard):** Long-running commands (>60s) execute detached (`background: true`). Hand-rolled nohup/sleep loops are strictly forbidden.
2. **W2 (Poll floor & ceiling):** Detached CI watchers must respect a ≥30s poll interval floor and a bounded timeout ceiling (default 2700s via `oc-prchecks wait`).
3. **W3 (Invocation verification):** Verify job dispatch identity before entering wait loops; never poll an ambiguous or unverified run ID.
4. **W4 (Notify wiring):** Automated watchers notify directly to the owning session UUID via `session_notify` upon terminal completion.
5. **W5 (Log-window cuts):** Grep and log queries must bound search ranges (`--since` or fixed tail) to avoid context compaction floods.
6. **W6 (Actor attribution):** automatic via ambient `$OPENCRABS_SESSION_ID` — see §Attribution & Goal Hygiene A1.

## Swap-head signature for rebase/synthesis/merge-derived binaries (owner 2026-09-03 "Land 1+2 only, keep version as-is") [LANE]

Gate 4 (Session-Id trailer, `quick-build-linux.yml` ORDER gates) applies to every swap head. **Rebase, synthesis and merge heads cannot carry trailers**, so a bare (unsigned) head must never be dispatched to the build leg (2026-09-03: bare merge `d02f4e08` passed pr-checks GREEN, swap blocked exit 2 pre-install; fixed forward-only with empty marker `1d0dd4cc`. 2026-09-11: the atomic cutover head `12d25260` hit the same wall — `oc-order-validate: UNSIGNED`, chain rc 6 — and stranded main undeployed until marker `70b04864` was landed). **Every upstream sync produces such a head, so this recurs on every sync.** Standing law:

1. **Marker, not waiver** — the marker-commit procedure (tree-identical empty trailer-signed commit before the build dispatch) lives in upstream-merge-runbook.md **step 9** — this file carries the RULING only: never dispatch a bare (unsigned) head, never loosen gate 4. Owner's swap ruling carries over; the marker changes no bytes.
2. **pr-checks mirrors gate 4 in swap mode** — `pr-checks.yml` (carrier branch `ci/quick-build-linux`, landed `464f77c4`) takes `swap=true`: runs the exact gate-4 regex on the gated ref before fmt/clippy/tests. Swap-mode GREEN ⇒ swappable — the build leg has no remaining semantic failure mode (clippy+tests subsume build success; the binary build itself stays quick-build's job, no duplicate artifact per the 2026-08-31 de-dup ruling). Input-gated: ordinary PR-lane runs unchanged.
3. **Version stays put on merges/swaps** — merge-derived binaries ship with the tree's standing version; `deployed.meta.json` (sha + artifact sha256) is the identity record, not the version string. Owner 2026-09-03: a version bump is a release-flow event, not a merge or swap event.
4. **Trailer retention across history rewrites (v0.4.170, Finding H-1 / row n=2102)** — Rebase, cherry-pick, or filter operations can silently strip `Session-Id` and `Issue-Ref` git trailers. Actors executing history rewrites must verify trailer retention across rebased commits (`git log -n <count> --format='%B' | git interpret-trailers --parse`) before fast-forwarding or pushing. Any commit stripped of its trailer during rebase must have its trailer restored before ff-merge.

## Decision Rollcall — owner-decision sweep, lanes post direct (owner order 2026-09-08 ~06:1xZ, topic 42487, ruling n=1994) [LANE]

A repeatable owner-facing procedure, distinct from the T5 sweep (issue triage)
and Duty-4 (skill input). When the owner says **"run a Decision Rollcall"**:

1. **Content — owner decisions ONLY.** Each lane presents outstanding decisions
   that need the OWNER's word: one decision + the lane's recommendation + one
   line of context each. NO status reports, no "nothing owed" chatter, no
   ledger trivia. The lane knows its own asks best — nobody filters or
   paraphrases them.
2. **Delivery — LANE-DIRECT, THE ONLY MODE.** Each lane posts IN ITS OWN
   LANE TOPIC, addressed to the owner directly. Lanes do NOT route their list
   through Triage or HQ; Triage does not relay, aggregate, or edit. A lane
   with zero outstanding owner decisions posts NOTHING — silence is the
   "nothing owed" signal. **Present-here mode is RETIRED** (owner override
   2026-09-08 09:05Z, topic 30220: "I don't want the decisions to be
   presented in triage lane. Every editor should be instructed to present
   their decisions in their own lane" — superseding the 08:34Z topic-42487
   amendment). Triage NEVER collects or presents decisions on any word;
   decisions NEVER appear in a Triage/HQ message, only in each lane's own
   topic.
3. **Triage role — coverage + stamp, nothing more.** Triage triggers the
   Rollcall on owner word, verifies every holding lane actually posted (or is
   sanctioned-silent: a same-turn lane-targeted chase receipt, or the lane's
   own zero-decision statement on the ledger — a bare non-post is neither),
   and stamps completion in the ledger. (This criterion is the single home;
   triage.md T7 points here.)
4. **Trigger — on demand** ("run a Decision Rollcall"). A cron or post-ship-chain
   hook is possible later; the owner has not ordered one. Do not self-schedule.

**Format law (owner amendment 2026-09-08 ~06:3xZ, topic 30220):**

5. **No acks.** A lane posts its decisions and nothing else — no "Rollcall
   received", no confirmation posts, no receipt chatter. The post IS the ack.
6. **No telegram_send.** Lane posts as its topic's final chat message
   (text auto-posts). `telegram_send` / `send_document` / media calls are
   forbidden in a Rollcall post.
7. **Context + diagrams.** Each decision is presented WITH its context and,
   where the decision has shape (flow, options, architecture), a mermaid
   diagram — the owner judges renderings, not descriptions.
8. **One decision per message.** Present 1 by 1 — sequential posts, never a
   batched wall. Each post: decision + recommendation + context (+ diagram).
9. **Owner gates designs and special cases.** A lane does NOT implement a
   design or a special case on its own recommendation — those await the
   owner's explicit word, same as any semantic gate.

## Inherited-claim three-pillar verification (landed in skill 2026-09-06, brain-scrub F6; previously only in MEMORY.md) [LANE]

When adopting another session's claim (branch, gate, fix): (1) the artifact
exists on disk/remote as claimed, (2) the evidence trail (gate run, job-name
sha pin) is live-verified by the adopting session itself, (3) no newer state
invalidates it (main moved, superseded fix). All three or the claim is
treated as unverified input, not as a receipt.

## HQ does not execute lane work — refuse and reroute (owner order 2026-09-09 ~10:4xZ: "you should refuse work that should be done by the triage lane and tell the requesting lane to reroute") [LANE]

When a lane sends HQ work that belongs to an executing lane — editor-lane fixes/rebases/carrier chains, Triage-lane intake verification, TOOLSMITH tool code — HQ REFUSES execution and tells the requesting lane to reroute to the owning lane (`session_notify` back to sender, one line: refused per HQ-no-execute law, reroute to <owning lane>). HQ executes ONLY: rulings, skill authoring (via the Triage intake channel), verdicts/gates with same-turn receipts, dispatch GOs, and its own duties (Duty 4/6, patrols, board reporting). Origin: the #129 carrier rebase landed on HQ via session-notify and was half-executed before the owner order arrived — lane worktree restored byte-exact, chain rerouted. If ownership is genuinely ambiguous, HQ rules on ownership (that IS HQ work), then reroutes.
