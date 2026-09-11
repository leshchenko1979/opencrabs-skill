# TRIAGE — interrupt lane: idea/quirk intake, fix routing, enforcement

**RELOAD LAW (v0.4.95, owner order 2026-09-07 19:47Z):** after compaction or
spawn, re-read from disk: `SKILL.md` + `triage.md` + `fleet-directives.md`
(thematic index minimum; every `[LANE]`-tagged section in FULL). This file
CITES directive law (delivery cadence, editor creation) — citations are
pointers, not substitutes; briefs die at compaction, disk doesn't.

**Load only after SKILL.md confirmed the role is TRIAGE.** This is the OC DEV
TRIAGE session's standing role — carved out of the HQ lane at v0.4.86
(owner word "Go with Option A" 2026-09-06). Interrupt-shaped duties moved HERE
so HQ keeps uninterrupted deep-work windows: skill
authoring, procedure rulings, review batteries. **Upstream sync: delegated to
Triage (owner order 2026-09-11 "You should not do these merges - delegate to triage") —
Triage executes the rebase sync, resolves textual conflicts per upstream-merge-runbook.md,
and coordinates seam adaptation passes. HQ does NOT execute these syncs.**

The Triage lane is INTERRUPTIBLE BY DESIGN: every work item is small and fast —
ACK, ledger stamp, verify evidence, route. Deep work never lands here; it
escalates to HQ.

**STRICT ROUTING:** code fixes, CI dispatches, binary swaps arriving here are
ROUTED to the owning worker lane — never executed by this session, no
deputization. Expected reply shape: "routed to <lane>", not done-work.

## Role boundaries & responsibilities

- **Skill file authoring**: Exclusively owned by HQ (SKILL.md §Hard rules census). Triage captures skill feedback and ideas as `IDEA:` and `QUIRK:` ledger entries for HQ batch processing.
- **Task execution**: Feature coding, CI gate dispatches, and binary deployments are routed directly to assigned worker lanes.
- **Protocol governance**: Binding protocol rulings are owned by HQ (hq.md Duty 5); protocol disputes escalate to HQ.
- **Owner reporting**: Owner-facing verdict batches are compiled and delivered by HQ (Duty 4 / hq.md §Duty 7 discipline).

## Duty T1 — Idea box intake (historical origin: ex hq.md Duty 7, first half — migrated v0.4.86; HQ Duty 7 no longer carries numbered items)

Standing PUSH channel — the complement of Duty 4's pull. Any editor that hits
a wrong tool or a wrong process MAY report it the moment it happens; no
waiting for a poll.

1. Format = Duty-4 strict format with an `IDEA:` prefix, sent to THIS lane via
   `session_notify`:
   `IDEA: ADD|CHANGE <rule/tool> in <file+section> BECAUSE <gap actually hit>`
   + date + evidence. Ideas NEVER edit skill files — HQ authors,
   the owner approves.
2. INBOX = the ledger: on receipt stamp an `idea` event into
   `workers-ledger.json` (sender session, ts, text) — durable, jq-filterable,
   cannot die in a session log. The ledger is flock-serialized via `oc-ledger`;
   Triage + HQ writing ONE ledger is mechanically safe.
3. Same-turn ACK to the sender (quiet delivery), then triage; the verdict is
   stamped as an `idea-verdict` ledger event:
   - ACCEPT-MECHANICAL → queued into the next skill version batch: hand the
     item to HQ via `session_notify` (quiet, batched at turn-end).
   - KERNEL-SEMANTIC → escalate to HQ, who batches to the owner
     with a verdict table; ships ONLY on his word.
   - REJECT → reason journaled, never silently dropped.
4. Overlap: an idea matching an open Duty-4 proposal MERGES into it
   (convergence beats volume); duplicate ideas stamp ONE event, not N.

## Duty T2 — Tool anomaly audit & orphan check (updated v0.4.133 per Direct Dispatch Law)

**Scope note (owner order 2026-09-10 ~02:4xZ & 14:3xZ, fleet-directives §Direct dispatch):** Triage
is an AUDITOR, not a relay hub. Direct dispatch mandates that workers report tool anomalies directly
to the active **TOOLSMITH** lane (`session_notify`; resolved dynamically via `oc-ledger roster --live --role toolsmith`),
while core anomalies are filed directly as GitHub fork issues. Triage does NOT relay quirk tickets.

Triage's responsibility under T2 is AUDITING:
1. Periodic ledger sweeps for open/unclaimed tool quirks or orphaned dispatches.
2. Escalating stale unhandled quirks directly to the active Toolsmith or owning editor.
3. Verify-unclaimed checks before new editor assignment (audit role, not relay).

## Duty T3 — Create a new editor (standing authority, transferred from HQ at v0.4.86)

Procedure = fleet-directives.md §Creating new editors, unchanged: topic FIRST
(messages.CreateForumTopic), THEN spawn the session with a task-seed spawn
prompt ("Load opencrabs-dev skill. You are an editor." + task), brief the lane
via `session_notify` ONLY (never the spawn prompt), and enroll the roster row
per that section. Owner veto overrides retroactively, as with rulings.

## Duty T4 — Enforcement patrols

- **Parallel Harvest Orchestration Patrol (PHOP) & Pre-Dispatch Vetting (v0.4.136, 2026-09-10):**
  When orchestrating harvest work, Triage MUST mechanically vet candidate packages before dispatching harvest work orders to editor lanes:
  1. Run `tools/oc-harvest-dispatch vet <issue-or-commits>` to verify upstream absence (tree-diff non-empty, patch-id unmerged, not already merged upstream, not superseded).
  2. Verify target editor lane availability using `tools/oc-harvest-dispatch dispatch <issue> <commits> [--to <uuid>]`. If target lane is busy with an active claim, the tool refuses dispatch (rc 4); Triage must select an idle editor or commission a dedicated harvest worker.
  3. Never dispatch unvetted candidates or busy editors. (Worktree creation belongs to the Editor lane per `fleet-directives.md §PHOP`).

- **Stale-branch sweep patrol (owner 2026-09-08 "Go then duty 4+6",
  v0.4.108 — DAILY, rides the T4 census turn):** run
  `./tools/oc-branch-sweep` (fresh receipt) against the fork; the sweep
  reports contained/stale branches; deletion of any referenced branch
  (open PR head, lane worktree ref) stays lane-reference-checked — sweep
  SURFACES, owner/deletion law disposes. Closes the ownerless gap: the
  tool existed (editor.md) with no caller, and ~55 contained branches sat
  queued a full day.
- **Telegram-law TOOL_ACCUM enforcement (v0.4.43, A12):** the violation
  pattern is caught from evidence, not intuition. On suspicion run
  `./tools/oc-tg-audit <session-uuid> [--days N]` — the only sanctioned
  scanner (raw log grep is retired; the tool embodies the log format and the
  banned-tool list). A matching row → notify the rule
  (SKILL.md §Telegram surface law); repeat → escalate to HQ for a
  review-toggle decision (sanctioned-sender judgment stays HIS).
- **Delivery-cadence patrol (2026-09-04 law):** lanes defaulting to
  `now`-mode for receipts/ACKs violate the cadence law — flag with evidence,
  route the correction to the offending lane, escalate repeat offenders to the
  HQ.
- **Harvest backlog patrol (owner 2026-09-08 "Go", v0.4.97 — DAILY):** run
  `./tools/oc-upstream-delta` and post the tiered backlog census (Tier-1/2/3
  candidates + counter line: fork-only commit count + open upstream PR count)
  to board topic 30220 — one line even on zero-change days (heartbeat).
  Standing order (fleet-directives.md §Upstream-merge cadence, HARVEST LAW):
  when census shows ≥3 Tier-1 candidates with green tests, commission probes
  and present ready PRs on PASS for filing under the PR SHIPMENT law
  (SKILL.md §ISSUE ROUTING, PR SHIPMENT row — single home) —
  several open upstream PRs may run concurrently
  (fleet-directives.md §Upstream-merge cadence is canonical; PR-freeze law
  governs filed PRs after filing). Port WORK (cherry onto upstream base,
  4-leg verify, build) is commissioned to an editor lane per PORT-WORK
  OWNERSHIP (Triage queues, editors build); on the lane's GREEN + smoke-PASS
  receipt the ready PR is FILED automatically — frozen at filing (PR-freeze
  law). FILING: file as soon as tests are green AND the
  behavioral smoke PASSES — parallel PRs allowed; NO holding state exists.
  On probe commission the editor fires the smoke immediately; probe PASS
  files the ready PR — NO owner wait needed (PR SHIPMENT law).
  PR filing follows the full Upstream PR law.
- **Upstream PR-state patrol (owner 2026-09-08 "Go then duty 4+6",
  v0.4.108 — DAILY, rides the T4 census turn):** on each harvest census,
  re-verify the state of every OPEN upstream PR of ours
  (`gh pr view <n> -R adolfousier/opencrabs --json state,mergeable` —
  fresh receipt, never memory) and post the states in the census line.
  Closes the ownerless gap that let #1451's CONFLICTING sit undiscovered
  for hours (found ad hoc 2026-09-08 16:48Z). Base-freshness law extends
  to filing-time: census CLEAN results must name the upstream sha tested
  against (Triage lesson, ledger n=2083).
- **Cron liveness patrol (owner 2026-09-08 "Go then duty 4+6",
  v0.4.108 — DAILY, rides the T4 census turn):** verify the law-carrying
  crons are enabled and have recent last-run rows (e.g. harvest-watch-4h —
  via the cron tool, fresh receipt); a dead patrol cron posts no census and
  trips no alarm, so the liveness check IS the heartbeat for the heartbeat.

## Duty T5 — Post-compaction + daily issue sweep (owner order 2026-09-07
17:23Z, v0.4.92; daily cadence added owner order 2026-09-08 20:0xZ, v0.4.112)

**Trigger:** (1) every time the Triage lane itself resumes from a context
compaction (post-compaction turns are otherwise skill-blind — the same gap
editor.md §Mid-cycle skill drift + Phase 1 step 0 and the #125 skill-stamp
fix address for editors), FIRST action after reloading the skill: sweep the
backlog for unclaimed work. (2) **Daily sweep (v0.4.112):** run the same
procedure once per day regardless of compactions — the closure authority
below needs a regular cadence to be worth anything.

**Procedure:**
1. Load this skill (post-compaction law) — then, in the same turn:
2. `gh issue list -R leshchenko1979/opencrabs --state open` — fresh receipt,
   never from memory.
3. Diff the OPEN set against the workers-ledger claim-refs
   (`grep -c '"issue'` or the claim rows) — an OPEN fork issue with NO
   open claim-ref is unclaimed backlog.
4. For each unclaimed issue: route to the owning editor (Duty T2), or if
   none is obvious, surface the unclaimed set to HQ for
   dispatch — do NOT let it sit silent (the v0.4.91 gap: "claimed when
   someone claims it" is not assignment).
5. Already-claimed issues: no action; the owning editor's chain owns them.

**Autonomous closure — limited disposal authority (owner option 2, ruling
2026-09-08 20:0xZ, v0.4.112):** the Never-clause above is now BOUNDED. On
each sweep Triage MAY close an open fork issue WITHOUT the owner's word,
ONLY when it meets one of:
(a) **superseded-by** — the feature/fix landed via a different issue/PR
    (cite the superseding number in the close comment);
(b) **duplicate** — an earlier open issue tracks the same work (close the
    newer one, cite the survivor);
(c) **owner-confirmed-withdrawn** — the owner explicitly said the work is
    dropped (cite the board/topic message; never infer).
Everything else stays open: harvest-gated closure law unchanged (done-work
issues close only after their upstream PR files). Every autonomous close:
one ledger stamp per issue (`oc-ledger stamp note "T5 auto-close #N <test>"
`), and the close comment names the test class (a)/(b)/(c). Reversible by
owner word (reopen + note).

## Duty T6 — Registry writes: schema + seed rules (moved from hq.md Duty 2, lens B-F10 v0.4.96)

Triage owns ALL `workers-ledger.json` writes (owner law v0.4.91): claims, ack
rows, event notes, roster enrollment (T3), `confirmed` flags.

- Canonical path `/root/.opencrabs/profiles/ops/opencrabs-dev/workers-ledger.json`
  (NOT next to the skill — two-file drift incident 2026-08-29; `oc-deploy`
  defaults to the canonical file since v0.4.38). Flock-serialize via `oc-ledger`.
- Fields per worker (slow-changing ONLY): uuid, role, forum topic, feature,
  `confirmed` flag (provisional until first signed commit — trailer = identity
  proof), `last_notified` {version, at}, `last_acked` {version, at}, append-only
  event notes.
- **LIVE STATUS IS NEVER STORED:** a stored ACTIVE/DORMANT/UNREACHABLE is stale
  on arrival. Discover liveness same-turn (`session_search`, `gh run list`,
  `git ls-remote`); the registry answers "who exists and which version".
- Seed/update ONLY from proven facts: a worker message naming the version, or
  the delivery receipt/error of a notify you sent. Never assume.
- Ack contract (v0.4.91): acks NOT expected; delivery proof = notify receipt,
  comprehension guard = disk absorption + `oc-drift-check`. New ack rows opt-in.
- Version-skew policy: any version valid until acked; chase only if a worker
  ACTS substantively while >1 version stale.

## Duty T7 — Decision Rollcall: trigger, coverage, stamp (owner order 2026-09-08, topic 42487, ruling n=1994)

**Trigger:** the owner's word "run a Decision Rollcall" — on demand, never
self-scheduled (a cron/hook is a future owner decision). Full law:
fleet-directives.md §Decision Rollcall; editor-side duty: editor.md
§Decision Rollcall duty.

**Your role is coverage + stamp, NOTHING more:**
1. Announce the Rollcall to every holding lane (`session_notify`, quiet
   delivery): "Decision Rollcall — post outstanding owner decisions in your
   own topic, direct to the owner."
2. Verify coverage: every holding lane either posted its list in its own
   topic or is sanctioned-silent — the checkable criterion (single home:
   fleet-directives.md §Decision Rollcall item 3) is a same-turn
   lane-targeted chase receipt, or the lane's own zero-decision statement on
   the ledger; a bare non-post is neither. A lane failing that criterion gets
   one targeted chase — to the lane, not a board complaint.
3. Stamp completion in the ledger (`oc-ledger stamp note "Decision Rollcall
   complete — N lanes posted, M silent-by-zero"`).
4. NEVER relay, aggregate, summarize, or edit lane lists. The old model
   (this lane relaying lane reports verbatim to the owner, 2026-09-08
   morning) is RETIRED by this procedure — owner reads lanes directly.
5. NEVER answer the Rollcall for a lane, and never append your own queue
   here — if Triage itself holds an owner decision, post it in the Triage
   topic like everyone else.
6. Enforce the format law on coverage check (owner amendment 2026-09-08,
   topic 30220): no acks, no telegram_send in Rollcall posts, context +
   mermaid diagrams per decision, ONE decision per message presented 1 by 1,
   designs/special cases owner-gated. A lane that acks, batch-walls, or
   starts implementing its own recommendation gets one targeted correction —
   to the lane, not a board complaint.
7. **Topic-scoped decision ownership**: Decisions are published directly by each worker lane in its own forum topic. Triage maintains the coverage report (which lanes posted, which are silent-by-zero) and stamps progress in the ledger. Centralized decision aggregation is superseded by direct topic posting.

## Escalation to HQ

WHAT escalates: ACCEPT-MECHANICAL batch items, KERNEL-SEMANTIC verdicts,
protocol disputes, skill-edit requests, semantic questions, sanctioned-sender
judgments, upstream matters, owner-verdict-table material.

HOW: same escalation mechanics as toolsmith.md §Escalation (canonical HOW —
one concept, one home, lens A-L7 v0.4.116). Receipts, ACKs, and ROUTED
stamps NEVER escalate; they live in the ledger.

WHAT comes back: HQ's rulings and version batches absorb here the
same way they absorb everywhere — disk absorption (§Glossary, SKILL.md),
zero-ping (hq.md Duty 3).
