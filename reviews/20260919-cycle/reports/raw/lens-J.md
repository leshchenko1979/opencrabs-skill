I'll start by reading my brief.


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"# review-lenses.md — Duty-6 reviewer lens catalog (B4+G-F4 split, v0.4.78)\n\nFull briefs for the eleven Duty-6 review lenses (A–J + standing brain-scrub; regrouped v0.4.81 with C joining TOOLS and D sole in ARTIFACTS — H later joined D in ARTIFACTS, v0.4.113/115; the MECHANICAL family + Reviewer J added v0.4.161 on owner order). hq.md §Duty 6 owns the\nmethod (read-only sub-agents, verbatim-quote verification, oc-review-persist\npersistence, poll triple-check, verdict table) and keeps only the family map\nthere; this file owns the per-lens scope briefs (brain-scrub brief lives at review-lenses.md § Review lens brain-scrub). Letters keep chronological\nbirth order (stable report/persist keys, not an ordering). Reviewer-performance\nloop lessons (hq.md step 7) fold INTO these briefs at ship time,\nattributed to the reviewer that produced the evidence. Family identity is the\nOBJECT under review, not the evidence flow between lenses (regrouped v0.4.81:\nC joined TOOLS — gaps/shape/implementation pipeline; D is sole in ARTIFACTS,\nthe family IS the deletion owner gate). Membership and grouping change only\non census evidence + owner word (hq.md step 7).\n\n#### FAMILY: DOCS — role files (wording / reading load / organization)\n\n   - **Reviewer A — REDUNDANCY + ONTOLOGY:** same rule stated twice across\n     files; duplicated war stories; terms violating the SKILL.md test ontology\n     (SMOKE TEST / CODE TESTS / FEATURE-PRESENCE CHECK / EXECUTION SANITY\n     SIGNAL); undefined coinages; stale ref names (lens I-2.2\n     v0.4.116: A owns ref CONSISTENCY; B weighs refs only as load-weight —\n     first finder gets attribution); SEDIMENT — stale layers\n     that survive because adding feels safe and removing feels risky\n     (docs-lens vocabulary reference:\n     `skills/writing-for-agents/SKILL.md`). PLUS the churn-drift checklist, EVERY\n     lens-A pass: (a) ONE CONCEPT = ONE NAME — sweep for synonyms of the same\n     gate/tool/artifact; (b) GLOSSARY CONFORMANCE — every load-bearing term\n ","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"     <DIR>  2026-09-19 04:09:35  reviews/\n     <DIR>  2026-09-18 20:33:34  run/\n     <DIR>  2026-09-19 03:52:20  tools/\n    278084  2026-09-18 20:01:51  CHANGELOG.md\n      5494  2026-09-19 03:38:59  README.md\n     46882  2026-09-19 03:33:57  SKILL.md\n     31523  2026-09-19 02:04:11  editor-upstream-pr.md\n     52141  2026-09-19 03:38:51  editor.md\n     73666  2026-09-19 03:38:15  fleet-directives.md\n     25990  2026-09-19 02:04:11  hq.md\n     21338  2026-09-19 02:04:11  review-lenses.md\n      6810  2026-09-19 00:57:11  s2-swap-journal-spec.md\n     12771  2026-09-19 00:52:54  toolsmith.md\n     28997  2026-09-19 02:04:11  triage.md\n     47129  2026-09-19 00:54:19  upstream-merge-runbook.md\n     15578  2026-09-11 11:46:36  war-stories.md\n","s":true}] -->
<!-- reasoning -->
I need to find the Reviewer J entry in review-lenses.md. The output was truncated. Let me grep for "Reviewer J".
<!-- /reasoning -->

Let me locate the Reviewer J entry specifically.


<!-- tools-v2: [{"d":"Grep 'Reviewer J' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"[SKILL GATE] This call touches '/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md' which matches skill 'opencrabs-dev' (globs: ~/opencrabs/**, ~/oc-wt-*/**, ~/.opencrabs/profiles/*/skills/opencrabs-dev/**, ~/.opencrabs/profiles/*/opencrabs-dev/**, ~/.opencrabs/profiles/*/projects/opencrabs-dev/**), not loaded in the current session context. The full skill body follows. Read it, then re-issue the identical call.\n\n---\n\n# opencrabs-dev — OpenCrabs source procedure\n\n**Owns:** everything touching `~/opencrabs` source, its GitHub Actions runs, or the\ninstalled `opencrabs` binary. This file = shared facts + role router only. Actual\nprocedures live in FOUR role files (`editor.md` / `hq.md` / `triage.md` / `toolsmith.md`);\nload ONLY the one matching the session's role.\n\n**Binding owner directives** (sync policy, upstream PR law, carriers/builds, cargo\nprohibition, telegram surface law, tool logging, gates, editor creation, tool-problem triage (Triage lane),\ncadence) live in `fleet-directives.md` — re-homed from ops AGENTS.md/MEMORY.md per\nowner order 2026-09-02. Load it before ANY opencrabs-dev work. Executing procedure for the sync\npolicy's rebase procedure: `upstream-merge-runbook.md` (freeze gate, roles, conflict\nclasses, migration-union rule, semantic-triage defaults).\n\n## STEP ZERO — establish the role (mandatory on every load)\n\nAsk the operator which role this session employs before doing anything:\n\n> **Editor, HQ, Triage, or Toolsmith?**\n\n| Role | Owns | Procedure file |\n|------|------|----------------|\n| **EDITOR** | Commits + error fixes: claim issue → worktree → code → CI gate → sign → push → ff-merge into fork `main` → `oc-deploy ship` → smoke on notify; feature COMPLETE → upstream PR filed on smoke PASS (procedure `editor-upstream-pr.md` Phase 7) | `editor.md` |\n| **HQ** | Skill set maintenance, worker ledger, Duty 4 worker polls, Duty 6 periodic 11-lens reviews (details in `hq.md` and `review-lenses.md`) | `hq.md` |\n| **TRIAGE** | Intake & hygi","s":false},{"d":"Grep 'MECHANICAL' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md:3:\n  1: # review-lenses.md — Duty-6 reviewer lens catalog (B4+G-F4 split, v0.4.78)\n  2: \n> Full briefs for the eleven Duty-6 review lenses (A–J + standing brain-scrub; regrouped v0.4.81 with C joining TOOLS and D sole in ARTIFACTS — H later joined D in ARTIFACTS, v0.4.113/115; the MECHANICAL family + Reviewer J added v0.4.161 on owner order). hq.md §Duty 6 owns the\n  4: method (read-only sub-agents, verbatim-quote verification, oc-review-persist\n  5: persistence, poll triple-check, verdict table) and keeps only the family map\n  6: there; this file owns the per-lens scope briefs (brain-scrub brief lives at review-lenses.md § Review lens brain-scrub). Letters keep chronological\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md:112:\n  109:      lands only in a file that role never opens. A split that breaks the\n  110:      load path is a REGRESSION finding against itself, not a cleanup.\n  111: \n> #### FAMILY: MECHANICAL — the law corpus read against on-disk state (enforceability class; family + Reviewer J added v0.4.161 on owner order)\n  113: \n  114:    - **Reviewer J — MECHANICAL ENFORCEMENT (law that should be a tool):** the LAW\n  115:      CORPUS itself — `SKILL.md`, `fleet-directives.md`, `editor.md`,\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md:114:\n  111: \n  112: #### FAMILY: MECHANICAL — the law corpus read against on-disk state (enforceability class; family + Reviewer J added v0.4.161 on owner order)\n  113: \n>    - **Reviewer J — MECHANICAL ENFORCEMENT (law that should be a tool):** the LAW\n  115:      CORPUS itself — `SKILL.md`, `fleet-directives.md`, `editor.md`,\n  116:      `editor-upstream-pr.md`, `hq.md`, `triage.md`, `toolsmith.md`,\n  117:      `tools/RC-CONTRACT.md` — read as a specification of WHO DECIDES, and asked of\n\n(3 matches)","s":true}] -->
<!-- reasoning -->
The skill gate blocked my reads. I need to load the skill. Actually the grep returned results, but the read_file returned the SKILL gate message. Interesting — grep worked. Let me read the Reviewer J section from review-lenses.md lines 108-160.

Actually, the SKILL GATE response says "Read it, then re-issue the identical call." But it dumped SKILL.md instead. Let me just read the relevant line range with read_file and see if it passes now. Actually the gate applies per-file. Let me try grep with more context on the Reviewer J entry, which worked.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'Reviewer J — MECHANICAL ENFORCEMENT' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md:114:\n  74:      PLUS the SUBSUMED PROCEDURE PRUNING RULE (v0.4.182): when a composite or\n  75:      milestone tool ships (e.g. `oc-start`, `oc-ship-chain`, `oc-smoke`),\n  76:      lower-level step-by-step plumbing rituals (manual worktree manipulation,\n  77:      manual `oc-prchecks` loops, manual issue log comments, manual push to main,\n  78:      manual log formatting) must be aggressively pruned from role files.\n  79:      Role files must document only the single milestone invocation and its\n  80:      recovery semantics, not internal plumbing procedures the tool handles.\n  81:    - **Reviewer G — ROLE-FILE STRUCTURE:** the ORGANIZATION of EACH role file\n  82:      — the role files (re-derived from `ls *.md` at spawn time; count not\n  83:      hardcoded — lens G-F8 v0.4.89) plus every\n  84:      split-out reference page in the skill root, re-derived from `ls *.md`\n  85:      at spawn time (objects rot, the dimension doesn't) — phase/duty ordering vs actual\n  86:      work sequence, sections grown past cohesion (one section = one concern),\n  87:      rules living in the wrong section, cross-reference integrity after\n  88:      edits, whether a file should split (e.g. per-phase reference pages) or\n  89:      regroup. Every STEP in a role file must end on a CHECKABLE completion\n  90:      criterion (can the agent tell done from not-done? vague criteria invite\n  91:      premature completion). Before any split verdict, test the cheaper\n  92:      ladder moves first: disclose reference behind a context pointer, regroup\n  93:      for CO-LOCATION (a concept's definition, rules, and caveats under one\n  94:      heading). Findings must weigh the cost of a split (cross-refs, worker\n  95:      reading load) against the cost of growth.\n  96:      PLUS the EXPLORATION & DRY VERIFICATION GATE (v0.4.182): every code-producing\n  97:      role file (e.g. `editor.md` Phase 3) MUST explicitly mandate structural sy","s":true}] -->
<!-- reasoning -->
Let me get the rest of the Reviewer J entry (lines 152-180).
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"     procedure → C.\n     BOUNDARY vs D/H (v0.4.162, from I-7.1) — the ARTIFACTS family owns the\n     ARTIFACT and its verdict: D asks what still reads or writes a file, flag or\n     marker, H asks whether the ledger's own record is coherent, and both end in an\n     HQ poll triple-check + owner word. J owns the LAW SENTENCE that assigns the\n     decision. So a rule telling a lane to look up whether an artifact is still\n     referenced is J's finding — the lookup is state-derivable and belongs in a\n     tool — while the DELETE / ARCHIVE / KEEP verdict stays D's. One site, one lens:\n     object is an artifact on disk → D/H; object is law text whose decision is\n     state-derivable → J.\n\n#### FAMILY: TOOLS — the tools/ surface (gaps / shape / implementation)\n\n   - **Reviewer C — CLI-AUTOMATION + USAGE GAPS:** recurring multi-step MANUAL\n     rituals in\n     any role's procedure that are deterministic enough to be one CLI command\n     (state-file sealing, presence gates, checksums, roster pulls, receipt\n     delivery). Each finding names the proposed tool + its single-command\n     interface. EXCLUDES: one-off steps, human-judgment calls (approval\n     gates, smokes), anything already a gate. Candidates feed the\n     HQ's process-tool ownership (scope above). PLUS USAGE-LOG\n     ANALYSIS: every C pass reads the actual tool records — state-dir\n     `tools.log`, `oc-deploy/journal/*.jsonl`, `workers-ledger.json` events,\n     smoke-verdicts — and derives ground truth no prose review can: which\n     verbs/flags are really invoked and how often, rc distributions (a tool\n     whose calls cluster on rc 2 is a broken interface), documented tools\n     never invoked in the window (YAGNI/deletion evidence for Reviewer D),\n     hand-built ritual artifacts that a proposal should replace. Findings\n     cite the log rows they rest on. ADOPTION-COMPLIANCE CHECK (v0.4.120,\n     owner-ordered): every C pass samples runtime `Detaching '...'` records\n     and flags ANY `gh run watch` / hand-","s":true}] -->
<!-- reasoning -->
Now I have the full Reviewer J brief. Key: T1, T2, T3 test. T3 is the tell: a rule phrased as an instruction to a reader ("always verify…", "never forget to…", "run X before Y", "re-derive the set"). Failing T3 = already mechanical, prose descriptive, NO ACTION. Failing T1 = a GATE, prose is correct home, NEVER a J finding.

Evidence format: (a) law site, file + verbatim quote, (b) state the decision reads, (c) tool that should own it + single-command interface, (d) cost paid or `unpriced`.

Now I need to read the law corpus: SKILL.md, fleet-directives.md, editor.md, editor-upstream-pr.md, hq.md, triage.md, toolsmith.md, tools/RC-CONTRACT.md.

Context: fleet-directives.md was SPLIT on 2026-09-18 — 25 sections moved byte-exact into role/topic files. I should check whether any law now assigns a state-derivable decision to agent memory, and whether any gate's input became unreachable after the move.

This is a large corpus (278KB CHANGELOG not in scope; SKILL 46KB, editor 52KB, fleet-directives 73KB, triage 29KB, editor-upstream-pr 31KB, hq 26KB, toolsmith 12KB, review-lenses 21KB, tools/**). Let me be systematic. I'll search for tell-tale phrases: "re-derive", "always verify", "never forget", "before Y", "by hand", "remember", "hold in context", "check that", "manually", "grep", snapshot lists, etc.

Let me start with grep across the skill dir for these patterns. But note the skill gate blocks reads of files matching the glob unless the skill is loaded. The grep worked. Let me try grep with the skill dir path.

Actually the read_file on review-lenses.md was blocked with a skill gate message that included the SKILL.md body. Hmm, but then the second read_file (start_line 150) succeeded. Interesting — maybe the gate is satisfied after first load. Let me just proceed with grep and read_file; they seem to work now.

Let me plan the searches:
1. `re-derive` / `re-deriving` / `derive`
2. `always verify` / `never forget` / `remember`
3. `grep` occurrences in law (a grep telling a lane to re-derive a set)
4. `manually` / `by hand`
5. `before` + check patterns
6. snapshot path lists

Let me run parallel greps.

Also the split: "whether any gate's input became unreachable after the move" — that's more of a load-path thing (lens G), but J should check if a law sentence now refers to a section that moved. Let me look at fleet-directives.md structure and see what remains.

Let me begin.
<!-- /reasoning -->

Now let me scan the law corpus for the T3 tell-phrases across all in-scope files.


<!-- tools-v2: [{"d":"Grep 're-derive|re-derives|re-derived|rederive' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:122:\n  120:    n=1452: a fabricated tail burned two gh dispatches; the first hypothesis\n  121:    after a lookup failure following a from-memory sha is SELF-FABRICATION —\n>    re-derive before blaming GitHub).\n  123: 8. **Solo-surface rule (Duty-4 proposal d5863180, owner \"All 4 go\"\n  124:    2026-09-07, semantic):** a SIDE-EFFECT command whose output is the only\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:374:\n  372: implementation comment).\n  373: \n> **Local fmt drift on files you did NOT touch is EXPECTED — and it is not yours to fix (SKILL.md §Box law; sharpened 2026-09-12, lane `462181e9` re-derived it from scratch because this rule lives in the box-law bullet while the check runs here).** The `/usr/local/bin/rustfmt` wrapper is **NEWER than CI's rustfmt**, so it flags cosmetic diffs on **CI-green committed code**. Rule: **KEEP AS-IS; fix only formatting artifacts you introduced yourself.** Two mechanics that make foreign drift look like your defect — (a) the wrapper **RECURSES through `mod.rs` into child modules**, so `--check src/tests/mod.rs` reports diffs from files your branch never touched; (b) `--skip-children` is **not supported** by this wrapper, and a `mod.rs` copied to /tmp fails to resolve its child modules. Isolation recipe: **check each TOUCHED file as a standalone copy; never `--check mod.rs` itself.** Do not spend three receipts re-deriving this — if fmt reports a file your diff does not contain, the answer is this paragraph.\n  375: \n  376: **Post-fmt scope audit BEFORE staging (Duty-4 P7, v0.4.80):** after any fmt\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:237:\n  235:    (incidents become rules/proposals, not lenses); no auto-growth. Lenses\n  236:    are quality dimensions (stable, few); objects change every batch and are\n>    re-derived from the skill root at spawn time.\n  238: 8. **Duty-6 Ledger Cadence Reset Stamp (owner order 2026-09-15):** Upon co","s":true},{"d":"Grep 'always verify|never forget|don't forget|remember to|by hand|manually' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:108:\n  106: | `./tools/oc-tg-audit <uuid> [--date D] [--days N] [--log-dir P]` | Telegram surface-law evidence scan |\n  107: | `./tools/oc-ledger sync` CHANGELOG gate | sync refuses a version bump whose CHANGELOG entry is missing |\n> | `./tools/oc-harvest-census <scan|check|record|sync>` | pre-flight census & lifecycle registry for upstream PR harvests; prevents duplicate/colliding PRs. `record` appends to `manual_records`, which `check` CONSULTS before declaring a unit unharvested — rc 1 `REFUSED … manually recorded as filed in PR #<n> (unit <u>)` — and the registry write MERGES into the loaded dict so foreign keys survive (v0.4.167; wired at `8f7b9558`, three commits after the v0.4.166 row read NO-OP — that law's own subject matter, one iteration later). Use `check`/`scan`, which derive IN_FLIGHT from the live scan |\n  109: | `./tools/oc-harvest-dispatch <issue> [--dry-run]` | dispatches automated harvest-to-upstream work order for eligible features |\n  110: | `./tools/oc-harvest-sweep <pr-branch> [--base adolfousier/main] [--repo P] [--port-of sha1,sha2]` | pre-gate harvest verification (editor Phase 7 sweep, mechanical legs); behavioral judgment stays human |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:548:\n  546: clause says a \"until X lands\" claim must be revisited in the SAME version window X lands — and this\n  547: row was that clause's own text, still stale.** The row now records the wired behaviour (rc 1\n> `REFUSED … manually recorded as filed in PR #<n> (unit <u>)`, the merging write, the landing sha) and\n  549: drops the DISPATCHED tail.\n  550: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:921:\n  919: \n  920: - **RUNBOOK step 7 CORRECTED — the lane-migration cut point was wrong, and it failed SILENTLY.** The step shipped in v0.4.138 said `git rebase --onto origin/main <old-fork-main-sha> <lane-branch>`. After a cutover the old fork-main sha is **no longer","s":true}] -->
<!-- reasoning -->
Lots of noise from CHANGELOG and reviews. I need to focus on the LAW corpus: SKILL.md, fleet-directives.md, editor.md, editor-upstream-pr.md, hq.md, triage.md, toolsmith.md, tools/RC-CONTRACT.md. Note that the J brief says the object is the law corpus including tools/RC-CONTRACT.md.

Let me narrow greps to specific files, and search for the T3 tell patterns. Let me search each law file for phrases like "verify", "check that", "confirm that", "ensure that", "make sure", "re-check", "list", "enumerate", "snapshot", "by hand", "manually", "grep".

Let me be efficient and grep per file. Let me start with the key files and look for state-derivable decision language.

Actually a better approach: since fleet-directives.md was split (25 sections moved byte-exact), and the split is the context, I should read fleet-directives.md and the role files to find law sentences that assign state-derivable decisions to agent memory.

Let me grep for specific strong candidates: "verify", "confirm", "check", "ensure", "must ... before", "count", "list", "snapshot".

Let me do targeted greps with file_pattern to exclude CHANGELOG/reviews.

Let me grep for "grep" in the law files (the exemplar was a grep telling a lane to re-derive a set).
<!-- /reasoning -->

Let me narrow to the law files and hunt the strongest T3 tells.


<!-- tools-v2: [{"d":"Grep 're-check|recheck|double-check|triple-check|verify by|check by hand|derive the set|enumerate the|snapshot of|held in context|hold in context' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:214:\n  211:    (`oc-review-persist`, byte-count + sha256 verified) counts as delivery\n  212:    when the reviewer toolset has no file-write capability; the report text\n  213:    arrives in the spawn-result push and is persisted verbatim.\n> 4. HQ VALIDATES every finding with the poll triple-check (disk truth /\n  215:    evidence / coherence): ACCEPT · KERNEL (already covered) · REJECT (reason\n  216:    recorded, never silently dropped).\n  217: 5. Mechanical fixes (dedup, wording, terminology, dead refs) land directly as\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:749:\n  746: - **Recording is mandatory — an absent gate is never a passed gate.** A skipped LEG1 must appear in the ship journal AND in a ledger row naming the sha. The v0.4.109 identity + verdict laws are unchanged: GREEN only for a gate that actually ran `completed success`; a skipped leg is cited as SKIPPED and never counted as a passed leg in a smoke receipt.\n  747: - **Upstream precedent cited, shape deliberately NOT copied.** `ci.yml:23-27` paths-ignores `**.md`/`docs/**` on push \"so they don't burn the matrix\" — but that test is extension-based and would skip a commit editing a compiled-in template. The law states the exclusion explicitly instead of inheriting that hole.\n  748: - **Scope is law text ONLY; the tool half is Toolsmith's (defect #20).** The section names NO flag — but the `oc-ship-chain` LEG1 change LANDED in this same tag (`d6cb9b9a`, 11:56:24Z), so a docs-only commit does NOT burn the gate and the force flag `OC_SHIPCHAIN_NO_DOCS_SKIP=1` does exist. **SUPERSEDED — see v0.4.163.** Law must name only verbs that exist (v0.4.153).\n> - **The exclusion-set bullet above is AMENDED same-day (commit `448f32e4`).** The first draft enumerated the 21 paths AND carried a `grep` telling a lane to re-derive the set — agent memory as a gate input. Owner struck it (*\"that should be purely mechanical\"*): the set is now DERIVED ","s":true},{"d":"Grep '^\\s*#{1,4} ' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:1:\n> # Fleet directives — opencrabs-dev cross-role law\n  2: \n  3: **Owns:** the binding owner directives that apply to EVERY opencrabs-dev lane — the `[LANE]` law every worker reads in full at spawn and at compaction reload, plus a residual of cross-cutting rulings that belong to no single role. Re-homed here from ops AGENTS.md/MEMORY.md per owner order 2026-09-02.\n  4: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:32:\n  29: \n  30: **Reload & orientation:** **Post-compaction skill reload & context manifest curation** · **Every turn ends with a \"what now/next?\" answer** · **Explain open questions & re-anchor context** · **Daemon no-reap**\n  31: \n> ## Owner Push Freeze — soaking groups held from upstream harvest (owner order 2026-09-18) [LANE]\n  33: \n  34: **Owner order, verbatim:** *\"freeze all these groups from pushing - I want to review them first and will release them later\"* (2026-09-18 17:33Z), followed by the first and only release so far: *\"Telegram flow cluster T6 - release for harvesting\"* (18:01Z).\n  35: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:53:\n  50: \n  51: **Rationale (owner's own words):** *\"I want to review them first\"* — the soak groups ARE his live-test surface, and harvesting one before he has exercised it upstreams a feature he has not yet accepted.\n  52: \n> ## Telegram surface law (owner 2026-08-28, skill v0.4.31) [LANE]\n  54: \n  55: Canonical full law: SKILL.md §Telegram surface law (v0.4.31). Editor-facing duties: editor.md §Telegram surface law. session_notify is the ONLY inter-role channel; no editor invokes telegram send/edit tools. Fleet-directives carries no extra text — do not restate the law here.\n  56: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:57:\n  54: \n  55: Canonical full law: SKILL.md §Telegram surface law (v0.4.31). Editor-facing duties: editor.md §Telegram surface law. se","s":true}] -->
<!-- reasoning -->
The output is huge and noisy. I need to be disciplined. Let me read the fleet-directives.md sections headers fully, and the role files. But reading 73KB fleet-directives is a lot. Let me get the section headers list for fleet-directives (the grep returned 41 matches but truncated). Let me read the file's headings via grep with a tighter limit and no context.

Actually the grep pattern `^\s*#{1,4} ` matched 41 times but output was truncated with context. Let me re-run without context.

Better: I'll read fleet-directives.md in chunks. It's 73666 bytes ≈ maybe 600 lines. Let me read it fully in a couple of calls with spill_to_disk false and max bytes.

Let me first get headings.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep '^#{1,4} ' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:1:\n> # Fleet directives — opencrabs-dev cross-role law\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:32:\n> ## Owner Push Freeze — soaking groups held from upstream harvest (owner order 2026-09-18) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:53:\n> ## Telegram surface law (owner 2026-08-28, skill v0.4.31) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:57:\n> ## Discussion links + fix-approval gate (owner 2026-08-28 14:28Z)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:64:\n> ## External lanes — fork issue reporting vs dev non-participation (owner order 2026-09-13) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:82:\n> ## Stage-entry consent (owner 2026-08-28 16:57Z)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:86:\n> ## Post-compaction skill reload & context manifest curation (owner 2026-09-04, updated 2026-09-17) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:97:\n> ## Receiver-side dedupe of reload demands (HQ ruling 2026-09-10, anomaly: duplicate v0.4.130 fanout wave)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:101:\n> ## Attribution guard (post-compaction wakes)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:105:\n> ## PR naming convention (owner 2026-08-30) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:112:\n> ## Strict Atomicity & Zero Bundling (owner order 2026-09-13; lane 1a63f103 proposal) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:119:\n> ## LLM Ergonomics & Efficiency Law (owner order 2026-09-13) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:128:\n> ## Upstream Coding & Testing Standards (CONTRIBUTING.md & Adolfo DM 2026-09-13) [LANE]\n\n/roo","s":true},{"d":"Grep '^#{1,4} ' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:28:\n> # opencrabs-dev — OpenCrabs source procedure\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:42:\n> ## STEP ZERO — establish the role (mandatory on every load)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:76:\n> ## Canonical tooling (v0.4.12, PROCESS-TOOL ownership)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:138:\n> ### Unified tools log\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:144:\n> ## Session-notify loop (since v0.3.3)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:171:\n> ### session_notify mechanics (upstream #1203, commit 13a24f25)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:204:\n> ### Telegram surface law (v0.4.31)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:225:\n> ## Test ontology (v0.4.2 — three kinds + one sanity signal, NEVER conflate)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:298:\n> ## Glossary — official terms (v0.4.62; one concept = one name)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:368:\n> ## Red-run triage heuristics (shared core, v0.4.10 — moved from editor.md Phase 6)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:387:\n> ## Shared environment facts (all roles)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:454:\n> ## Upstream relations (v0.4.0, owner-approved 2026-08-26)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:469:\n> ## Hard rules (all roles)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:572:\n> ## Shared war stories (why these rules exist)\n\n(14 matches)","s":true}] -->
<!-- reasoning -->
Now let me read the law files. Let me start reading fleet-directives.md fully (it's the file that was split). I'll read in chunks of ~200 lines. 73666 bytes / ~ say 470 lines. Let me read with spill_to_disk=false and max_output_bytes large.

Actually, read_file with max_output_bytes. Let me read lines 1-200 first, then continue. But the skill gate... The first read attempt returned the gate. The second read succeeded. Let me just try.

Let me read fleet-directives.md sections. I'll use grep with high context? No, better to read the file.

Let me read the whole fleet-directives.md with a big max_output_bytes and spill_to_disk=false so it clamps (but clamping loses content). Hmm. Better read in ranges.

Let me do read_file line ranges.
<!-- /reasoning -->

Now let me read the core law files. Starting with fleet-directives.md (the split file).


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"**Reload & orientation:** **Post-compaction skill reload & context manifest curation** · **Every turn ends with a \"what now/next?\" answer** · **Explain open questions & re-anchor context** · **Daemon no-reap**\n\n## Owner Push Freeze — soaking groups held from upstream harvest (owner order 2026-09-18) [LANE]\n\n**Owner order, verbatim:** *\"freeze all these groups from pushing - I want to review them first and will release them later\"* (2026-09-18 17:33Z), followed by the first and only release so far: *\"Telegram flow cluster T6 - release for harvesting\"* (18:01Z).\n\n**What \"these groups\" are.** The owner was reading the delivered live-test plan (`/tmp/live-test-plan-2026-09-18.md`, board topic 30220, `msg=67358`) — the soak/test surface of the deployed binary (50 `feat` commits landed since 09-16 00:00). Its groups are the frozen set: **18 T-groups (T1–T18) + 7 Tier-3 items**. One group is released.\n\n| State | Groups |\n|---|---|\n| **FROZEN** — no upstream push / harvest | **17 T-groups:** T1 (#299), T2 (#286), T3 (#291), T4 (#295), T5 (#285), T7 (#280/#289/#258), T8 (#234/#155), T9 (#1629/#233), T10 (#317), T11 (#247), T12 (#208/#228), T13 (#278), T14 (#298), T15 (#241), T16 (`[agent] default_provider`), T17 (#256), T18 (#150) · **7 Tier-3 items:** #290, #271, cron per-job in-flight guard, #264, #273, repeated-bash nudge, #345 |\n| **RELEASED** — harvest eligible | **T6 — Telegram flow cluster** (#250 🎯 telemetry marker, 🌐/🧠 tool classes, ⏰ cron icon, compact event labels, #232 telemetry bar, queued-message roll tag) |\n\n**The rule:**\n\n1. **No upstream push of a frozen group.** No upstream PR is filed for a frozen group's commits, and no lane stages one, until the owner releases that group by name. Soak maturity elapsing is not a release.\n2. **Release is an OWNER action, never a lane decision.** A group leaves the freeze only on an explicit owner message naming it — exactly as T6 did. Silence, a green census, a lane's own confidence, or an idle editor never release a group","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"Every tool, schema, hint, error message, and prompt designed for agents must prioritize **LLM ergonomics and operational efficiency**. LLMs have limited context horizons, suffer amnesia across compactions, struggle with mental list arithmetic, and hallucinate when forced to reconstruct hidden state. Designing for agents means eliminating these failure modes at the interface:\n\n1. **Contextual & Relative Anchors Over Mental Arithmetic:** Never force an agent to compute, track, or predict numeric array indices, line numbers, or offsets across turns. Prefer semantic anchors (title substring/fuzzy matching) or relative keywords (`\"current\"`, `\"next\"`, `\"tail\"`).\n2. **Actionable, Self-Healing Feedback:** Tool error messages are inline prompts. Never emit bare rejections (`\"Invalid index\"`, `\"Task not found\"`). When validation fails, the error output MUST provide the active state snapshot and the exact valid candidate options so the agent can self-correct in a single follow-up turn without blind exploration.\n3. **Turn Consolidation & Immediate State Delivery:** Mutating tool operations should return confirmation along with the resulting state summary (e.g. `add_tasks` returning the updated plan summary). Eliminate redundant round-trips whose sole purpose is inspecting what the previous action produced.\n4. **Information Saliency & Token Discipline:** Hints, schemas, and descriptions must maximize signal-to-noise. Eliminate verbose boilerplate; state constraints and contracts explicitly; keep prompt payloads tight to prevent context window bloat and compaction pressure.\n\n## Upstream Coding & Testing Standards (CONTRIBUTING.md & Adolfo DM 2026-09-13) [LANE]\n\nMandatory standards for any code slated for upstream harvest (`adolfousier/opencrabs`) or developed in the fork:\n\n1. **Test Isolation (NO inline tests in `src/`):** ALL tests must live under `src/tests/*_test.rs` registered in `src/tests/mod.rs`. Absolutely **NO inline `#[cfg(test)] mod tests { ... }`** blocks at the bott","s":true}] -->
<!-- reasoning -->
This is very useful. I found a candidate already: in the Docs-Only LEG1 Gate Skip section, there's a clause:

"**The compiled-in exclusion set — 21 paths (HQ-verified first-hand 2026-09-12 against `src/**/*.rs`).**" — this enumerates 21 paths. But then it says "The exclusion set is DERIVED BY THE TOOL at gate time — never by hand, never carried in a lane's context. The 21 paths listed above are illustrative, not normative". And "Mechanical evaluation (Finding J-2, v0.4.170): Lanes must verify qualification directly using `tools/oc-ship-chain --eval-docs-skip <sha>` instead of manual path inspection or hand-derived checks."

So the standing exemplar has been fixed. This is not a finding anymore — it's the amended version. Good.

Hmm wait, but there's a subtlety. The heading says "The compiled-in exclusion set — 21 paths". Is the list still there as a snapshot? Yes, listed as illustrative. And the law says never by hand. And the tool `--eval-docs-skip` exists. So no finding.

But wait — is `--eval-docs-skip` a real flag? The J brief says NOT THIS LENS — whether a law-cited verb or flag EXISTS (phantom-verb class) is a corpus LINT, not a reviewer pass. So I shouldn't flag that.

Let me continue reading fleet-directives.md sections 150-260, 260-360, 360-448.

I saw up to line ~200 in the second read (Owner-Dependent Smoke Legs). Let me read 200-360.

Actually the read at start_line 120 gave lines 120 through ~200 (truncated at 57823 bytes... wait it says output truncated 57823 bytes (357 lines) exceeded 14000). Hmm, it started at 120 and the content shown went through the "Owner-Dependent Smoke Legs" section which is line 201. So it read 120-~205. Then truncated.

Let me read 200-360 and 360-470.

Let me continue. I'll read in chunks.

Actually I realize reading all of this is heavy but necessary. Let me read the remaining fleet-directives and then the role files.

Let me do targeted reads. Read start_line 200, line_count 130. And start_line 330, line_count 130.

Let me be careful with max_output_bytes to get full content: set to 16000 and spill_to_disk=false might truncate. Let me use line_count limits.

Let me read fleet-directives 200-330.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"## Owner-Dependent Smoke Legs — Park, Don't Chase (v0.4.152, owner order 2026-09-12) [LANE]\n\n**Origin (owner, 2026-09-12 ~08:0xZ, verbatim):** *\"I saw you stranded on waiting for a smoke — that shouldn't happen, no human smoke will be confirmed as I was away. Why not just leave these PRs for the next cycle?\"* Worked example: a verdict-only lane (#155) sat ~4 h because its 4th smoke leg was an owner visual pass, and that leg was treated as a blocking gate in an owner-absent window. Waiting bought nothing — the candidate was verdict-only and excluded from harvest, so no PR was ever going to be filed off it.\n\n### L1 — An owner-dependent leg is NEVER a blocking gate (park, don't chase)\n\nA smoke leg that only the OWNER can satisfy (a visual pass, a tap, an eye-confirm on a Telegram card) MUST NOT block a lane. The owning lane:\n\n1. stamps the legs it CAN prove — lineage, identity, CI gate, and any agent-runnable behavioral probe (a live call, a forced trigger, an observed output through the new code);\n2. appends a **`PARKED-OWNER-EYE`** row to `smoke-verdicts.log` naming the exact owner action required AND the packaging sha;\n3. **RELEASES the lane** and moves to its next task.\n\n`PARKED-OWNER-EYE` is a lane-release, NOT a hold: the lane goes idle and claimable, the candidate is deferred. This does not contradict the NO-HOLD law (§Upstream-merge cadence) — NO-HOLD forbids a *waiting state*; parking is the mechanism that keeps a lane OUT of one. A lane idling on an owner leg is in violation; a lane that parks and moves on is compliant.\n\n### L2 — Shift exit condition: receipts or an explicit park\n\nA shift (night or day) is COMPLETE only when every workstream sits in exactly one of two terminal states:\n\n- **RECEIPTED** — the work landed and its receipts are stamped (PR filed, swap verified, ledger row, smoke row); or\n- **PARKED** — an explicit `PARKED-OWNER-EYE` row (or an equivalently named park, with its reason) exists, naming the next-cycle action and the owner.\n\nA workstre","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"`landed` := a ledger row of kind `done` or `close` addressing the issue, **OR** a commit referencing the issue on fork `main` (git arm). Either arm marks it landed. Implementation: `tools/oc-issue-dispatch` — `ledger_landed_issues()` (imports `oc_claims.LANDED_KINDS`) + `fetch_landed_issues()` (git arm). Tool side: leshchenko1979/opencrabs#337.\n\n`tools/lib/oc_claims.py` is the ONE canonical predicate — no lane re-inlines it. It carries BOTH sets, and their distinction is load-bearing:\n\n- `LANDED_KINDS = (\"close\", \"done\")` — evidence the WORK landed.\n- `CLOSING_KINDS = (\"close\", \"confirm\", \"reject\", \"done\", \"unclaim\")` — the kinds that can close a CLAIM. A strict superset; **NOT interchangeable**.\n\n**Using `CLOSING_KINDS` as the landing test STARVES real work.** The module's own docstring records the measurement: over the live ledger on 2026-09-18, `CLOSING_KINDS` reaches 228 issues, 125 of them ONLY via the three non-landing kinds — and 48 were reachable by `unclaim` ALONE (a released claim whose work was still unbuilt), suppressed purely because a claim had been RELEASED. A `confirm` row flips a bookkeeping flag and ships nothing; an `unclaim` row returns the issue to the pool, unbuilt; a `reject` row means no work was done at all. **None of the three is evidence the work shipped**, and a released-but-unbuilt issue is legitimately re-dispatchable.\n\n### D2 — Landed-but-unharvested issues are HARVEST QUEUE, not editor dispatch\n\nThe closure law (`triage.md §Autonomous closure`) deliberately keeps DONE work **OPEN** until its own upstream PR files. Without the landed term every such issue reads `unclaimed AND vetted` → DISPATCHABLE, so the sweep re-wires exactly the issues the closure law forbids closing. **With the term present the two sets are disjoint by construction:** an OPEN issue whose work already landed in fork `main` waits on a PR, not on code — it routes to the harvest queue and NEVER to an editor lane.\n\n### D3 — Live instance, receipted (2026-09-18)\n\nOne T5","s":true}] -->
<!-- reasoning -->
Good. Continuing to read fleet-directives 350-448.

Note the D1 section quotes LANDED_KINDS and CLOSING_KINDS verbatim in the law — but that's descriptive of a tool's constants, and the law says the module is the ONE canonical predicate, no lane re-inlines it. So it's descriptive, not a lane instruction. Hmm, actually the law text lists the sets explicitly. But it says `tools/lib/oc_claims.py` is the ONE canonical predicate — no lane re-inlines it. So the law isn't assigning the decision to agent memory; it says import the module. Not a finding.

Let me continue reading. Read 350-448.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"- **Ancestry Matching & Coalescence:** `oc-deploy` and `oc-ship-chain` accept descendant builds via ancestry matching (`git merge-base --is-ancestor \"$SHA\" \"$CAND_SHA\"`). If Editor B pushes while Editor A's carrier build is running, and Editor C pushes right after, GitHub Actions coalesces B and C into a single build. When that build succeeds, both Editor B and Editor C recognize their commits as deployed without running redundant builds.\n- **Host Swap Mutex & Monotonicity:** Host binary swaps remain strictly serialized and monotonic via `host-swap.lock` (`flock -x $STATE_DIR/host-swap.lock`) and lineage verification (`git merge-base --is-ancestor \"$PREV_SHA\" \"$SHA\"`), preventing stale binary overwrites.\n- **Merge Serialization:** `oc-ship-chain` serializes Leg 3 (fast-forward merge) via `ship.lock`.\n\n```mermaid\nflowchart TD\n    E1[\"Editor 1 (Push A)\"] -->|Dispatches| R1[\"Carrier Build 1 (Active on A)\"]\n    E2[\"Editor 2 (Push B)\"] -->|Queues| R2[\"Carrier Build 2 (Pending on B)\"]\n    E3[\"Editor 3 (Push C)\"] -->|Replaces Pending| R3[\"Carrier Build 3 (Pending on C)\"]\n    R1 -->|Build 1 Finishes| S1[\"Swap A to Host\"]\n    R3 -->|Build 3 Finishes on C| S2[\"Swap C to Host (Coalesced B+C)\"]\n    S2 -.->|Ancestry Match| ACK2[\"Editor 2 Acknowledged (B in C)\"]\n    S2 -.->|Direct Match| ACK3[\"Editor 3 Acknowledged (C)\"]\n```\n\n## Features-compat gate — no silent feature-loss swaps (HQ ruling 2026-09-04, MANDATORY) [LANE]\n\n`oc-deploy swap-execute` **refuses** any artifact whose feature set drops a feature present in `deployed.meta.json` (exit 4, journal `features-drop-gate`, markers untouched) unless the operator passes `--allow-features-drop` explicitly. Feature *additions* pass freely; *drops* are the failure class. Enforced in-code (selftest 17p/17q). Rationale: the 06:36:06Z rogue swap (run `33844429519`, `features=\"telegram\"` over a live `telegram,code-graph` binary) killed structural memory for 12h — and the 18:57Z f3c03269 swap was the same class (no-tests artifact, auto-con","s":true}] -->
<!-- reasoning -->
I'm getting a good sense of fleet-directives.md. There are potential findings here. Let me note candidates:

1. **Upstream PR filing — base CI gate pre-claim** (line 442): "Before filing an upstream PR, poll base-main CI gate state and pre-claim any OWNERLESS red files by carrying a sweep commit in the PR itself". This is an instruction to an agent to "poll base-main CI gate state and pre-claim any OWNERLESS red files". Is this state-derivable? Yes — base-main CI state is on disk/API (a tool `oc-prchecks`/`oc-upstream-delta` touches it). And "pre-claim any OWNERLESS red files" — determining ownerless is a function of the ledger/git. This is T3: "always verify... run X before Y" — an instruction to the reader. Hmm. But is there a tool? `oc-harvest-sweep` does "pre-gate harvest verification (editor Phase 7 sweep, mechanical legs)". Actually there's `oc-pr-fault-scope` mentioned in reviews. Let me consider. This might be a J finding: the law asks the lane to poll base CI state and compute ownerless red files by hand. But T2 requires a tool that already touches that state. `oc-upstream-delta` touches upstream state. Hmm. I need to be careful — a finding must name (c) the tool that should own it and its single-command interface. This one could name `oc-harvest-sweep` (already "pre-gate harvest verification"). Actually I'm not certain. Let me hold this as a candidate but look for stronger ones.

Actually, let me reconsider. The J lens's defect class is specifically: law that assigns a state-derivable decision to an agent's memory. The strongest tells are "re-derive the set", "always verify", "never forget to", "run X before Y", and set/list a lane must hold in context.

Candidates so far:
- The Docs-Only exclusion set — already fixed (amended), with `--eval-docs-skip`. Not a finding (exemplar).

Let me look at more. I should read the role files: editor.md, hq.md, triage.md, toolsmith.md, editor-upstream-pr.md, SKILL.md, tools/RC-CONTRACT.md.

Let me now grep for specific patterns in the role files that suggest state-derivable decisions assigned to memory. Good candidates: "read the ... list", "count", "re-derive", "verify that", "check whether", "must be listed", "enumerate", "maintain a list", "keep track".

Let me also look for the split's effect: "whether any gate's input became unreachable after the move". So I should check whether any law references a section that moved to another file. E.g., a law in editor.md says "see fleet-directives.md §X" where §X moved to triage.md. Or a gate that reads a list defined in a file the role doesn't load.

Let me search for cross-file section references.

Let me read hq.md (26KB) fully — it's the Duty 6 owner and important.

Let me also read triage.md and toolsmith.md and editor.md.

This is a lot. Let me prioritize: the brief says object is the LAW CORPUS read against on-disk state. Let me grep for the strongest T3 patterns across the law files only (exclude CHANGELOG, reviews, war-stories).

Let me construct a grep with file_pattern excluding? grep tool only supports one file_pattern glob. I could use path per file.

Let me grep in each law file for a combined pattern.

Patterns: "always verify|never forget|must verify|must check|must confirm|re-derive|by hand|manually|keep track|maintain a list|hold in context|enumerate|count the|list of|snapshot"

Let me run on hq.md, triage.md, toolsmith.md, editor.md, editor-upstream-pr.md, SKILL.md.

Actually let me do a big grep with regex on the directory but limit to file_pattern "*.md" — but that includes CHANGELOG and reviews. Hmm.

Alternative: grep each file individually in parallel. Let me do that.

Let me focus. I'll grep the 7 law files for the T3 pattern.

Let me start with a combined regex and path per file. I'll do 4 files in parallel.
<!-- /reasoning -->

Let me grep the role files for state-derivable-decision tells.


<!-- tools-v2: [{"d":"Grep 'verify|re-derive|by hand|manually|count|enumerate|list of|snapshot|keep track|check that|confirm that|ensure' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:98:\n  96: | Explicit owner reload order | **`PUSH-ALL-QUIET` broadcast wave** via `oc-notify-fanout --title \"SKILL CHANGE — v<v>\"` (generates per-lane briefs, self-uuid reload instruction, DB-validated targets, ledger stamp). |\n  97: | Confirm law (probe-verified 2026-09-07) | `delivery=quiet` + `confirm=true` is a NO-OP watch — quiet always returns instantly with a deferred verdict + notify_id; confirm only watches synchronous states. Routine pushes: quiet, NO confirm, fire-and-forget (drift-check is the comprehension guard). CRITICAL notifies (owner-gated orders, breaking `[ALL]`): `delivery=now` + `confirm=true` — that pair gives the blocking watch and a `woke`/`delivered` verdict; `now` refuses while target mid-turn → retry on refusal |\n> | Worker >3 versions behind, acting substantively | targeted notify (mechanical drift and ack-row reads don't count) |\n  99: \n  100: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:143:\n  141:    - **Mechanical State Check**: HQ reads the submissions in a single batch turn from disk (`ls $REVIEW_DIR/proposals/`)\n  142:      and ledger events (`oc-ledger events --kind proposal`).\n>      **Window-safe read:** `events` counts `--n` rows back from the NEWEST (default 20 — see the `--n N` usage note under `oc-ledger events`), so a\n  144:      **kind-filtered** read is safe — the filter runs BEFORE windowing and cannot be starved by unrelated rows. A\n  145:      **marker-prefix** read over `--kind note` is NOT safe: by cycle close the `note` tail no longer holds the proposals,\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:207:\n  205:    file write is the PRIMARY copy; HQ's persist step\n  206:    (`oc-review-persist <lens> @<file>`, re-read-verified + sha256-indexed)\n>    becomes a VERIFIED COPY (byte-count + sha check), never the only copy.\n  208:    A report existing only in push-transit does not count as delivered.\n  209:    Fallback (write-less reviewe","s":true},{"d":"Grep 'verify|re-derive|by hand|manually|count|enumerate|list of|snapshot|keep track|check that|confirm that|ensure' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:15:\n  13: \n  14: The Triage lane is INTERRUPTIBLE BY DESIGN: every work item is small and fast —\n> ACK, ledger stamp, verify evidence, route. Deep work never lands here; it\n  16: escalates to HQ.\n  17: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:44:\n  42: - **Parallel Harvest Orchestration Patrol (PHOP) & Pre-Dispatch Vetting (v0.4.136, 2026-09-10; Native GitHub Protection 2026-09-16):**\n  43:   When orchestrating harvest work, Triage MUST mechanically vet candidate packages before dispatching harvest work orders to editor lanes:\n>   1. Run `tools/oc-harvest-dispatch vet <issue-or-commits>` to verify upstream absence (tree-diff non-empty, patch-id unmerged, not already merged upstream, not superseded).\n  45:   2. **Native Sub-Issues & Blockers Check (owner order 2026-09-16; strengthened v0.4.198):**\n  46:      - Sub-issues / Child cleanups: If candidate is a sub-issue or child cleanup (linked via `gh issue edit <issue> --parent <parent-issue>` or touching/deleting code from an unharvested subsystem), verify parent feature is already merged upstream. If parent is unmerged, reject candidate harvest as blocked sub-issue (Issue #188 unharvested parent refusal).\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:46:\n  44:   1. Run `tools/oc-harvest-dispatch vet <issue-or-commits>` to verify upstream absence (tree-diff non-empty, patch-id unmerged, not already merged upstream, not superseded).\n  45:   2. **Native Sub-Issues & Blockers Check (owner order 2026-09-16; strengthened v0.4.198):**\n>      - Sub-issues / Child cleanups: If candidate is a sub-issue or child cleanup (linked via `gh issue edit <issue> --parent <parent-issue>` or touching/deleting code from an unharvested subsystem), verify parent feature is already merged upstream. If parent is unmerged, reject candidate harvest as blocked sub-issue (Issue #188 unharvested parent refusal).\n  47:      - Blockers: If candidate ha","s":true}] -->
<!-- reasoning -->
There are several candidates in triage.md:

1. **triage.md:46-48** — "Sub-issues / Child cleanups: If candidate is a sub-issue or child cleanup ... verify parent feature is already merged upstream. If parent is unmerged, reject candidate harvest as blocked sub-issue." and "Blockers: If candidate has active blockers declared via `gh issue edit <issue> --add-blocked-by <blocker-issue>`, reject dispatch as `HELD_BLOCKED_BY_DEPENDENCY` until blockers land upstream." and "Upstream baseline verification: Verify target code path on live `adolfousier/main`..."

These are instructions to an agent to verify state that's derivable from the GitHub API / git. But is there a tool? The vet step is `tools/oc-harvest-dispatch vet <issue-or-commits>` — which the law says to run in step 1. And RC-CONTRACT says oc-harvest-dispatch vet enforces "native sub-issue parent verification (HELD_PARENT_UNHARVESTED), and dependency resolution (HELD_BLOCKED_BY_DEPENDENCY)". So the tool ALREADY owns those checks! So the law text at step 2 duplicates manual verification instructions that the tool already performs. Hmm — that would make it a J finding: the law asks the agent to "verify parent feature is already merged upstream" by hand while the tool (`oc-harvest-dispatch vet`) already returns HELD_PARENT_UNHARVESTED. Wait, but step 2 says "Native Sub-Issues & Blockers Check" and describes what to verify. If the tool does it, then the law is assigning to agent memory a decision the tool already settles → T1 yes, T2 yes (tool already touches it), T3 yes (asks agent to verify). That's a solid J finding.

Hmm, but I should be careful: maybe step 2 describes the criteria the tool enforces (descriptive), and the actual instruction is step 1 "Run the tool". Let me read triage.md lines 42-55 in full to judge.

Also:
2. **triage.md:84-86** — "Upstream PR-state patrol: on each harvest census, re-verify the state of every OPEN upstream PR of ours (`gh pr view <n> -R adolfousier/opencrabs --json state,mergeable` — fresh receipt, never memory) and post the states in the census line." This is "re-verify the state of every OPEN upstream PR" — state-derivable from the API. But it says "fresh receipt, never memory" — so it's already forcing a fresh read, not memory. Hmm, T3 is about asking agent to remember/derive/re-check by hand. This asks to re-verify via gh pr view. Is there a tool? `oc-upstream-delta`? The census is `./tools/oc-upstream-delta`. Hmm. "re-verify the state of every OPEN upstream PR of ours" — the enumeration "every OPEN upstream PR of ours" is a set the lane must derive and hold. Could be a J finding. But the law explicitly says to use a fresh `gh pr view` receipt — so it's a tool-ish read. Marginal.

3. **triage.md:92-94** — "Cron liveness patrol: verify the law-carrying crons are enabled and have recent last-run rows (e.g. oc-harvest-dispatch-4h — via the cron tool, fresh receipt)". This is state-derivable (cron enabled + last-run rows). It names a tool (the cron tool). Hmm.

4. **triage.md:291** — "Injection verification REQUIRED: a `session_notify` 'delivered' receipt ≠ injected. Before stamping any ack, verify injection from the daemon log ... Grep the log for the target session id after the send; stamp ack only on a real injection". This is a manual grep instruction — "grep the log for the target session id after the send". This is a T3 tell: an instruction to the reader to grep a log by hand. State is on disk (the daemon log). Is there a tool that touches it? `oc-log-search` exists (in RC-CONTRACT: "oc-log-search | 0 | 2 | 0 matches-found / 1 zero-hits"). Hmm, and `oc-ping-proof`? Actually there's a tool `oc-ping-proof` in the list. Let me check. The tools list: oc-artifact-verify, oc-attrib, oc-branch-sweep, oc-carrier-features, oc-commit, oc-deploy, oc-drift-check, oc-harvest-sweep, oc-index-worktree, oc-issue-log, oc-issue-sweep, oc-job-verify, oc-ledger, oc-log-search, oc-notify-fanout, oc-order-validate, oc-ping-proof, oc-pr-atomicity, oc-pr-fault-scope, oc-prchecks, oc-rebase-safety, oc-review-persist, oc-seal-state, oc-shadow-rotate, oc-ship-audit, oc-ship-chain, oc-skew-scan, oc-smoke-evidence, oc-tg-audit, oc-upstream-delta, oc-waiter, oc-wt.

`oc-ping-proof` — sounds like a delivery-proof tool. Hmm. The law says "verify injection from the daemon log ... Grep the log for the target session id after the send". This is exactly the standing exemplar shape: law carries a `grep` telling a lane to re-derive/verify state by hand. And a tool already touches that state (oc-log-search, or the session_notify machinery). This is a strong J finding candidate. But wait — is this "notify delivery proof" state-derivable? Yes: the daemon log has the injection line. T1 yes. T2: `oc-log-search` (or `oc-ping-proof`) touches logs. T3: yes, "verify injection ... grep the log".

Hmm, but I need the (c) tool that should own it + single-command interface. Could propose `oc-notify-proof <uuid>` or extend `oc-log-search`. Hmm, `oc-ping-proof` exists. Let me check RC-CONTRACT for oc-ping-proof and oc-log-search to name the right host.

5. **triage.md:292** — "Liveness check + no_route accounting: before `session_notify` to any session not heard from this turn, verify the target is live — `session_search` with `updated_since` (or a same-turn log grep for the session id...)". Again a manual log grep. Same family.

Hmm, these are strong. But I must be careful: the J lens says "a rule phrased as an instruction to a reader ('always verify…', 'never forget to…', 'run X before Y', 're-derive the set') is the defect class." And "including one-shot checks and any set or list a lane is told to hold in context."

So triage.md:291 "verify injection ... grep the log" — one-shot check, state-derivable → J finding. But is there a tool? If no tool exists and no natural host, the finding must still name (c). `oc-log-search` is a natural host. Or the session_notify tool itself.

Actually wait — I should be careful about over-reporting. The lens says a finding must name the tool half. Let me consider whether these are genuinely state-derivable and whether a tool is the natural host.

Actually, let me reconsider the scope. The brief says: "for each law sentence that assigns a state-derivable decision (a gate, a count, a status, a classification), ask whether the law ASSIGNS THE DECISION TO AN AGENT'S MEMORY instead of deriving it from state on disk."

So the key is: the law assigns the decision to agent MEMORY. triage.md:291's "grep the log" is assigned to the agent (manual grep), not memory per se — it's a fresh read. Hmm. But the lens explicitly includes "run X before Y" and "always verify" as T3 tells, and "any set or list a lane is told to hold in context."

Hmm. Let me think about which findings are strongest and best-evidenced:

A. **triage.md step 2 "Native Sub-Issues & Blockers Check"** — manual verification instructions that duplicate what `oc-harvest-dispatch vet` already returns (HELD_PARENT_UNHARVESTED, HELD_BLOCKED_BY_DEPENDENCY). Strong: T1 yes (parent merged state on GitHub), T2 yes (tool already touches it — RC-CONTRACT names the exact predicates), T3 yes (asks the lane to verify by hand). This is a very clean J finding. Let me verify the exact verbatim text.

B. **triage.md:291 injection verification grep** — T1 yes, T2 `oc-log-search`, T3 yes. Clean-ish.

C. **triage.md:84-86 upstream PR-state patrol re-verify** — T1 yes, T2 maybe `oc-upstream-delta`/`oc-prchecks`, T3 "re-verify". 

D. **fleet-directives §Upstream PR filing — base CI gate pre-claim** — "poll base-main CI gate state and pre-claim any OWNERLESS red files". T1 yes, T2 `oc-pr-fault-scope` (name suggests fault scope = red files!). T3 "poll... pre-claim any OWNERLESS red files". Strong.

Let me verify these by reading the exact lines and the RC-CONTRACT entries for the relevant tools.

Also I should check editor.md and SKILL.md and editor-upstream-pr.md and toolsmith.md.

And the split context: check whether a gate's input became unreachable. E.g., triage.md:50 says "Canon: `fleet-directives.md §Dispatch Eligibility — the 4-bucket predicate`" — good, points to the moved home. triage.md T4/T5 point to fleet-directives. Let me check for stale references to sections that moved.

Let me read triage.md fully-ish (29KB, ~300 lines) and editor.md key parts.

Actually, given the 6000-char report limit and the need for high-quality findings, I should aim for maybe 3-6 findings. Let me gather evidence carefully.

Let me read the relevant sections and RC-CONTRACT tool entries.

Let me read triage.md lines 40-100 and 280-300.

And RC-CONTRACT for oc-pr-fault-scope, oc-log-search, oc-ping-proof, oc-harvest-dispatch, oc-upstream-delta.

Let me do parallel reads/greps.
<!-- /reasoning -->

Strong candidates emerging. Let me verify the exact law text and the tool surfaces.


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md","o":"- **Parallel Harvest Orchestration Patrol (PHOP) & Pre-Dispatch Vetting (v0.4.136, 2026-09-10; Native GitHub Protection 2026-09-16):**\n  When orchestrating harvest work, Triage MUST mechanically vet candidate packages before dispatching harvest work orders to editor lanes:\n  1. Run `tools/oc-harvest-dispatch vet <issue-or-commits>` to verify upstream absence (tree-diff non-empty, patch-id unmerged, not already merged upstream, not superseded).\n  2. **Native Sub-Issues & Blockers Check (owner order 2026-09-16; strengthened v0.4.198):**\n     - Sub-issues / Child cleanups: If candidate is a sub-issue or child cleanup (linked via `gh issue edit <issue> --parent <parent-issue>` or touching/deleting code from an unharvested subsystem), verify parent feature is already merged upstream. If parent is unmerged, reject candidate harvest as blocked sub-issue (Issue #188 unharvested parent refusal).\n     - Blockers: If candidate has active blockers declared via `gh issue edit <issue> --add-blocked-by <blocker-issue>`, reject dispatch as `HELD_BLOCKED_BY_DEPENDENCY` until blockers land upstream.\n     - Upstream baseline verification: Verify target code path on live `adolfousier/main` to ensure work is not already clean or differently structured upstream.\n  3. Verify target editor lane availability using `tools/oc-harvest-dispatch dispatch <issue> <commits> [--to <uuid>]`. If target lane is busy with an active claim, the tool refuses dispatch (rc 4); Triage must select an idle editor or commission a dedicated harvest worker.\n  4. **Landed-term gate (v0.4.204, HQ ruling 2026-09-18):** before wiring, confirm the issue is NOT already landed — a `done`/`close` row addressing it, or a commit referencing it on fork `main`. This patrol runs from a cron (`oc-harvest-dispatch-4h`) that wired #302 while #302 carried Triage's own `done` row (n=8267) and zero claims: `done` + zero claims satisfied the old two-term predicate. A landed-but-unharvested issue is HARVEST-queue work, never a fresh ","s":true},{"d":"Grep 'oc-pr-fault-scope|oc-log-search|oc-ping-proof|oc-upstream-delta' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/RC-CONTRACT.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/RC-CONTRACT.md:40:\n  39: | oc-lint-laws | 0 | 2 | 0 clean / 1 findings / 3 tools-dir-or-corpus-file-missing · **M2-18 law-vs-tool corpus lint (HQ mechanical audit, n=3845).** The law names verbs and flags; nothing checked they EXIST — so `oc-ship-chain --resume` and `oc-ledger stamp proposal` each reached a lane and were caught only when an editor RAN the dead verb. This is the check: every `oc-*` invocation in the law corpus is resolved against the tool it names. Three classes — PHANTOM-FLAG (the tool's source carries ZERO occurrences of the flag), PHANTOM-VERB (a subcommand-dispatching tool carries zero occurrences of the verb), UNKNOWN-TOOL (no such file in `tools/`). **An invocation is scoped to its MARKDOWN UNIT, not its line:** outside a fence only backtick spans are scanned, inside a fence the whole line is one unit, because a span is what a reader copies. Line-scoping was the first draft's defect — 40 then 13 findings on a CLEAN corpus, every one a flag belonging to a DIFFERENT command later on the same line (`cargo test --locked` after `oc-prchecks`, `--gated-run` after `oc-deploy`); a second window is the tool→flag GAP, capped at 3 tokens so a flag five words into prose (`standalone oc-wt stays the fallback only when --create is unavailable` — that `--create` is `oc-wt`'s) is never attributed. **CITATIONS:** a law that DOCUMENTS an absence (\"there is no `--resume` flag\") names a phantom ON PURPOSE, so a line carrying an absence marker downgrades the hit to a CITATION — counted, printable with `--show-citations`, EXIT-NEUTRAL; failing the incident table that records the family would make the lint unusable. The marker list is deliberately narrow and `Do not forget to run X` does NOT suppress (selftest-asserted). `--strict` narrows \"known\" to case-arm declarations (`^\\s+--flag)`) to catch a flag documented in prose but never wired; the default zero-occurrence rule UNDER-reports rather than mis-reports, ","s":true}] -->
<!-- reasoning -->
Now I have tool surfaces. `oc-pr-fault-scope` = "0 IN-SCOPE / 1 BASE-FAULT" — that's exactly the "ownerless red files" / base-fault classification tool. And `oc-log-search`, `oc-ping-proof` (0 WOKEN / 1 SILENT / 3 UNREACHABLE / 4 parse-fail) — that's the delivery/injection proof tool!

So:
- fleet-directives §Upstream PR filing — base CI gate pre-claim: "poll base-main CI gate state and pre-claim any OWNERLESS red files" → the classification IN-SCOPE vs BASE-FAULT is exactly what `oc-pr-fault-scope` derives. The law asks the lane to "poll base-main CI gate state and pre-claim any OWNERLESS red files" by hand. T1 yes, T2 yes (`oc-pr-fault-scope`), T3 yes. Strong finding.

- triage.md:291 injection verification: "verify injection from the daemon log ... Grep the log for the target session id after the send" → `oc-ping-proof` derives WOKEN/SILENT/UNREACHABLE. T1 yes, T2 yes, T3 yes ("verify ... grep the log"). Strong finding.

Hmm, but wait. `oc-ping-proof` — does it check delivery injection? "0 WOKEN / 1 SILENT / 3 UNREACHABLE" — this looks like a liveness ping proof, which is exactly the "verify the target is live" in triage.md:292. And the injection check (daemon log) may be different. Let me be careful about which tool to name. The triage.md:292 liveness check says "verify the target is live — session_search with updated_since (or a same-turn log grep for the session id)". That maps to `oc-ping-proof` (WOKEN/SILENT/UNREACHABLE). The triage.md:291 injection check maps to... the daemon log. Hmm, `oc-ping-proof` might cover both.

Actually, let me reconsider — I should be careful not to over-claim the tool host. Let me read oc-ping-proof's contract fully and oc-pr-fault-scope's. But RC-CONTRACT entries for those two are terse one-liners: "oc-ping-proof | 0 | 2 | 0 WOKEN / 1 SILENT / 3 UNREACHABLE / 4 parse-fail" and "oc-pr-fault-scope | 0 | 2 | 0 IN-SCOPE / 1 BASE-FAULT / 3 gh-fail". Good enough to name.

Now, the important thing: are these genuine J findings, or do they fail T1/T3? Let me apply:

For triage.md:291 (injection verification): The decision "was the notify actually injected?" is a pure function of the daemon log on disk. T1 ✓. A tool touches that state: `oc-ping-proof` (WOKEN/SILENT) — plausibly. T3 ✓: "verify injection ... Grep the log". So it's a finding. But hmm — is this a GATE? No, it's a mechanical verification. So it's a valid J finding.

But wait — actually, I want to reconsider whether this is really "assigned to agent memory" vs "assigned to a fresh read". The lens says T3 is "the rule currently asks an AGENT to remember, derive, or re-check that state by hand." A manual grep is "re-check that state by hand." So yes.

Hmm, however — I worry about over-reporting generic "verify X" clauses. The lens explicitly warns: "Failing T3 = already mechanical, the prose is descriptive, NO ACTION." And a finding must name the tool half or HQ rejects it. And "NOT THIS LENS — whether a law-cited verb or flag EXISTS."

Let me be selective and pick the strongest, most defensible findings. Let me also examine editor.md, editor-upstream-pr.md, SKILL.md, toolsmith.md, hq.md more.

Key candidates so far:
1. fleet-directives §Upstream PR filing (line ~442): "poll base-main CI gate state and pre-claim any OWNERLESS red files by carrying a sweep commit in the PR itself". Tool: oc-pr-fault-scope (IN-SCOPE/BASE-FAULT). 
2. triage.md:46-48 "Native Sub-Issues & Blockers Check" — manual verification of parent-merged / blockers / upstream baseline, while `oc-harvest-dispatch vet` (per RC-CONTRACT) already enforces HELD_PARENT_UNHARVESTED and HELD_BLOCKED_BY_DEPENDENCY. Strong.
3. triage.md:291 injection verification grep → oc-ping-proof.
4. triage.md:292 liveness check → oc-ping-proof.
5. triage.md:84-86 upstream PR-state patrol re-verify every OPEN upstream PR → hmm, this is a "re-verify ... fresh receipt, never memory" — it explicitly says never memory. So the decision is NOT assigned to memory; it's assigned to a fresh gh read. But it's still a manual enumeration of "every OPEN upstream PR of ours" that a tool should derive. Marginal. Could be J (the SET is state-derivable). Hmm. But there IS a tool touching upstream state: `oc-upstream-delta`. And the census is posted via that. Hmm, marginal — I'll consider.
6. triage.md:92-94 cron liveness patrol "verify the law-carrying crons are enabled and have recent last-run rows ... via the cron tool" — it names a tool (the cron tool). T2 satisfied. T3: "verify". Hmm. But "law-carrying crons" is a set the lane must know. Marginal.

Let me also check editor.md and hq.md and SKILL.md for the strongest.

Actually, let me step back and think about what the "expected" findings for this cycle might be. The context: fleet-directives.md was SPLIT on 2026-09-18 — 25 sections moved byte-exact into role/topic files. So the reviewer is asked to check (a) whether any law now assigns a state-derivable decision to agent memory, and (b) whether any gate's input became unreachable after the move.

For (b): I should look for cross-references that broke. E.g., a law sentence in editor.md that references "fleet-directives.md §X" where §X moved to triage.md, or an anchor that no longer exists. Let me grep for "§" references to fleet-directives across the corpus and check whether those sections still exist in fleet-directives.md.

The fleet-directives.md headings I enumerated: Owner Push Freeze, Telegram surface law, Discussion links + fix-approval gate, External lanes, Stage-entry consent, Post-compaction skill reload, Receiver-side dedupe, Attribution guard, PR naming convention, Strict Atomicity & Zero Bundling, LLM Ergonomics, Upstream Coding & Testing Standards, Unified Event Capture, Autonomous Priority Authority, Autonomous Editor Goal, Full-Gate Pre-PR Testing, Docs-Only LEG1 Gate Skip, Owner-Dependent Smoke Legs, Out-of-Feature-Set Issues, Dispatch Eligibility, Claim Release & Superseded Plans, Guard-Flag Escalation, Attribution & Goal Hygiene, Post-Rewrite Swap Recovery, Carrier Concurrency, Features-compat gate, Cross-lane message delivery discipline, Direct dispatch, Designated Domain Affinity, Early Claim, Every turn ends with what now/next, Explain open questions, Upstream PR filing, Verification during truncated-output, Daemon no-reap, telegram_send addressing rule.

So the split moved 25 sections INTO role files. That means some sections that USED to be in fleet-directives are now elsewhere. References pointing to fleet-directives for those would be stale.

Let me grep for references like "fleet-directives.md §" and "fleet-directives §" across the corpus (excluding CHANGELOG/reviews ideally).

Also "SKILL.md §" references.

Let me do that grep.

Actually, the J lens's object is "law sentence that assigns a state-derivable decision". The load-path/gate-input-unreachable question is more lens G. But the brief explicitly asks me to check "whether any gate's input became unreachable after the move." So I should check it, and if I find one, report it (even if G also owns it — but one site one lens; hmm). Actually the brief says the split "moved law text between files; check whether any law now assigns a state-derivable decision to agent memory, and whether any gate's input became unreachable after the move." So both are in scope for me.

Let me grep for § references.

Let me run:
- grep "fleet-directives.md §" across skill dir (excluding reviews maybe).
- grep "§" in the law files.

Let me do it.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'fleet-directives\\.md §|fleet-directives §' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor-upstream-pr.md:232:\n>    - **Owner-dependent leg → PARK, don't chase (v0.4.152, owner order 2026-09-12)**: if the remaining behavioral evidence needs the OWNER (visual pass, tap, eye-confirm), it is NOT a blocking gate. Stamp the provable legs, append `PARKED-OWNER-EYE` (owner action + packaging sha), RELEASE the lane, and let the candidate roll to the next owner-present window. Never idle on an owner leg — the owner being away is exactly when this binds. Full law: `fleet-directives.md §Owner-Dependent Smoke Legs — Park, Don't Chase`.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:5:\n> > **RELOAD LAW & MANIFEST CURATION (Section 10):** Canonical procedure lives in `fleet-directives.md §Post-compaction skill reload & context manifest curation` (keep `opencrabs-dev`, `editor.md`, `fleet-directives.md` in `active_skills`; re-read on compaction/spawn).\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:82:\n> **Direct dispatch (owner order 2026-09-10, fleet-directives §Direct dispatch):\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:409:\n> 1. **Leg 1 (CI Gate):** Dispatches and watches `oc-prchecks` (`pr-checks.yml` on your branch: fmt + clippy + `cargo test --locked --profile ci --all-features`). **Exception — a pure-docs commit SKIPS this leg** (owner ruling 2026-09-12: *\"We don't need the pure docs commits to pass through ci on our side.\"*). \"Pure docs\" is defined in the law, not by the tool: every changed path ends `.md` **and** is not `include_str!`-compiled into the binary — the 21-path compiled-in exclusion set lives in `fleet-directives.md §Docs-Only LEG1 Gate Skip`. A skip is recorded as **SKIPPED** and is never a passed gate: do not cite a skipped leg as GREEN, and do not count it as a passed leg in a smoke receipt.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:446:\n> - **Exit 6 — INFRA / ORDER-GATE:** dispatch or poll infrastructure failure (`oc-p","s":true},{"d":"Grep 'SKILL\\.md §' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor-upstream-pr.md:165:\n> - **BUILD TRIGGERS = exactly TWO, no exceptions:** Canonical law lives in `SKILL.md §Hard rules` (`oc-deploy ship` or owner word; CI gate = `oc-prchecks`).\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor-upstream-pr.md:293:\n>    - **WHO POSTS — HQ posts it, on the filing lane's behalf. There is NO editor carve-out (v0.4.204, HQ ruling 2026-09-18).** An editor lane CANNOT discharge this gate itself: SKILL.md §Telegram surface law forbids editors from invoking ANY telegram send/edit tool, not even into their own topic. Without this assignment the two laws bind the same actor and the obligation has **no executor on the filing side**. So: the filing editor sends HQ the 1-liner text (`session_notify`, `delivery.mode=\"turn-end\"`) in the same turn it stages the PR; HQ posts it to the venue. This is NOT a new carve-out — it is the existing lifecycle assignment, since SKILL.md §Upstream relations item 5 makes **Maintainer Interaction (incl. the OC Dev chat heads-up) HQ's area**. The obligation is on the CHAIN, not the filer: a lane that has put the text in HQ's queue has discharged it, and its harvest may proceed.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:15:\n> `oc-deploy` (NO dispatch exceptions: BUILD TRIGGERS = exactly TWO — SKILL.md §Hard rules).\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:48:\n> Full law + audit history: SKILL.md §Telegram surface law (canonical). Your\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:52:\n>   your own topic (canonical enumeration: SKILL.md §Telegram surface law). Your\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:262:\n>   SKILL.md §Upstream relations): NEVER `merge --ff-only adolfousier/main` into\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:270:\n>   `rebase --onto`. *(SKILL.md §Shared war stories)*\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:374:\n>","s":true}] -->
<!-- reasoning -->
Very useful. I see references to sections that may have MOVED. Notably:

- toolsmith.md:99: "per fleet-directives §Cross-lane delivery (cadence law..." — but the actual section in fleet-directives.md is "Cross-lane message delivery discipline". "§Cross-lane delivery" might be a shortened name. Let me check if there's a section named "Cross-lane delivery" vs "Cross-lane message delivery discipline". The heading is "## Cross-lane message delivery discipline (owner order 2026-09-04 22:31Z) [LANE]". So "§Cross-lane delivery" is a loose reference but resolvable.

- SKILL.md:194: "Escalation ladder canonical: fleet-directives.md §Cross-lane delivery" — same loose ref.

- lens-B report (20260918) mentions many sections: `§Remotes & sync`, `§Seam-resolution shape`, `§Deep Core Advance Heads-Up Gate`, `§CI-wait discipline & actor attribution`, `§Swap-head signature`, `§Post-swap notify`, `§Cargo prohibition`, `§Creating new editors`, `§Decision Rollcall`, `§Tool-problem reports`, `§Tool logging rule`, `§Daemon no-reap`, `§Inherited-claim three-pillar verification`, `§Verification during a truncated-output window`, `§Attribution guard`, `§Receiver-side dedupe`, `§Parked issues`, `§Every turn ends...`, `§Explain open questions`, `§Stage-entry consent`, `§No auto-rollback on smoke FAIL`, `§Features-compat gate`, `§Carrier hotfix gates`, `§Owner Push Freeze`, `§External lanes`, `§Topic domain alignment`, `§Rule-text provenance`, `§telegram_send addressing rule`, `§Swap-sha test coverage & Split-Gate Pipeline`, `§Claim Release & Superseded Plans`, `§Upstream PR filing — base CI gate pre-claim`, `§Cross-fork PR inspection`.

Wait — the lens-B report says these are canonical in fleet-directives.md. But many of these are NOT in the current fleet-directives.md heading list I enumerated! E.g., `§Remotes & sync`, `§Seam-resolution shape`, `§Deep Core Advance Heads-Up Gate`, `§CI-wait discipline & actor attribution`, `§Swap-head signature`, `§Cargo prohibition`, `§Creating new editors`, `§Decision Rollcall`, `§Tool-problem reports`, `§Tool logging rule`, `§Inherited-claim three-pillar verification`, `§No auto-rollback on smoke FAIL`, `§Carrier hotfix gates`, `§Topic domain alignment`, `§Swap-sha test coverage & Split-Gate Pipeline`, `§Cross-fork PR inspection`.

Hmm — but that lens-B report is dated 20260918, and the split happened 2026-09-18. So the report may predate or be contemporaneous with the split. Actually the report explicitly says these are canonical in fleet-directives.md. If the split moved 25 sections OUT of fleet-directives.md into role files, then those references (from other files pointing to fleet-directives.md §X) would be STALE — pointing at a section that no longer lives there.

Wait, but the report is in reviews/20260918-cycle/reports/ — that's today's cycle. Hmm, it might be from the same day before the split.

This is the key thing to check: did the split move sections that other files still reference as living in fleet-directives.md? Let me enumerate what's currently in fleet-directives.md (I have the heading list) and compare with references.

Current fleet-directives.md headings (from grep):
1. Owner Push Freeze
2. Telegram surface law
3. Discussion links + fix-approval gate
4. External lanes
5. Stage-entry consent
6. Post-compaction skill reload & context manifest curation
7. Receiver-side dedupe of reload demands
8. Attribution guard (post-compaction wakes)
9. PR naming convention
10. Strict Atomicity & Zero Bundling
11. LLM Ergonomics & Efficiency Law
12. Upstream Coding & Testing Standards
13. Unified Event Capture
14. Autonomous Priority Authority Law
15. Autonomous Editor Goal & Continuous Phase Execution Law
16. Full-Gate Pre-PR Testing Law
17. Docs-Only LEG1 Gate Skip
18. Owner-Dependent Smoke Legs
19. Out-of-Feature-Set Issues
20. Dispatch Eligibility
21. Claim Release & Superseded Plans
22. Guard-Flag Escalation Law
23. Attribution & Goal Hygiene
24. Post-Rewrite Swap Recovery
25. Carrier Concurrency & Coalescence Law
26. Features-compat gate
27. Cross-lane message delivery discipline
28. Direct dispatch
29. Designated Domain Affinity & Topic Context Focus Law
30. Early Claim
31. Every turn ends with a "what now/next?" answer
32. Explain open questions & re-anchor context
33. Upstream PR filing — base CI gate pre-claim
34. Verification during a truncated-output window
35. Daemon no-reap
36. telegram_send addressing rule

Note the file has 52 heading matches but that includes h2 and h3. The h2 (##) sections are the ones above (~36).

Now, sections referenced by lens-B as canonical in fleet-directives but NOT present in the current file:
- §Remotes & sync — NOT in current fleet-directives. Hmm, wait. Is there a §Remotes & sync? Let me check. In the first grep of fleet-directives headings, I don't see it. But earlier I saw in the hq.md grep? No. Let me search for "Remotes & sync".

Actually, hold on. My heading grep for fleet-directives.md returned 52 matches, but the output was truncated at some point? No, it showed all up to line 465. Let me count: the list ended at "telegram_send addressing rule (line 465)". 52 matches total. Hmm, but the file is 448 lines? No wait, earlier read said "448 lines" for the file. Actually the read said "70272 bytes (448 lines)". And heading at line 465?? That's inconsistent. Hmm, the heading grep showed "fleet-directives.md:465". So the file has >465 lines. The earlier read_file said "(448 lines)" — that was the count read from start_line 28 maybe. Whatever.

Wait, actually the heading list I got seems to be missing many sections. Let me recount the grep output: it listed matches at lines 1,32,53,57,64,82,86,97,101,105,112,119,128,141,158,164,171,184,201,205,215,224,230,236,240,244,248,252,261,274,285,289,293,297,308,317,325,327,333,339,347,366,370,393,397,414,430,434,442,451,459,465. That's 52. So the file's last heading is at line 465, and the file is ~500+ lines. Hmm, the read_file at start_line 350 with line_count 99 showed up to line 448 content. So the file is ~470+ lines. OK.

So the headings at 442 = "Upstream PR filing — base CI gate pre-claim", 451 = "Verification during a truncated-output window", 459 = "Daemon no-reap", 465 = "telegram_send addressing rule". So those are the LAST sections. There's no "§Remotes & sync" in fleet-directives.md currently!

Hmm, but lens-B report says `§Remotes & sync` (hq.md: "SYNC LAW canonical = fleet-directives.md §Remotes & sync"). So hq.md points to a fleet-directives section "Remotes & sync" that... let me verify whether it exists. My heading grep would have caught "## Remotes & sync" if it existed. It didn't. Unless it's under a different heading form.

Wait — maybe I'm wrong; maybe "Remotes & sync guard" is a subsection. Let me grep for "Remotes" in fleet-directives.md.

This is exactly the "gate's input became unreachable after the move" check! If the split moved §Remotes & sync out of fleet-directives.md (into hq.md or upstream-merge-runbook.md), then hq.md's pointer "SYNC LAW canonical = fleet-directives.md §Remotes & sync" is stale — the gate's input (the sync law) is now unreachable at the cited location.

Hmm, but wait — this could also be lens A/G territory. But the brief explicitly asks me to check it. And "one site, one lens" — but my brief says to check it, so I'll report if evidenced.

Let me grep fleet-directives.md for "Remotes", "sync guard", "Cargo prohibition", "Creating new editors", etc. to see which referenced sections exist.

Actually — hold on. Let me reconsider. The heading grep might have missed sections because the pattern `^\s*#{1,4} ` requires a space after #. All headings have that. So it should catch all.

Hmm, but the count is 52 and I listed them. Let me just directly grep for these section names.

Let me grep fleet-directives.md for: Remotes, Cargo prohibition, Creating new editors, Decision Rollcall, Tool-problem reports, Tool logging rule, Inherited-claim, No auto-rollback, Carrier hotfix gates, Cross-fork PR, Swap-sha test coverage, CI-wait discipline, Deep Core Advance.

If these are absent from fleet-directives.md, then references to them as "fleet-directives.md §X" are stale → the split moved them.

Let me do that.

Actually, I realize the "split" described: "on 2026-09-18 fleet-directives.md was SPLIT - 25 sections moved byte-exact into the role/topic files." So 25 sections that were in fleet-directives.md are now in role files. So references from other files (and possibly from within the moved text) that say "fleet-directives.md §X" are now dangling.

But careful: lens B (20260918 report) verified "Canon:" markers and said these ARE canonical in fleet-directives.md. That report might be from BEFORE the split, or the split might have happened after. Actually the lens-B report file is reviews/20260918-cycle/reports/lens-B-redundancy-20260918.md — dated 2026-09-18, same day. Hmm.

Hmm, this is getting complicated. Let me just directly check: does fleet-directives.md contain §Remotes & sync? Let me grep.

Let me run greps for these section names in fleet-directives.md.

Also I should check the current SKILL.md for a "canonical-home table" that might list where sections live.

Let me run the greps.
<!-- /reasoning -->

Let me check whether sections referenced as living in fleet-directives.md still exist there (the split's reachability question).


<!-- tools-v2: [{"d":"Grep 'Remotes|Cargo prohibition|Creating new editors|Decision Rollcall|Tool-problem reports|Tool logging rule|Inherited-claim|No auto-rollback|Carrier hotfix|Cross-fork PR|Swap-sha test coverage|CI-wait discipline|Deep Core Advance|Seam-resolution|Swap-head signature|Post-swap notify|Parked issues|Topic domain alignment' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:12:\n> | intake & assignment, dispatch hygiene, topic domain alignment, parked issues, Decision Rollcall, creating new editors | `triage.md` |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:48:\n> 4. **This is NOT the carrier FREEZE of §Remotes & sync guard (2).** That one is mechanical (no sync while a carrier chain sits between dispatch and swap). This one is an owner hold on a feature group's harvest. Same word, different concept — write **owner push freeze (harvest hold)** when you mean this one.\n\n(2 matches)","s":true},{"d":"Grep 'Remotes & sync|§Remotes|sync guard|Cargo prohibition|Creating new editors|Decision Rollcall' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:196:\n> ## Decision Rollcall duty — owner decisions post direct, in YOUR topic (owner order 2026-09-08, topic 42487, ruling n=1994)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:198:\n> When Triage announces a **Decision Rollcall** (full law: triage.md\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:199:\n> §Decision Rollcall), each editor answers in ITS OWN LANE TOPIC, addressed to\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:462:\n> | **2. Sync Model (REBASE)** | Triage | `upstream-merge-runbook.md` | `upstream-merge-runbook.md §Remotes & sync` |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:263:\n> Sync execution is DELEGATED TO TRIAGE (owner order 2026-09-11: \"You should not do these merges - delegate to triage\"; HQ does not execute syncs). **SYNC LAW canonical = `upstream-merge-runbook.md §Remotes & sync` (REBASE model); executing procedure: `upstream-merge-runbook.md` (managed by Triage via `triage.md §Duty T7`).**\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:8:\n>   - **Distinguished from the existing carrier FREEZE** (`§Remotes & sync` guard 2 — mechanical: no sync while a carrier chain sits between dispatch and swap). Same word, different concept; write **owner push freeze (harvest hold)** when you mean this one. **Scope boundary:** the freeze holds HARVEST, not development — fixes, commits, ships and smokes inside fork `main` continue normally; only the upstream push of a frozen group is withheld.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:928:\n> - **GOVERNANCE — the MERGE sync model is RETIRED for the REBASE model** (owner-approved transition 2026-09-11, plan \"Fork Rebase Transition and Sync Workflow\"). Fork main is rebased onto `adolfousier/main`: a small set of topical commits sits directly on upstream/main, and each sync is a rebase that DROPS the commits upstream has accepted, so the ahead counter r","s":true}] -->
<!-- reasoning -->
Important discovery: 

- hq.md:263 now says: "SYNC LAW canonical = `upstream-merge-runbook.md §Remotes & sync`". So the reference was UPDATED to point at upstream-merge-runbook.md. Good — the split fixed that.
- SKILL.md:462: "| **2. Sync Model (REBASE)** | Triage | `upstream-merge-runbook.md` | `upstream-merge-runbook.md §Remotes & sync` |" — updated too.
- fleet-directives.md:48: "This is NOT the carrier FREEZE of §Remotes & sync guard (2)." — this is a bare § reference within fleet-directives.md, now DANGLING because §Remotes & sync moved to upstream-merge-runbook.md. Hmm! That's a stale internal reference — the Owner Push Freeze section refers to "§Remotes & sync guard (2)" which no longer exists in fleet-directives.md. This is a reachability issue: a lane reading fleet-directives.md §Owner Push Freeze is told to distinguish from §Remotes & sync guard (2), but that section is not in the file. It moved to upstream-merge-runbook.md.

Hmm, but is that a J finding? It's a stale cross-ref — lens A owns ref consistency. Hmm. My brief says "whether any gate's input became unreachable after the move." This reference isn't exactly a gate input. Hmm. It's a pointer to a definition used to disambiguate a gate ("freeze"). Marginal. Could be A's.

- fleet-directives.md:12: the thematic index table now lists where sections live: "| intake & assignment, dispatch hygiene, topic domain alignment, parked issues, Decision Rollcall, creating new editors | `triage.md` |". So the split added a routing table. Good.

Let me read the top of fleet-directives.md (lines 1-32) to see the routing table fully — it maps sections to their new homes. That'll tell me which sections moved.

Let me read lines 1-32.

Also I need to check whether references elsewhere still point to fleet-directives.md for moved sections. E.g., editor.md:196 "Decision Rollcall duty ... full law: triage.md §Decision Rollcall" — updated. SKILL.md canonical-home table (line 462 area) — let me read that table.

Let me read SKILL.md around 454-470 (the canonical home table) and fleet-directives.md 1-32.

Let me also read the lens-S report? No, that's a report, not law.

OK let me read fleet-directives.md lines 1-32 and SKILL.md lines 454-470.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"**Owns:** the binding owner directives that apply to EVERY opencrabs-dev lane — the `[LANE]` law every worker reads in full at spawn and at compaction reload, plus a residual of cross-cutting rulings that belong to no single role. Re-homed here from ops AGENTS.md/MEMORY.md per owner order 2026-09-02.\n\n**Shape after the 2026-09-18 split.** Role- and topic-scoped law no longer lives here: 25 sections were relocated byte-exact into the file that owns them, and this file keeps a pointer only — one concept, one home. Read scoped law THERE:\n\n| Kind of law | Canonical file |\n|---|---|\n| sync model & rebase, seam resolution, harvest cadence / HARVEST LAW / NO-HOLD, PHOP, swap-head signature | `upstream-merge-runbook.md` |\n| editor phases, smoke procedure, CI-wait & CI-watcher discipline, carrier hotfix gates, swap-sha coverage, no auto-rollback, inherited-claim pillars | `editor.md` |\n| upstream PR lifecycle, deep-core heads-up gate, dependent PRs law, cross-fork PR inspection, upstream issue filings | `editor-upstream-pr.md` |\n| intake & assignment, dispatch hygiene, topic domain alignment, parked issues, Decision Rollcall, creating new editors | `triage.md` |\n| tool-problem reports, tool logging rule | `toolsmith.md` |\n| HQ duties, cadence boundary, rule-text provenance, refuse-and-reroute | `hq.md` |\n| Duty-6 lens briefs (A–J families + brain-scrub) | `review-lenses.md` |\n| post-swap notify / fan-out vocabulary | `s2-swap-journal-spec.md` |\n\n**Thematic index** (lens B-17/G-F9 v0.4.90 — file is flat; jump via section name). **[LANE] tag (v0.4.95):** sections every worker MUST read in full at spawn/compaction reload (editor.md/triage.md/toolsmith.md/hq.md RELOAD LAW v0.4.95). EXCEPTION (v0.4.96, lens B-F1): HQ re-reads THIS ENTIRE FILE IN FULL — it owns and rules on the directives; the other three roles may use this thematic-index minimum for non-[LANE] sections.\n\n**Owner holds & gates:** **Owner Push Freeze** (soaking groups held from upstream harvest) · **Discussion link","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"Upstream movement is WATCHED and ABSORBED on a schedule per the matrix below:\n\n| Lifecycle Area | Owning Role | Key Tool / Procedure | Canonical Home |\n|---|---|---|---|\n| **1. Upstream Delta Watch** | Triage | `./tools/oc-upstream-delta` | `triage.md §Duty T4` |\n\n| **2. Sync Model (REBASE)** | Triage | `upstream-merge-runbook.md` | `upstream-merge-runbook.md §Remotes & sync` |\n| **3. Absorption & Dropping** | Triage / HQ | Auto-classify DROPPABLE patch-ids | `upstream-merge-runbook.md` |\n| **4. Upstream PR Lifecycle** | Editor | Phase 7b / Phase 7c (`oc-harvest-dispatch`) | `editor-upstream-pr.md` |\n| **5. Maintainer Interaction** | HQ / Alexey | Track PR comments via gh API & OC Dev chat heads-up | `editor-upstream-pr.md §Deep Core Advance Heads-Up Gate` |\n| **6. Fork-local CI (`ci/*`)** | HQ | Carrier namespace `ci/quick-build-linux` | `hq.md §Parity` |\n| **7. Fork Branch Lifecycle** | Triage | `./tools/oc-branch-sweep` (archive before delete) | `triage.md §Duty T4` |\n\n## Hard rules (all roles)\n\n- Reports to Alexey: every issue/PR reference\n  carries the LINK behind the number (issues: `https://github.com/leshchenko1979/opencrabs/issues/N`\n  — the fork is the issues home; PRs: `https://github.com/adolfousier/opencrabs/pull/N`) — a bare `#N` is never enough.\n- Refer to workers by TOPIC/CHAT NAME only (owner 2026-08-31): Mermaid, Push to\n  session, Vector memory, … — NEVER by session uuid. Applies to EVERY surface:\n  owner reports, inter-lane advisories, session_notify text, verdict tables,\n  ledger commentary. Uuids are for ROUTING fields only (`target_session`,\n  `OC_ACTOR`, `Session-Id` trailers, tool arguments) — never prose. Test: an\n  owner reading the message must know WHICH chat to open without a lookup.","s":true}] -->
<!-- reasoning -->
Now I have the routing table. The split moved 25 sections. Key: the routing table is the pointer map.

Now, the question: did any reference break? Let me check each "fleet-directives.md §X" reference in the law corpus against whether X still exists in fleet-directives.md.

From the earlier grep, the "fleet-directives.md §" references in law files:
- editor-upstream-pr.md:232 → §Owner-Dependent Smoke Legs — EXISTS ✓
- editor.md:5 → §Post-compaction skill reload — EXISTS ✓
- editor.md:82 → §Direct dispatch — EXISTS ✓
- editor.md:409 → §Docs-Only LEG1 Gate Skip — EXISTS ✓
- editor.md:446 → §Post-Rewrite Swap Recovery — EXISTS ✓
- editor.md:533 → §Owner-Dependent Smoke Legs — EXISTS ✓
- toolsmith.md:3 → §Post-compaction skill reload — EXISTS ✓
- toolsmith.md:99 → §Cross-lane delivery (cadence law) — the actual heading is §Cross-lane message delivery discipline. "§Cross-lane delivery" is an abbreviated form; probably OK.
- SKILL.md:191 → §Cross-lane message delivery discipline — EXISTS ✓
- SKILL.md:194 → §Cross-lane delivery — EXISTS (abbrev)
- SKILL.md:286 → §Owner-Dependent Smoke Legs — EXISTS ✓
- SKILL.md:488 → §Post-compaction skill reload — EXISTS ✓
- hq.md:3 → §Post-compaction skill reload — EXISTS ✓
- hq.md:263 → now points to upstream-merge-runbook.md §Remotes & sync ✓ (fixed)

And within fleet-directives.md:48 → "§Remotes & sync guard (2)" — DANGLING (moved to upstream-merge-runbook.md).

Hmm. Is that the kind of finding for me? The brief says "whether any gate's input became unreachable after the move." The §Owner Push Freeze section's rule 4 is about distinguishing two freezes. Its pointer to §Remotes & sync guard (2) is now unreachable from fleet-directives.md. But a reader of fleet-directives.md would look in the file and not find it. However, the routing table at the top says sync model & rebase → upstream-merge-runbook.md. So a diligent reader could find it. Marginal. And it's more lens A (ref consistency). I'll consider mentioning as LOW maybe. Hmm.

Actually, hold on. Let me reconsider the whole task. The J lens is about law assigning state-derivable decisions to agent memory. The split-reachability is a secondary check. Let me focus on the primary defect class and gather 3-5 solid findings.

Let me now read editor.md and hq.md and editor-upstream-pr.md and toolsmith.md and SKILL.md more thoroughly for the T3 tells.

Let me grep editor.md for the patterns.

Actually, let me think about which law sentences are the strongest J candidates across the corpus:

1. **triage.md:46-48 — "Native Sub-Issues & Blockers Check"**: manual verification of parent-merged/blockers/upstream-baseline, while `oc-harvest-dispatch vet` already enforces HELD_PARENT_UNHARVESTED and HELD_BLOCKED_BY_DEPENDENCY. T1/T2/T3 all yes. Strong. Verbatim quotes available.

Wait, but let me double-check: RC-CONTRACT says for oc-harvest-dispatch: "`vet` candidate enforces 24h feature soak gating ..., subsystem cohesion (`HELD_DEPENDENT_SOAK`...), active claim fencing (`HELD_IN_FLIGHT_LANE`), native sub-issue parent verification (`HELD_PARENT_UNHARVESTED`), and dependency resolution (`HELD_BLOCKED_BY_DEPENDENCY`, Issue #255)". YES — the tool enforces parent verification and dependency resolution. So the law's step 2 manual checks duplicate the tool. This is a clean finding: the law asks Triage to hand-verify parent-merged and blockers, but `oc-harvest-dispatch vet` already derives those verdicts. Fix: delete step 2's manual checks, point at the tool's rc output.

Hmm — but wait, is it possible step 2 describes what the TOOL does (i.e., the criteria the tool enforces), not instructions to the agent? The phrasing: "Sub-issues / Child cleanups: If candidate is a sub-issue or child cleanup (...), verify parent feature is already merged upstream. If parent is unmerged, reject candidate harvest as blocked sub-issue." — "verify parent feature is already merged upstream" is an imperative to the reader. And "Upstream baseline verification: Verify target code path on live adolfousier/main". These are imperatives. So yes, T3.

But careful: "one site, one lens" and the boundary vs C: C owns recurring multi-step PROCEDURE rituals that should collapse into one command. Here the tool ALREADY exists (oc-harvest-dispatch vet), and step 1 already says run it. So the manual step 2 is a law sentence assigning a state-derivable decision to the agent. That's J. Good.

Hmm, but actually the "reject as blocked sub-issue" decision — is that a GATE? No, it's a mechanical classification. So J.

2. **fleet-directives.md §Upstream PR filing — base CI gate pre-claim** (line 442): "Before filing an upstream PR, poll base-main CI gate state and pre-claim any OWNERLESS red files by carrying a sweep commit in the PR itself". T1: base-main CI state + ownerless classification are derivable (gh API + ledger). T2: `oc-pr-fault-scope` (0 IN-SCOPE / 1 BASE-FAULT) touches exactly this state; `oc-harvest-sweep` is the "pre-gate harvest verification". T3: "poll ... and pre-claim any OWNERLESS red files" — imperative to the reader. Strong.

Let me get the exact verbatim text of that section (lines 442-450).

3. **triage.md:291 — injection verification grep**: "Before stamping any ack ..., verify injection from the daemon log ... Grep the log for the target session id after the send; stamp ack only on a real injection". T1 yes (daemon log on disk). T2: `oc-log-search` (0 matches / 1 zero-hits) or `oc-ping-proof`. T3 yes. Strong.

Hmm, `oc-log-search` is a generic log search — a natural host. Or `oc-ping-proof` (0 WOKEN/1 SILENT/3 UNREACHABLE) which is exactly a liveness/delivery proof. Let me name `oc-ping-proof` for the liveness check (triage.md:292) and `oc-log-search` for the injection grep? Hmm, actually let me read oc-ping-proof's fuller contract to be precise. The RC-CONTRACT line is terse. Let me search the tools dir for oc-ping-proof description.

Actually — I should be careful about which tool to name. Let me quickly look at the tools dir listing and maybe the header of oc-ping-proof and oc-log-search.

Let me read tools/oc-ping-proof and tools/oc-log-search headers.

4. **triage.md:292 — liveness check**: "before session_notify to any session not heard from this turn, verify the target is live — session_search with updated_since (or a same-turn log grep for the session id...)". T1 yes, T2 `oc-ping-proof`, T3 yes. Same family as 3. I might combine 3 and 4 into one finding or report separately. Actually they're two distinct law sentences. But "one site one lens" — both are J. I'll report the stronger one (injection grep) and mention the liveness one.

Hmm, but actually, wait. Let me reconsider whether these notify-verification clauses are really "defects" the lens wants, or whether they're acceptable because the tool half doesn't exist. The lens says a finding must name (c) the tool that should own it and its single-command interface. If `oc-ping-proof` exists and does WOKEN/SILENT/UNREACHABLE, then the tool half largely EXISTS and the law is telling the lane to hand-grep instead → that's exactly the defect (agent memory instead of the tool). Strong.

Let me verify oc-ping-proof is about session liveness/delivery. Let me read its header.

5. **hq.md:276 — "Checkout-ref verification: Checkout log lines identify the tested tree; verify checkout-ref matches the expected head SHA before treating a verdict as final evidence."** T1: the checkout ref vs head sha is derivable from the run's log/API. T2: `oc-prchecks` or `oc-job-verify` (0 VERIFIED / 2 IN-FLIGHT / 3 FAILED / 4 REF-MISMATCH / 5 NOT-FOUND — "embed-sha compares exact OR first-12-hex prefix"). Hmm, oc-job-verify has REF-MISMATCH! So the law asks HQ to "verify checkout-ref matches the expected head SHA" by hand, while `oc-job-verify` returns REF-MISMATCH. Strong candidate! Let me get exact text.

Let me read hq.md around 270-290.

6. **triage.md:84-86 — upstream PR-state patrol**: "re-verify the state of every OPEN upstream PR of ours (gh pr view <n> ...) and post the states". T1 yes. T2: `oc-upstream-delta`? Hmm, that's delta not PR states. There's no obvious tool for "every OPEN upstream PR state". Marginal — maybe skip.

7. **triage.md:92-94 — cron liveness patrol**: "verify the law-carrying crons are enabled and have recent last-run rows ... via the cron tool". Names a tool. T2 ok. T3 "verify". Hmm — but it says "via the cron tool, fresh receipt", so the tool does the read. Marginal.

Let me also check editor.md for state-derivable decisions assigned to memory. E.g., Phase 3 exploration, Phase 6 etc. And editor-upstream-pr.md.

Let me grep editor.md for T3 patterns.

Let me batch: read hq.md 265-295, grep editor.md, read tools/oc-ping-proof header, read fleet-directives 442-450.

Let me do these.
<!-- /reasoning -->

Let me pull exact text for the strongest candidates and check the tool hosts.


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"Before filing an upstream PR, poll base-main CI gate state and pre-claim any\nOWNERLESS red files by carrying a sweep commit in the PR itself\n(Session-Id-only trailer, no Issue-Ref). Do NOT rely on sequencing comments\nor separate base-repair PRs landing first — the 2026-09-05 #1394/#1393/#1395\nout-of-order merge (fork #103 incident) proved sequencing comments don't\nprotect merge order.\n\n## Verification during a truncated-output window is not verification (Duty-4 proposal, owner-approved 2026-09-06; sharpens AGENTS.md truncated-output law)\n\nWhen the earlier run's output was truncated, VERIFICATION ITSELF must be\nre-run fresh OUTSIDE that window — a compat check performed during the","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md","o":"Sync execution is DELEGATED TO TRIAGE (owner order 2026-09-11: \"You should not do these merges - delegate to triage\"; HQ does not execute syncs). **SYNC LAW canonical = `upstream-merge-runbook.md §Remotes & sync` (REBASE model); executing procedure: `upstream-merge-runbook.md` (managed by Triage via `triage.md §Duty T7`).**\n\nHQ retains watch and governance authority only:\n- **Watch**: Monitor upstream delta (`./tools/oc-upstream-delta`) and notify Triage to execute rebase sync when upstream advances.\n- **Rulings**: Rule on non-trivial merge blockers or semantic conflicts escalated by Triage.\n- **Parity verification**: Ensure carrier proof-dispatch runs clean after rebase cutover. Procedural execution steps live exclusively in `upstream-merge-runbook.md` and `triage.md`.\n\n## Detached command execution (background: true)\n\nLong-running commands (>60s, test batteries, carrier/CI waits, heavy audits) MUST run detached via the bash tool parameter `background: true`.\n\n- **Auto-resume & injection:** The daemon tracks detached executions natively and auto-resumes the session upon process completion. Do NOT hand-roll polling loops or detached background daemons.\n- **Terminal state:** CI waits must gate completion on terminal state (`completed` status; `success`/`failure` conclusion).\n- **Checkout-ref verification:** Checkout log lines identify the tested tree; verify checkout-ref matches the expected head SHA before treating a verdict as final evidence.\n- **REST v3 keys are snake_case:** In `gh api` `--jq` filters, `run_started_at`/`updated_at` work; camelCase (`runStartedAt`) silently evaluates to null.\n\n## HQ does not execute lane work — refuse and reroute (owner order 2026-09-09 ~10:4xZ: \"you should refuse work that should be done by the triage lane and tell the requesting lane to reroute\")\n\nWhen a lane sends HQ work that belongs to an executing lane — editor-lane fixes/rebases/carrier chains, Triage-lane intake verification, TOOLSMITH tool code — HQ REFUSES execution and ","s":true},{"d":"Grep 'SILENT|WOKEN|inject|session' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ping-proof","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ping-proof:5:\n  3: # oc-ping-proof — B25: report-only roster-ping verification against\n  4: # workers-ledger.json. UNREACHABLE if the uuid is not on the roster; else\n> # WOKEN when the worker's last_acked.at or any event at >= ping-ts, SILENT\n  6: # otherwise. Bare HH:MMZ stamps are normalized to today (UTC) before compare\n  7: # (the ledger mixes ISO and bare-HH:MM formats). Zero side effects.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ping-proof:12:\n  10: #   oc-ping-proof <uuid> <ping-ts> [--ledger <file>] | --selftest\n  11: #\n> # Exit codes: 0 WOKEN · 1 SILENT · 2 usage · 3 UNREACHABLE · 4 parse failure\n  13: # Env: OC_TOOLS_LOG\n  14: # Output: verdict line on stdout (\"WOKEN|SILENT|UNREACHABLE <uuid>\");\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ping-proof:14:\n  12: # Exit codes: 0 WOKEN · 1 SILENT · 2 usage · 3 UNREACHABLE · 4 parse failure\n  13: # Env: OC_TOOLS_LOG\n> # Output: verdict line on stdout (\"WOKEN|SILENT|UNREACHABLE <uuid>\");\n  15: #         evidence (matched stamp) on stderr.\n  16: # =============================================================================\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ping-proof:40:\n  38: }\n  39: \n> [ \"${1:-}\" = \"-h\" ] || [ \"${1:-}\" = \"--help\" ] && { echo \"usage: oc-ping-proof <uuid> <ping-ts> [--ledger <file>]\"; echo \"Exit: 0 WOKEN / 1 SILENT / 2 usage / 3 UNREACHABLE / 4 parse failure\"; exit 0; }  # C-#3: help=0\n  41: if [ \"${1:-}\" = \"--selftest\" ]; then\n  42:   d=\"$(mktemp -d)\" || exit 3\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ping-proof:51:\n  49: ],\"events\":[]}\n  50: JSON\n>   \"$0\" u-woke 2026-08-28T11:00Z --ledger \"$d/wl.json\" >/dev/null 2>&1; [ $? -eq 0 ] || { echo \"selftest: u-woke not WOKEN\" >&2; exit 1; }\n  52:   \"$0\" u-silent 2026-08-21T00:00Z --ledger \"$d/wl.json\" >/dev/null 2>&1; [ $? -eq 1 ] || { echo \"selftest: u-silent not SILENT\" >&2; exit 1; }\n  53:   \"$0\" u-event 20","s":true}] -->
<!-- reasoning -->
Good. `oc-ping-proof <uuid> <ping-ts>` = report-only roster-ping verification. WOKEN/SILENT/UNREACHABLE based on the ledger. This is the liveness check tool (triage.md:292). So the law's "verify the target is live — session_search with updated_since (or a same-turn log grep for the session id)" is exactly what `oc-ping-proof` derives. Strong J finding.

For the injection check (triage.md:291) — that's the daemon log, not the ledger. `oc-log-search` is the natural host (log search). Hmm, or the tool could be extended. I'll name `oc-log-search`.

Now hq.md:276 "Checkout-ref verification: Checkout log lines identify the tested tree; verify checkout-ref matches the expected head SHA before treating a verdict as final evidence." → `oc-job-verify` (REF-MISMATCH) or `oc-prchecks`. This is a strong J candidate: T1 (the run's checkout ref and head sha are on the API/log), T2 (`oc-job-verify` rc 4 REF-MISMATCH), T3 ("verify ... before treating a verdict as final evidence"). Good.

Now let me also check editor.md and editor-upstream-pr.md and SKILL.md and toolsmith.md.

Let me grep editor.md for T3 patterns.

Let me also consider the "Reviewer J" brief's note about the split: "check whether any law now assigns a state-derivable decision to agent memory". Hmm. Let me look for law sentences that were MOVED and now live in a role file but reference state.

Let me grep editor.md.

Also toolsmith.md (12KB) — small, read it fully.

Let me read toolsmith.md fully and grep editor.md.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/toolsmith.md","o":"**RELOAD LAW & MANIFEST CURATION (Section 10):** Canonical procedure lives in `fleet-directives.md §Post-compaction skill reload & context manifest curation` (keep `opencrabs-dev`, `toolsmith.md`, `fleet-directives.md` in `active_skills`; re-read on compaction/spawn).\n\n**Load only after SKILL.md confirmed the role is TOOLSMITH.** This is the OC DEV\nTOOLSMITH session's standing role — carved out at v0.4.87 (owner word \"Go\ntoolsmith\" 2026-09-06), promoted from the carrier-tools editor row (topic\n39171, rostered since 2026-09-01). Owns the skill's CLI tooling under\n`tools/` — the commands every other lane runs: `oc-ledger`, `oc-deploy`,\n`oc-prchecks`, `oc-order-validate`, `oc-tg-audit`, the\n`tools/tests` battery. Duty TM1 below owns the what/how.\n\n**STRICT SCOPE:** skill markdown + fleet-directives stay HQ-only\n(single-writer law). The OpenCrabs daemon/carrier source (`~/opencrabs`) is\nEDITOR territory — this lane touches neither.\n\n## Role Boundaries (affirmative scope)\n\n- **Toolsmith Scope:** Toolsmith owns CLI tools under `tools/` and the selftest battery (`tools/tests/run.sh`).\n- **Skill Documentation:** Skill markdown, role files, and `fleet-directives.md` are authored strictly by HQ. Tooling gaps requiring skill documentation are proposed directly to HQ via `oc-ledger stamp proposal` or disk.\n- **Daemon Source & Builds:** Daemon source (`~/opencrabs`), carrier dispatches, and binary swaps belong strictly to Editor lanes. Daemon defects are filed directly as GitHub fork issues.\n- **Rulings & Decisions:** Protocol disputes and binding rulings escalate to HQ (Duty 5).\n- **Priority authority (owner order 2026-09-15):** Toolsmith has complete, independent authority over tooling work order sequencing, bugfix order, and test battery stewardship — never ask the human operator about priorities.\n- **Owner Communication:** HQ owns owner-facing verdict batches; Toolsmith reports status to HQ/Triage or the operator when queried.\n\n## Duty TM1 — Own `tools/` code (author + fixer","s":true},{"d":"Grep 're-derive|by hand|manually|always verify|never forget|must verify|must check|verify that|confirm that|enumerate|count the|keep track|snapshot' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:122:\n  120:    n=1452: a fabricated tail burned two gh dispatches; the first hypothesis\n  121:    after a lookup failure following a from-memory sha is SELF-FABRICATION —\n>    re-derive before blaming GitHub).\n  123: 8. **Solo-surface rule (Duty-4 proposal d5863180, owner \"All 4 go\"\n  124:    2026-09-07, semantic):** a SIDE-EFFECT command whose output is the only\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:374:\n  372: implementation comment).\n  373: \n> **Local fmt drift on files you did NOT touch is EXPECTED — and it is not yours to fix (SKILL.md §Box law; sharpened 2026-09-12, lane `462181e9` re-derived it from scratch because this rule lives in the box-law bullet while the check runs here).** The `/usr/local/bin/rustfmt` wrapper is **NEWER than CI's rustfmt**, so it flags cosmetic diffs on **CI-green committed code**. Rule: **KEEP AS-IS; fix only formatting artifacts you introduced yourself.** Two mechanics that make foreign drift look like your defect — (a) the wrapper **RECURSES through `mod.rs` into child modules**, so `--check src/tests/mod.rs` reports diffs from files your branch never touched; (b) `--skip-children` is **not supported** by this wrapper, and a `mod.rs` copied to /tmp fails to resolve its child modules. Isolation recipe: **check each TOUCHED file as a standalone copy; never `--check mod.rs` itself.** Do not spend three receipts re-deriving this — if fmt reports a file your diff does not contain, the answer is this paragraph.\n  375: \n  376: **Post-fmt scope audit BEFORE staging (Duty-4 P7, v0.4.80):** after any fmt\n\n(2 matches)","s":true}] -->
<!-- reasoning -->
editor.md:376 "Post-fmt scope audit BEFORE staging (Duty-4 P7, v0.4.80): after any fmt..." — let me read that. It might be a manual audit of staged files that a tool should do.

Let me read editor.md 374-400.

Also editor.md:122 "re-derive before blaming GitHub" — that's a heuristic, not a gate.

Let me read editor.md 376-400.

Also I should look at editor-upstream-pr.md.

Let me read editor.md around 376-400 and grep editor-upstream-pr.md.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md","o":"pass, audit the diff before staging — rustfmt can reformat unrelated\npre-existing lines (2026-09-01: flow.rs:418); revert out-of-scope hunks and\nkeep the commit pure (atomicity law).\n\n**fmt-clean ≠ compiles — audit CALL-SITE SHAPE before you chain (v0.4.141).**\nThere is no local compile path on this box: `which cargo` prints a path, but\nrunning it prints `BLOCKED` — *the presence of a path is not evidence of a\ntoolchain*, the same family as \"an empty result from a wrong path is not a\nverdict\". `rustfmt --edition 2024 --check` proves FORMATTING only, so the first\nreal compile is CI — a full gate dispatch. Before `oc-ship-chain`, mechanically\ncross-check every NEW or CHANGED call site against the callee's real definition:\n**free fn vs associated fn** (a free-fn path on an associated fn is `E0425`),\nthe **receiver** (`&self` / `&mut self` / none), and **`Drop`-impl move rules**\n(moving a field out of `&mut self` in `drop` is `E0507` — take it with\n`Option::take()`). Lane `facd50af` (2026-09-11, #111) burned a whole gate budget\non exactly these two classes after a clean fmt pre-pass.\nDONE = Target change implemented, formatted via rustfmt, call-site shapes verified, and signed commit landed on branch with Session-Id trailer.\n\n## Phase 5 — Ship (`oc-ship-chain`)\n\n**`oc-ship-chain` IS the single, exclusive ship path from commit to swapped binary (v0.4.126; manual push-to-main, manual issue-log, and manual oc-deploy sediment retired v0.4.132).**\nThe Editor runs `oc-ship-chain` in one detached invocation under one chain-id:\n\n```bash\n# 1. Push your branch first\ngit -C ~/oc-wt-<task> push -u origin <branch>\n\n# 2. Run the ship chain (runs in background; resumes session on finish)\ntools/oc-ship-chain --sha <commit-sha> --branch <branch> [--issue <issue-n>]\n```","s":true},{"d":"Grep 're-derive|by hand|manually|always verify|never forget|must verify|must check|verify that|confirm that|enumerate|count the|keep track|snapshot|list of' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/editor-upstream-pr.md","o":"No matches found for pattern: 're-derive|by hand|manually|always verify|never forget|must verify|must check|verify that|confirm that|enumerate|count the|keep track|snapshot|list of'","s":true}] -->
<!-- reasoning -->
editor.md Phase 4/5 has "mechanically cross-check every NEW or CHANGED call site against the callee's real definition: free fn vs associated fn, the receiver, and Drop-impl move rules" — a manual cross-check of state (the code) that... hmm, is it state-derivable? The call-site shape correctness is what the compiler derives. And the law says there's no local compile path, so the first real compile is CI. Hmm. So this manual cross-check is assigned because CI is the only compile. Is this a J finding? T1: "does the call site match the callee?" is a pure function of the source tree — the compiler settles it. T2: a tool touches that state — `oc-prchecks` (CI) does, but the point is to avoid burning the gate. Hmm. Actually the law itself says there's no local compile path on the box; so a tool CAN'T derive it locally. Hmm — T2 fails? Actually `cargo` is BLOCKED locally. So the state (does it compile) is NOT derivable on disk locally — it requires CI. So T1/T2 fail: not derivable without CI. So NOT a J finding. Good, exclude.

Hmm, but wait: "mechanically cross-check every NEW or CHANGED call site against the callee's real definition" — could be a tool that parses the source. But the lens requires T2 "a tool already touches that state, or an existing tool is the natural host". A static checker could be the host... but that's speculative. And the decision is genuinely not a pure function of state on disk available to a lane (no compiler). Hmm, actually a source-level parser COULD derive it. But this is marginal and I'd be inventing a tool. I'll skip or mention as LOW? The lens says a finding with no (c) is not a finding. I could name `memory_search scope="external"` (the code symbol graph) — the lens G exploration mandate already mandates symbol-graph exploration. Hmm, that's a tool that touches that state! `memory_search scope="external"` gives callee definitions. Hmm. Interesting. But is "free fn vs associated fn" derivable from the symbol graph? Partially. This is a stretch. I'll leave it out to avoid padding.

Let me now focus and check editor-upstream-pr.md manually (grep found no matches, so its law is phrased differently). Let me read editor-upstream-pr.md key parts. It's 31KB. Let me grep for "verify" and "check" there.

Also let me check SKILL.md for T3 patterns.

Let me grep editor-upstream-pr.md and SKILL.md for verify/check/confirm.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'verify|confirm|check that|ensure|fresh receipt|never memory|from memory|re-read' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/editor-upstream-pr.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor-upstream-pr.md:11:\n  9: Trigger: the feature is COMPLETE — merged into fork `main`, shipped inside a\n  10: green swapped build, smoke test PASS (v0.4.104 four-leg rubric). With tests green\n> and smoke confirmed, Editor prepares the harvested PR branch, posts the smoke\n  12: evidence, and files the upstream PR. Development-time contact stays issues-only;\n  13: this PR is the ONE sanctioned exception (completed features only).\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor-upstream-pr.md:62:\n  60: #     or blocking wait form:\n  61: #       tools/oc-prchecks wait leshchenko1979/<feature>\n> #     (Do NOT pass --fast for final pre-PR verification. Full gate ensures 100% upstream test parity.)\n  63: #   Standing rules PR-GATE-STANDING in the Rules list below (flags verbatim\n  64: #   from pr-checks.yml; ANY red = fix cycle + re-dispatch, never a filed PR;\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor-upstream-pr.md:200:\n  198: | Maintainer rejects/closes the PR | Owning editor | REOPEN the linked issues with a pointer comment; record the outcome |\n  199: \n> Hard rules: verify the failing log names files THIS PR actually touches BEFORE\n  201: pinging anyone (identical clippy walls on every PR can live on the upstream base). Soft-fail fmt diffs are\n  202: cosmetic — NEVER ping for fmt alone. Absorption ends the lifecycle: if the\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor-upstream-pr.md:223:\n  221: 1. **Dedicated Worktree**: Create isolated worktree off `adolfousier/main` tip:\n  222:    `tools/oc-wt add up-<slug> leshchenko1979/fix/<slug> --create --from adolfousier/main`\n> 2. **Cherry-pick & Pre-Sweep**: Cherry-pick source commits preserving trailers (`-x` / `Issue-Ref`), then verify clean lineage with `tools/oc-harvest-sweep leshchenko1979/fix/<slug> --base adolfousier/main`.\n  224:    - **Atomic Subsystem Bundling & Fix Squashing (Owner Order 2026-09-17, v0.4.200)**: A harve","s":true},{"d":"Grep 'verify|confirm|check that|ensure|re-derive|by hand|manually|fresh receipt|never memory|from memory' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:88:\n  86: |---|---|\n  87: | `./tools/oc-order-validate <sha>` | ORDER gates inside `oc-deploy ship` |\n> | `./tools/oc-job-verify <run-id> <source-ref> [--features] [--identity-only]` | standalone run-identity gate (provenance of RED runs) |\n  89: | `./tools/oc-artifact-verify <artifact-path> [--source <sha>] [--run-id <id>] [--markers m1,m2] [--expect-sha <sha256>] [--expect-version <v>] [--repo R] [--json]` | EXECUTION SANITY SIGNAL + FEATURE-PRESENCE CHECK |\n  90: | `./tools/oc-seal-state [--sha S] [...]` | baseline/orders seal (flag-based interface — no positional `<sha>`) |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:89:\n  87: | `./tools/oc-order-validate <sha>` | ORDER gates inside `oc-deploy ship` |\n  88: | `./tools/oc-job-verify <run-id> <source-ref> [--features] [--identity-only]` | standalone run-identity gate (provenance of RED runs) |\n> | `./tools/oc-artifact-verify <artifact-path> [--source <sha>] [--run-id <id>] [--markers m1,m2] [--expect-sha <sha256>] [--expect-version <v>] [--repo R] [--json]` | EXECUTION SANITY SIGNAL + FEATURE-PRESENCE CHECK |\n  90: | `./tools/oc-seal-state [--sha S] [...]` | baseline/orders seal (flag-based interface — no positional `<sha>`) |\n  91: | `./tools/oc-attrib --repo <path> (--range <A..B> or --deployed) [--ledger <f>] [--contributors]` | commit-range → worker-lane attribution; `--contributors` projects the 3-col TSV (SINGLE SHAPE); `--deployed` composes the range from `deployed.sha` + `prev_sha` (fan-out compute backend for [issue #24](https://github.com/leshchenko1979/opencrabs/issues/24)) |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:99:\n  97: | `./tools/oc-ping-proof <uuid> <ping-ts> [--ledger f]` | post-swap notify proof: WOKEN / SILENT / UNREACHABLE verdict |\n  98: | `./tools/oc-pr-atomicity <pr-number>` | atomicity gate (editor Phase 7 / issue triage) |\n> | `./tools/oc-ledger <verb>` | workers-ledger: stamp/sync/check-ver","s":true}] -->
<!-- reasoning -->
Found strong candidates in editor-upstream-pr.md:

- editor-upstream-pr.md:227 "**In-Flight Lane Fence (v0.4.187)**: Check `workers-ledger.json` / `oc-roster` to ensure no active editor lane is currently modifying the subsystem. If an active lane is working on the subsystem, hold harvest dispatch until that lane finishes, hot-swaps, and lands." — T1: active claims are on the ledger (state on disk). T2: `oc-ledger claim-ref --open` / `oc_claims` touches that state. T3: "Check ... to ensure". Strong J candidate. And RC-CONTRACT says `oc-harvest-dispatch vet` already enforces "active claim fencing (`HELD_IN_FLIGHT_LANE`)". So the law asks the lane to hand-check the ledger for active lanes while the tool already returns HELD_IN_FLIGHT_LANE. Strong finding (duplicate of the triage.md step-2 family).

- editor-upstream-pr.md:223 "verify clean lineage with `tools/oc-harvest-sweep ...`" — names a tool. Fine.

- editor-upstream-pr.md:229 "4-Leg Smoke Pass: Verify full 4-leg smoke pass ... is recorded with live receipts in smoke-verdicts.log." — the smoke-verdicts.log is on disk; a tool could derive. Hmm, is there a tool? `oc-smoke-evidence`. Hmm. Marginal.

- editor-upstream-pr.md:252 "(a) `git diff origin/main...HEAD` symbol sweep — grep the branch diff for fork-renamed/fork-only symbols and verify each has a live caller in the UPSTREAM tree" — a manual grep + verify. T1: caller existence is derivable from the source tree. T2: `memory_search scope="external"` symbol graph. T3: "grep ... and verify". Hmm, strong-ish. This is a symbol-graph query — the lens G exploration mandate says use `memory_search scope="external"` for caller-tree. So a manual `git diff` grep to find callers duplicates the symbol graph. Hmm, plausible J finding.

- editor-upstream-pr.md:241 "Editor verifies upstream baseline state (`git diff origin/main...adolfousier/main`)" — a manual command; names a command. Hmm, it IS the tool (git). Marginal.

- editor-upstream-pr.md:266 "UPSTREAM BASELINE & NARRATIVE VERIFICATION: When staging ... verify against live adolfousier/main whether upstream has already resolved the underlying issue" — T1: derivable (diff). T2: `oc-harvest-sweep`/`oc-upstream-delta`. T3: "verify". Hmm.

Now the "one site, one lens" rule: object is law text whose decision is state-derivable → J. So these are J.

But I must avoid padding. Let me pick the strongest 4-6 findings, each with a verbatim quote, the state, the tool + interface, and cost (or `unpriced`).

Let me also verify the triage.md "In-Flight Lane Fence"-like and harvest-dispatch vet overlap. Actually the cleanest, most defensible findings:

**Finding 1 (HIGH): triage.md §PHOP step 2 — manual parent/blocker verification duplicates `oc-harvest-dispatch vet`.**
Quote: "verify parent feature is already merged upstream" / "reject dispatch as `HELD_BLOCKED_BY_DEPENDENCY` until blockers land upstream."
State: whether the parent/blocker is merged upstream (GitHub API / git).
Tool: `oc-harvest-dispatch vet <issue-or-commits>` — RC-CONTRACT: "native sub-issue parent verification (`HELD_PARENT_UNHARVESTED`), and dependency resolution (`HELD_BLOCKED_BY_DEPENDENCY`)".
Cost: #188 parent refusal, #302 churn (n=8267).

Hmm wait, but is this a duplicate or a description? The heading "Native Sub-Issues & Blockers Check" with imperatives "verify parent feature is already merged upstream". It's an instruction to Triage to do this. But the tool does it. So the law assigns to the agent a decision the tool derives → J. Good. But one could argue the law is describing the tool's criteria. Hmm. The phrasing "If candidate is a sub-issue ... verify parent feature is already merged upstream" reads as an instruction. I'll report it but frame carefully.

Actually, hmm. Let me reconsider. RC-CONTRACT for oc-harvest-dispatch says vet enforces parent verification and dependency resolution. So triage.md step 2's manual checks are redundant with step 1's tool run. The defect: law asks the agent to hand-derive a verdict the tool already returns. That's the J class exactly ("re-check that state by hand"). Solid.

**Finding 2 (HIGH): editor-upstream-pr.md:227 In-Flight Lane Fence — "Check workers-ledger.json / oc-roster to ensure no active editor lane is currently modifying the subsystem."**
State: active claims on the ledger.
Tool: `oc-ledger claim-ref <uuid> --open` or `oc-harvest-dispatch vet` (HELD_IN_FLIGHT_LANE).
Strong.

Hmm, but these two are the same family (harvest pre-flight manual checks vs the vet tool). Maybe combine? No — different files/sites. Report both, or report the stronger. The lens says one site one lens, but they're two sites. I could report both as separate findings. But to avoid padding, maybe report the editor-upstream-pr one and the triage one... Both are legit. Hmm. Actually the triage.md step-2 one is broader (parent+blockers+baseline). Let me report triage.md step 2 as one finding covering the manual checks, and editor-upstream-pr.md:227 as another.

Hmm, but actually — is the "In-Flight Lane Fence" check state-derivable in a way a tool settles? Yes: `oc-harvest-dispatch vet` returns HELD_IN_FLIGHT_LANE. So the law says "Check workers-ledger.json / oc-roster to ensure no active editor lane is currently modifying the subsystem" — a hand check. J finding.

**Finding 3 (HIGH): triage.md:291 injection verification — "verify injection from the daemon log ... Grep the log for the target session id after the send".**
State: daemon log injection line.
Tool: `oc-log-search <pattern>` (or a notify-proof verb). Actually `oc-ping-proof` is ledger-based. The daemon log grep → `oc-log-search`. Hmm, `oc-log-search` is "telemetry-only daemon-log search; HARD FENCE: brain::provider lines never match". So it's a log search tool — natural host. Good.

**Finding 4 (MED): triage.md:292 liveness check — "verify the target is live — session_search with updated_since (or a same-turn log grep for the session id)".**
State: session liveness / last activity.
Tool: `oc-ping-proof <uuid> <ping-ts>` (0 WOKEN / 1 SILENT / 3 UNREACHABLE).
Strong.

Hmm, 3 and 4 are both in triage.md Duty T3 (creating new editors). Maybe combine into one finding about the notify-verification family? They're two sentences. I'll report as one finding with two quotes, or two findings. Let me report them as two, or one combined. Given the 6000-char limit, I'll combine 3+4 into one finding (same family, same file, adjacent lines) — no, the format wants one verbatim quote per finding. I can quote both. Let me do one finding for the liveness check (oc-ping-proof is a precise host) and mention the injection grep within it.

Hmm, actually let me keep them separate but concise, OR combine. Let me combine into one "notify delivery verification" finding with the liveness quote (stronger tool match) and reference the injection grep.

**Finding 5 (MED): hq.md:276 Checkout-ref verification — "verify checkout-ref matches the expected head SHA before treating a verdict as final evidence."**
State: the run's checkout ref vs head sha.
Tool: `oc-job-verify <run-id> <source-ref>` (rc 4 REF-MISMATCH) or `oc-prchecks`.
Strong.

**Finding 6 (MED): fleet-directives §Upstream PR filing — base CI gate pre-claim — "poll base-main CI gate state and pre-claim any OWNERLESS red files".**
State: base-main CI failures ∩ PR files = IN-SCOPE/BASE-FAULT.
Tool: `oc-pr-fault-scope <pr#> --run <id>` (0 IN-SCOPE / 1 BASE-FAULT).
Strong.

Hmm, wait: the law says "poll base-main CI gate state and pre-claim any OWNERLESS red files by carrying a sweep commit in the PR itself". The classification of "ownerless red files" is exactly `oc-pr-fault-scope`'s IN-SCOPE/BASE-FAULT. And `oc-harvest-sweep` is the "pre-gate harvest verification (editor Phase 7 sweep, mechanical legs)". So a tool exists. Good.

Now, is that enough? That's 6 findings. Given 6000-char limit, that might be too many. Let me prioritize the strongest 4-5.

Also, I should double check the "gate's input became unreachable after the move" angle. Let me quickly check whether any law references a section that moved. The fleet-directives.md:48 "§Remotes & sync guard (2)" is now dangling (moved to upstream-merge-runbook.md). Let me verify §Remotes & sync is in upstream-merge-runbook.md. The routing table says sync model & rebase → upstream-merge-runbook.md. And SKILL.md:462 and hq.md:263 point there. So fleet-directives.md:48's bare "§Remotes & sync guard (2)" is a stale internal reference. Hmm — is it a "gate's input"? The Owner Push Freeze is a gate (owner hold), and rule 4 distinguishes it from "the carrier FREEZE of §Remotes & sync guard (2)". The reader is told to distinguish from a section that isn't in the file. But the routing table points them. Marginal. I could report as LOW. But is it J's class? It's a ref-consistency issue (A's). Hmm. The brief told me to check it, so I'll mention it briefly as LOW if I have room. Actually — hmm, "one site, one lens: object is law text whose decision is state-derivable → J". A dangling ref isn't a state-derivable decision. So it's A's finding, not mine. But my brief explicitly asked. I'll note it in Coverage or as a LOW finding clearly attributed as an observation. Hmm. The rules say "Report only defects you can evidence" and "Do not pad." I think I can include it as a LOW with a note, since my brief asked me to check reachability. Actually, I'll include it because the brief explicitly asked "whether any gate's input became unreachable after the move" — and this is the one instance I found. But it's not really a gate input. Hmm.

Let me look more carefully for a real "gate input became unreachable" case. The moved sections include "CI-wait & CI-watcher discipline" → editor.md; "swap-sha coverage" → editor.md; "carrier hotfix gates" → editor.md; "inherited-claim pillars" → editor.md; "deep-core heads-up gate" → editor-upstream-pr.md; "PHOP" → upstream-merge-runbook.md; "harvest cadence / HARVEST LAW / NO-HOLD" → upstream-merge-runbook.md; "tool-problem reports, tool logging rule" → toolsmith.md; "cadence boundary, rule-text provenance, refuse-and-reroute" → hq.md; "intake & assignment, dispatch hygiene, topic domain alignment, parked issues, Decision Rollcall, creating new editors" → triage.md.

Now, is there a law elsewhere that references, say, "fleet-directives.md §Tool logging rule" or "§Creating new editors" or "§CI-wait discipline"? The lens-B report claims references like `§Creating new editors` (triage T3: "Procedure = fleet-directives.md §Creating new editors, unchanged"), `§Tool logging rule` (s2-swap-journal-spec.md header cites it), `§CI-wait discipline` (editor.md: "live canonically in: fleet-directives.md §CI-wait discipline"). If those references still say "fleet-directives.md", they're now stale (moved).

But lens-B's report is from the 20260918 cycle — possibly BEFORE the split. Let me grep the CURRENT law files for these references:
- "§Creating new editors" 
- "§Tool logging rule"
- "§CI-wait"
- "§Deep Core Advance"
- "§PHOP" / "HARVEST LAW"
- "§cadence boundary"
- "§rule-text provenance"

Let me grep for these in the current law files (exclude reviews/CHANGELOG).

Let me run a grep for "fleet-directives.md §" again but this time I already have the list from the first grep (it was truncated at 80 matches, including reviews). Let me re-grep with file_pattern to target law files only... grep tool takes a single path. Let me grep the whole dir but with a narrower pattern and see law-file hits.

Pattern: "fleet-directives.md §(Creating|Tool|CI-wait|Deep Core|PHOP|HARVEST|cadence|rule-text|Swap|Seam|Merge-resolution|Remotes)"

Let me run it.

Also "fleet-directives §" (without .md).

Let me do it.
<!-- /reasoning -->

Let me check for stale pointers to sections that moved in the split.


<!-- tools-v2: [{"d":"Grep 'fleet-directives(\\.md)? §(Creating|Tool-problem|Tool logging|CI-wait|CI-watcher|Deep Core|PHOP|HARVEST|NO-HOLD|cadence|rule-text|Swap-sha|Swap-head|Seam|Merge-resolution|Remotes|no auto-rollback|Carrier hotfix|inherited-claim|parked issues|Topic domain|Dispatch hygiene|intake)' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:25:\n> - **Deep Core Advance Heads-Up Gate — stale path list + the missing executor (HQ ruling 2026-09-18; `fleet-directives.md §Deep Core Advance Heads-Up Gate`, `editor-upstream-pr.md` Phase 7)**: two defects in one gate.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:389:\n>   - **New Features (`feat/*`):** Codified mandatory **≥24-hour post-swap soak period** in the live running deployment in `fleet-directives.md §HARVEST LAW` and `editor-upstream-pr.md §Step 4` before upstream PR harvest eligibility. Ensures multi-session resilience, edge-case exposure, and regression soak time on the live binary.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:400:\n>   - Codified persistent **Topic Domain Alignment** in `fleet-directives.md §Topic domain alignment & rename authority`.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:1539:\n> - **AUTO-SHIP law (owner order 2026-09-09 \"the owner should not approve shipping, it should be automatic\"):** PR filing + fork ship chains are AUTOMATIC on smoke PASS (v0.4.104 four-leg rubric). The owner-go-before-filing gate (\"my go before pr\", 2026-09-08 21:44Z) is RETIRED for both fork ships and upstream PR filings; owner is notified after the act. Surviving gates: mechanical CI legs, smoke rubric, rollback-is-owner's-call. (fleet-directives.md §NO-HOLD.)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260911-cycle/reports/skill-review-brain-scrub-20260911.md:148:\n> | fleet-directives §Creating new editors item 3 | ✓ editor item 3, line 181+ |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260911-cycle/reports/skill-review-brain-scrub-20260911.md:151:\n> | fleet-directives §Tool-problem reports | ✓ line 197 |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260918-cycle/reports/lens-B-redundancy-20260918.md:100:\n> Verified via explicit `Canon:`/canonical markers in the siblings: `§Remo","s":true},{"d":"Grep '^#{1,3} ' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:1:\n> # Upstream sync runbook — fork main ← adolfousier/main\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:18:\n> ## Gates (fail closed)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:28:\n> ## Roles\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:39:\n> ## Process\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:189:\n> ## Risk register\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:204:\n> ## Historical — the MERGE model (RETIRED 2026-09-11)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:221:\n> ## Port — REBASE-PORT model (RETIRED for fork main 2026-09-02; PR-branch chains only)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:254:\n> ## Remotes & sync\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:258:\n> ## Seam-resolution shape (REBASE model — replaces the retired merge-resolution shape)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:262:\n> ## Upstream-merge cadence · HARVEST LAW · NO-HOLD\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:312:\n> ## Parallel Harvest Orchestration Protocol (PHOP) (v0.4.136, 2026-09-10)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:316:\n> ### 1. The 4-Stage Harvest Lifecycle\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:325:\n> ### 2. Standard Dispatch Wire Envelope\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:343:\n> ### 3. Orchestration Sequence\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/upstream-merge-runbook.md:384:\n> ## Swap-head signature for rebase/synthesis/merge-derived binaries (owner 2026-09-03 \"Land 1+2 only, keep version as-is\")\n\n(15 matches)","s":true}] -->
<!-- reasoning -->
Good — upstream-merge-runbook.md now hosts §Remotes & sync, §Seam-resolution shape, §Upstream-merge cadence · HARVEST LAW · NO-HOLD, §PHOP, §Swap-head signature. So the split moved those. 

The current law-file references to fleet-directives.md §... are all to sections that EXIST in fleet-directives.md (from my earlier grep: editor-upstream-pr.md:232, editor.md:5,82,409,446,533, toolsmith.md:3,99, SKILL.md:191,194,286,488, hq.md:3). And hq.md:263 points to upstream-merge-runbook.md. So the split's cross-refs were mostly updated.

The only dangling internal ref I found: fleet-directives.md:48 "§Remotes & sync guard (2)". That's a bare § within the same file. Since §Remotes & sync moved to upstream-merge-runbook.md, this pointer is stale.

Hmm, is that a "gate input unreachable"? The Owner Push Freeze rule 4 says "This is NOT the carrier FREEZE of §Remotes & sync guard (2)." A reader following that reference inside fleet-directives.md finds nothing. So yes, a moved-section reference became unreachable. It's arguably lens A (ref consistency) but my brief asked me to check it. I'll report as LOW/MED, framed as a split-reachability defect.

Hmm — but the lens says "one site, one lens: object is law text whose decision is state-derivable → J". A dangling ref is not J's class. But my brief explicitly instructs me to check the split reachability. I'll include it as a LOW finding, noting it's a split-reachability observation.

Hmm, wait. Let me reconsider. Actually maybe I'm overcomplicating. Let me re-read my brief: "The split itself moved law text between files; check whether any law now assigns a state-derivable decision to agent memory, and whether any gate's input became unreachable after the move."

So the two things to check: (1) did the split cause a law to assign a state-derivable decision to memory? (2) did a gate's input become unreachable?

For (2), "gate's input became unreachable" — e.g., if a gate reads a list/definition that moved to a file the gate's role doesn't load. Hmm. Let me think: e.g., §Docs-Only LEG1 Gate Skip's exclusion set — the gate (oc-ship-chain LEG1) derives it from the tree; the law text moved? No, it stayed in fleet-directives.md. 

Hmm, what about the §Owner Push Freeze — it's [LANE], read by all. Its rule 4 references §Remotes & sync guard (2), now in upstream-merge-runbook.md which is a separate file. A lane reading only fleet-directives.md can't find it. That IS an unreachable gate input of a sort. I'll report it.

Actually, let me also check: does the fleet-directives.md thematic index / routing table cover "§Remotes & sync"? Yes: "sync model & rebase, seam resolution, ... → upstream-merge-runbook.md". So a diligent reader resolves it. So the dangling ref is mitigated by the routing table. Hmm. That weakens it to LOW. Still, the inline pointer "§Remotes & sync guard (2)" is a same-file-style ref that no longer resolves in-file. I'll report LOW.

Now let me also double check a couple more potential J findings I should verify:

- SKILL.md §Hard rules / §Canonical tooling might have a state-derivable decision. Let me look at SKILL.md around 76-140 (the tool table) — the oc-harvest-census row says "Use `check`/`scan`, which derive IN_FLIGHT from the live scan" — good, tool does it.

- triage.md:74 "run ./tools/oc-upstream-delta and post the tiered backlog census (Tier-1/2/3 candidates + counter line: fork-only commit count + open upstream PR count)" — the counts are derivable; oc-upstream-delta outputs them. Names the tool. Fine.

- triage.md:84-86 upstream PR-state patrol — "re-verify the state of every OPEN upstream PR of ours (`gh pr view <n> -R adolfousier/opencrabs --json state,mergeable` — fresh receipt, never memory)". Hmm, this is a manual loop over "every OPEN upstream PR of ours" — the SET is derivable (`gh pr list`), and the per-PR state is derivable. T2: is there a tool? `oc-upstream-delta` gives ahead/behind/absorbed; not PR states. Hmm, no obvious tool. So T2 fails → not a J finding (can't name tool half). Skip.

Hmm, actually the lens says a finding must name the tool that SHOULD own it. It doesn't have to already exist ("the rule is a TOOL SPEC THAT HAS NOT BEEN WRITTEN YET and the finding names the tool half"). T2 says "a tool already touches that state, OR an existing tool is the natural host". For the PR-state patrol, `gh` is the tool (it's already a command). Hmm — the law already names `gh pr view`. So it's already a command per PR. The defect would be the manual enumeration + loop. Marginal. Skip to avoid padding.

OK. Let me also verify the editor-upstream-pr.md:252 symbol-sweep finding's tool host. "grep the branch diff for fork-renamed/fork-only symbols and verify each has a live caller in the UPSTREAM tree". T1: caller existence in the upstream tree is derivable from source. T2: `memory_search scope="external"` code-symbol graph (the lens G mandate). T3: "grep ... and verify". Hmm. This is a plausible J finding: the law tells the editor to hand-grep for callers instead of querying the symbol graph. Actually the review-lenses.md lens G "EXPLORATION & DRY VERIFICATION GATE" mandates `memory_search scope="external"` for caller-tree analysis. So there IS a tool (the code graph). So a manual grep+verify of callers is the defect. Strong-ish. But the phrase is inside a conflict-class item (a). Hmm. I could include it as MED.

Hmm, I have many candidates. Let me now decide the final set (aim ~5, HIGH/MED), keeping within 6000 chars.

Final candidates ranked:
1. HIGH — triage.md §PHOP step 2: manual parent-merged / blocker / upstream-baseline verification; `oc-harvest-dispatch vet` already returns HELD_PARENT_UNHARVESTED / HELD_BLOCKED_BY_DEPENDENCY. (triage.md:45-48)
2. HIGH — editor-upstream-pr.md:227 In-Flight Lane Fence: "Check workers-ledger.json / oc-roster to ensure no active editor lane is currently modifying the subsystem"; `oc-harvest-dispatch vet` returns HELD_IN_FLIGHT_LANE; `oc-ledger claim-ref --open` is the tool. 
3. HIGH — triage.md:291-292 notify delivery/liveness verification by hand (daemon-log grep; session_search) — `oc-ping-proof <uuid> <ping-ts>` (WOKEN/SILENT/UNREACHABLE) and `oc-log-search`. 
4. MED — hq.md:276 Checkout-ref verification — `oc-job-verify <run-id> <source-ref>` (rc 4 REF-MISMATCH).
5. MED — fleet-directives §Upstream PR filing — base CI gate pre-claim: "poll base-main CI gate state and pre-claim any OWNERLESS red files" — `oc-pr-fault-scope <pr#> --run <id>` (IN-SCOPE/BASE-FAULT).
6. MED — editor-upstream-pr.md:252 caller verification via grep — `memory_search scope="external"` symbol graph.
7. LOW — fleet-directives.md:48 dangling §Remotes & sync guard (2) (split reachability).

That's 7. Too many for 6000 chars with verbatim quotes + state + tool + cost. Let me trim to ~5 strongest. I'll drop #6 (weakest tool-match / arguable) or keep as LOW. Hmm. Let me keep 1,2,3,4,5 and maybe 7 (short). Drop 6.

Actually, let me reconsider #4 and #5 — both are single law sentences with a clear tool. Good. Keep.

Hmm, let me reconsider #1 and #2 — they might be seen as the same family (harvest pre-flight manual checks vs the vet tool). But they're different sites/files. I'll keep both but could merge. Actually, merging would be cleaner and save space: "Manual harvest pre-flight checks duplicated across two files". But the format wants one locator + quote per finding. I'll keep them separate but concise.

Hmm, I worry about the report length. 6000 chars is generous. Let me draft.

Let me get exact line numbers for the quotes:
- triage.md: the PHOP step 2 lines are 45-48. Quote: "verify parent feature is already merged upstream. If parent is unmerged, reject candidate harvest as blocked sub-issue" and "reject dispatch as `HELD_BLOCKED_BY_DEPENDENCY` until blockers land upstream." and "Verify target code path on live `adolfousier/main`". Locator: triage.md:46-48 (SS §Duty T4 — PHOP).
- editor-upstream-pr.md:227: quote "**In-Flight Lane Fence (v0.4.187)**: Check `workers-ledger.json` / `oc-roster` to ensure no active editor lane is currently modifying the subsystem."
- triage.md:291: quote "Before stamping any ack ("brief delivered", "lane briefed"), verify injection from the daemon log ... Grep the log for the target session id after the send; stamp ack only on a real injection". And triage.md:292: "before `session_notify` to any session not heard from this turn, verify the target is live — `session_search` with `updated_since`".
- hq.md:276: "Checkout-ref verification: Checkout log lines identify the tested tree; verify checkout-ref matches the expected head SHA before treating a verdict as final evidence."
- fleet-directives.md:442-443: "Before filing an upstream PR, poll base-main CI gate state and pre-claim any OWNERLESS red files by carrying a sweep commit in the PR itself".
- fleet-directives.md:48: "This is NOT the carrier FREEZE of §Remotes & sync guard (2)."

Now let me double check the RC-CONTRACT host for `oc-harvest-dispatch vet`: "native sub-issue parent verification (`HELD_PARENT_UNHARVESTED`), and dependency resolution (`HELD_BLOCKED_BY_DEPENDENCY`, Issue #255)" and "active claim fencing (`HELD_IN_FLIGHT_LANE`)". Yes. 

And `oc-pr-fault-scope <pr#> --run <id>` | failing-files ∩ PR-files = IN-SCOPE/BASE-FAULT (SKILL.md:123). Good — that's the natural host for "ownerless red files".

And `oc-job-verify <run-id> <source-ref> [--features] [--identity-only]` (SKILL.md:88) = "standalone run-identity gate". RC-CONTRACT: "0 VERIFIED / 2 IN-FLIGHT / 3 FAILED / 4 REF-MISMATCH / 5 NOT-FOUND · embed-sha compares exact OR first-12-hex prefix". So REF-MISMATCH is the host for checkout-ref verification. Good.

And `oc-ping-proof <uuid> <ping-ts> [--ledger f]` = "post-swap notify proof: WOKEN / SILENT / UNREACHABLE verdict" (SKILL.md:97). Host for the liveness check. Good.

And `oc-log-search <pattern> [--log <f>] [--since <ts>] [--module <re>] [--tail N]` = "telemetry-only daemon-log search" (SKILL.md:126). Host for the injection grep. Good.

Now cost: I should give (d) the cost already paid or `unpriced`. I have some from the law text:
- triage.md:46: "(Issue #188 unharvested parent refusal)" — cost.
- triage.md:291: "Origin: auditor lane a65e7ab6 — Triage stamped 're-brief delivered' (n=1803) while both sends sat parked" — cost.
- triage.md:292: "e.g. c10cd97b last seen 09-05 10:56Z, notified 09-06 23:00Z → no_route" — cost.
- editor-upstream-pr.md:227: unpriced (or the general harvest churn).
- hq.md:276: unpriced.
- fleet-directives.md:442: "the 2026-09-05 #1394/#1393/#1395 out-of-order merge (fork #103 incident)" — cost.

Good.

Now, one concern: the lens says a finding must name (c) the tool half; else HQ rejects. I'll name the tool + single-command interface for each.

Also — I must include the T1/T2/T3 test in every report? "THE TEST — quote it in every report". Hmm, the brief for J says "quote it in every report". So my report should quote the T1/T2/T3 test. I'll include it briefly in the Verdict or Coverage. The required report shape is fixed though: "# Lens J - cycle 20260919-cycle / ## Verdict: <one line> / ## Findings / ## Coverage". I can fold the T-test quote into the Verdict line or a lead-in. I'll add a short line under Findings intro quoting T1/T2/T3.

Hmm, the shape says "exactly this shape". I'll keep to the shape but can include the T-test quote within the Findings section as a lead sentence. Let me include it compactly.

Now let me make sure I'm not missing a HIGH that's more central. The brief says "the defect class you exist to kill" = law assigning state-derivable decisions to agent memory. Let me do one more sweep: search for "must" + "check"/"verify"/"ensure" in hq.md and triage.md and SKILL.md, and any "count"/"list".

Actually, I have enough. But let me quickly check hq.md Duty 6 for the reviewer spawn set / lens list — could be a state-derivable set held in memory (the lens count). E.g., hq.md: "spawn set" enumerates lenses A–J. If the law enumerates the 11 lenses and says "re-derive from ls", that's the exemplar shape. Let me check hq.md Duty 6 spawn set.

review-lenses.md says lens G: "the role files (re-derived from `ls *.md` at spawn time; count not hardcoded)". And hq.md:237 "objects change every batch and are re-derived from the skill root at spawn time". So they already derive. Good.

Let me check hq.md Duty 6 spawn set for a hardcoded lens list.

Let me grep hq.md for "lens" / "A–J" / "spawn".

Actually, let me look at hq.md Duty 6 region (lines ~200-260).

Let me read hq.md 195-260.

Hmm, I've already seen 200-245 partially. Let me read 180-240.

Let me do that to be thorough, then write the report.
<!-- /reasoning -->

Let me check hq.md Duty 6 (the reviewer spawn set) for a hardcoded state-derivable set.


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md","o":"   Schema:\n   `{ \"cycle_id\": \"<id>\", \"cadence\": \"<cadence-string>\", \"started_at\": \"<ts>\", \"status\": \"IN_PROGRESS|COMPLETED\", \"proposals\": [...], \"lenses\": { \"<lens>\": { \"status\": \"PENDING|COMPLETED\", \"report_path\": \"...\", \"verdict\": \"...\" } }, \"codification_plan\": [...], \"updated_at\": \"<ts>\" }`\n   Before spawning reviewers or codifying findings, HQ initializes `state.json`.\n   **Step-0 Recovery Mandate:** After ANY context compaction or session restart during Duty 4+6, HQ must first check for an existing `reviews/<cycle-id>/state.json` before re-querying proposals, re-spawning reviewers, or re-drafting plans. Reading `state.json` restores the exact cycle state, preventing redundant tool calls or loss of completed work across compactions.\n1. Reviewers are READ-ONLY SUB-AGENTS (spawn read_only=true, allow_nested=false),\n   one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub); they NEVER edit skill files. Duty-6 reviews\n   are ALWAYS sub-agent work, never HQ-only inline reading. Same-day\n   second passes of one lens suffix the report name (`-run2`) and split scopes\n   (`B2`/`A2`) — the lens catalog (review-lenses.md) is unchanged by that;\n   family map letters stay A–J. Findings\n   must carry verbatim quotes; HQ verifies every accepted quote against\n   disk before acting. Hollow report → ONE retry with the prompt narrowed to\n   that single lens; a second hollow result unlocks inline fallback, which\n   must be flagged as such in the review record.\n2. Split lenses for independence by family (DOCS=A,B,G · TOOLS=C,E,F ·\n   MECHANICAL=J · ARTIFACTS=D+H · META=I) — letters keep chronological birth order (stable\n   report/persist keys, not an ordering). FULL LENS CATALOG: `review-lenses.md`\n   (same dir as this file) — read it before spawning reviewers; each brief\n   names the lens scope, exclusions, and evidence format.\n\n3. PERSISTENCE (persist-first write-through, owner law 2026-09-08, v0.4.116):\n   the SPAWN PROMPT instructs each reviewer to write its FULL report to\n ","s":true}] -->
<!-- reasoning -->
hq.md Duty 6 item 2: "Split lenses for independence by family (DOCS=A,B,G · TOOLS=C,E,F · MECHANICAL=J · ARTIFACTS=D+H · META=I)". 

Hmm — is this a hardcoded family map that could drift? It says "letters keep chronological birth order". And item 1 says "one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub)". These enumerate the lens set in law. But item 7 says "objects change every batch and are re-derived from the skill root at spawn time" — objects, not lenses. The LENS SET is enumerated in hq.md. Is the lens set state-derivable? The lens catalog is in review-lenses.md; `oc-review-persist` LENSES whitelist carries the set. Hmm — so the law (hq.md) enumerates the lenses (A–J + brain-scrub) AND the family grouping, while the machine-readable set lives in review-lenses.md and oc-review-persist's LENSES. Is this a J finding? The decision "which lenses to spawn" is derivable from review-lenses.md / the tool's LENSES whitelist. The law asks HQ to spawn "one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub)". Hmm — this is a set the law holds in text. If a lens is added/removed, the law text must be updated by hand. Hmm. But the lens brief catalog is in review-lenses.md and the tool's LENSES whitelist. Is there drift risk? The review-lenses.md header says "the eleven Duty-6 review lenses (A–J + standing brain-scrub)". And hq.md item 2's family map: DOCS=A,B,G · TOOLS=C,E,F · MECHANICAL=J · ARTIFACTS=D+H · META=I. Hmm — but review-lenses.md's family structure says: FAMILY DOCS (A, B, G), FAMILY MECHANICAL (J), FAMILY TOOLS (C, E, F...), FAMILY ARTIFACTS (D, H), FAMILY META (I). So they agree. 

Is this a J finding? The lens roster is a set that a tool (oc-review-persist LENSES) already carries. The law asks HQ to spawn one per lens, enumerated by hand. Hmm. But this is arguably a stable structural enumeration (like "four role files") — the lens set is stable ("Lenses are quality dimensions (stable, few)"). And review-lenses.md is the catalog. Hmm. This is borderline. The J brief says "including one-shot checks and any set or list a lane is told to hold in context." The lens list IS a set HQ holds. But is it "a pure function of state on disk"? The canonical lens set is in review-lenses.md (a file) — so yes, derivable. And `oc-review-persist`'s LENSES whitelist is the machine-readable set. So a tool already carries it. Hmm. So T1/T2/T3 could all pass: the law enumerates the lens set in hq.md text (memory) while the tool whitelist carries it → drift risk. 

Hmm, but wait — the law says "the lens catalog (review-lenses.md) is unchanged by that" and "FULL LENS CATALOG: review-lenses.md — read it before spawning reviewers". So hq.md POINTS to review-lenses.md as the catalog. So the set is not held in memory; it's read from the file. So not a finding. Good — exclude.

Hmm, but hq.md item 2 does hardcode the family map "(DOCS=A,B,G · TOOLS=C,E,F · MECHANICAL=J · ARTIFACTS=D+H · META=I)" — that's a state-derivable grouping (derivable from review-lenses.md's FAMILY headings). And it's the kind of enumeration that can drift. Hmm. But it also says "FULL LENS CATALOG: review-lenses.md — read it before spawning". So the law gives a pointer. Marginal. I'll skip (avoid padding) — or mention as LOW. Hmm.

Actually, hold on, there's a subtle issue: hq.md item 2 family map lists "DOCS=A,B,G · TOOLS=C,E,F" — but the review-lenses.md FAMILY TOOLS includes C, E, F. And FAMILY DOCS = A, B, G. OK consistent. But the earlier review-lenses.md text (v0.4.114) said "regrouped v0.4.81 with C joining TOOLS and D sole in ARTIFACTS — H later joined D". OK.

I'll skip this — it's a pointer-backed enumeration.

Now let me also check: is there any law that says a lane must count/derive the number of lens reports (the "DONE = all 11 lens reports persisted" formula at hq.md:241)? That's a count. "DONE = all 11 lens reports persisted via oc-review-persist + ...". Hmm — "all 11 lens reports" is a hardcoded count. The lens count is derivable from review-lenses.md / oc-review-persist LENSES. Is this a J finding? The completion formula asks HQ to check "all 11 lens reports persisted". A tool `oc-review-persist check-cycle` exists! RC-CONTRACT: "check-cycle: 0 census complete / 2 usage / 3 catalog UNDERIVABLE (refuses to call a cycle clean off an unreadable catalog) / 5 lens(es) missing -- unreceipted". So the tool `oc-review-persist check-cycle` DERIVES the census (which lenses are missing). But the law (hq.md:241) states a hardcoded "all 11 lens reports" formula that HQ must verify by hand. Hmm — but does the law say to verify by hand? It says "DONE = all 11 lens reports persisted via oc-review-persist + receipts logged in skill-review-index.log + ...". This is a completion formula enumerating conditions. The "all 11" count is state-derivable and the tool `check-cycle` derives it. Hmm. Is this J? The law assigns the "are all lenses persisted?" decision to HQ's manual check, while `oc-review-persist check-cycle` derives it. T1 ✓ (report files on disk), T2 ✓ (`oc-review-persist check-cycle`), T3 — hmm, the formula doesn't explicitly say "verify by hand"; it's a DONE definition. Hmm. Marginal. But the hardcoded count "11" is exactly the "count not hardcoded" concern that lens G raised for role files. Hmm.

Actually, this is a decent candidate: hq.md:241 hardcodes "all 11 lens reports" while the lens set is state-derivable and `oc-review-persist check-cycle` computes the census. If a lens is added (e.g., J was added v0.4.161), this count must be updated by hand — and indeed the CHANGELOG v0.4.161 said "Census updated: SKILL.md (Reviewers A–J + brain-scrub = ELEVEN), hq.md Duty 6 families + spawn set, README.md" — i.e., adding J required hand-editing the count in multiple places! That's evidence the count is hand-maintained (the "census" churn). Hmm! That's a good finding: the law carries the lens count "ELEVEN"/"11" in multiple files, hand-maintained, while `oc-review-persist check-cycle` derives the census from disk. 

Let me verify: hq.md:241 "DONE = all 11 lens reports persisted". And review-lenses.md header "the eleven Duty-6 review lenses (A–J + standing brain-scrub)". And SKILL.md probably "ELEVEN". Let me grep for "eleven" / "11 lens" / "ELEVEN".

Let me grep for "eleven|11 lens|A–J|A-J" in law files.

This could be a strong J finding: a count (11) held in law text that is a pure function of the lens catalog on disk, with a tool (`oc-review-persist check-cycle`) that already derives the census. And the CHANGELOG documents that adding J required hand-updating the count in 3 files (census churn). Cost: the census churn itself.

Hmm, but is the count "state-derivable"? The lens set is defined in review-lenses.md (a file) — so yes. And the persisted reports are on disk. So "all 11 lens reports persisted" = a pure function of disk state. T1 ✓, T2 ✓ (check-cycle), T3 ✓ (HQ holds the count). 

Hmm, this is arguably a solid J finding. But — careful — the lens says "Failing T3 = already mechanical, the prose is descriptive, NO ACTION." The DONE formula is prescriptive ("DONE = all 11 ..."). Hmm. And "a rule phrased as an instruction to a reader... is the defect class". The DONE formula is a definition HQ uses to judge completion — it's an instruction to HQ to check 11 reports. Hmm.

Hmm, I think this is defensible but somewhat weak because the tool `check-cycle` exists and the law might already rely on it. Let me check whether hq.md mentions `check-cycle`. Let me grep hq.md for check-cycle.

Let me run a couple greps: "eleven|ELEVEN|11 lens" and "check-cycle" across law files.

Let me do that.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'eleven|ELEVEN|11 lens|check-cycle|A–J|A-J' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:345:\n  343: - **Roster** — the worker registry in `workers-ledger.json` (enroll / claim /\n  344:   ack rows); `oc-attrib` joins Session-Id trailers against it.\n> - **Lens (Reviewer A–J)** — one Duty-6 read-only review perspective\n  346:   (hq.md §Duty 6; full briefs: `review-lenses.md`).\n  347: - **HQ** — the skill-owning lane. The former name *Supervisor* is RETIRED\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:190:\n  188:    second passes of one lens suffix the report name (`-run2`) and split scopes\n  189:    (`B2`/`A2`) — the lens catalog (review-lenses.md) is unchanged by that;\n>    family map letters stay A–J. Findings\n  191:    must carry verbatim quotes; HQ verifies every accepted quote against\n  192:    disk before acting. Hollow report → ONE retry with the prompt narrowed to\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:241:\n  239:    `tools/oc-ledger stamp note \"v<version> ACCEPTED — Duty 6 Cycle <cycle-id> closed\" --by \"hq <uuid>\"`\n  240:    This stamps the mechanical boundary recognized by `oc-ledger cadence` (`^v[0-9]+\\.[0-9]+\\.[0-9]+ ACCEPTED`), resetting the review cadence counter from `FIRE` back to `0/5 WAIT`. Without this stamp, `oc-ledger cadence` will fail to reset and will continuously report overdue review cycles.\n> - **Checkable Completion Formula**: `DONE = all 11 lens reports persisted via oc-review-persist + receipts logged in skill-review-index.log + master verdict compiled in reviews/<cycle-id>/verdict.md + review manifest marked COMPLETED in reviews/<cycle-id>/state.json + oc-ledger stamp note \"v<version> ACCEPTED — Duty 6 Cycle <id> closed\" executed (resetting cadence to 0/5 WAIT).`\n  242: \n  243: Rationale: HQ authors most rules — author-blindness is structural.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:18:\n  16: | `editor-upstream-pr.md` | Harvest & upstream PR filing procedure (Phase 7b/7c) |\n  17: | `hq.md` | HQ role — worker rost","s":true}] -->
<!-- reasoning -->
Very interesting. A prior lens-I report (20260912) flagged the "ten-lens ... ELEVEN" oxymoron in SKILL.md:51 and enumerated the lens count across files. And there was a proposal for `oc-review-persist check-cycle <cycle-dir>` to block closing Duty 6 unless all active catalog lenses have a persisted report. That tool NOW EXISTS (RC-CONTRACT line: "check-cycle: 0 census complete / ... 5 lens(es) missing").

And hq.md:241 still says "DONE = all 11 lens reports persisted". Hmm. So the count "11" is hardcoded in the law while `oc-review-persist check-cycle` derives the census from the catalog. This is a J finding: the law hardcodes a count (11) that is a pure function of the on-disk lens catalog, and the tool `check-cycle` already derives it. And the CHANGELOG v0.4.161 shows adding lens J required hand-updating the count in SKILL.md, hq.md, README.md ("Census updated: SKILL.md (Reviewers A–J + brain-scrub = ELEVEN), hq.md Duty 6 families + spawn set, README.md").

Hmm, so this is a solid J candidate: hq.md:241 "all 11 lens reports" — the count is state-derivable (catalog on disk + persisted reports), the tool `oc-review-persist check-cycle` is the natural host, and the law asks HQ to hold the number. T3: the DONE formula instructs HQ to check the count. Cost: the census churn (adding J hand-edited the count in 3 files).

But wait — the lens says "Failing T3 = already mechanical, the prose is descriptive, NO ACTION." Is "DONE = all 11 lens reports persisted" descriptive or prescriptive? It's a completion criterion — HQ must judge DONE. So it's an instruction to HQ to verify the count. Hmm. It's borderline but I think reportable as MED.

Hmm, but actually, one could argue the law already points to the tool: does hq.md reference `oc-review-persist check-cycle`? Let me check. Let me grep hq.md for "check-cycle". From the grep, no hq.md hit for check-cycle (only reviews). So hq.md's DONE formula doesn't cite check-cycle. So the law holds the count by hand while the tool exists. J finding. Good.

Hmm, but careful: "all 11 lens reports persisted" — is the number 11 correct? A–J (10) + brain-scrub (1) = 11. Yes. But wait, review-lenses.md says "the eleven Duty-6 review lenses (A–J + standing brain-scrub)". And hq.md item 1 says "one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub)" = 11. And item 2 family map lists DOCS=A,B,G · TOOLS=C,E,F · MECHANICAL=J · ARTIFACTS=D+H · META=I = 3+3+1+2+1 = 10, plus brain-scrub = 11. OK consistent.

Hmm, so is the count a defect? The defect is that the count is held in prose and must be hand-updated when the catalog changes, while `oc-review-persist check-cycle` derives it. Per the J lens: "including one-shot checks and any set or list a lane is told to hold in context." The count 11 is a derived number. And the standing exemplar was exactly a snapshot list (21 paths). So this is analogous: a count held in law that the tool derives. I'll report as MED.

Hmm, but I want to be careful: is "11" really "assigned to agent memory"? The law states it as fact; HQ would check "did all 11 persist?" A tool derives the census. So the decision "is the cycle complete (all lenses persisted)?" is state-derivable and the tool owns it. The law's prose duplicates the count. I'll frame it as: the count is a snapshot the tool (`check-cycle`) derives; the law should cite the tool's rc rather than the number.

OK. Now I have 7 candidates. Let me finalize ~5-6.

Let me reconsider severity and pick the most defensible:

1. **HIGH** — triage.md §PHOP step 2: manual parent/blocker/upstream-baseline verification duplicates `oc-harvest-dispatch vet`. (triage.md:46-48)
2. **HIGH** — editor-upstream-pr.md:227 In-Flight Lane Fence: manual ledger check duplicates `oc-harvest-dispatch vet` HELD_IN_FLIGHT_LANE.
3. **MED** — triage.md:291-292 notify delivery + liveness verification by hand → `oc-ping-proof` / `oc-log-search`.
4. **MED** — hq.md:276 Checkout-ref verification by hand → `oc-job-verify` (REF-MISMATCH).
5. **MED** — fleet-directives.md:442 base CI pre-claim "OWNERLESS red files" → `oc-pr-fault-scope` (IN-SCOPE/BASE-FAULT).
6. **MED/LOW** — hq.md:241 hardcoded "all 11 lens reports" → `oc-review-persist check-cycle`.
7. **LOW** — fleet-directives.md:48 dangling §Remotes & sync guard (2) (split reachability).

7 findings might exceed 6000 chars. Let me estimate: each finding ~600-700 chars → ~4500 chars + headers + coverage ~1000 → ~5500. Tight but OK. Let me trim to 6 (drop #7 or #6). Hmm. I'll keep #1-6 and mention #7 in Coverage briefly (as an observation) — no, findings should be in Findings. Hmm. Actually, since my brief explicitly asked about reachability after the split, I should report #7. Let me include it as LOW and keep findings concise.

Actually, let me reconsider #2 vs #1 — they're the same defect family and the lens warns against double-covering ("findings double-covered by two lenses" is I's concern, but padding is bad). Still, they're distinct sites in distinct files; both are legitimate. I'll keep both but make #2 brief.

Hmm, let me reconsider whether #1 is truly a finding given step 1 runs the tool. The law says: step 1 "Run `tools/oc-harvest-dispatch vet <issue-or-commits>` to verify upstream absence (tree-diff non-empty, patch-id unmerged, not already merged upstream, not superseded)." Step 2 "Native Sub-Issues & Blockers Check" then gives manual verification imperatives. So step 2 asks for manual work that the tool in step 1 already performs. That's the defect: the law assigns to the agent (hand-verify parent merged, hand-reject blockers, hand-verify upstream baseline) decisions the tool derives. Good.

Hmm, although — one could argue step 2 documents what vet checks. But the imperatives "verify parent feature is already merged upstream", "Verify target code path on live adolfousier/main" are agent instructions. And RC-CONTRACT confirms vet enforces HELD_PARENT_UNHARVESTED and HELD_BLOCKED_BY_DEPENDENCY. So the manual checks are redundant → J.

OK, let me write the report. I need to be careful with the exact required shape:

# Lens J - cycle 20260919-cycle
## Verdict: <one line>
## Findings
For each: **[HIGH|MED|LOW] <title>** . locator `<file>:<line>` or `<file>  SS<heading>` . VERBATIM QUOTE (mandatory) . the state that COULD derive it instead . suggested fix
## Coverage
what you actually read; what you did NOT read.

Let me write findings in that micro-format. I'll include the T1/T2/T3 test quote as required ("quote it in every report") — I'll put it right under ## Findings as a lead line, or in the Verdict. The shape is fixed, but adding the required test quote inside Findings should be acceptable. Actually, to respect "exactly this shape", I'll fold the T-test quote into the Verdict line? That's awkward. I'll add a short lead sentence at the top of Findings. I think that's fine and satisfies the brief's "quote it in every report".

Hmm, the shape says ## Findings then "For each: ...". Adding a lead sentence before the findings might violate "exactly this shape". But the J brief mandates quoting the T1/T2/T3 test in every report. I'll put it as a one-line lead. Acceptable.

Let me now double-check line numbers:

- triage.md:46-48: step 2 lines. Line 46 = "Sub-issues / Child cleanups: If candidate is a sub-issue ... verify parent feature is already merged upstream. If parent is unmerged, reject candidate harvest as blocked sub-issue (Issue #188 unharvested parent refusal)." Line 47 = Blockers. Line 48 = Upstream baseline verification.
- editor-upstream-pr.md:227: In-Flight Lane Fence.
- triage.md:291: Injection verification REQUIRED. triage.md:292: Liveness check.
- hq.md:276: Checkout-ref verification.
- fleet-directives.md:442: "Before filing an upstream PR, poll base-main CI gate state and pre-claim any OWNERLESS red files..."
- hq.md:241: Checkable Completion Formula "all 11 lens reports".
- fleet-directives.md:48: "This is NOT the carrier FREEZE of §Remotes & sync guard (2)."

Good.

Now let me also double-check: for finding #5, is there a tool that derives "ownerless red files"? `oc-pr-fault-scope <pr#> --run <id>` | "failing-files ∩ PR-files = IN-SCOPE/BASE-FAULT". Yes — BASE-FAULT = the failing files are NOT in the PR (i.e., ownerless/base reds). So it classifies exactly. And the law says "poll base-main CI gate state and pre-claim any OWNERLESS red files". The tool derives the classification. Good.

Hmm, but the law says "poll base-main CI gate state" — the base-main CI gate state is the base's CI; oc-pr-fault-scope uses a run id. Close enough — the natural host. I'll name `oc-pr-fault-scope <pr#> --run <id>` and `oc-harvest-sweep` as the mechanical leg.

Now, cost field: I'll cite the incident in the law where available; else `unpriced`.

Let me also reconsider severity. The lens severity scale (from I): HIGH (load-bearing lie / stall class) · MED (real gap, bounded blast radius) · LOW (nit). Hmm, for J, severity isn't defined explicitly. I'll use: HIGH for ones with documented incidents + a tool already existing that the law ignores (a lane following the law does redundant manual work — stall/burn class). MED for others.

Actually, let me reconsider: is finding #1 HIGH? The manual verification duplicates a tool the law already invokes in the same step → a lane does redundant work; and it's the exact class. I'd say MED-HIGH. Given the documented cost (#188 refusal, #302 churn), I'll say HIGH for #1 and #3 (documented incidents: n=1803, no_route). Hmm, #3's incident is about a real delivery failure — the law's manual grep is what caught it; the tool would settle it. I'll say MED for #3? Hmm. The lens: a rule asking an agent to re-check state by hand is the defect. The incident shows the state is load-bearing. I'll mark #3 HIGH (stall class — a missed injection means content unaccounted for).

Let me finalize:
1. HIGH — triage.md PHOP step 2 manual harvest pre-flight (parent/blockers/baseline).
2. MED — editor-upstream-pr.md In-Flight Lane Fence manual ledger check.
3. HIGH — triage.md notify injection/liveness hand-verification.
4. MED — hq.md checkout-ref verification by hand.
5. MED — fleet-directives base CI pre-claim "OWNERLESS red files".
6. MED — hq.md "all 11 lens reports" count.
7. LOW — fleet-directives dangling §Remotes & sync guard (2) after split.

Hmm, that's 7. Let me consider dropping #6 or #2 to stay focused. The brief says don't pad. I think #1-5 are strong; #6 is defensible; #7 is the split-reachability check my brief asked for. I'll include all 7 but keep each tight. Actually 7 findings in 6000 chars is ~700 chars each including locator/quote/state/fix. Doable if terse.

Hmm, let me reconsider #6 more. "DONE = all 11 lens reports persisted via oc-review-persist" — hmm. Actually the law does say "persisted via oc-review-persist", so the persistence is tool-mediated. The "11" is the count. Is the count "state-derivable"? Yes (catalog). And `check-cycle` derives the census. Hmm — but is `check-cycle` referenced anywhere in law? If not, the law holds the count in prose. I'll report as MED. OK.

Hmm, actually, I realize I should double check whether the "11" is even correct — could it be a lie now? Lens count: A,B,C,D,E,F,G,H,I,J = 10 + brain-scrub = 11. Yes, 11. Fine.

Let me write it. I'll aim for ~5800 chars.

Let me draft carefully with verbatim quotes.

Finding 1:
**[HIGH] Manual harvest pre-flight duplicates the vet tool.** locator `triage.md:46-48` (§Duty T4 PHOP). Quote: "verify parent feature is already merged upstream. If parent is unmerged, reject candidate harvest as blocked sub-issue" … "reject dispatch as `HELD_BLOCKED_BY_DEPENDENCY` until blockers land upstream." … "Verify target code path on live `adolfousier/main`". State: whether the parent/blocker is merged upstream (GitHub API + git), and the PR's file footprint. Tool half: `oc-harvest-dispatch vet <issue-or-commits>` already returns `HELD_PARENT_UNHARVESTED` and `HELD_BLOCKED_BY_DEPENDENCY` (RC-CONTRACT:31) and the claim fence `HELD_IN_FLIGHT_LANE`. Fix: delete step 2's hand-verification imperatives; step 1's rc names the verdict. Cost: Issue #188 unharvested-parent refusal; #302 wired with a `done` row (n=8267).

Finding 2:
**[MED] In-Flight Lane Fence asks for a hand ledger read.** locator `editor-upstream-pr.md:227`. Quote: "**In-Flight Lane Fence (v0.4.187)**: Check `workers-ledger.json` / `oc-roster` to ensure no active editor lane is currently modifying the subsystem." State: open claims / active lanes on the ledger. Tool: `oc-harvest-dispatch vet` (`HELD_IN_FLIGHT_LANE`) or `oc-ledger claim-ref <uuid> --open`. Fix: cite the tool's rc. Cost: unpriced.

Finding 3:
**[HIGH] Notify delivery + liveness verified by hand.** locator `triage.md:291-292`. Quote: "Before stamping any ack (\"brief delivered\", \"lane briefed\"), verify injection from the daemon log … Grep the log for the target session id after the send" and "verify the target is live — `session_search` with `updated_since` (or a same-turn log grep for the session id…)". State: the daemon-log injection line; the roster's last activity stamp. Tool: `oc-log-search <pattern>` (SKILL.md:126) and `oc-ping-proof <uuid> <ping-ts>` → WOKEN/SILENT/UNREACHABLE (SKILL.md:97). Fix: replace the hand greps with the tool verdict. Cost: n=1803 parked sends; c10cd97b no_route.

Finding 4:
**[MED] Checkout-ref verification by hand.** locator `hq.md:276`. Quote: "Checkout-ref verification: Checkout log lines identify the tested tree; verify checkout-ref matches the expected head SHA before treating a verdict as final evidence." State: the run's checkout ref vs the expected head sha. Tool: `oc-job-verify <run-id> <source-ref>` (rc 4 REF-MISMATCH; RC-CONTRACT:37) / `oc-prchecks`. Fix: cite the tool. Cost: unpriced.

Finding 5:
**[MED] Base CI pre-claim classifies OWNERLESS reds by hand.** locator `fleet-directives.md:442-443`. Quote: "Before filing an upstream PR, poll base-main CI gate state and pre-claim any OWNERLESS red files by carrying a sweep commit in the PR itself". State: failing files ∩ PR files. Tool: `oc-pr-fault-scope <pr#> --run <id>` → IN-SCOPE / BASE-FAULT (SKILL.md:123); `oc-harvest-sweep` is the pre-gate mechanical leg. Fix: name the tool. Cost: fork #103 incident.

Finding 6:
**[MED] Completion formula holds a lens count the tool derives.** locator `hq.md:241`. Quote: "DONE = all 11 lens reports persisted via oc-review-persist + …". State: the lens catalog on disk + the persisted reports. Tool: `oc-review-persist check-cycle` → rc 0 census complete / rc 5 lens(es) missing (RC-CONTRACT:48). Fix: replace "all 11" with the tool's census rc; the number is hand-maintained (adding lens J at v0.4.161 hand-edited it in SKILL.md, hq.md, README.md). Cost: the census churn itself (CHANGELOG v0.4.161).

Finding 7:
**[LOW] Split left a same-file pointer dangling.** locator `fleet-directives.md:48`. Quote: "This is NOT the carrier FREEZE of §Remotes & sync guard (2)." State: the section's own home. §Remotes & sync was moved byte-exact to `upstream-merge-runbook.md §Remotes & sync` (runbook:254) in the 2026-09-18 split, so the in-file pointer resolves to nothing. Fix: re-point to `upstream-merge-runbook.md §Remotes & sync`.

Coverage: read SKILL.md (structure + tool table + Hard rules + Upstream relations), fleet-directives.md (all 36 sections), hq.md (Duty 6 + sync + detached exec + cadence + provenance), triage.md (Duty T4 patrols + T3 editor creation), editor.md (relevant phases + fmt/CI sections), editor-upstream-pr.md (Phase 7 + hard rules), toolsmith.md (full), review-lenses.md (Reviewer J brief), tools/RC-CONTRACT.md (register rows), tools/oc-ping-proof. Did NOT read: CHANGELOG.md (history, out of scope), war-stories.md, s2-swap-journal-spec.md, README.md in full, tools/* tool source beyond oc-ping-proof, reviews/**.

Let me now write the final message, keeping under 6000 chars.

Let me count roughly. I'll write concisely.

Actually, one more consideration: the J brief says "EVIDENCE FORMAT — each finding carries (a) the law site, file + verbatim quote, (b) the state the decision reads, (c) the tool that should own it and its single-command interface, (d) the cost already paid (incident, ledger row, run id) or the word `unpriced`." I've included all. Good.

Let me write it.

I should also mention that I'm read-only and the report is returned as the final message (the brief says return as final message). Yes.

Let me make sure the verbatim quotes are exact. Let me re-verify a few from what I read:

- triage.md:46: "Sub-issues / Child cleanups: If candidate is a sub-issue or child cleanup (linked via `gh issue edit <issue> --parent <parent-issue>` or touching/deleting code from an unharvested subsystem), verify parent feature is already merged upstream. If parent is unmerged, reject candidate harvest as blocked sub-issue (Issue #188 unharvested parent refusal)." ✓
- triage.md:47: "Blockers: If candidate has active blockers declared via `gh issue edit <issue> --add-blocked-by <blocker-issue>`, reject dispatch as `HELD_BLOCKED_BY_DEPENDENCY` until blockers land upstream." ✓
- triage.md:48: "Upstream baseline verification: Verify target code path on live `adolfousier/main` to ensure work is not already clean or differently structured upstream." ✓
- editor-upstream-pr.md:227: "- **In-Flight Lane Fence (v0.4.187)**: Check `workers-ledger.json` / `oc-roster` to ensure no active editor lane is currently modifying the subsystem. If an active lane is working on the subsystem, hold harvest dispatch until that lane finishes, hot-swaps, and lands." ✓
- triage.md:291: "**Injection verification REQUIRED (owner order 2026-09-07 + auditor finding, n=1803 verify):** a `session_notify` "delivered" receipt ≠ injected. Before stamping any ack ("brief delivered", "lane briefed"), verify injection from the daemon log: ... Grep the log for the target session id after the send; stamp ack only on a real injection (or queue redelivery)." ✓
- triage.md:292: "**Liveness check + no_route accounting ...:** before `session_notify` to any session not heard from this turn, verify the target is live — `session_search` with `updated_since` (or a same-turn log grep for the session id; ...)" ✓
- hq.md:276: "- **Checkout-ref verification:** Checkout log lines identify the tested tree; verify checkout-ref matches the expected head SHA before treating a verdict as final evidence." ✓
- fleet-directives.md:442: "Before filing an upstream PR, poll base-main CI gate state and pre-claim any OWNERLESS red files by carrying a sweep commit in the PR itself (Session-Id-only trailer, no Issue-Ref)." ✓
- hq.md:241: "- **Checkable Completion Formula**: `DONE = all 11 lens reports persisted via oc-review-persist + receipts logged in skill-review-index.log + ...`" ✓
- fleet-directives.md:48: "4. **This is NOT the carrier FREEZE of §Remotes & sync guard (2).**" ✓

Good. Now write.

Character budget: I'll be terse.

Let me write the final answer.
<!-- /reasoning -->

# Lens J - cycle 20260919-cycle

## Verdict: The corpus still carries six state-derivable decisions assigned to a lane's hand (a tool already returns the verdict), plus one dangling in-file pointer left by the 2026-09-18 split; no HIGH lies, but the redundant-manual-work class is live.

## Findings
Test quoted per brief: **T1** decision is a pure function of state on disk · **T2** a tool already touches that state · **T3** the rule asks an agent to remember/derive/re-check by hand.

**[HIGH] Harvest pre-flight hand-verifies what `vet` already returns.** locator `triage.md:46-48` (§Duty T4, PHOP step 2). QUOTE: "verify parent feature is already merged upstream. If parent is unmerged, reject candidate harvest as blocked sub-issue" · "reject dispatch as `HELD_BLOCKED_BY_DEPENDENCY` until blockers land upstream" · "Verify target code path on live `adolfousier/main`". STATE: parent/blocker merged-ness (GitHub API + git) and the footprint. TOOL: `oc-harvest-dispatch vet <issue-or-commits>` already emits `HELD_PARENT_UNHARVESTED` and `HELD_BLOCKED_BY_DEPENDENCY` (RC-CONTRACT:31); step 1 of the same section already runs it. FIX: delete step 2's imperatives, let step 1's rc name the verdict. COST: Issue #188 unharvested-parent refusal; #302 wired carrying its own `done` row (n=8267).

**[MED] In-Flight Lane Fence asks for a hand ledger read.** locator `editor-upstream-pr.md:227`. QUOTE: "**In-Flight Lane Fence (v0.4.187)**: Check `workers-ledger.json` / `oc-roster` to ensure no active editor lane is currently modifying the subsystem." STATE: open claims / active lanes. TOOL: `oc-harvest-dispatch vet` (`HELD_IN_FLIGHT_LANE`) or `oc-ledger claim-ref <uuid> --open`. FIX: cite the tool verdict instead of the manual check. COST: unpriced.

**[HIGH] Notify delivery + liveness proven by hand-grep.** locator `triage.md:291-292` (§Duty T3). QUOTE: "Before stamping any ack ("brief delivered", "lane briefed"), verify injection from the daemon log … Grep the log for the target session id after the send; stamp ack only on a real injection" and "verify the target is live — `session_search` with `updated_since` (or a same-turn log grep for the session id…)". STATE: the daemon-log injection line; the roster's last-activity stamp. TOOL: `oc-log-search <pattern>` (SKILL.md:126) for injection, `oc-ping-proof <uuid> <ping-ts>` → WOKEN/SILENT/UNREACHABLE (SKILL.md:97) for liveness. FIX: replace both hand greps with the tool verdict. COST: n=1803 parked "delivered" sends; c10cd97b `no_route`.

**[MED] Checkout-ref verification done by hand.** locator `hq.md:276`. QUOTE: "Checkout-ref verification: Checkout log lines identify the tested tree; verify checkout-ref matches the expected head SHA before treating a verdict as final evidence." STATE: run checkout-ref vs expected head sha. TOOL: `oc-job-verify <run-id> <source-ref>` → rc 4 REF-MISMATCH (RC-CONTRACT:37). FIX: cite the tool's rc. COST: unpriced.

**[MED] Base-CI pre-claim classifies "OWNERLESS red files" by hand.** locator `fleet-directives.md:442-443`. QUOTE: "Before filing an upstream PR, poll base-main CI gate state and pre-claim any OWNERLESS red files by carrying a sweep commit in the PR itself". STATE: failing-files ∩ PR-files. TOOL: `oc-pr-fault-scope <pr#> --run <id>` → IN-SCOPE / BASE-FAULT (SKILL.md:123); `oc-harvest-sweep` is the pre-gate mechanical leg. FIX: name the tool; drop the hand poll. COST: fork #103 out-of-order merge.

**[MED] Completion formula holds a lens count the tool derives.** locator `hq.md:241`. QUOTE: "`DONE = all 11 lens reports persisted via oc-review-persist + …`". STATE: the lens catalog on disk + the persisted reports. TOOL: `oc-review-persist check-cycle` → rc 0 census complete / rc 5 lens(es) missing (RC-CONTRACT:48). FIX: replace "all 11" with the tool's census rc. COST: the census churn itself — adding lens J at v0.4.161 required hand-editing the number in SKILL.md, hq.md, README.md (CHANGELOG v0.4.161).

**[LOW] Split left a same-file pointer dangling.** locator `fleet-directives.md:48`. QUOTE: "**This is NOT the carrier FREEZE of §Remotes & sync guard (2).**" STATE: the referenced section's own home. §Remotes & sync was moved byte-exact to `upstream-merge-runbook.md §Remotes & sync` (runbook:254) in the 2026-09-18 split, so this in-file pointer resolves to nothing. FIX: re-point to `upstream-merge-runbook.md §Remotes & sync`. COST: unpriced.

## Coverage
Read: `review-lenses.md` (Reviewer J brief, T1–T3); `SKILL.md` (frontmatter, router, canonical tool table, test ontology, glossary, upstream relations, hard rules); `fleet-directives.md` (all 36 sections, incl. the post-split pointer table); `hq.md` (Duty 6 in full, sync, detached exec, cadence boundary, provenance); `triage.md` (Duty T4 patrols, PHOP, Duty T3 editor creation); `editor.md` (scope, fmt/CI/phase sections, exits); `editor-upstream-pr.md` (Phase 7, hard rules, conflict classes); `toolsmith.md` (full); `tools/RC-CONTRACT.md` (register rows); `tools/oc-ping-proof` source. NOT read: `CHANGELOG.md` (history — excluded by the lens's own scope), `war-stories.md`, `s2-swap-journal-spec.md`, `README.md` in full, all `tools/*` source except `oc-ping-proof`, and `reviews/**`. I did not re-litigate the docs-only LEG1 exclusion set — the standing exemplar is already amended (tool-derived at gate time via `--eval-docs-skip`), so no finding. Split reachability checked: every cross-file `fleet-directives.md §X` pointer in the law still resolves (hq.md:263 and SKILL.md:462 were re-pointed to `upstream-merge-runbook.md`); only the in-file pointer at `fleet-directives.md:48` is stale.

