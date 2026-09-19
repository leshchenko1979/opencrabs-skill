# Duty-6 Review — Lens B (STRUCTURE: LLM-efficiency + responsibility creep), re-dispatch run (re-persisted 2026-09-06; original B report was lost to phantom-persist; r2 agent 0077b0e2, all quotes re-verified on disk this run; frontmatter v0.4.85)

Scope honored: review-lenses.md §Reviewer B brief; G1-G8 not duplicated; prior round's claims treated as hypotheses — several were wrong (B-11).

## Findings

**B-1 · HIGH — Two contradictory resume paths for the same rc-5 condition, same list.** editor.md:113-114 (item 7: "resume via `gh run view <id>` / a read-only poller") vs editor.md:135 (item 10: "Re-attach to a witnessed run with `oc-prchecks resume <run-id>`"). Tool truth verified: resume verb EXISTS (oc-prchecks:85-86, selftest :249-267) — item 10 current, item 7 is superseded v0.4.71 text whose "read-only poller" route is exactly the hand-rolled poller item 10/W4 forbid. Cross-ref: oc-prchecks:476/:490 rc-5 stdout prints "resume: gh run view" — F's. Resolution: item 7 resume clause → "per item 10". LANDED in v0.4.85 amendment (c16706b9).

**B-2 · HIGH — Overruled Duty-1 war-story clause still live.** supervisor.md:41-42 "Every change carries provenance: date + the incident/run-id… A rule without a war story rots into folklore" vs fleet-directives.md F13 ("rule text carries NO biography… CHANGELOG at ship time", owner "Approve all"). Provenance chain: A-lens F13 → owner word → fleet-directives landed — but the losing text stood as live Duty-1 procedure; a supervisor following Duty 1 verbatim violates F13 on the next bump. Resolution: Duty-1 → "Provenance = the `## v<v>` CHANGELOG entry, written at ship time". LANDED (c16706b9).

**B-3 · HIGH — v0.4.85 release record claimed edits not in the shipped tree (CHANGELOG-vs-disk drift).** CHANGELOG.md:311 claimed G4 (7→8 lens counts) but SKILL.md:122 "7-lens", review-lenses.md:3 "seven", supervisor.md:130 "(A/B/C/D/E/F/G)" were unedited; CHANGELOG.md:310 claimed Duty-3 cadence fix but supervisor.md:87-88 still carried "interrupt=true for operational wakes… default". Verified REAL by supervisor re-check before fix. Resolution: edits landed + v0.4.84 bullet promoted (B-10) — c16706b9, battery PASS 144/0. NOTE: this is the phantom-persist family hitting the batch record itself; acceptance greps now run per CHANGELOG claim.

**B-4 · MED — Supervisor-only tool rows in the shared full-read path.** SKILL.md is re-read IN FULL on every editor claim (Phase 1 step 0) yet carries supervisor-only rows: :60 oc-issue-sweep, :61 oc-skew-scan, :71 oc-tg-audit, oc-review-persist/oc-ship-audit/oc-ping-proof/oc-ledger confirm/cadence rows; oc-ledger row ~150 words of editor-never-invoked verbs. Resolution: audience-tag + push detail behind pointers. QUEUED.

**B-5 · MED — Tool table violates its own "purpose only" contract (SKILL.md:44 vs oc-prchecks/oc-ledger rows carrying version history + incident citations).** Resolution: history → CHANGELOG (F13) at next batch. QUEUED.

**B-6 · MED — "HQ" vs "supervisor lane" identity split + MAY/MUST divergence.** fleet-directives.md:91 (2026-09-03 owner ruling: the supervisor lane IS OC DEV HQ) vs editor.md:68 ("If HQ is unreachable, fallback is the supervisor lane" — fallback == primary now) vs supervisor.md:177 MAY vs :200 MUST, 23 lines apart. Resolution: one name everywhere, delete editor fallback clause, align Duty-7 to MUST. QUEUED.

**B-7 · MED — oc-waiter env-knob census in editor reading path though carrier waits are supervisor-owned** (editor.md item 10 ~:133-137 full arm spec + env knobs vs supervisor.md W4 repeat). Resolution: editor keeps prohibition + one-line pointer to W4. QUEUED.

**B-8 · MED — fleet-directives accreting editor procedure against its charter** (§:3 "carries only a pointer" vs tail 155+: Lint pre-claim, cross-fork fetch, truncated-window — Phase-7-shaped how-tos in the file BOTH roles load in full, absent from editor.md Phase 7). Resolution: move procedures into editor.md Phase 7; directives keep one-line rulings. QUEUED.

**B-9 · LOW — NO-OP sentences:** editor.md:349 "Reuse beats re-implement." (restates DRY default); editor.md:41 "Never compile locally." (paid for by its own §Box law). Resolution: cut both tails. QUEUED.

**B-10 · LOW — CHANGELOG v0.4.84 legacy one-line bullet breaks the format contract** (header: structured `##` entries; sandwiched between structured v0.4.83/v0.4.85 — a `^## v` consumer misses it). Resolution: promoted (c16706b9). LANDED.

**B-11 · INFO — Dead-ref sweep CLEAN; two lost-round claims corrected.** `oc-prchecks resume` EXISTS (not dead); RC-CONTRACT covers oc-waiter/oc-review-persist (not dead); SKILL.md version 0.4.85 matches — "frontmatter stale" suspicion moot. Lost-round corrections: "missing v0.4.84" was wrong (entry exists as bullet); "resume dead ref" was wrong (defect is the doc contradiction).

## Verdict
3 HIGH / 5 MED / 2 LOW / 1 INFO. B-1/B-2/B-3/B-10 landed same-session (v0.4.85 amendment c16706b9, battery PASS 144/0); B-4..B-9 queued for next batch. No overlap with G1-G8 or A's F-numbers beyond acknowledged boundaries. Yield: 10 actionable, 4 landed, 6 queued.
