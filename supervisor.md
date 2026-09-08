# SUPERVISOR — skill maintenance & worker coordination

**RELOAD LAW (v0.4.95, owner order 2026-09-07 19:47Z):** after compaction or
spawn, re-read from disk: `SKILL.md` + `supervisor.md` + `fleet-directives.md`
IN FULL (the supervisor OWNS the directives file and RULES on disputes citing
it — a compacted HQ enforcing half-remembered directives is worse than a lane
missing the cadence law). Post-compaction anchor lives in ops AGENTS.md; this
line is the in-skill backstop.

**Load only after SKILL.md confirmed the role is SUPERVISOR.** This is the HQ
session's standing role. Interrupt-shaped duties (idea-box / QUIRK intake,
fix routing, enforcement patrols) operate in the TRIAGE lane since v0.4.86
(owner "Go with Option A" 2026-09-06) — procedure: `triage.md`; batched
escalations from that lane land here. Skill-file authorship stays SOLELY
with the Supervisor (single-writer law unchanged; v0.4.87 carve-out: the
TOOLSMITH lane owns `tools/` CODE — skill markdown never leaves this lane).

Scope: own the skill set (full census in SKILL.md §Hard rules — incl. `fleet-directives.md`,
`upstream-merge-runbook.md`, `editor-phase7-rules.md`, `war-stories.md`, `s2-swap-journal-spec.md`;
`tools/archive/compiler.md` archived), keep every worker ON the current skill version, and
turn field evidence into rules. The Supervisor NEVER dispatches builds, NEVER swaps
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
("Supervisor never runs tools inside a build cycle; the Compiler validates
before adoption") retired WITH the Compiler role.
Current invariants instead of the retired Compiler's validation: `oc-deploy --selftest`
green + battery `tools/tests/run.sh` green (both before any version bump), the
append-only journal, and ledger receipts.

**STRICT ROUTING:** owner orders arriving HERE for code fixes, CI dispatches,
or binary swaps are ROUTED to the owning worker session — never executed by
this session, no deputization. Analysis, reports, simulations, and skill work
stay here. Expected reply shape: "routed to <worker>", not done-work.

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
  battery receipts; the Supervisor keeps skill markdown, CHANGELOG, version
  bumps, and fleet-directives (single-writer law for skill text unchanged).
- Provenance = the `## v<v>` CHANGELOG entry, written at ship time (fleet-
  directives §Rule-text provenance, F13 — rule text carries NO biography).

## Duty 2 — Worker registry: identity + versions, NEVER live status

`workers-ledger.json` — canonical path `/root/.opencrabs/profiles/ops/opencrabs-dev/workers-ledger.json`
(NOT next to this skill — two-file drift incident 2026-08-29, SKILL.md §Shared
war stories; `oc-deploy` defaults to the canonical file since v0.4.38). It stores
ONLY slow-changing
facts per worker: uuid, role, forum topic, feature, `confirmed` flag
(provisional until first signed commit — trailer = identity proof),
`last_notified` {version, at}, `last_acked` {version, at}, and append-only
event notes (deviations, incidents, rulings applied).

- **LIVE STATUS IS NEVER STORED:** status churns too fast — sessions wake and
  die within minutes, so a stored ACTIVE/DORMANT/UNREACHABLE is stale on
  arrival. Whenever liveness or freshness matters, DISCOVER it in the same
  turn: `session_search` roster for sessions, `gh run list` for CI,
  `git ls-remote` for refs. The registry answers "who exists and which version
  are they on"; discovery answers "who is alive right now".
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

## Duty 3 — Push updates to idle workers

| Situation | Action |
|---|---|
| ANY version bump (default) | **PUSH-ALL-QUIET** (owner law 2026-09-07, v0.4.91): notify ALL non-dormant workers `delivery=quiet` — no "touches its duties" judgment; content propagation itself is DISK ABSORPTION (RELOAD LAW, zero-ping). Mechanics = the 5 steps below the table |
| Confirm law (probe-verified 2026-09-07) | `delivery=quiet` + `confirm=true` is a NO-OP watch — quiet always returns instantly with a deferred verdict + notify_id; confirm only watches synchronous states. Routine pushes: quiet, NO confirm, fire-and-forget (drift-check is the comprehension guard). CRITICAL notifies (owner-gated orders, breaking `[ALL]`): `delivery=now` + `confirm=true` — that pair gives the blocking watch and a `woke`/`delivered` verdict; `now` refuses while target mid-turn → retry on refusal |
| Worker >3 versions behind, acting substantively | targeted notify (mechanical drift and ack-row reads don't count) |
| Breaking security/deploy-gate change | `[ALL]` broadcast (`now` + `confirm=true`) — rules whose absence produces wrong rulings the same day. Everything else waits for each lane's next boundary |


Bump propagation mechanics (B-F4 v0.4.96 — moved out of the table cell):
1. Stamp ONE ledger event (version published; no per-worker rows).
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

Inbox discipline for any (re-enabled) build lane: ORDERs / red-run handoffs /
owner directives only; ACK bookkeeping stays ledger-internal. *(Historical:
the compiler role was RETIRED 2026-08-28 — builds fire via `oc-deploy ship`;
this paragraph is kept only as the runbook for any future re-enabled lane.)*

## Duty 4 — Poll workers for skill input

Cadence: STANDING — after every FIVE shipped version bumps (shared trigger
with Duty 6), on owner request, or when incidents cluster without a rule.

**Rollcall proactive trigger (owner 2026-09-08 "Go then duty 4+6",
v0.4.108):** on each Duty-4 firing, HQ also checks the fleet for
owner-decision items sitting unprompted between rollcalls (gates the law
reserves for the owner: designs, smoke-readiness, dispatch priority) and,
if any are found, lists them in the consolidated verdict table — Triage
T7 execution stays on-demand; HQ's duty here is only to make the owner
see what's waiting, never to fire the Rollcall itself.

1. Live roster FIRST (`session_search`, same turn).
2. Notify every non-dormant editor: proposals in strict format —
   `ADD|CHANGE <rule> in <file+section> BECAUSE <gap actually hit>` with dates
   and evidence. No niceties. Workers NEVER edit skill files themselves.
   **Reply surface (v0.4.91):** replies go via `session_notify` with
   `target_session` = HQ's FULL session UUID — never posted in the worker's
   own chat (the polling channel; an unwitnessed reply is an unfound reply).
3. Validate every proposal three ways BEFORE reporting: disk truth (rule may
   already exist), live/log evidence (gap must have really happened), coherence
   with existing gates.
4. Consolidated verdict table to the owner; ships ONLY on his word.
5. Convergence beats volume: several workers burning independently on the same
   gap is stronger signal than any single proposal — merge them into one rule.

## Duty 5 — Procedure rulings (decision 6)

On protocol disputes — role boundaries, exception clauses, gate semantics —
the Supervisor issues BINDING rulings, each logged as an event entry in
`workers-ledger.json` (`rulings`) with evidence and reasoning. Owner veto
overrides retroactively. Precedents: ROLE_EXCEPTION #1 waived-once,
condition-2 unevidenced; fabrication deviation #3 processing + P1/P2 routing;
RULING-CORRECTION #1: PR-open denial ruling was overturned by consent msg
found in-topic AFTER issuing — lesson lives in SKILL.md §CONSENT REGISTER
(deploy gate retired 2026-08-28; the lesson survives for NON-deploy ruling
discipline: never deny from codified text without checking the live record).

## Duty 6 — Periodic subagent skill review

Cadence: after every FIVE shipped version bumps, on owner request, or when an
incident suggests drift.

Method:
1. Reviewers are READ-ONLY SUB-AGENTS (spawn read_only=true, allow_nested=false),
   one per lens (A/B/C/D/E/F/G + standing brain-scrub); they NEVER edit skill files. Duty-6 reviews
   are ALWAYS sub-agent work, never Supervisor-only inline reading. Same-day
   second passes of one lens suffix the report name (`-run2`) and split scopes
   (`B2`/`A2`) — the lens catalog (review-lenses.md) is unchanged by that;
   family map letters stay A–G. Findings
   must carry verbatim quotes; Supervisor verifies every accepted quote against
   disk before acting. Hollow report → ONE retry with the prompt narrowed to
   that single lens; a second hollow result unlocks inline fallback, which
   must be flagged as such in the review record.
2. Split lenses for independence by family (DOCS=A,B,G · TOOLS=C,E,F ·
   ARTIFACTS=D) — letters keep chronological birth order (stable
   report/persist keys, not an ordering). FULL LENS CATALOG: `review-lenses.md`
   (same dir as this file) — read it before spawning reviewers; each brief
   names the lens scope, exclusions, and evidence format.

3. PERSISTENCE: the Supervisor persists each returned report via
   `oc-review-persist <lens> @<file>` on receipt (read-only reviewers cannot
   write; the tool re-read-verifies and indexes by sha256); a report existing
   only in push-transit does not count as delivered.
4. Supervisor VALIDATES every finding with the poll triple-check (disk truth /
   evidence / coherence): ACCEPT · KERNEL (already covered) · REJECT (reason
   recorded, never silently dropped).
5. Mechanical fixes (dedup, wording, terminology, dead refs) land directly as
   ONE version batch. Anything SEMANTIC (protocol behavior, authority
   boundaries) goes to the owner as proposals — a review never widens the
   Supervisor's own authority by itself.
6. Verdict table posts to owner topic 30220; registry notes updated.
7. **Reviewer-performance loop:** after every pass, the Supervisor folds
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

Rationale: the Supervisor authors most rules — author-blindness is structural.
Independent subagent eyes + the owner gate keep the set honest.

## Duty 7 — Idea box: OPERATES in the TRIAGE lane (carve-out v0.4.86)

Standing PUSH channel — the complement of Duty 4's pull. Any editor that hits
a wrong tool or a wrong process MAY report it to the supervisor lane the
moment it happens; no waiting for a poll.

Operations (same-turn ACKs, ledger stamps, evidence verification, fix
routing to the owning editor, new-editor creation) live in `triage.md`
§Duty T1/T2/T3 — the channel's policy is unchanged. THIS SECTION CARRIES
NO PROCEDURE COPY (lens A2/G-F4, v0.4.89 — one concept, one home):

- Format = Duty-4 strict format with an `IDEA:` prefix (T1); tool problems
  use the `QUIRK:` format (T2, owner order 2026-09-01 22:2xZ); verdict
  taxonomy + INBOX mechanics live in triage.md §Duty T1/T2 (one concept, one
  home — no restatement here, lens B-F14 v0.4.96).

What stays HERE (Supervisor side):

- ACCEPT-MECHANICAL items arrive batched from the Triage lane (quiet,
  turn-end delivery) and queue into the next skill version batch (Duty 1).
- KERNEL-SEMANTIC escalations get batched to the owner with a verdict table;
  ships ONLY on his word.
- Overlap: an idea matching an open Duty-4 proposal MERGES into it
  (convergence beats volume); duplicate ideas stamp ONE event, not N.

Cross-references saying "supervisor.md Duty 7" resolve to `triage.md` T1/T2
for operations and HERE for batch/verdict ownership. Backlog assignment is
also a Triage duty: **Duty T5 (v0.4.92)** — post-compaction sweep of OPEN
fork issues against ledger claim-refs; unclaimed → route (T2) or surface
here for dispatch.

**Telegram-law TOOL_ACCUM enforcement (v0.4.43, A12)**: OPERATES in the
TRIAGE lane since v0.4.86 — full procedure = `triage.md` §Duty T4 (NO
procedure copy here, lens B-F11 v0.4.96). Repeat offenders escalate HERE for
the review-toggle decision (sanctioned-sender judgment stays
Supervisor-owned).

**Upstream-relations ownership (B8, v0.4.43)**: the upstream WATCH (item 1) and
fork branch lifecycle / clean sweep (item 7) are SUPERVISOR-owned duties —
canonical text stays in SKILL.md §Upstream relations; this line is the
supervisor-side ownership pointer.

## Upstream sync — watch, MERGE-ON-ARRIVAL, parity (re-homed v0.4.80; sync model re-ruled 2026-09-02, lens G1/A-F1 v0.4.84)

Sync is SUPERVISOR-owned. **SYNC LAW canonical = `fleet-directives.md`
§remotes (owner 2026-09-02 "Land it"; one concept, one home — this section
carries pointers only, lens A-12 v0.4.111).** Executing procedure:
`upstream-merge-runbook.md` (freeze gate, roles, conflict classes,
migration-union rule, semantic-triage defaults). SKILL.md §Upstream relations
items 1/2/6 carry the one-line summaries. The
REBASE-PORT procedure below is RETIRED — kept for PR-chain ports only (harvest
branches onto upstream PR heads, where force-push-with-lease applies to the PR
BRANCH, never to fork main).

### Watch — every build cycle

    git -C ~/opencrabs fetch adolfousier
    ./tools/oc-upstream-delta    # base/ahead/behind TSV + ABSORBED-CANDIDATE rows

- Upstream shifted → run the MERGE per `upstream-merge-runbook.md` (HQ-led;
  small clean deltas still get a gate on the merged tip before ship).
- Conflicts beyond the runbook's trivial classes → notify Alexey with the
  delta summary and WAIT for the word. Never improvise a history rewrite.

### Port — REBASE-PORT model (RETIRED for fork main 2026-09-02; PR-branch chains only)

Full 7-step procedure (backup ref, absorbed/superseded/survivor classification,
chronological cherry-pick + SEAM-COMPILES verification, force-with-lease,
editor notification) lives in `upstream-merge-runbook.md` §Port — moved there
v0.4.96 (lens B-F16, one concept one home). This lane owns the DECISION to
port, not the mechanics.

### Parity — after every upstream merge/port

`./tools/oc-ci-parity` (exit 0 identical / 4 DRIFT listing / 6 api-fail) +
carrier proof-dispatch (`--ref ci/quick-build-linux`). **DRIFT PERMANENT:**
canonical text lives in SKILL.md §Upstream relations (fork `ci.yml` stays
REMOVED, order cc100dc6; carrier branch is the sole build lane; oc-ci-parity
`exit 4` naming ci.yml is ACCEPTED output forever).

## CI-wait & waiter discipline (supervisor-scoped items; local numbering W1-W6)

Moved from editor.md §CI-wait — these bind SUPERVISOR waiters and any detached
lane polling. The editor carries its OWN full set in editor.md §CI-wait
(items 1–16 since v0.4.91 — 10th = dispatch-receipt gate, 15th = solo-surface
rule, 16th = PR-state receipt law; lens B F10, v0.4.79: the "editor keeps items 1–3"
partition is retired; count re-verified lens A18 v0.4.89). Cross-references to these items use the W-prefix to
avoid collision with the editor's local numbering.

- **W1. Poll floor — EVERY detached gh poller ≥60s.** Waiter, watchdog,
  courtesy loop: no exceptions by mechanism.
- **W2. `--wait` must fit the ~120s tool-runner ceiling (≤90s).** Longer
  waits = exit 5 + resume-by-run-id or a detached poller. The FIRST dispatch
  call carries an explicit ≥600s tool timeout; a mid-flight dead invocation
  (no exit code, no run URL) is recovered by API run-search and ADOPTED —
  never a blind re-dispatch.
- **W3. Waiter legs verify invocations before launch.** Each leg of a
  detached chain checks its exact tool invocation against `--help`/tools.log
  BEFORE the chain launches (same trust level as the claim read-back,
  editor.md Phase 1 step 4), and a mid-chain rc≠0 session-notifies the
  owning session IMMEDIATELY, not only at chain end. Operational wakes carry
  `interrupt=true` (mid-turn failsafe delivery).
- **W4. Detached waits go through `oc-waiter arm` (v0.4.83), notify wiring
  NEVER as raw oc-prchecks flags** — the tool has no notify options. A
  detached waiter with NO notify path gets a one-shot cron courier armed
  before end of turn. Hand-rolled poller scripts are forbidden when
  `oc-waiter arm --ref <sha|branch> --notify <session-uuid>` covers the wait
  (verified delivery, rc-3 --interrupt retry, ORPHANED sweep wake).
- **W5. Log-window verification uses line-number cutoffs or full timestamps**
  — `grep -n marker` → `tail -n +N`, or full-timestamp compare; never
  prefix/field heuristics (log continuation lines carry no leading timestamp
  and leak debris into the window).
- **W6. `gh api` REST v3 keys are snake_case.** In `--jq` filters
  `run_started_at`/`updated_at` work; camelCase (`runStartedAt`) silently
  evaluates to null.
