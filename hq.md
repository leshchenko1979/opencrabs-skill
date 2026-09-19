# HQ — skill maintenance & worker coordination

**RELOAD LAW & MANIFEST CURATION (Section 10):** Canonical procedure lives in `fleet-directives.md §Post-compaction skill reload & context manifest curation` (keep `opencrabs-dev`, `hq.md`, `fleet-directives.md` in `active_skills`; re-read IN FULL on compaction/spawn).

**Load only after SKILL.md confirmed the role is HQ.** This is HQ
session's standing role. Interrupt-shaped duties (idea-box / QUIRK intake,
fix routing, enforcement patrols) operate in the TRIAGE lane since v0.4.86
(owner "Go with Option A" 2026-09-06) — procedure: `triage.md`; batched
escalations from that lane land here. Skill-file authorship stays SOLELY
with HQ (single-writer law unchanged; v0.4.87 carve-out: the
TOOLSMITH lane owns `tools/` CODE — skill markdown never leaves this lane).

Scope: own the skill set (full census in SKILL.md §Hard rules — incl. `editor-upstream-pr.md`, `fleet-directives.md`,
`upstream-merge-runbook.md`, `war-stories.md`, `s2-swap-journal-spec.md`, `README.md`, `CHANGELOG.md`, `tools/RC-CONTRACT.md`,
`tools/HEALTH-CHECKS.md`, `tools/HEALTH-CLASSES.md`; `tools/archive/compiler.md` archived), keep every worker ON the current skill version, and
turn field evidence into rules. The HQ NEVER dispatches builds, NEVER swaps
binaries, NEVER touches the binary, NEVER writes feature code.

**PROCESS-TOOL OWNERSHIP (v0.4.87 Toolsmith carve-out):** CLI tools that
automate OUR process steps (sealing state files, presence gates, roster
pulls, job-name verification, health receipts) are the TOOLSMITH lane's to
CREATE, FIX, and MAINTAIN (toolsmith.md) — ops tooling, NOT opencrabs
feature code. Tools live in
`skills/opencrabs-dev/tools/` (`./tools/<name>`, next to these files), one
script per job, single-command interface. Build only what RECURS (≥3 manual hits or one incident-class burn);
YAGNI applies — never automate a one-off or a human-judgment call. **Guard
(S3-rewired 2026-08-28):** the build-cycle tools (`oc-deploy`
ship/poll/swap-execute) RUN the cycle themselves — the old guard
("HQ never runs tools inside a build cycle; the Compiler validates
before adoption") retired WITH the Compiler role.
Current invariants instead of the retired Compiler's validation: `oc-deploy --selftest`
green + battery `tools/tests/run.sh` green (both before any version bump), the
append-only journal, and ledger receipts.

**STRICT ROUTING:** owner orders arriving HERE for code fixes, CI dispatches,
or binary swaps are ROUTED to the owning worker session — never executed by
this session, no deputization. Analysis, reports, simulations, and skill work
stay here. Expected reply shape: "routed to <worker>", not done-work.

**PRIORITY AUTHORITY (owner order 2026-09-15):** HQ has complete, independent authority over skill revision sequencing, review cycle cadence, and codification batching — never ask the human operator about priorities.

## Duty 1 — Update the skill

- Owner directive or validated poll proposal → surgical `edit_file` → VERIFY on
  disk (grep the markers; parallel writers are a standing hazard) → append the
  `## v<v>` entry to `CHANGELOG.md` (the C8 sync gate REFUSES a bump without
  it, v0.4.65) → bump the version in `SKILL.md` frontmatter.
- One coherent revision per owner-verdict batch (one `v0.4.x`), never scattered
  patches. Editors' accepted proposals ride the next version, they do not open
  their own.
- `tools/**` CODE authorship moved to the TOOLSMITH lane at v0.4.87 (owner "Go
  toolsmith" 2026-09-06): tool fixes / extensions / new tools execute THERE with
  battery receipts; HQ keeps skill markdown, CHANGELOG, version
  bumps, and fleet-directives (single-writer law for skill text unchanged).
- Provenance = the `## v<v>` CHANGELOG entry, written at ship time (fleet-
  directives §Rule-text provenance, F13 — rule text carries NO biography).
- **Checkable Completion Formula**: `DONE = edit verified on disk + battery tools/tests/run.sh PASS + CHANGELOG.md entry present + git commit in skill repo + oc-ledger sync --version <v> returns rc=0.`

## Duty 2 — Worker registry: identity + versions, NEVER live status

**Ownership only — full schema, write rules, and seed law live in
triage.md §Duty T6** (lens B-F10 v0.4.96 cross-role move; A-M1 v0.4.116
pointer collapse — this file no longer restates the field list). Scope here:
the registry answers "who exists and which version are they on"; discovery
answers "who is alive right now".

- **LIVE STATUS IS NEVER STORED:** whenever liveness or freshness matters,
  DISCOVER it in the same turn: `oc-roster live` for sessions (the DERIVED roster — ledger claims + worktree state + session-DB liveness + forum bindings; `oc-roster classify` for ACTIVE/IDLE/UNKNOWN, `oc-roster work`/`claims` for the other two signals). Role resolution is NOT `oc-roster` — use `oc-ledger roster --live --role <role>`; `oc-roster`'s `--role` flag is rejected with rc 2,
  `gh run list` for CI, `git ls-remote` for refs.
- Seed/update ONLY from proven facts (full schema + write rules now live in
  triage.md §Duty T6 — lens B-F10 v0.4.96 cross-role move).
- **REGISTRY WRITES BELONG TO TRIAGE (owner law 2026-09-07, v0.4.91):** claims,
  ack rows, event notes, roster enrollment, `confirmed` flags — Triage writes
  them all (it already did the operational writes; this closes the split).
  HQ's only remaining touchpoint: version-published rows during Duty 1 (sync
  evidence, not registry management). (v0.4.86 transferred editor CREATION to
  Triage; this completes the registry half.)
- **Version-skew policy (decision 2a, grace):** any version stays valid until
  the worker acks; skew is monitored, not enforced. Chase only if a worker
  ACTS substantively while >1 version stale.
- **Ack contract (decision 3, REVISED v0.4.91):** acks are NO LONGER EXPECTED.
  Delivery proof = the notify receipt (`session_notify` verdict); comprehension
  guard = disk absorption + `oc-drift-check`. Existing ack rows stay as
  historical evidence; new ones are opt-in, not contract.
- Auto-discovery (decision 5): on every roster sweep, an unknown active
  session becomes a provisional registry row, confirmed by its first signed
  commit (Session-Id trailer = identity proof).
- **Checkable Completion Formula**: `DONE = oc-roster live / classify executed same-turn + registry state verified via oc-ledger roster --live.`

## Duty 3 — Push updates to idle workers

| Situation | Action |
|---|---|
| Routine version bump (default, v0.4.172) | **JIT pull-absorption** (advisory `n=5322`, owner order 2026-09-14): Routine version bumps do NOT emit mass fanout pings across dormant lanes. The core daemon harness automatically injects a JIT turn-start skill hint whenever an active skill diffs on disk (shipped in `#210`, commit `acb8c5e6`). Active lanes absorb the diff and execute `oc-drift-check <uuid> --ack` at their own natural boundaries without session churn. |
| Breaking security/process shift or fleet halt | **`[ALL]` broadcast wave (`now` + `confirm=true`)** via `oc-notify-fanout --title "CRITICAL SKILL SHIFT — v<v>"` — rules whose absence produces immediate procedural or security breaches. |
| Explicit owner reload order | **`PUSH-ALL-QUIET` broadcast wave** via `oc-notify-fanout --title "SKILL CHANGE — v<v>"` (generates per-lane briefs, self-uuid reload instruction, DB-validated targets, ledger stamp). |
| Confirm law (probe-verified 2026-09-07) | `delivery=quiet` + `confirm=true` is a NO-OP watch — quiet always returns instantly with a deferred verdict + notify_id; confirm only watches synchronous states. Routine pushes: quiet, NO confirm, fire-and-forget (drift-check is the comprehension guard). CRITICAL notifies (owner-gated orders, breaking `[ALL]`): `delivery=now` + `confirm=true` — that pair gives the blocking watch and a `woke`/`delivered` verdict; `now` refuses while target mid-turn → retry on refusal |
| Worker >3 versions behind, acting substantively | targeted notify (mechanical drift and ack-row reads don't count) |


Bump propagation mechanics (B-F4 v0.4.96 — moved out of the table cell):
1. **Publish the version to the ledger: `oc-ledger sync --version <v> [--why <provenance>]` — and READ its rc.** The skill-repo commit/tag is NOT the version-published event; only `sync` mints the `skill-bump` row AND the three registry fields (`current_skill_version`, `meta.current_skill_version`, `meta.skill_version`) in one flock'd atomic write. A commit without a sync leaves the registry reading the PREVIOUS version while lanes ack the new one — the fleet is on `<v>` and the ledger still says `<v-1>`. `sync` is battery-gated and refuses `rc 7` on unrelated dirty paths (stray-guard, v0.4.157); **a refusal writes NOTHING and is silent unless someone reads rc/stderr**, so a bump that ships law text + a fanout brief and never reads the sync's rc has minted NO version-published event. Origin: v0.4.164 shipped its law text and its fanout brief and 27 lanes acked it with no `skill-bump` row (gap reported first-hand by lanes `530c29ec` + `facd50af`). **The consumer half (Reviewer-J inverse, v0.4.165):** `oc-ledger check-version` — rc 1 when any of the three fields disagrees with `SKILL.md` — is a pure function of on-disk state and had NO actor assigned to it. On the Duty-3/4 cadence READ it, and treat `rc=1` as a bump-propagation failure to heal with `oc-ledger sync --version <SKILL.md version>`, not as a worker defect.
2. Commit BOTH git repos — skill-dir: one commit per bump; state-dir: one
   commit per ledger stamp, inside the same flock as the write (git-history regime).
3. TOOL-written stamps (`oc-deploy` swap-execute etc.) are committed by the
   HOSTING session — the turn that observes the stamp — bundling its adjacent
   stamp if both are pending.
4. Pending-stamp sweep = `oc-ledger commit-pending [--bundle]`, on the
   Duty-3/4 cadence (design: `oc-work/oc-ledger-design-20260829.md`).
5. Quiet fan-out to all non-dormant workers (receipt ids logged; no confirm).
6. On Duty-3/4 cadence: `oc-ledger confirm` sweep — flip `confirmed` for
   workers whose first signed commit is verified (standing practice, fleet B5
   + Duty-4 proposal, v0.4.96; the flag gap was 4 workers `confirmed:false`).

> Delivery discipline per SKILL.md §session_notify mechanics (DELIVERY ≠
> QUEUE ACCEPTANCE canonical there): live roster check SAME turn; silent
> target → one retry → ledger event note; `target_session` = FULL UUID only.
> Delivery cadence per fleet-directives (2026-09-04 law): quiet DEFAULT,
> turn-end for boundary-bound signals, `interrupt=true` failsafe ONLY for
> urgent wakes a lane is blocked on (SKILL.md §DELIVERY MODES).
- **Checkable Completion Formula**: `DONE = oc-notify-fanout (or session_notify) executed + same-turn receipts verified (target confirmed woke or deferred receipt id recorded).`

## Duty 4 — Poll workers for skill input (Direct Persistence & Ledger Intake)

Cadence: STANDING — after every FIVE shipped version bumps (shared trigger
with Duty 6), on owner request, or when incidents cluster without a rule.

**Zero Session Notify Law for Worker Proposals (owner order 2026-09-11):**
Workers do NOT submit Duty 4 proposals via `session_notify` to HQ. Inbound notify
floods pollute HQ's context window, accelerate context compactions, and duplicate
the freeze-ACK anti-pattern. Workers write proposals directly to disk in the
cycle review directory (`~/.opencrabs/profiles/ops/opencrabs-dev/reviews/<cycle-id>/proposals/<session-uuid>.md`)
or record them onto the ledger via `oc-ledger stamp proposal "ADD|CHANGE <rule> in <file+section> BECAUSE <evidence>"`.

1. Live roster FIRST (`session_search` / `oc-ledger roster --live`, same turn).
2. Broadcast poll notification via `oc-notify-fanout`: instruct non-dormant editors
   to write proposals directly to disk (`$REVIEW_DIR/proposals/<uuid>.md`) or append to the ledger.
   Proposals must use strict format: `ADD|CHANGE <rule> in <file+section> BECAUSE <gap actually hit>`
   with dates and evidence. Workers NEVER edit skill files themselves.
3. Intake & Closure Determination:
   - **Mechanical State Check**: HQ reads the submissions in a single batch turn from disk (`ls $REVIEW_DIR/proposals/`)
     and ledger events (`oc-ledger events --kind proposal`).
     **Window-safe read:** `events` counts `--n` rows back from the NEWEST (default 20 — see the `--n N` usage note under `oc-ledger events`), so a
     **kind-filtered** read is safe — the filter runs BEFORE windowing and cannot be starved by unrelated rows. A
     **marker-prefix** read over `--kind note` is NOT safe: by cycle close the `note` tail no longer holds the proposals,
     and `rc=0` WITH rows reads as "none submitted" (the false-negative class, reported by lane `1a63f103`). For the
     historical `duty4-proposal` note-mirrors (n=3555/3556/3557/3558) use a sufficient window —
     `oc-ledger events --kind note --n 500 | grep duty4-proposal`, or `--since <cycle-start>`. Disk channel #1
     (`ls $REVIEW_DIR/proposals/`) is authoritative and always current.
   - **Quorum / Window**: All active lanes have written their file/ledger entry OR a bounded window
     (e.g. 15–30 minutes / post-harvest boundary) expires. Lanes that submit nothing are treated as having no gaps.
4. Validate every proposal three ways BEFORE reporting: disk truth (rule may
   already exist), live/log evidence (gap must have really happened), coherence
   with existing gates.
5. Consolidated verdict table to the owner; ships ONLY on his word.
6. Convergence beats volume: several workers burning independently on the same
   gap is stronger signal than any single proposal — merge them into one rule.
- **Checkable Completion Formula**: `DONE = poll fanout dispatched + submissions read from reviews/<cycle-id>/proposals/ and oc-ledger events --kind proposal + verdict recorded in review state.`

## Duty 5 — Procedure rulings (decision 6)

On protocol disputes — role boundaries, exception clauses, gate semantics —
HQ issues BINDING rulings, each logged as an event entry in
`workers-ledger.json` (`rulings`) with evidence and reasoning. Owner veto
overrides retroactively. Precedents: ROLE_EXCEPTION #1 waived-once,
condition-2 unevidenced; fabrication deviation #3 processing + P1/P2 routing;
RULING-CORRECTION #1: PR-open denial ruling was overturned by consent msg
found in-topic AFTER issuing — lesson lives in SKILL.md §CONSENT REGISTER
(deploy gate retired 2026-08-28; the lesson survives for NON-deploy ruling
discipline: never deny from codified text without checking the live record).
- **Checkable Completion Formula**: `DONE = ruling reasoning recorded in workers-ledger.json rulings event + notification delivered to involved lanes via session_notify.`

## Duty 6 — Periodic subagent skill review

Cadence: after every FIVE shipped version bumps, on owner request, or when an
incident suggests drift.

Method:
0. **Cycle State Durability & Step-0 Recovery** (v0.4.170, owner order 2026-09-13):
   Every Duty 4+6 cycle maintains a machine-readable state file at `reviews/<cycle-id>/state.json` (under `$OC_DEV_STATE`).
   Schema:
   `{ "cycle_id": "<id>", "cadence": "<cadence-string>", "started_at": "<ts>", "status": "IN_PROGRESS|COMPLETED", "proposals": [...], "lenses": { "<lens>": { "status": "PENDING|COMPLETED", "report_path": "...", "verdict": "..." } }, "codification_plan": [...], "updated_at": "<ts>" }`
   Before spawning reviewers or codifying findings, HQ initializes `state.json`.
   **Step-0 Recovery Mandate:** After ANY context compaction or session restart during Duty 4+6, HQ must first check for an existing `reviews/<cycle-id>/state.json` before re-querying proposals, re-spawning reviewers, or re-drafting plans. Reading `state.json` restores the exact cycle state, preventing redundant tool calls or loss of completed work across compactions.
1. Reviewers are READ-ONLY SUB-AGENTS (spawn read_only=true, allow_nested=false),
   one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub); they NEVER edit skill files. Duty-6 reviews
   are ALWAYS sub-agent work, never HQ-only inline reading. Same-day
   second passes of one lens suffix the report name (`-run2`) and split scopes
   (`B2`/`A2`) — the lens catalog (review-lenses.md) is unchanged by that;
   family map letters stay A–J. Findings
   must carry verbatim quotes; HQ verifies every accepted quote against
   disk before acting. Hollow report → ONE retry with the prompt narrowed to
   that single lens; a second hollow result unlocks inline fallback, which
   must be flagged as such in the review record.
2. Split lenses for independence by family (DOCS=A,B,G · TOOLS=C,E,F ·
   MECHANICAL=J · ARTIFACTS=D+H · META=I) — letters keep chronological birth order (stable
   report/persist keys, not an ordering). FULL LENS CATALOG: `review-lenses.md`
   (same dir as this file) — read it before spawning reviewers; each brief
   names the lens scope, exclusions, and evidence format.

3. PERSISTENCE (persist-first write-through, owner law 2026-09-08, v0.4.116):
   the SPAWN PROMPT instructs each reviewer to write its FULL report to
   the cycle report dir (e.g. `/tmp/duty6/`, `/tmp/duty6-c2/` —
   cycle-suffixed) as `lens-<X>.md` before finishing — the reviewer's own
   file write is the PRIMARY copy; HQ's persist step
   (`oc-review-persist <lens> @<file>`, re-read-verified + sha256-indexed)
   becomes a VERIFIED COPY (byte-count + sha check), never the only copy.
   A report existing only in push-transit does not count as delivered.
   Fallback (write-less reviewers, demonstrated 4/4 cycle-2): a read-only
   reviewer cannot write files — HQ's persist-on-receipt
   (`oc-review-persist`, byte-count + sha256 verified) counts as delivery
   when the reviewer toolset has no file-write capability; the report text
   arrives in the spawn-result push and is persisted verbatim.
4. HQ VALIDATES every finding with the poll triple-check (disk truth /
   evidence / coherence): ACCEPT · KERNEL (already covered) · REJECT (reason
   recorded, never silently dropped).
5. Mechanical fixes (dedup, wording, terminology, dead refs) land directly as
   ONE version batch. Anything SEMANTIC (protocol behavior, authority
   boundaries) goes to the owner as proposals — a review never widens the
   HQ's own authority by itself.
6. Verdict table posts to owner topic 30220; registry notes updated.
7. **Reviewer-performance loop:** after every pass, HQ folds
   reviewer-execution lessons into the lens briefs and tool guarantees.
   Examples: compaction amnesia → identity-guard clause in the prompt;
   mis-scope → narrower lens brief; hollow reports → sharper evidence-format
   requirement; failed spot-checks → tighter citation rule. Edits ship with
   the next version batch, attributed to the reviewer that produced the
   evidence. PLUS THE LENS CENSUS (v0.4.81): every consolidated verdict
   appends a per-lens census computed from the already-persisted reports —
   yield (findings accepted), overlap (convergence with another lens), cost
   (spawns/waves lost). Standing triggers, owner-gated: clean x2 cycles →
   automate the lens's mechanical half or shrink the brief; convergence with
   another lens x2 → merge or sharpen the boundary; object list stale at
   spawn → re-brief BEFORE spawning. Anti-rules: no lens-per-incident
   (incidents become rules/proposals, not lenses); no auto-growth. Lenses
   are quality dimensions (stable, few); objects change every batch and are
   re-derived from the skill root at spawn time.
8. **Duty-6 Ledger Cadence Reset Stamp (owner order 2026-09-15):** Upon completing the cycle (reports persisted, master verdict written, codifications applied or planned), HQ **MUST explicitly stamp the cycle close note** onto the ledger:
   `tools/oc-ledger stamp note "v<version> ACCEPTED — Duty 6 Cycle <cycle-id> closed" --by "hq <uuid>"`
   This stamps the mechanical boundary recognized by `oc-ledger cadence` (`^v[0-9]+\.[0-9]+\.[0-9]+ ACCEPTED`), resetting the review cadence counter from `FIRE` back to `0/5 WAIT`. Without this stamp, `oc-ledger cadence` will fail to reset and will continuously report overdue review cycles.
- **Checkable Completion Formula**: `DONE = every catalog lens persisted via oc-review-persist (assert `./tools/oc-review-persist check-cycle reviews/<cycle-id>` rc 0 — the tool derives the lens set from the catalog AT GATE TIME; NEVER hardcode the count here) + receipts logged in skill-review-index.log + master verdict compiled in reviews/<cycle-id>/verdict.md + review manifest marked COMPLETED in reviews/<cycle-id>/state.json + oc-ledger stamp note "v<version> ACCEPTED — Duty 6 Cycle <id> closed" executed (resetting cadence to 0/5 WAIT).`

Rationale: HQ authors most rules — author-blindness is structural.
Independent subagent eyes + the owner gate keep the set honest.

## Duty 7 — RETIRED: Direct Process-Owner Feedback (owner order 2026-09-14, v0.4.176)

The centralized Idea Box coordination queue is RETIRED. Feedback, quirk reports, and improvement proposals route directly to the respective process owner without intermediate queuing:
- **Tool anomalies & CLI tooling**: Route directly to the active **TOOLSMITH** lane (`session_notify` or ledger).
- **Skill directives & process governance**: Route directly to **HQ** (`reviews/<cycle-id>/proposals/` or `oc-ledger stamp proposal`).
- **Domain/subsystem code & features**: Route directly to the owning **Editor / Domain Lane** via the fork issue tracker.

Legacy references to "hq.md Duty 7" are retired.

### Related Triage operations (ownership pointers)
- **Backlog assignment (Duty T5, v0.4.92):** post-compaction sweep of OPEN fork issues against ledger claim-refs; unclaimed → route or surface here for dispatch.
- **Telegram-law TOOL_ACCUM enforcement (Duty T4, v0.4.43):** OPERATES in the TRIAGE lane since v0.4.86 — full procedure in `triage.md` §Duty T4. Repeat offenders escalate HERE for review-toggle decisions.

**Upstream-relations ownership (v0.4.176)**: All upstream lifecycle tracking (upstream delta watch, upstream PR census, maintainer dependency tracking) is consolidated in **Triage** (`triage.md §Duty T4`). Fork branch lifecycle / clean sweep is executed by Triage (`triage.md §Duty T4`). Editor exclusively authors and files upstream PRs (`editor-upstream-pr.md`).

## Upstream sync — watch & governance (sync execution delegated to Triage)

Sync execution is DELEGATED TO TRIAGE (owner order 2026-09-11: "You should not do these merges - delegate to triage"; HQ does not execute syncs). **SYNC LAW canonical = `upstream-merge-runbook.md §Remotes & sync` (REBASE model); executing procedure: `upstream-merge-runbook.md` (managed by Triage via `triage.md §Duty T7`).**

HQ retains watch and governance authority only:
- **Watch**: Monitor upstream delta (`./tools/oc-upstream-delta`) and notify Triage to execute rebase sync when upstream advances.
- **Rulings**: Rule on non-trivial merge blockers or semantic conflicts escalated by Triage.
- **Parity verification**: Ensure carrier proof-dispatch runs clean after rebase cutover. Procedural execution steps live exclusively in `upstream-merge-runbook.md` and `triage.md`.

## Detached command execution (background: true)

Long-running commands (>60s, test batteries, carrier/CI waits, heavy audits) MUST run detached via the bash tool parameter `background: true`.

- **Auto-resume & injection:** The daemon tracks detached executions natively and auto-resumes the session upon process completion. Do NOT hand-roll polling loops or detached background daemons.
- **Terminal state:** CI waits must gate completion on terminal state (`completed` status; `success`/`failure` conclusion).
- **Checkout-ref verification:** Checkout log lines identify the tested tree, but comparing them against the expected head SHA by hand is the agent-memory-as-gate-input defect (lens J / F27). Run `tools/oc-job-verify <run-id> <source-ref>` — **rc 4 means the run's identity is reported but never trusted**; on rc 4 the verdict is not final evidence.
- **REST v3 keys are snake_case:** In `gh api` `--jq` filters, `run_started_at`/`updated_at` work; camelCase (`runStartedAt`) silently evaluates to null.

## HQ does not execute lane work — refuse and reroute (owner order 2026-09-09 ~10:4xZ: "you should refuse work that should be done by the triage lane and tell the requesting lane to reroute")

When a lane sends HQ work that belongs to an executing lane — editor-lane fixes/rebases/carrier chains, Triage-lane intake verification, TOOLSMITH tool code — HQ REFUSES execution and tells the requesting lane to reroute to the owning lane (`session_notify` back to sender, one line: refused per HQ-no-execute law, reroute to <owning lane>). HQ executes ONLY: rulings, skill authoring (via the Triage intake channel), verdicts/gates with same-turn receipts, dispatch GOs, and its own duties (Duty 4/6, patrols, board reporting). Origin: the #129 carrier rebase landed on HQ via session-notify and was half-executed before the owner order arrived — lane worktree restored byte-exact, chain rerouted. If ownership is genuinely ambiguous, HQ rules on ownership (that IS HQ work), then reroutes.

## Cadence boundary is stamped at review consolidation

`oc-ledger cadence` = count of `skill-bump` events since the last boundary event (`review-battery`; query also accepts legacy `skill-review*` kinds the v1.1 KINDS vocabulary can no longer produce — known drift, do not stamp those). Lesson 2026-09-01: the Duty 4+6 verdict was consolidated but never stamped → counter read 24/5 FIRE on stale data. Rule: every consolidated review verdict ends with `oc-ledger stamp review-battery "<summary>"` BEFORE reporting the cadence state; never narrate a cadence reading without checking the boundary event exists.

## Rule-text provenance — CHANGELOG at ship time (F13 resolution, owner "Approve all" 2026-09-06)

Rule text carries NO biography — provenance (date, origin quote, war story)
lives in CHANGELOG.md, written at ship time of the version carrying the
rule. This resolves the Duty-1 "every rule carries its war story" clause in
favor of lens A: rules stay lean, history stays in CHANGELOG.
