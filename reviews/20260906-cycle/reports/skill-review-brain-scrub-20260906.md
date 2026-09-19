# Duty-6 Review — brain-scrub lens (ops profile brain files), executed + persisted 2026-09-06

Lens registered this battery (oc-review-persist LENSES += brain-scrub, fleet-directives §). Scope: ~/.opencrabs/profiles/ops/{AGENTS,MEMORY}.md — scrubbing content that is purely opencrabs-dev process law and should live in the skill (one concept, one home), per the 2026-09-05 new-rules routing law. Findings verified against disk before any edit; shrinks owner-approved ("Approve all" 04:38Z, decision 5); land-in-skill-first honored.

## Findings ×8

**HIGH ×2 — AGENTS.md carries full law text duplicating richer skill canon:**
- Lane-briefing channel (3 lines of full law) — canonical richer copy at fleet-directives.md:86 (§Creating new editors item 3, incl. the owner-visibility exception the AGENTS.md copy lacked). SHRUNK to pointer.
- Cross-lane delivery cadence (full quiet/turn-end/now + escalation text) — canonical fleet-directives.md §Cross-lane message delivery discipline (`bb402cbf`). SHRUNK to pointer.

**HIGH ×2 — MEMORY.md stale law (dangerous if followed):**
- modum sanction line: "Sanctioned local tools: `modum` (lint) + rustfmt wrapper" — modum RETIRED; following the line would bless a dead binary. SCRUBBED (rustfmt wrapper only, lint = CI dispatch).
- Hand-rolled cron_manage poller watcher pattern (post-upstream-merge rounds lesson) — superseded same day by oc-waiter (editor.md §CI-wait item 10, v0.4.83; hand-rolled pollers forbidden). SCRUBBED: rule kept (same-turn proof), prescription replaced with oc-waiter pointer + supersession note.

**MED ×2 — laws living only in passive MEMORY.md (don't bind cold sessions; skill didn't have them):**
- Daemon no-reap / ruling 1273 (ops-unit restarts only; default daemon on old binary = expected). LANDED: fleet-directives §Daemon no-reap (F5). MEMORY copy left as dated history.
- Inherited-claim three-pillar verification (artifact exists / evidence live-verified by adopter / no newer state invalidates). LANDED: fleet-directives §Inherited-claim three-pillar verification (F6).

**LOW ×2 — noted, no action (extend-or-leave):**
- Verified-write rule (MEMORY) — generalizes the AGENTS.md execution-discipline family; already shadowed by "verify everything". Leave.
- Loop-guard resume rules (MEMORY) — dated war story, no live prescription conflict. Leave.

## Execution receipts
- AGENTS.md: 2 law-text bullets → pointers (write_opencrabs_file dedup_intent, owner-approved).
- MEMORY.md: 2 stale prescriptions scrubbed (python replace, anchors asserted, grep-verified 0 residual).
- fleet-directives.md: F5 + F6 sections appended (land-in-skill-first BEFORE scrub).
- Shipped in skill v0.4.85 (32952a69, push receipt 25602f83..32952a69 main->main; battery PASS 144/0).
