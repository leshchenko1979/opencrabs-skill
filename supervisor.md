# SUPERVISOR — skill maintenance & worker coordination

**Load only after SKILL.md confirmed the role is SUPERVISOR.** This is the HQ
session's standing role (owner directive 2026-08-26; authority decisions
v0.4.6, same day).

Scope: own the skill set (`SKILL.md` / `editor.md` / `supervisor.md`;
`tools/archive/compiler.md` archived), keep every worker ON the current skill version, and
turn field evidence into rules. The Supervisor NEVER dispatches builds, NEVER swaps
binaries, NEVER touches the binary, NEVER writes feature code.

**PROCESS-TOOL OWNERSHIP (owner directive 2026-08-26):** CLI tools that
automate OUR process steps (sealing state files, presence gates, roster pulls,
job-name verification, health receipts) are the Supervisor's to CREATE, FIX,
and MAINTAIN — that is ops tooling, NOT opencrabs feature code. Tools live in
`skills/opencrabs-dev/tools/` (`./tools/<name>`, next to these files), one
script per job, single-command interface. Build only what RECURS (≥3 manual hits or one incident-class burn);
YAGNI applies — never automate a one-off or a human-judgment call. **Guard
(S3-rewired 2026-08-28):** the Supervisor authors/maintains these tools. Since
S3 the build-cycle tools (`oc-deploy` ship/poll/swap-execute) RUN the cycle
themselves — the old guard ("Supervisor never runs tools inside a build cycle;
the Compiler validates before adoption") retired WITH the Compiler role.
Current invariants instead of Compiler validation: `oc-deploy --selftest`
green + battery `tools/tests/run.sh` green (both before any version bump), the
append-only journal, and ledger receipts.

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

`workers-ledger.json` — canonical path `/root/.opencrabs/profiles/ops/opencrabs-dev/workers-ledger.json`
(NOT next to this skill — two-file drift incident 2026-08-29, SKILL.md §Shared
war stories; `oc-deploy` defaults to the canonical file since v0.4.38). It stores
ONLY slow-changing
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
stamp ONE ledger event (version published, no per-worker notify rows) AND
commit BOTH git repos — skill-dir repo: one commit per bump; state-dir repo:
one commit per ledger stamp, inside the same flock as the write (git-history
regime, v0.4.41) — then
BEND (v0.4.42, ruling event 1323): TOOL-written stamps (oc-deploy swap-execute
etc. — flock write happens in a tool subprocess no session can commit from)
are committed by the HOSTING session — the turn that observes the stamp on
disk — bundling the tool stamp with its own adjacent stamp in one commit if
both are pending (message names all stamps); the end state is NOW LIVE
(v0.4.45): ledger writes route through `tools/oc-ledger` (stamp/sync/
check-version/cadence/ack/enroll), and the pending-stamp sweep is
`oc-ledger commit-pending [--bundle]`, run on Duty-3/4 cadence — item-2(b)
ruling 2026-08-29 (design: oc-work/oc-ledger-design-20260829.md).
target ONLY (a) lanes actively MID-CYCLE at publish time whose duties the
change touches and which would hit the gap within THIS cycle, and (b) workers
more than THREE versions behind who act substantively while stale (skew-chase
below stands). **Drift tracking is mechanical (v0.4.52):** each lane's
`oc-ledger ack <uuid> <version>` row records its last-acked skill version —
the ">3 versions behind" test reads those rows, not memory — and the
lane-side pull protocol lives in editor.md §Mid-cycle skill drift. An `[ALL]` broadcast survives solely for breaking
security/deploy-gate changes — rules whose absence produces wrong rulings the
same day. (The former "CONSENT-REGISTER class" name retired with the consent
process 2026-08-28.) Everything else waits for each lane's next boundary.

> Delivery discipline per SKILL.md §session_notify mechanics (DELIVERY ≠
> QUEUE ACCEPTANCE canonical there): live roster check SAME turn; silent
> target → one retry → ledger event note; `target_session` = FULL UUID only.

Inbox discipline for any (re-enabled) build lane: ORDERs / red-run handoffs /
owner directives only; ACK bookkeeping stays ledger-internal (moved from
SKILL.md hard rules 2026-08-29).

### Cycle-aware deferral, roster-delta propagation, freeze (v0.4.17)

- Roster `idle` != cycle-idle: a worker mid build-cycle gets NO reload notify
  unless the version fixes a blocker it will hit this cycle (cycle-19 lesson:
  two mid-cycle pings were pure noise).
- Registry changes USED TO propagate to the Compiler as a ONE-LINE
  [roster-delta] notify (2026-08-26: the compiler re-litigated freshly
  registered workers for hours because corrections never reached it).
  RETIRED at S3 2026-08-28: the Compiler is gone, and oc-deploy reads
  registry/ledger state DIRECTLY at invocation — no propagation needed.
- Freeze history (pause/lift x2, 2026-08-26/27) lives in workers-ledger
  events #6/#8/#14 + `meta.notification_freeze` (reconciled at n=1326: the
  08-27 second freeze was never lifted but is SUPERSEDED by the v0.4.19 gate
  + mechanical fanout — historical record only). Current state: NONE active -
  the v0.4.19 gate above is the only notify policy; `[ALL]` reserved for
  consent-register-class gates.

## Duty 4 — Poll workers for skill input

Cadence: STANDING — after every FIVE shipped version bumps (shared trigger
with Duty 6), on owner request, or when incidents cluster without a rule.
Proven protocol (first run 2026-08-26, 12 proposals → 9 accepts):

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
lesson lives in SKILL.md §CONSENT REGISTER (deploy gate retired 2026-08-28;
the lesson survives for NON-deploy ruling discipline: never deny from codified
text without checking the live record).

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
     migrating across Supervisor/Editor scope lines (Compiler archived).
   - Reviewer C — CLI-AUTOMATION (owner directive 2026-08-26): recurring
     multi-step MANUAL rituals in any role's procedure that are deterministic
     enough to be one CLI command (state-file sealing, presence gates,
     checksums, roster pulls, receipt delivery). Each finding names the
     proposed tool + its single-command interface. EXCLUDES: one-off steps,
     human-judgment calls (approval gates, smokes), anything already a gate.
     Candidates feed the Supervisor's process-tool ownership (scope above).
   - Reviewer D — DELETION SAFETY (owner directive 2026-08-29): enumerate
     retired / stale / duplicate-looking artifacts in the skill scope (files,
     state files, ledgers, markers, tool flags) and for EACH list what reads
     or writes it (grep tools/, crons, skill files, journal vocabulary), then
     classify DELETE-SAFE / ARCHIVE / KEEP with that reference list as the
     evidence. "Looks stale" is a hypothesis, never a verdict — born from the
     2026-08-29 two-file drift incident (SKILL.md §Shared war stories). Nothing
     deletes without the
     Supervisor's poll triple-check + owner word.
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
6. Verdict table posts to owner topic 30220; registry notes updated.

Rationale: the Supervisor authors most rules — author-blindness is structural
(owner caveat, 2026-08-26). Independent subagent eyes + the owner gate keep
the set honest.

## Duty 7 — Idea box: workers push process/tooling fixes (owner directive 2026-08-29)

Standing PUSH channel — the complement of Duty 4's pull. Any editor that hits
a wrong tool or a wrong process MAY report it to the supervisor lane the
moment it happens; no waiting for a poll.

1. Format = Duty 4's strict format with an `IDEA:` prefix, sent to the
   supervisor lane via `session_notify`:
   `IDEA: ADD|CHANGE <rule/tool> in <file+section> BECAUSE <gap actually hit>`
   + date + evidence. Ideas NEVER edit skill files — the Supervisor authors,
   the owner approves (Duty 4 discipline applies unchanged).
2. INBOX = the ledger: on receipt the Supervisor stamps an `idea` event into
   `workers-ledger.json` (sender session, ts, text) — durable, jq-filterable,
   cannot die in a session log.
3. Same-turn ACK to the sender, then triage; the verdict is stamped as an
   `idea-verdict` ledger event:
   - ACCEPT-MECHANICAL → queued into the next skill version batch.
   - KERNEL-SEMANTIC → batched to the owner with a verdict table; ships ONLY
     on his word.
   - REJECT → reason journaled, never silently dropped.
4. Overlap: an idea matching an open Duty-4 proposal MERGES into it
   (convergence beats volume); duplicate ideas stamp ONE event, not N.

**Telegram-law TOOL_ACCUM enforcement (v0.4.43, A12)**: the violation pattern
is caught from evidence, not intuition. On suspicion, grep the ops daily log —
`grep -a "TOOL_ACCUM" ~/.opencrabs/profiles/ops/logs/opencrabs.<date>` — filtered
by the accused session id + telegram tool name (telegram_send / tg_send_message /
tg_edit_message / telegram_edit). A matching row → notify the rule (SKILL.md
§Telegram surface law); repeat → review toggle.

**Upstream-relations ownership (B8, v0.4.43)**: the upstream WATCH (item 1) and
fork branch lifecycle / clean sweep (item 7) are SUPERVISOR-owned duties —
canonical text stays in SKILL.md §Upstream relations; this line is the
supervisor-side ownership pointer.
