# review-lenses.md — Duty-6 reviewer lens catalog (B4+G-F4 split, v0.4.78)

Full briefs for the ten Duty-6 review lenses (A–I + standing brain-scrub; regrouped v0.4.81 with C joining TOOLS and D sole in ARTIFACTS — H later joined D in ARTIFACTS, v0.4.113/115). supervisor.md §Duty 6 owns the
method (read-only sub-agents, verbatim-quote verification, oc-review-persist
persistence, poll triple-check, verdict table) and keeps only the family map
there; this file owns the per-lens scope briefs (brain-scrub brief lives at fleet-directives.md § Review lens brain-scrub). Letters keep chronological
birth order (stable report/persist keys, not an ordering). Reviewer-performance
loop lessons (supervisor.md step 7) fold INTO these briefs at ship time,
attributed to the reviewer that produced the evidence. Family identity is the
OBJECT under review, not the evidence flow between lenses (regrouped v0.4.81:
C joined TOOLS — gaps/shape/implementation pipeline; D is sole in ARTIFACTS,
the family IS the deletion owner gate). Membership and grouping change only
on census evidence + owner word (supervisor.md step 7).

#### FAMILY: DOCS — role files (wording / reading load / organization)

   - **Reviewer A — REDUNDANCY + ONTOLOGY:** same rule stated twice across
     files; duplicated war stories; terms violating the SKILL.md test ontology
     (SMOKE TEST / CODE TESTS / FEATURE-PRESENCE CHECK / EXECUTION SANITY
     SIGNAL); undefined coinages; stale ref names (lens I-2.2
     v0.4.116: A owns ref CONSISTENCY; B weighs refs only as load-weight —
     first finder gets attribution); SEDIMENT — stale layers
     that survive because adding feels safe and removing feels risky
     (docs-lens vocabulary reference:
     `skills/writing-great-skills/SKILL.md`). PLUS the churn-drift checklist, EVERY
     lens-A pass: (a) ONE CONCEPT = ONE NAME — sweep for synonyms of the same
     gate/tool/artifact; (b) GLOSSARY CONFORMANCE — every load-bearing term
     in a rule must resolve in SKILL.md §Glossary or §Test ontology;
     (c) POST-MIGRATION PATH SWEEP — after any artifact/path migration grep
     the ROOT literal of the OLD location (not the artifact name) across all
     three skill files; (d) ENUMERATION CONSISTENCY — counts of lenses/tools/
     gates/phases in prose must match their defining sections; (e) RETIRED
     CONCEPTS MARKED — any mention of a retired role/tool carries
     RETIRED + date, never present-tense; (f) LEADING-WORD COLLAPSE — prose
     restating one quality across a phrase list or spelling the same idea
     out at 2+ sites collapses into a single pretrained leading word; a
     restatement is duplication wearing prose. PLUS PROVENANCE SEDIMENT:
     live rule text carries the RULE, never its biography — owner-directive
     parentheticals, incident dates, "first pass shipped ..." notes,
     STRENGTHENED markers move to CHANGELOG.md at ship time; a lens finding
     names each offender.
   - **Reviewer B — LLM EFFICIENCY + RESPONSIBILITY CREEP:** token weight of
     each role's required reading (a worker must not need another role's
     procedures), prose that should be tables, dead references, duties
     migrating across Supervisor/Editor scope lines (Compiler archived).
     PLUS the NO-OP TEST sentence by sentence (docs-lens vocabulary
     reference: `skills/writing-great-skills/SKILL.md`) — a line the model
     already obeys by default is load paid for nothing (does it change
     behavior vs the default? the fix is a stronger term, not a longer
     sentence); reference that belongs behind a context pointer to a linked
     file instead of inline (progressive disclosure — the information
     hierarchy: in-skill steps with checkable completion criteria, in-skill
     reference, external reference); and SPRAWL — a file too long even when
     every line is live and unique (cure: disclose reference, then split by
     branch — not word-trimming).
   - **Reviewer G — ROLE-FILE STRUCTURE:** the ORGANIZATION of EACH role file
     — the role files (re-derived from `ls *.md` at spawn time; count not
     hardcoded — lens G-F8 v0.4.89) plus every
     split-out reference page in the skill root, re-derived from `ls *.md`
     at spawn time (objects rot, the dimension doesn't) — phase/duty ordering vs actual
     work sequence, sections grown past cohesion (one section = one concern),
     rules living in the wrong section, cross-reference integrity after
     edits, whether a file should split (e.g. per-phase reference pages) or
     regroup. Every STEP in a role file must end on a CHECKABLE completion
     criterion (can the agent tell done from not-done? vague criteria invite
     premature completion). Before any split verdict, test the cheaper
     ladder moves first: disclose reference behind a context pointer, regroup
     for CO-LOCATION (a concept's definition, rules, and caveats under one
     heading). Findings must weigh the cost of a split (cross-refs, worker
     reading load) against the cost of growth.
     LOAD-PATH MANDATE (owner order 2026-09-07): any split or regroup verdict
     MUST also trace the skill's LOADING — which parts are always-injected
     (AGENTS.md anchors) vs on-demand (`load_brain_file` / SKILL.md section
     loads) — and verify every moved section remains reachable on the paths
     its readers actually use: the anchor line still points at the new home,
     the post-compaction re-load hint still names a file that holds the rule,
     and nothing a role loads by habit (supervisor duties, editor phases)
     lands only in a file that role never opens. A split that breaks the
     load path is a REGRESSION finding against itself, not a cleanup.

#### FAMILY: TOOLS — the tools/ surface (gaps / shape / implementation)

   - **Reviewer C — CLI-AUTOMATION + USAGE GAPS:** recurring multi-step MANUAL
     rituals in
     any role's procedure that are deterministic enough to be one CLI command
     (state-file sealing, presence gates, checksums, roster pulls, receipt
     delivery). Each finding names the proposed tool + its single-command
     interface. EXCLUDES: one-off steps, human-judgment calls (approval
     gates, smokes), anything already a gate. Candidates feed the
     Supervisor's process-tool ownership (scope above). PLUS USAGE-LOG
     ANALYSIS: every C pass reads the actual tool records — state-dir
     `tools.log`, `oc-deploy/journal/*.jsonl`, `workers-ledger.json` events,
     smoke-verdicts — and derives ground truth no prose review can: which
     verbs/flags are really invoked and how often, rc distributions (a tool
     whose calls cluster on rc 2 is a broken interface), documented tools
     never invoked in the window (YAGNI/deletion evidence for Reviewer D),
     hand-built ritual artifacts that a proposal should replace. Findings
     cite the log rows they rest on. ADOPTION-COMPLIANCE CHECK (v0.4.120,
     owner-ordered): every C pass samples runtime `Detaching '...'` records
     and flags ANY `gh run watch` / hand-rolled nohup CI poller spawn as a
     law violation (one-watcher law, editor.md) — official surfaces are
     `oc-waiter arm` and one-shot `gh run view`; also flags
     `oc-prchecks --wait` used as a verdict waiter (double-duty). Each
     violation names the session id from the log row. Boundary watch vs A/B: C's dimension is
     GAPS (what should be a command), not doc wording or weight.

   - **Reviewer E — INTERFACE/TOPOLOGY:** the TOOL SURFACE itself — pairs of
     tools whose invocations are bound to come one after another in practice
     (merge candidates), verbs that belong in one tool instead of two, a flag
     duplicating another tool's job, a ritual two tools cover in half each.
     Lens A reviews duplicate RULES; E reviews duplicate/chainable INTERFACES.
     Each finding names the merge/verb-move + its single-command shape.
     EXCLUDES: one-off chains, anything with an approval gate between the
     steps (a gate is human judgment — never merged away).
   - **Reviewer F — TOOL CODE REVIEW:** the tools/ implementations themselves
     — shell correctness (quoting, set -e gaps, rc collisions with the
     documented rc register), journaling completeness (every state-changing
     step writes its log line BEFORE the next step — owner tool-logging
     rule), selftest coverage vs the documented interface, dead flags/verbs,
     divergence between SKILL.md tool-table rows and actual behavior (flags,
     rc, paths). Findings cite file:line.

#### FAMILY: EFFICIENCY — SKILL.md size budget (lens B F3/F18, v0.4.96)

   - **SKILL.md BUDGET RULE:** SKILL.md is the always-loaded router — every
     line costs 4x (all four roles re-read it IN FULL under the RELOAD LAW).
     It carries: hard rules, ontology/glossary, tool-table PURPOSE-only rows,
     role routing, load paths. Executable procedure, verb vocabularies, and
     step-by-step mechanics belong in the owning role file or reference page
     (RC-CONTRACT.md = SOLE tool register). Every Duty-6 pass re-weighs
     SKILL.md against this rule; growth beyond router scope = findings.

#### FAMILY: ARTIFACTS — files, state, ledgers, flags (deletion verdicts — the family IS the owner gate; C usage-log YAGNI evidence feeds it from TOOLS)

   - **Reviewer D — DELETION SAFETY:** enumerate retired / stale /
     duplicate-looking artifacts in the skill scope (files, state files,
     ledgers, markers, tool flags) and for EACH list what reads or writes it
     (grep tools/, crons, skill files, journal vocabulary), then classify
     DELETE-SAFE (evidence law, folded from D's own method note v0.4.116:
     a zero-hit claim from a |-pattern grep in literal mode is UNVERIFIED —
     quote the query + scope for every negative-existence claim) / ARCHIVE / KEEP with that reference list as the evidence.
     "Looks stale" is a hypothesis, never a verdict. Nothing deletes without
     the Supervisor's poll triple-check + owner word.
   - **Reviewer H — LEDGER HEALTH (shipped v0.4.114, owner GO 2026-09-08 20:16Z):**
     the workers-ledger.json read AS A WHOLE, not per-slice — the slice tools
     (`oc-ledger claims`, `oc-ship-audit`, `oc-waiter-sweep`) each audit one
     family and stay the enforcement surface; H reads for what they cannot
     see: (1) RECEIPT COMPLETENESS — incident/lesson-mention rows with no
     corresponding codified rule in fleet-directives.md/editor.md/AGENTS.md
     (lesson-extraction completeness; each finding names the row AND the law
     home that should carry it, or the explicit owner waiver), (2) PHANTOM
     FAMILIES — rows claiming stamps/writes/deliveries with no same-turn tool
     receipt verifiable from the row's own citations (the n=1845/n=1555 class),
     (3) CLAIM LIFECYCLE — open claim-refs whose chains closed (merged/shipped/
     retracted) without a release row, (4) CONTRADICTION PAIRS — later rows
     asserting the opposite of earlier rows for the same object without a
     retraction, (5) CADENCE/VERSION SYNC — skill-bump rows vs tags vs
     CHANGELOG monotonicity. Evidence format unchanged: every finding cites
     the ledger row n + the verifiable artifact (git/gh/log) that confirms or
     breaks it — quote-or-no-finding. H reviews the JOURNAL, never edits it;
     corrections land as new rows or law edits via the Supervisor.
   - **Reviewer I — META-REVIEW (added v0.4.114, owner pick 2026-09-08 ~20:4xZ, recommended shape 1):**
     reviews the LENS CATALOG AND ITS OUTPUT — the only reviewer whose object
     is the review machinery itself. Scope: (1) BRIEF CORRECTNESS — each brief
     in this file (A–I) still matches what its reviewer actually checked in
     the latest persisted report (scope drift, stale check classes), (2)
     OVERLAP — findings double-covered by two lenses, or coverage GAPS where
     no lens owns an artifact class, (3) FALSE-POSITIVE/NEGATIVE HISTORY —
     per-lens accuracy record from the Supervisor's premise-verification
     history (precedents: brain-scrub "cargo ban homeless" overstatement, the
     B-8 misattribution — both rejected 2026-09-08), (4) EVIDENCE DISCIPLINE —
     quote-or-no-finding adherence rate in persisted reports (I-4.1
     v0.4.116 evidence unit: locator + verbatim snippet for HIGH/P-class;
     locator-only permitted for mechanical nits; volatile files cited by
     section header + short quote, line numbers secondary — I-4.2).
     CORPUS (I-5.1 v0.4.116): durable reports live in
     `reviews/<cycle>/reports/`; when two skill-review-index.log files
     diverge, the CYCLE-LOCAL index wins over the root one. Severity scale:
     HIGH (load-bearing lie / stall class) · MED (real gap, bounded blast
     radius) · LOW (nit). I reads
     persisted reports + this catalog + the Supervisor's validation notes; it
     does NOT re-litigate findings already triple-checked, it audits the
     PATTERN. Output feeds catalog brief edits and reviewer spawning. Same
     quote-or-no-finding evidence rule. Self-reference cap: I may flag its own
     brief's defects, but never reviews its own report (recursion capped at
     one level).
