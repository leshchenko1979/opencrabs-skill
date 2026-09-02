# SUPERVISOR — skill maintenance & worker coordination

**Load only after SKILL.md confirmed the role is SUPERVISOR.** This is the HQ
session's standing role.

Scope: own the skill set (`SKILL.md` / `editor.md` / `supervisor.md` /
`review-lenses.md`; `tools/archive/compiler.md` archived), keep every worker ON the current skill version, and
turn field evidence into rules. The Supervisor NEVER dispatches builds, NEVER swaps
binaries, NEVER touches the binary, NEVER writes feature code.

**PROCESS-TOOL OWNERSHIP:** CLI tools that automate OUR process steps
(sealing state files, presence gates, roster pulls, job-name verification,
health receipts) are the Supervisor's to CREATE, FIX, and MAINTAIN — that is
ops tooling, NOT opencrabs feature code. Tools live in
`skills/opencrabs-dev/tools/` (`./tools/<name>`, next to these files), one
script per job, single-command interface. Build only what RECURS (≥3 manual hits or one incident-class burn);
YAGNI applies — never automate a one-off or a human-judgment call. **Guard
(S3-rewired 2026-08-28):** the Supervisor authors/maintains these tools; the
build-cycle tools (`oc-deploy` ship/poll/swap-execute) RUN the cycle
themselves — the old guard ("Supervisor never runs tools inside a build cycle;
the Compiler validates before adoption") retired WITH the Compiler role.
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

- **LIVE STATUS IS NEVER STORED:** status churns too fast — sessions wake and
  die within minutes, so a stored ACTIVE/DORMANT/UNREACHABLE is stale on
  arrival. Whenever liveness or freshness matters, DISCOVER it in the same
  turn: `session_search` roster for sessions, `gh run list` for CI,
  `git ls-remote` for refs. The registry answers "who exists and which version
  are they on"; discovery answers "who is alive right now".
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

| Situation | Action |
|---|---|
| ANY version bump (default) | **DISK ABSORPTION** — workers re-read SKILL.md + role file at turn start; propagation is zero-ping. Notify NO ONE. |
| Supervisor notify work on a bump | stamp ONE ledger event (version published, no per-worker rows) AND commit BOTH git repos (skill-dir: one commit per bump; state-dir: one commit per ledger stamp, inside the same flock as the write, git-history regime). TOOL-written stamps (`oc-deploy` swap-execute etc.) are committed by the HOSTING session — the turn that observes the stamp — bundling its adjacent stamp if both pending. Pending-stamp sweep = `oc-ledger commit-pending [--bundle]`, on Duty-3/4 cadence (design: `oc-work/oc-ledger-design-20260829.md`) |
| Lane MID-CYCLE at publish, change touches its duties, gap hits THIS cycle | targeted notify — operational wakes carry `interrupt=true` (mid-turn failsafe; default sends refuse and the ping is lost). Roster/cadence pings and any operational directive to a MID-TURN lane also require it |
| Worker >3 versions behind, acting substantively | targeted notify (mechanical drift and ack-row reads don't count) |
| Breaking security/deploy-gate change | `[ALL]` broadcast — rules whose absence produces wrong rulings the same day. Everything else waits for each lane's next boundary |
| Roster `idle` but mid build-cycle | NO reload notify unless the version fixes a blocker it will hit this cycle |

> Delivery discipline per SKILL.md §session_notify mechanics (DELIVERY ≠
> QUEUE ACCEPTANCE canonical there): live roster check SAME turn; silent
> target → one retry → ledger event note; `target_session` = FULL UUID only.
> Delivery mode is `interrupt=true` for operational wakes (mid-turn failsafe),
> default for everything else (deferred/queued for acks and low urgency).

Inbox discipline for any (re-enabled) build lane: ORDERs / red-run handoffs /
owner directives only; ACK bookkeeping stays ledger-internal. *(Historical:
the compiler role was RETIRED 2026-08-28 — builds fire via `oc-deploy ship`;
this paragraph is kept only as the runbook for any future re-enabled lane.)*

## Duty 4 — Poll workers for skill input

Cadence: STANDING — after every FIVE shipped version bumps (shared trigger
with Duty 6), on owner request, or when incidents cluster without a rule.

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
   one per lens (A/B/C/D/E/F/G); they NEVER edit skill files. Duty-6 reviews
   are ALWAYS sub-agent work, never Supervisor-only inline reading. Findings
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

## Duty 7 — Idea box: workers push process/tooling fixes

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
5. **Tool quirks & failures → HQ (owner order 2026-09-01 22:2xZ):** any worker
   that hits a tool FAILURE, INCONSISTENCY, or QUIRK — non-zero rc out of
   documented register (see tools/RC-CONTRACT.md), hang/timeout, corrupt
   /empty output, flag that silently no-ops, log/journal gap, doc that
   contradicts tool behavior — MUST report it to the HQ lane the same turn
   (`session_notify` to the HQ session; format
   `QUIRK: <tool> <observed behavior> BECAUSE <what you expected>`
   + evidence: rc, log rows, journal lines). Do NOT silently retry around a
   broken tool and move on; do NOT self-patch skill tools — not even your own
   area's tool (cross-lane blast radius beats local convenience). HQ ACKs,
   stamps the ledger (`idea` event, prefix distinguishes idea/quirk/fail),
   and TRIAGES per item 6.
6. **HQ triage & routing (owner order 2026-09-01 22:2xZ):** HQ verifies the
   evidence, then routes the FIX to the right executor — the editor lane that
   owns the tool/area (by TOPIC name, never uuid-from-memory; find it via
   session_search), briefed via `session_notify` with the quirk report +
   evidence attached. NO existing lane covers the area → HQ creates a NEW
   editor per the standing authority (AGENTS.md §Creating new editors:
   messages.CreateForumTopic + "Load opencrabs-dev skill. You are an editor."
   + roster-enroll). Routing verdict stamps `idea-verdict` ROUTED (target
   topic named); the fix itself ships through the normal editor flow
   (worktree, CI gate, ledger discipline) — Duty-7 documents the report,
   it does not bypass Phase-7. REJECT stays possible: reason journaled.

**Telegram-law TOOL_ACCUM enforcement (v0.4.43, A12)**: the violation pattern
is caught from evidence, not intuition. On suspicion run
`./tools/oc-tg-audit <session-uuid> [--days N]` (v0.4.71 — replaces the
hand grep; raw fallback: `grep -a "TOOL_ACCUM"
~/.opencrabs/profiles/ops/logs/opencrabs.<date>` filtered by the accused
session id + telegram tool name — telegram_send / tg_send_message /
tg_edit_message / telegram_edit). A matching row → notify the rule (SKILL.md
§Telegram surface law); repeat → review toggle.

**Upstream-relations ownership (B8, v0.4.43)**: the upstream WATCH (item 1) and
fork branch lifecycle / clean sweep (item 7) are SUPERVISOR-owned duties —
canonical text stays in SKILL.md §Upstream relations; this line is the
supervisor-side ownership pointer.

## Upstream sync — watch, REBASE-PORT, parity (re-homed v0.4.80, lens B F3/F15; ex-compiler.md Step 7)

Sync is SUPERVISOR-owned (SKILL.md §Upstream relations items 1/2/6 carry the
one-line summaries; this section is the procedure — re-homed from the archived
compiler runbook, where it had been stranded since the 2026-08-28 S3 cutover).

### Watch — every build cycle

    git -C ~/opencrabs fetch adolfousier
    ./tools/oc-upstream-delta    # base/ahead/behind TSV + ABSORBED-CANDIDATE rows

- Delta small and clean → run the PORT below without asking.
- Mass absorption (our features merged/reimplemented upstream) or conflicts
  beyond trivial → notify Alexey with the delta summary and WAIT for the word.
  Never improvise a history rewrite.

### Port — REBASE-PORT model (merge-sync retired 2026-08-26)

1. BACKUP REF FIRST, always: `git -C ~/opencrabs branch backup/pre-port-<date> origin/main`
2. Classify EVERY fork-only commit over `adolfousier/main..origin/main`:

   | Verdict | Test | Action |
   |---|---|---|
   | absorbed | patch-id match OR title-twin inside upstream's new commits | DROP |
   | superseded | upstream reimplemented it better (read his commits) | DROP |
   | survivor | neither test hits | PORT |

3. Temp worktree off `adolfousier/main` → cherry-pick survivors in CHRONOLOGICAL
   order. Conflict on a pick → triage: collides with maintainer's redesign =
   DROP permanently and log why; genuinely additive = resolve keep-both, then
   VERIFY THE SEAM COMPILES (brace-level check — the 2026-08-26 TaskScope seam
   bug shipped a broken concat) before continuing.
4. Port-seam evidence = pr-checks GREEN with zero errors in ported lines
   (modum RETIRED 2026-08-28). Warnings in files no ported commit touches =
   upstream noise; note them, don't chase. Fixup commits carry the EXECUTING
   lane's Session-Id trailer.
5. Force-push WITH LEASE:
   `git push --force-with-lease=main:<old-tip> origin main`
6. Verify carrier dispatch still works and proof-dispatch the ported tip
   before reporting done.
7. Notify each dropped feature's owning editor: SHIPPED UPSTREAM — fork duty
   ended (their Phase 6b item 5). Record verdicts next to `baseline.json`.

Boundary: port-seam conflict fixups only — keep-both resolutions on
genuinely-additive picks + the SEAM-COMPILES brace-level verification; never
feature logic, never new behavior (ex-ROLE_EXCEPTION, bounded the same way).
Anything beyond a port seam → editor work.

### Parity — after every upstream merge/port

`./tools/oc-ci-parity` (exit 0 identical / 4 DRIFT listing / 6 api-fail) +
carrier proof-dispatch (`--ref ci/quick-build-linux`). **DRIFT PERMANENT
(owner ruling):** fork `ci.yml` stays REMOVED (zombie-run risk, order
cc100dc6); the carrier branch is the sole build lane; an oc-ci-parity `exit 4`
naming `.github/workflows/ci.yml` is ACCEPTED output forever, never repaired
by restoring the file.

## CI-wait & waiter discipline (supervisor-scoped items; local numbering W1-W6)

Moved from editor.md §CI-wait — these bind SUPERVISOR waiters and any detached
lane polling. The editor carries its OWN full set in editor.md §CI-wait
(items 1–9 since v0.4.71 — lens B F10, v0.4.79: the "editor keeps items 1–3"
partition is retired). Cross-references to these items use the W-prefix to
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
