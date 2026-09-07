# Duty-6 Review — Lens B (LLM EFFICIENCY + RESPONSIBILITY CREEP) — 2026-08-31
Reviewer: sub-agent 539cd459 (read-only). Supervisor persists per Duty 6 §3.
Measurement: SKILL.md ≈10.5k tok, editor.md ≈8.9k, supervisor.md ≈3.8k; editor full-load mandate ≈19.4k tok.

## Findings (13) — HIGH 1, MED 6, LOW 6
11. SKILL.md §Shared war stories closing line "AGENTS.md carries only the pointer" is FALSE · scope-creep · ops AGENTS.md L88/89 duplicate row, L93 archived-role duty in present tense (compiler path not repointed, missed by v0.4.44 sweep), L97 stale "tackling comment" procedure contradicting §ISSUE ROUTING, L152 pins v0.4.29 (live 0.4.56) · reduce AGENTS.md to pointers + add it to repoint sweeps · HIGH
8. supervisor.md Duty 6 §3 hand-write persistence predates oc-review-persist (v0.4.45), contradicts SKILL.md row path (oc-work/ vs tool default /tmp), nothing persisted per either text until today · dead-ref · rewrite to `oc-review-persist <lens> @<file>` + fix SKILL.md row path · MED
7. editor.md CI-wait "named in its ROSETTE" — occurs once on disk, undefined · dead-ref · replace with runtime-prompt source · MED
12. editor.md CI-wait item 1 carrier-wait clause contradicts editor's own NEVER-watch-builds scope · scope-creep · strike carrier clause, supervisor-owned · MED
1. Editor full-load mandate carries ~1.6k tok supervisor-only SKILL.md content · token-weight · demote supervisor-tagged rows, tag Upstream-relations owners · MED
3. oc-ledger register row ~320 tok of supervisor-internal mechanics; editors use 2 verbs · token-weight · compress + pointer · MED
5. §Shared environment facts 13 same-shape bullets ≈1.5k tok prose · prose-as-table · convert to Topic|Fact|Rule table · MED
2. Retired oc-consent-check register row ~120 tok · token-weight · delete row (CONSENT REGISTER carries policy) · LOW
4. IDEA template forces loading supervisor.md · token-weight · inline template · LOW
6. Duty 2 ledger schema as prose · prose-as-table · field table · LOW
9. "SKILL.md §Tool table" anchor dead (section = §Canonical tooling); compiler.md ×2, editor.md Phase 5 · dead-ref · repoint · LOW
10. SKILL.md Upstream item 6 orphaned "(c)" label, no (a)/(b) · dead-ref · drop marker · LOW
13. supervisor.md Duty 3 inbox discipline for the retired build lane, superseded ORDER vocabulary · scope-creep · move to archive runbook · LOW
