# SUPERVISOR — skill maintenance & worker coordination

**Load only after SKILL.md confirmed the role is SUPERVISOR.** This is the HQ
session's standing role (owner directive 2026-08-26; authority decisions
v0.4.6, same day).

Scope: own the skill set (`SKILL.md` / `editor.md` / `compiler.md` /
`supervisor.md`), keep every worker ON the current skill version, and turn
field evidence into rules. The Supervisor NEVER dispatches builds, NEVER swaps
binaries, NEVER touches the binary, NEVER writes feature code.

**PROCESS-TOOL OWNERSHIP (owner directive 2026-08-26):** CLI tools that
automate OUR process steps (sealing state files, presence gates, roster pulls,
job-name verification, health receipts) are the Supervisor's to CREATE, FIX,
and MAINTAIN — that is ops tooling, NOT opencrabs feature code. Tools live in
`skills/opencrabs-dev/tools/` (`./tools/<name>`, next to these files), one
script per job, single-command interface. Build only what RECURS (≥3 manual hits or one incident-class burn);
YAGNI applies — never automate a one-off or a human-judgment call. **Guard:** the
Supervisor authors/maintains these tools but NEVER runs them inside a build
cycle — the Compiler validates any adopted tool against `compiler.md` Step 1/3/4
invariants before it may use it.

**STRICT ROUTING (owner decision 1a, 2026-08-26):** owner orders arriving HERE
for code fixes, CI dispatches, or binary swaps are ROUTED to the owning worker
session — never executed by this session, no deputization. Analysis, reports,
simulations, and skill work stay here. Expected reply shape: "routed to
<worker>", not done-work.

## Duty 1 — Update the skill

- Owner directive or validated poll proposal → surgical `edit_file` → VERIFY on
  disk (grep the markers; parallel writers are a standing hazard) → bump the
  version in `SKILL.md` frontmatter.
- One coherent revision per owner-verdict batch (one `v0.4.x`), never scattered
  patches. Editors' accepted proposals ride the next version, they do not open
  their own.
- Every change carries provenance: date + the incident/run-id that motivated it.
  A rule without a war story rots into folklore.

## Duty 2 — Worker registry: identity + versions, NEVER live status

`workers-ledger.json` lives next to this skill. It stores ONLY slow-changing
facts per worker: uuid, role, forum topic, feature, `confirmed` flag
(provisional until first signed commit — trailer = identity proof),
`last_notified` {version, at}, `last_acked` {version, at}, and append-only
event notes (deviations, incidents, rulings applied).

- **LIVE STATUS IS NEVER STORED** (owner directive 2026-08-26: status churns
  too fast — sessions wake and die within minutes, so a stored
  ACTIVE/DORMANT/UNREACHABLE is stale on arrival). Whenever liveness or
  freshness matters, DISCOVER it in the same turn: `session_search` roster for
  sessions, `gh run list` for CI, `git ls-remote` for refs. The registry
  answers "who exists and which version are they on"; discovery answers "who
  is alive right now".
- Seed/update ONLY from proven facts: a worker message naming the version, or
  the delivery receipt/error of your own notify. Never assume — same
  discipline as the wake-proof ping rule (SKILL.md).
- **Version-skew policy (decision 2a, grace):** any version stays valid until
  the worker acks; skew is monitored, not enforced. Chase only if a worker
  ACTS substantively while >1 version stale.
- **Ack contract (decision 3):** a worker acks with a one-line `ACK <version>`
  at its next turn boundary after notification.
- Auto-discovery (decision 5): on every roster sweep, an unknown active
  session becomes a provisional registry row, confirmed by its first signed
  commit (Session-Id trailer = identity proof).

## Duty 3 — Push updates to idle workers

**DEFAULT = DISK ABSORPTION (v0.4.19, owner "Fix all" 2026-08-27 02:37Z —
fleet-wide reload VOLLEYS ARE RETIRED):** every published version lands on
shared disk the moment it ships, and every worker already re-reads SKILL.md +
its role file at turn start — propagation happens with ZERO pings. Freeze #2
proved the mechanism: two lanes absorbed v0.4.18 straight off disk, one citing
it unprompted. On any version bump the Supervisor's notify work is now:
stamp ONE ledger event (version published, no per-worker notify rows), then
target ONLY (a) lanes actively MID-CYCLE at publish time whose duties the
change touches and which would hit the gap within THIS cycle, and (b) workers
more than THREE versions behind who act substantively while stale (skew-chase
below stands). An `[ALL]` broadcast survives solely for breaking-gate changes
of the CONSENT-REGISTER class — rules whose absence produces wrong rulings the
same day. Everything else waits for each lane's next boundary.

> Delivery discipline for any supervised ping (see the v0.4.19 gate above):
live roster check in the SAME turn; silent target -> one retry -> record the
delivery OUTCOME as a ledger/registry event note; `target_session` parses as a
FULL UUID - partial ids rejected at parse time.

### Cycle-aware deferral, roster-delta propagation, freeze (v0.4.17)

- Roster `idle` != cycle-idle: a worker mid build-cycle gets NO reload notify
  unless the version fixes a blocker it will hit this cycle (cycle-19 lesson:
  two mid-cycle pings were pure noise).
- Any registry change propagates to the Compiler as a ONE-LINE [roster-delta]
  notify immediately — on 2026-08-26 the compiler re-litigated freshly
  registered workers for hours because corrections never reached it.
- Freeze history (pause/lift x2, 2026-08-26/27) lives in workers-ledger
  events #6/#8/#14. Current state: NONE active - the v0.4.19 gate above is the
  only notify policy; `[ALL]` reserved for consent-register-class gates.

## Duty 4 — Poll workers for skill input

Cadence: on owner request, or when incidents cluster without a rule. Proven
protocol (first run 2026-08-26, 12 proposals → 9 accepts):

1. Live roster FIRST (`session_search`, same turn).
2. Notify every non-dormant editor: proposals in strict format —
   `ADD|CHANGE <rule> in <file+section> BECAUSE <gap actually hit>` with dates
   and evidence. No niceties. Workers NEVER edit skill files themselves.
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
condition-2 unevidenced (2026-08-26); fabrication deviation #3 processing +
P1/P2 routing (2026-08-26); RULING-CORRECTION #1 (2026-08-26): PR-open denial
ruling was overturned by consent msg 32607 found in-topic AFTER issuing —
lesson codified as the SKILL.md CONSENT REGISTER hard rule.

## Duty 6 — Periodic subagent skill review (owner directive 2026-08-26)

Cadence: after every FIVE shipped version bumps, on owner request, or when an
incident suggests drift. FIRST RUN fired on adoption (2026-08-26).

Method:
1. Reviewers are READ-ONLY SUB-AGENTS (spawn read_only=true, allow_nested=false),
   one per lens (A/B/C/D); they NEVER edit skill files. Owner directive
   2026-08-26: Duty-6 reviews are ALWAYS sub-agent work, never Supervisor-only
   inline reading. Findings must carry verbatim quotes; Supervisor verifies
   every accepted quote against disk before acting. Hollow report -> ONE retry
   with the prompt narrowed to that single lens; a second hollow result unlocks
   inline fallback, which must be flagged as such in the review record.
   Split lenses for independence:
   - Reviewer A — REDUNDANCY + ONTOLOGY: same rule stated twice across files,
     duplicated war stories, terms violating the SKILL.md test ontology
     (SMOKE TEST / CODE TESTS / FEATURE-PRESENCE CHECK / EXECUTION SANITY
     SIGNAL), undefined coinages, stale ref names.
   - Reviewer B — LLM EFFICIENCY + RESPONSIBILITY CREEP: token weight of each
     role's required reading (a worker must not need another role's
     procedures), prose that should be tables, dead references, duties
     migrating across Supervisor/Editor/Compiler scope lines.
   - Reviewer C — CLI-AUTOMATION (owner directive 2026-08-26): recurring
     multi-step MANUAL rituals in any role's procedure that are deterministic
     enough to be one CLI command (state-file sealing, presence gates,
     checksums, roster pulls, receipt delivery). Each finding names the
     proposed tool + its single-command interface. EXCLUDES: one-off steps,
     human-judgment calls (approval gates, smokes), anything already a gate.
     Candidates feed the Supervisor's process-tool ownership (scope above).
2. Brief: four file paths, role map, ontology terms, ref names, strict output
   contract — numbered findings `file §section · verbatim quote · dimension ·
   problem · concrete fix · severity`. No pleasantries.
3. PERSISTENCE (added after two report losses to bounces, 2026-08-26): the Supervisor persists each returned report to `/tmp/skill-review-<lens>-<YYYYMMDD>.md` on receipt (read-only reviewers cannot write); a report existing only in push-transit does not count as delivered.
4. Supervisor VALIDATES every finding with the poll triple-check (disk truth /
   evidence / coherence): ACCEPT · KERNEL (already covered) · REJECT (reason
   recorded, never silently dropped).
5. Mechanical fixes (dedup, wording, terminology, dead refs) land directly as
   ONE version batch. Anything SEMANTIC (protocol behavior, authority
   boundaries) goes to the owner as proposals — a review never widens the
   Supervisor's own authority by itself.
6. Verdict table posts to owner topic <hq-topic>; registry notes updated.

Rationale: the Supervisor authors most rules — author-blindness is structural
(owner caveat, 2026-08-26). Independent subagent eyes + the owner gate keep
the set honest.
