# review-lenses.md — Duty-6 reviewer lens catalog (B4+G-F4 split, v0.4.78)

Full briefs for the seven Duty-6 review lenses. supervisor.md §Duty 6 owns the
method (read-only sub-agents, verbatim-quote verification, oc-review-persist
persistence, poll triple-check, verdict table) and keeps only the family map
there; this file owns the per-lens scope briefs. Letters keep chronological
birth order (stable report/persist keys, not an ordering). Reviewer-performance
loop lessons (supervisor.md step 7) fold INTO these briefs at ship time,
attributed to the reviewer that produced the evidence.

#### FAMILY: DOCS — role files (wording / reading load / organization)

   - **Reviewer A — REDUNDANCY + ONTOLOGY:** same rule stated twice across
     files; duplicated war stories; terms violating the SKILL.md test ontology
     (SMOKE TEST / CODE TESTS / FEATURE-PRESENCE CHECK / EXECUTION SANITY
     SIGNAL); undefined coinages; stale ref names; SEDIMENT — stale layers
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
     — editor.md, supervisor.md, SKILL.md, review-lenses.md — phase/duty ordering vs actual
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

#### FAMILY: TOOLS — the tools/ surface (surface shape / implementation)

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

#### FAMILY: EVIDENCE + LIFECYCLE — logs, artifacts, retirement (C usage-log YAGNI evidence feeds D deletion verdicts)

   - **Reviewer C — CLI-AUTOMATION:** recurring multi-step MANUAL rituals in
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
     cite the log rows they rest on.
   - **Reviewer D — DELETION SAFETY:** enumerate retired / stale /
     duplicate-looking artifacts in the skill scope (files, state files,
     ledgers, markers, tool flags) and for EACH list what reads or writes it
     (grep tools/, crons, skill files, journal vocabulary), then classify
     DELETE-SAFE / ARCHIVE / KEEP with that reference list as the evidence.
     "Looks stale" is a hypothesis, never a verdict. Nothing deletes without
     the Supervisor's poll triple-check + owner word.
