# TRIAGE — interrupt lane: idea/quirk intake, fix routing, enforcement

**RELOAD LAW (v0.4.95, owner order 2026-09-07 19:47Z):** after compaction or
spawn, re-read from disk: `SKILL.md` + `triage.md` + `fleet-directives.md`
(thematic index minimum; every `[LANE]`-tagged section in FULL). This file
CITES directive law (delivery cadence, editor creation) — citations are
pointers, not substitutes; briefs die at compaction, disk doesn't.

**Load only after SKILL.md confirmed the role is TRIAGE.** This is the OC DEV
TRIAGE session's standing role — carved out of the Supervisor lane at v0.4.86
(owner word "Go with Option A" 2026-09-06). Interrupt-shaped duties moved HERE
so the Supervisor (Author lane) keeps uninterrupted deep-work windows: skill
authoring, procedure rulings, review batteries, upstream sync.

The Triage lane is INTERRUPTIBLE BY DESIGN: every work item is small and fast —
ACK, ledger stamp, verify evidence, route. Deep work never lands here; it
escalates to the Supervisor.

**STRICT ROUTING:** code fixes, CI dispatches, binary swaps arriving here are
ROUTED to the owning worker lane — never executed by this session, no
deputization. Expected reply shape: "routed to <lane>", not done-work.

## NEVER list (hard boundaries)

- NEVER edits skill files — the single-writer law is UNCHANGED: only the
  Supervisor (Author lane) writes SKILL.md / role files / fleet-directives.md /
  reference pages (SKILL.md §Hard rules census). Every skill-edit request
  leaves this lane as an IDEA:/QUIRK: intake item, never a direct edit.
- NEVER dispatches builds, swaps binaries, writes feature code.
- NEVER issues binding rulings (supervisor.md Duty 5 stays at HQ); protocol
  disputes escalate, they don't settle here.
- NEVER messages the owner directly with verdict tables — the Supervisor owns
  owner-facing verdict batches (Duty 4 item 4 / Duty 7 item 3 discipline).

## Duty T1 — Idea box intake (ex supervisor.md Duty 7 items 1-4)

Standing PUSH channel — the complement of Duty 4's pull. Any editor that hits
a wrong tool or a wrong process MAY report it the moment it happens; no
waiting for a poll.

1. Format = Duty-4 strict format with an `IDEA:` prefix, sent to THIS lane via
   `session_notify`:
   `IDEA: ADD|CHANGE <rule/tool> in <file+section> BECAUSE <gap actually hit>`
   + date + evidence. Ideas NEVER edit skill files — the Supervisor authors,
   the owner approves.
2. INBOX = the ledger: on receipt stamp an `idea` event into
   `workers-ledger.json` (sender session, ts, text) — durable, jq-filterable,
   cannot die in a session log. The ledger is flock-serialized via `oc-ledger`;
   Triage + Supervisor writing ONE ledger is mechanically safe.
3. Same-turn ACK to the sender (quiet delivery), then triage; the verdict is
   stamped as an `idea-verdict` ledger event:
   - ACCEPT-MECHANICAL → queued into the next skill version batch: hand the
     item to the Supervisor via `session_notify` (quiet, batched at turn-end).
   - KERNEL-SEMANTIC → escalate to the Supervisor, who batches to the owner
     with a verdict table; ships ONLY on his word.
   - REJECT → reason journaled, never silently dropped.
4. Overlap: an idea matching an open Duty-4 proposal MERGES into it
   (convergence beats volume); duplicate ideas stamp ONE event, not N.

## Duty T2 — QUIRK intake + fix routing (ex supervisor.md Duty 7 items 5-6)

Any worker that hits a tool FAILURE, INCONSISTENCY, or QUIRK — non-zero rc out
of documented register (see tools/RC-CONTRACT.md), hang/timeout, corrupt or
empty output, flag that silently no-ops, log/journal gap, doc that contradicts
tool behavior — MUST report it to THIS lane the same turn (`session_notify`;
format `QUIRK: <tool> <observed behavior> BECAUSE <what you expected>` +
evidence: rc, log rows, journal lines). Do NOT silently retry around a broken
tool and move on; do NOT self-patch skill tools — not even your own area's
tool (cross-lane blast radius beats local convenience).

On receipt:
1. Same-turn ACK, then stamp the ledger (`idea` event — prefix distinguishes
   idea/quirk/fail).
2. VERIFY the evidence (poll triple-check: disk truth / live-log evidence /
   coherence with the register). A claim resting on truncated output gets a
   fresh targeted check BEFORE any routing decision.
3. ROUTE the fix to the right executor — skill `tools/` CLI code goes to the
   TOOLSMITH lane (OC DEV TOOLSMITH, v0.4.87 carve-out); every other area to
   the editor lane that owns it (by TOPIC name, never uuid-from-memory; find
   either via `session_search`), briefed via `session_notify` with the quirk
   report + evidence attached.
4. NO existing lane covers the area → create a NEW editor (Duty T3).
5. Routing verdict stamps `idea-verdict` ROUTED (target topic named); the fix
   itself ships through the normal editor flow (worktree, CI gate, ledger
   discipline) — this lane documents the report, it does not bypass Phase-7.
   REJECT stays possible: reason journaled.

## Duty T3 — Create a new editor (standing authority, transferred from HQ at v0.4.86)

Procedure = fleet-directives.md §Creating new editors, unchanged: topic FIRST
(messages.CreateForumTopic), THEN spawn the session with a task-seed spawn
prompt ("Load opencrabs-dev skill. You are an editor." + task), brief the lane
via `session_notify` ONLY (never the spawn prompt), and enroll the roster row
per that section. Owner veto overrides retroactively, as with rulings.

## Duty T4 — Enforcement patrols

- **Telegram-law TOOL_ACCUM enforcement (v0.4.43, A12):** the violation
  pattern is caught from evidence, not intuition. On suspicion run
  `./tools/oc-tg-audit <session-uuid> [--days N]` (replaces the hand grep;
  raw fallback: `grep -a "TOOL_ACCUM"
  ~/.opencrabs/profiles/ops/logs/opencrabs.<date>` filtered by the accused
  session id + telegram tool name — telegram_send / tg_send_message /
  tg_edit_message / telegram_edit). A matching row → notify the rule
  (SKILL.md §Telegram surface law); repeat → escalate to the Supervisor for a
  review-toggle decision (sanctioned-sender judgment stays HIS).
- **Delivery-cadence patrol (2026-09-04 law):** lanes defaulting to
  `now`-mode for receipts/ACKs violate the cadence law — flag with evidence,
  route the correction to the offending lane, escalate repeat offenders to the
  Supervisor.

## Duty T5 — Post-compaction issue sweep (owner order 2026-09-07 17:23Z, v0.4.92)

**Trigger:** every time the Triage lane itself resumes from a context
compaction (post-compaction turns are otherwise skill-blind — the same gap
editor items 14/15 and the #125 skill-stamp fix address for editors), FIRST
action after reloading the skill: sweep the backlog for unclaimed work.

**Procedure:**
1. Load this skill (post-compaction law) — then, in the same turn:
2. `gh issue list -R leshchenko1979/opencrabs --state open` — fresh receipt,
   never from memory.
3. Diff the OPEN set against the workers-ledger claim-refs
   (`grep -c '"issue'` or the claim rows) — an OPEN fork issue with NO
   open claim-ref is unclaimed backlog.
4. For each unclaimed issue: route to the owning editor (Duty T2), or if
   none is obvious, surface the unclaimed set to the Supervisor for
   dispatch — do NOT let it sit silent (the v0.4.91 gap: "claimed when
   someone claims it" is not assignment).
5. Already-claimed issues: no action; the owning editor's chain owns them.

**Never:** close or park an issue on your own authority — closure follows
the harvest law (fork issue closes only after its upstream PR is filed).
This sweep SURFACES; it does not dispose.

## Escalation to the Supervisor (Author lane)

WHAT escalates: ACCEPT-MECHANICAL batch items, KERNEL-SEMANTIC verdicts,
protocol disputes, skill-edit requests, semantic questions, sanctioned-sender
judgments, upstream matters, owner-verdict-table material.

HOW: `session_notify` per fleet-directives §Cross-lane delivery (cadence law
canonical — quiet DEFAULT, turn-end for boundary-bound, `interrupt=true`
failsafe only). Batch at turn-end — one notify with
N items beats N notifies. Receipts, ACKs, and ROUTED stamps NEVER escalate;
they live in the ledger.

WHAT comes back: the Supervisor's rulings and version batches absorb here the
same way they absorb everywhere — disk absorption (§Glossary, SKILL.md),
zero-ping (supervisor.md Duty 3).
