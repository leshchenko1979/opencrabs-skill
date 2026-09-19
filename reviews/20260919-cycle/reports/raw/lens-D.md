
<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"# review-lenses.md — Duty-6 reviewer lens catalog (B4+G-F4 split, v0.4.78)\n\nFull briefs for the eleven Duty-6 review lenses (A–J + standing brain-scrub; regrouped v0.4.81 with C joining TOOLS and D sole in ARTIFACTS — H later joined D in ARTIFACTS, v0.4.113/115; the MECHANICAL family + Reviewer J added v0.4.161 on owner order). hq.md §Duty 6 owns the\nmethod (read-only sub-agents, verbatim-quote verification, oc-review-persist\npersistence, poll triple-check, verdict table) and keeps only the family map\nthere; this file owns the per-lens scope briefs (brain-scrub brief lives at review-lenses.md § Review lens brain-scrub). Letters keep chronological\nbirth order (stable report/persist keys, not an ordering). Reviewer-performance\nloop lessons (hq.md step 7) fold INTO these briefs at ship time,\nattributed to the reviewer that produced the evidence. Family identity is the\nOBJECT under review, not the evidence flow between lenses (regrouped v0.4.81:\nC joined TOOLS — gaps/shape/implementation pipeline; D is sole in ARTIFACTS,\nthe family IS the deletion owner gate). Membership and grouping change only\non census evidence + owner word (hq.md step 7).\n\n#### FAMILY: DOCS — role files (wording / reading load / organization)\n\n   - **Reviewer A — REDUNDANCY + ONTOLOGY:** same rule stated twice across\n     files; duplicated war stories; terms violating the SKILL.md test ontology\n     (SMOKE TEST / CODE TESTS / FEATURE-PRESENCE CHECK / EXECUTION SANITY\n     SIGNAL); undefined coinages; stale ref names (lens I-2.2\n     v0.4.116: A owns ref CONSISTENCY; B weighs refs only as load-weight —\n     first finder gets attribution); SEDIMENT — stale layers\n     that survive because adding feels safe and removing feels risky\n     (docs-lens vocabulary reference:\n     `skills/writing-for-agents/SKILL.md`). PLUS the churn-drift checklist, EVERY\n     lens-A pass: (a) ONE CONCEPT = ONE NAME — sweep for synonyms of the same\n     gate/tool/artifact; (b) GLOSSARY CONFORMANCE — every load-bearing term\n ","s":true}] -->

<!-- tools-v2: [{"d":"Grep 'Reviewer D' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"[SKILL GATE] This call touches '/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md' which matches skill 'opencrabs-dev' (globs: ~/opencrabs/**, ~/oc-wt-*/**, ~/.opencrabs/profiles/*/skills/opencrabs-dev/**, ~/.opencrabs/profiles/*/opencrabs-dev/**, ~/.opencrabs/profiles/*/projects/opencrabs-dev/**), not loaded in the current session context. The full skill body follows. Read it, then re-issue the identical call.\n\n---\n\n# opencrabs-dev — OpenCrabs source procedure\n\n**Owns:** everything touching `~/opencrabs` source, its GitHub Actions runs, or the\ninstalled `opencrabs` binary. This file = shared facts + role router only. Actual\nprocedures live in FOUR role files (`editor.md` / `hq.md` / `triage.md` / `toolsmith.md`);\nload ONLY the one matching the session's role.\n\n**Binding owner directives** (sync policy, upstream PR law, carriers/builds, cargo\nprohibition, telegram surface law, tool logging, gates, editor creation, tool-problem triage (Triage lane),\ncadence) live in `fleet-directives.md` — re-homed from ops AGENTS.md/MEMORY.md per\nowner order 2026-09-02. Load it before ANY opencrabs-dev work. Executing procedure for the sync\npolicy's rebase procedure: `upstream-merge-runbook.md` (freeze gate, roles, conflict\nclasses, migration-union rule, semantic-triage defaults).\n\n## STEP ZERO — establish the role (mandatory on every load)\n\nAsk the operator which role this session employs before doing anything:\n\n> **Editor, HQ, Triage, or Toolsmith?**\n\n| Role | Owns | Procedure file |\n|------|------|----------------|\n| **EDITOR** | Commits + error fixes: claim issue → worktree → code → CI gate → sign → push → ff-merge into fork `main` → `oc-deploy ship` → smoke on notify; feature COMPLETE → upstream PR filed on smoke PASS (procedure `editor-upstream-pr.md` Phase 7) | `editor.md` |\n| **HQ** | Skill set maintenance, worker ledger, Duty 4 worker polls, Duty 6 periodic 11-lens reviews (details in `hq.md` and `review-lenses.md`) | `hq.md` |\n| **TRIAGE** | Intake & hygi","s":false}] -->

<!-- tools-v2: [{"d":"Grep 'Reviewer D' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md:177:\n>      never invoked in the window (YAGNI/deletion evidence for Reviewer D),\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md:227:\n>    - **Reviewer D — DELETION SAFETY:** enumerate retired / stale /\n\n(2 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"     step-by-step mechanics belong in the owning role file or reference page\n     (RC-CONTRACT.md = SOLE tool register). Every Duty-6 pass re-weighs\n     SKILL.md against this rule; growth beyond router scope = findings.\n\n#### FAMILY: ARTIFACTS — files, state, ledgers, flags (deletion verdicts — the family IS the owner gate; C usage-log YAGNI evidence feeds it from TOOLS; BOUNDARY vs J, v0.4.162 — this family owns the ARTIFACT and its verdict, J owns the law sentence that assigns a state-derivable decision: object is an artifact on disk → here, object is law text → J)\n\n   - **Reviewer D — DELETION SAFETY:** enumerate retired / stale /\n     duplicate-looking artifacts in the skill scope (files, state files,\n     ledgers, markers, tool flags) and for EACH list what reads or writes it\n     (grep tools/, crons, skill files, journal vocabulary), then classify\n     DELETE-SAFE (evidence law, folded from D's own method note v0.4.116:\n     a zero-hit claim from a |-pattern grep in literal mode is UNVERIFIED —\n     quote the query + scope for every negative-existence claim) / ARCHIVE / KEEP with that reference list as the evidence.\n     \"Looks stale\" is a hypothesis, never a verdict. Nothing deletes without\n     HQ's poll triple-check + owner word.\n   - **Reviewer H — LEDGER HEALTH (shipped v0.4.114, owner GO 2026-09-08 20:16Z):**\n     the workers-ledger.json read AS A WHOLE, not per-slice — the slice tools\n     (`oc-ledger claims`, `oc-ship-audit`) each audit one family and stay the\n     enforcement surface, while the `oc-roster-detached-sweep` cron sweeps\n     detached work; H reads for what they cannot\n     see: (1) RECEIPT COMPLETENESS — incident/lesson-mention rows with no\n     corresponding codified rule in fleet-directives.md/editor.md/AGENTS.md\n     (lesson-extraction completeness; each finding names the row AND the law\n     home that should carry it, or the explicit owner waiver), (2) PHANTOM\n     FAMILIES — rows claiming stamps/writes/deliveries with no same-turn t","s":true}] -->

<!-- tools-v2: [{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":".git/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git:\n  COMMIT_EDITMSG\n  FETCH_HEAD\n  HEAD\n  ORIG_HEAD\n  branches/\n    /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/branches:\n  config\n  description\n  hooks/\n    /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/hooks:\n    applypatch-msg.sample\n    commit-msg.sample\n    fsmonitor-watchman.sample\n    post-update.sample\n    pre-applypatch.sample\n    pre-commit.sample\n    pre-merge-commit.sample\n    pre-push.sample\n    pre-rebase.sample\n    pre-receive.sample\n    prepare-commit-msg.sample\n    push-to-checkout.sample\n    sendemail-validate.sample\n    update.sample\n  index\n  info/\n    /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/info:\n    exclude\n  logs/\n    /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/logs:\n    HEAD\n    refs/\n      /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/logs/refs:\n      heads/\n        /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/logs/refs/heads:\n        feat/\n          /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/logs/refs/heads/feat:\n          merge-queue-landings\n        fix/\n          /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/logs/refs/heads/fix:\n          harvest-sweep-patchid\n          harvest-sweep-patchid-wt\n          oc-issue-sweep-search-json\n        main\n      remotes/\n        /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/logs/refs/remotes:\n        origin/\n          /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/logs/refs/remotes/origin:\n          feat/\n            /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/logs/refs/remotes/origin/feat:\n            merge-queue-landings\n          main\n      stash\n  objects/\n    /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/objects:\n    00/\n      /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/objects/00:\n      1fd9c92a23bde4ac121a8c00296cff07be6ae2\n      295cfe63f7273a9e3c001b1b1f036ee1d4a95a\n      3e67dc7daeb1bc","s":true}] -->
<!-- reasoning -->
Let me list the top level of the skill dir without recursion.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"     <DIR>  2026-09-19 04:09:35  reviews/\n     <DIR>  2026-09-18 20:33:34  run/\n     <DIR>  2026-09-19 03:52:20  tools/\n    278084  2026-09-18 20:01:51  CHANGELOG.md\n      5494  2026-09-19 03:38:59  README.md\n     46882  2026-09-19 03:33:57  SKILL.md\n     31523  2026-09-19 02:04:11  editor-upstream-pr.md\n     52141  2026-09-19 03:38:51  editor.md\n     73666  2026-09-19 03:38:15  fleet-directives.md\n     25990  2026-09-19 02:04:11  hq.md\n     21338  2026-09-19 02:04:11  review-lenses.md\n      6810  2026-09-19 00:57:11  s2-swap-journal-spec.md\n     12771  2026-09-19 00:52:54  toolsmith.md\n     28997  2026-09-19 02:04:11  triage.md\n     47129  2026-09-19 00:54:19  upstream-merge-runbook.md\n     15578  2026-09-11 11:46:36  war-stories.md\n","s":true}] -->

<!-- tools-v2: [{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews","o":"2026-09-05-A-redundancy.md\n20260907-duty46/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260907-duty46:\n  verdict-table.md\n20260907-duty46-cycle2/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260907-duty46-cycle2:\n  reports/\n    /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260907-duty46-cycle2/reports:\n    skill-review-A-20260829-run2.md\n    skill-review-A-20260829.md\n    skill-review-A-20260831.md\n    skill-review-A-20260901.md\n    skill-review-A-20260907.md\n    skill-review-A2-20260907.md\n    skill-review-B-20260829-run2.md\n    skill-review-B-20260829.md\n    skill-review-B-20260831.md\n    skill-review-B-20260901.md\n    skill-review-B-20260905.md\n    skill-review-B-20260907.md\n    skill-review-B2-20260907.md\n    skill-review-C-20260829-run2.md\n    skill-review-C-20260829.md\n    skill-review-C-20260831.md\n    skill-review-C-20260901.md\n    skill-review-C-20260905.md\n    skill-review-C-20260907.md\n    skill-review-C2-20260831.md\n    skill-review-C2-20260907.md\n    skill-review-D-20260829-run2.md\n    skill-review-D-20260829.md\n    skill-review-D-20260831.md\n    skill-review-D-20260901.md\n    skill-review-D-20260907.md\n    skill-review-D2-20260907.md\n    skill-review-E-20260901.md\n    skill-review-E-20260907.md\n    skill-review-E2-20260907.md\n    skill-review-E2b-20260907.md\n    skill-review-F-20260901.md\n    skill-review-F-20260905.md\n    skill-review-F-20260907.md\n    skill-review-F2-20260907.md\n    skill-review-G-20260901.md\n    skill-review-G-20260907.md\n    skill-review-G2-20260907.md\n    skill-review-brain-scrub-20260905.md\n  skill-review-index.log\n  verdict-table.md\n20260909-cycle/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260909-cycle:\n20260910-cycle/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260910-cycle:\n  reports/\n    /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260910-cycle/reports:\n    skill-review-A-20260910.md\n    skill-review-B-20260910.md\n    s","s":true}] -->
<!-- reasoning -->
Now let's look at the state dir. Where is it? Probably `run/`. Let me look at the run dir.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/run","o":"t4-20260918T1322Z/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/run/t4-20260918T1322Z:\n  branch-sweep.txt\n  census.err\n  census.json\n  delta.err\n  delta.txt\nt4-20260918T1700Z/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/run/t4-20260918T1700Z:\n  census.err\n  census.json\nt4-20260918T1944Z/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/run/t4-20260918T1944Z:\n  branch-sweep.txt\n  census.err\n  census.json\n  delta.err\n  delta.txt\n  soak-split.json\n  vet-mature.txt\n  vet.txt\n  vetall.log\n  vetall.sh\n  vetall2.log\n  vetall2.sh\nwave-04c5173aaa04.targets\nwave-20b1140d2aff.targets\nwave-230f0db95dea.lock\nwave-2593ade96011.targets\nwave-2a69309c81ba.targets\nwave-36f9c396e0b6.lock\nwave-36f9c396e0b6.sent\nwave-36f9c396e0b6.targets\nwave-3c7a4460b03e.lock\nwave-3c7a4460b03e.sent\nwave-3c7a4460b03e.targets\nwave-50e7112a05cd.lock\nwave-50e7112a05cd.sent\nwave-50e7112a05cd.targets\nwave-571b09a0f2e2.lock\nwave-5c0792d39150.sent\nwave-5c0792d39150.targets\nwave-7b71e9ba0cfe.lock\nwave-7b71e9ba0cfe.sent\nwave-7b71e9ba0cfe.targets\nwave-809e74a02813.targets\nwave-8e40aea3d1e0.targets\nwave-9857092b1d26.targets\nwave-9fa8ff6abae3.targets\nwave-a9561c346258.targets\nwave-bef2ecc3bd9f.targets\nwave-c31ab1cccd02.sent\nwave-c31ab1cccd02.targets\nwave-cdc1aec7c6d6.sent\nwave-cdc1aec7c6d6.targets\nwave-dd7f9a903b7d.sent\nwave-dd7f9a903b7d.targets\nwave-e1445533ddad.targets\nwave-ec509072d45d.targets\nwave-eca4532965e2.targets\nwave-f1a594611c40.lock\nwave-f1a594611c40.sent\nwave-f1a594611c40.targets\nwave-fb1babcdf8e3.lock\nwave-fb1babcdf8e3.sent\nwave-fb1babcdf8e3.targets\nwave-fc103e23dd5f.lock\nwave-fc103e23dd5f.sent\nwave-fc103e23dd5f.targets\n","s":true}] -->
<!-- reasoning -->
Hmm, the run dir has wave-* files. But where's the "state dir (workers-ledger.json, journals, markers, locks, tools.log)"? Let me search.

Actually the run dir may not be the state dir. Let's search for workers-ledger.json.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Glob **/workers-ledger.json","o":"Found 1 files matching '**/workers-ledger.json':\n\n  opencrabs-dev/workers-ledger.json\n","s":true},{"d":"Glob **/tools.log","o":"Found 1 files matching '**/tools.log':\n\n  opencrabs-dev/tools.log\n","s":true}] -->
<!-- reasoning -->
Those are relative to base_dir /root/.opencrabs/profiles/ops — so /root/.opencrabs/profiles/ops/opencrabs-dev/workers-ledger.json? Wait, the base_dir was ops. Hmm, the output shows "opencrabs-dev/workers-ledger.json". Let me check.

Actually wait — the working directory might be /root/.opencrabs/profiles/ops. Let me check both locations.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"ls ~/.opencrabs/profiles/ops/opencrabs-dev","o":"     <DIR>  2026-09-19 04:10:24  .git/\n     <DIR>  2026-09-18 10:21:50  __pycache__/\n     <DIR>  2026-09-15 04:10:40  archive/\n     <DIR>  2026-09-19 02:34:28  designs/\n     <DIR>  2026-09-19 04:06:17  fd-split-20260918/\n     <DIR>  2026-09-11 09:08:10  hooks/\n     <DIR>  2026-09-09 18:58:44  incident-evidence-20260909/\n     <DIR>  2026-09-12 09:49:58  incident-evidence-20260912/\n     <DIR>  2026-09-03 18:17:54  journal/\n     <DIR>  2026-08-31 06:13:37  oc-deploy/\n     <DIR>  2026-09-17 01:24:22  probes/\n     <DIR>  2026-09-18 06:56:22  reports/\n     <DIR>  2026-09-18 02:53:08  rescue-299-20260918T025308Z/\n     <DIR>  2026-09-18 03:02:44  rescue-299-20260918T030243Z/\n     <DIR>  2026-09-18 03:05:32  rescue-299-20260918T030531Z/\n     <DIR>  2026-09-16 23:28:06  reviews/\n     <DIR>  2026-09-11 08:04:18  roster/\n     <DIR>  2026-09-14 08:20:06  runs/\n         7  2026-08-29 13:22:54  .gitignore\n        37  2026-09-18 12:08:21  .oc-harvest-dispatch-lane-cursor\n         0  2026-09-19 04:11:20  .oc-prchecks-dispatch.lock\n        24  2026-09-18 14:45:03  .oc-prchecks-rc2\n     10150  2026-09-13 07:35:04  138-harvest-port-plan.md\n      1892  2026-09-12 21:41:08  138-hydrate-evidence.txt\n      7067  2026-09-13 08:49:38  138-ship-state.md\n     11267  2026-09-12 10:18:32  155-checkpoint.md\n      4715  2026-09-12 09:18:55  173-leg4-injection-evidence.md\n      3295  2026-09-12 10:42:04  175-anchor-ab-evidence.md\n      3969  2026-09-12 16:33:53  179-smoke-probe-design.md\n     16576  2026-09-12 13:35:53  187-ship-state.md\n      2503  2026-09-18 13:57:35  233-harvest-state.md\n      4964  2026-09-15 09:33:15  234-base-red-verdict.md\n      3834  2026-09-18 01:51:35  275-279-ship-state.md\n      3989  2026-09-18 10:34:42  291-fence-diagnosis.py\n      3325  2026-09-18 10:38:46  291-fence-enumerate.py\n      3018  2026-09-18 04:00:36  291-leg4-probe.py\n     48489  2026-09-18 22:11:55  291-smoke-state.md\n     28408  2026-09-18 04:02:37  291-smoke-state.md.2026-09-18T040237.bak\n     35976  20","s":true}] -->
<!-- reasoning -->
Wait, this is `/root/.opencrabs/profiles/ops/opencrabs-dev` — the STATE dir. Yes, the task says "the state dir (workers-ledger.json, journals, markers, locks, tools.log)". So the state dir is `/root/.opencrabs/profiles/ops/opencrabs-dev/`.

Hmm, but the brief says "Root: /root/.opencrabs/profiles/ops/skills/opencrabs-dev/". And the state dir is a sibling. Let me confirm the working directory and check the SKILL.md / fleet-directives.md for the state dir path.

Let me read the key laws. First, let me find the law about the state dir path, the reviews corpus law, the index log law, etc.

Let me look at the reviews dir under state dir too: `/root/.opencrabs/profiles/ops/opencrabs-dev/reviews/`.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"ls ~/.opencrabs/profiles/ops/opencrabs-dev/reviews","o":"20260908-c1/\n  /root/.opencrabs/profiles/ops/opencrabs-dev/reviews/20260908-c1:\n  reports/\n    /root/.opencrabs/profiles/ops/opencrabs-dev/reviews/20260908-c1/reports:\n    lens-a.md\n    skill-review-A-20260908.md\n    skill-review-B-20260908.md\n    skill-review-C-20260908.md\n    skill-review-D-20260908.md\n    skill-review-E-20260908.md\n    skill-review-F-20260908.md\n    skill-review-G-20260908.md\n    skill-review-H-20260908.md\n    skill-review-I-20260908.md\n    skill-review-brain-scrub-20260908.md\n    skill-review-brain-scrub-20260908b.md\n20260908-c2/\n  /root/.opencrabs/profiles/ops/opencrabs-dev/reviews/20260908-c2:\n  reports/\n    /root/.opencrabs/profiles/ops/opencrabs-dev/reviews/20260908-c2/reports:\n    brain-scrub.md\n    lens-A.md\n    lens-B.md\n    lens-C.md\n    lens-D.md\n    lens-E.md\n    lens-F.md\n    lens-G.md\n    lens-H.md\n    lens-I.md\n20260909-c3/\n  /root/.opencrabs/profiles/ops/opencrabs-dev/reviews/20260909-c3:\n  lens-A-20260909.md\n  lens-B-C-D-E-20260909.md\n  lens-F-20260909.md\n  lens-G-20260909.md\n  lens-I-20260909.md\n20260909-c4/\n  /root/.opencrabs/profiles/ops/opencrabs-dev/reviews/20260909-c4:\n  brain-scrub-20260909.md\n  lens-A-20260909.md\n  lens-B-20260909.md\n  lens-C-20260909.md\n  lens-D-20260909.md\n  lens-E-20260909.md\n  lens-F-20260909.md\n  lens-G-20260909.md\n  lens-H-20260909.md\n  lens-I-20260909.md\n20260911-c5/\n  /root/.opencrabs/profiles/ops/opencrabs-dev/reviews/20260911-c5:\n  duty4-proposals.log\n  proposals/\n    /root/.opencrabs/profiles/ops/opencrabs-dev/reviews/20260911-c5/proposals:\n    1a63f103-b899-4ad2-a5b3-c89f2902bf97.md\n  review-lens-A.md\n  review-lens-B.md\n  review-lens-C.md\n  review-lens-D.md\n  review-lens-E.md\n  review-lens-F.md\n  review-lens-G.md\n  review-lens-H.md\n  review-lens-ai-antispam-hq.md\n  review-lens-brain-scrub.md\n  review-lens-c5-brain-scrub.md\n  review-lens-c5-lens-I.md\n  review-lens-delegate.md\n  review-lens-inferhub-15-iq-basis.md\n  review-lens-inferhub-16-gate-rank.md\n  review-lens-inferhub-16-top1-gate.md\n  rev","s":true},{"d":"ls ~/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918","o":"BASELINE.md\n__pycache__/\n  /root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/__pycache__:\n  fd_xref.cpython-314.pyc\nblocks/\n  /root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/blocks:\n  blk_000.bin\n  blk_001.bin\n  blk_002.bin\n  blk_003.bin\n  blk_004.bin\n  blk_005.bin\n  blk_006.bin\n  blk_007.bin\n  blk_008.bin\n  blk_009.bin\n  blk_010.bin\n  blk_011.bin\n  blk_012.bin\n  blk_013.bin\n  blk_014.bin\n  blk_015.bin\n  blk_016.bin\n  blk_017.bin\n  blk_018.bin\n  blk_019.bin\n  blk_020.bin\n  blk_021.bin\n  blk_022.bin\n  blk_023.bin\n  blk_024.bin\n  blk_025.bin\n  blk_026.bin\n  blk_027.bin\n  blk_028.bin\n  blk_029.bin\n  blk_030.bin\n  blk_031.bin\n  blk_032.bin\n  blk_033.bin\n  blk_034.bin\n  blk_035.bin\n  blk_036.bin\n  blk_037.bin\n  blk_038.bin\n  blk_039.bin\n  blk_040.bin\n  blk_041.bin\n  blk_042.bin\n  blk_043.bin\n  blk_044.bin\n  blk_045.bin\n  blk_046.bin\n  blk_047.bin\n  blk_048.bin\n  blk_049.bin\n  blk_050.bin\n  blk_051.bin\n  blk_052.bin\n  blk_053.bin\n  blk_054.bin\n  blk_055.bin\n  blk_056.bin\n  blk_057.bin\n  blk_058.bin\n  blk_059.bin\n  blk_060.bin\nblocks.tsv\nfd_index_check.py\nfd_xref.py\nheader.bin\nheader2.bin\nindex_post.txt\nindex_pre.txt\nparts/\n  /root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/parts:\n  sec_000.bin\n  sec_001.bin\n  sec_002.bin\n  sec_003.bin\n  sec_004.bin\n  sec_005.bin\n  sec_006.bin\n  sec_007.bin\n  sec_008.bin\n  sec_009.bin\n  sec_010.bin\n  sec_011.bin\n  sec_012.bin\n  sec_013.bin\n  sec_014.bin\n  sec_015.bin\n  sec_016.bin\n  sec_017.bin\n  sec_018.bin\n  sec_019.bin\n  sec_020.bin\n  sec_021.bin\n  sec_022.bin\n  sec_023.bin\n  sec_024.bin\n  sec_025.bin\n  sec_026.bin\n  sec_027.bin\n  sec_028.bin\n  sec_029.bin\n  sec_030.bin\n  sec_031.bin\n  sec_032.bin\n  sec_033.bin\n  sec_034.bin\n  sec_035.bin\n  sec_036.bin\n  sec_037.bin\n  sec_038.bin\n  sec_039.bin\n  sec_040.bin\n  sec_041.bin\n  sec_042.bin\n  sec_043.bin\n  sec_044.bin\n  sec_045.bin\n  sec_046.bin\n  sec_047.bin\n  sec_048.bin\n  sec_049.bin\n  sec_050.bin\n  sec_051.bin\n  sec_052.bin\n  sec_053.bin\n  sec_054.bi","s":true}] -->
<!-- reasoning -->
There's a LOT here. I need to focus. My scope: artifacts, state, ledgers and flags produced by the skill as they are now (post-split 2026-09-19). Root: /root/.opencrabs/profiles/ops/skills/opencrabs-dev/. Look at reviews/**, the state dir, CHANGELOG.md, war-stories.md, and any artifact a law says must exist.

CONTEXT: on 2026-09-18 fleet-directives.md was SPLIT and a new cycle dir reviews/20260918-cycle/ was created holding two reports (lens-B-redundancy-20260918.md, lens-S-staleness-archaeology-20260918.md). Note lens S is NOT a catalog lens.

Key candidate findings:
1. `reviews/20260918-cycle/reports/` — two reports, but no state.json, no index log. The cycle dir exists but lacks state.json/verdict. Is there a law requiring state.json? Need to check hq.md / SKILL.md for the cycle dir structure law.
2. The 20260918-cycle reports are named `lens-B-...` and `lens-S-...`, not `skill-review-...`. And lens S is not a catalog lens.
3. `reviews/20260919-cycle/state.json` exists but reports/ is empty.
4. Orphaned dirs like `20260915-c18/` (empty reports dir, has state.json), `20260915-c17/` (reports empty but has cohort files at cycle root), `20260909-cycle/` (totally empty!).
5. `reviews/20260907-duty46-cycle2/reports/` has old-style reports; `20260907-duty46/` only has verdict-table.md.
6. `reviews/inbox/` files — 20260907-duty6-lens-*.md.
7. `reviews/skill-review-B-20260906.md` etc at root — root-level reports that per I-5.1 should live in reviews/<cycle>/reports/.
8. Root `reviews/skill-review-index.log` and per-cycle index logs — divergence.
9. `run/` dir with wave-*.lock / .targets / .sent — locks and markers.
10. `fd-split-20260918/` — huge working dir (blocks, parts, receipts, pycache) — is it a law-required artifact or a scratch dir?
11. `291-smoke-state.md.bak*` files, `harvest-registry.json.bak-*`, `smoke-verdicts.log.bak-*`, `oc-deploy-shadow.archive.log` — backups.
12. `workers-ledger.json.lock`, `tools.log.lock`, `ship.lock`, `host-swap.lock`, `.oc-prchecks-dispatch.lock` — lock files.

I must quote the governing law for each finding. So I need to find the laws:
- The law about reviews corpus location (`reviews/<cycle>/reports/`), index log precedence (I-5.1).
- The law about state.json in cycle dirs.
- The law about the state dir.
- The law about locks.
- The law about backups?
- The law about the ledger.
- CHANGELOG.md law (provenance sediment moves to CHANGELOG at ship time).
- war-stories.md law.

Let me read hq.md and SKILL.md, and grep fleet-directives.md for relevant terms.

Let me be efficient. Let me grep for "state.json", "reviews/", "index.log", "cycle", "lock", "state dir" across the skill files.

Given the SKILL GATE, reads of skill files trigger the full skill body. That's expensive but okay. Let me use grep which returns the skill gate + matches. Actually grep triggered the gate earlier and returned the whole skill body (truncated) plus matches. Hmm, that's a lot of noise. Let me just do it.

Let me grep for "state.json" in the skill dir.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'state\\.json' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"No matches found for pattern: 'state\\.json'","s":true}] -->
<!-- reasoning -->
Hmm, no matches for state.json in skill .md files. Let me check hq.md content for cycle dir law. Let me read hq.md.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md","o":"# HQ — skill maintenance & worker coordination\n\n**RELOAD LAW & MANIFEST CURATION (Section 10):** Canonical procedure lives in `fleet-directives.md §Post-compaction skill reload & context manifest curation` (keep `opencrabs-dev`, `hq.md`, `fleet-directives.md` in `active_skills`; re-read IN FULL on compaction/spawn).\n\n**Load only after SKILL.md confirmed the role is HQ.** This is HQ\nsession's standing role. Interrupt-shaped duties (idea-box / QUIRK intake,\nfix routing, enforcement patrols) operate in the TRIAGE lane since v0.4.86\n(owner \"Go with Option A\" 2026-09-06) — procedure: `triage.md`; batched\nescalations from that lane land here. Skill-file authorship stays SOLELY\nwith HQ (single-writer law unchanged; v0.4.87 carve-out: the\nTOOLSMITH lane owns `tools/` CODE — skill markdown never leaves this lane).\n\nScope: own the skill set (full census in SKILL.md §Hard rules — incl. `editor-upstream-pr.md`, `fleet-directives.md`,\n`upstream-merge-runbook.md`, `war-stories.md`, `s2-swap-journal-spec.md`, `README.md`, `CHANGELOG.md`, `tools/RC-CONTRACT.md`,\n`tools/HEALTH-CHECKS.md`, `tools/HEALTH-CLASSES.md`; `tools/archive/compiler.md` archived), keep every worker ON the current skill version, and\nturn field evidence into rules. The HQ NEVER dispatches builds, NEVER swaps\nbinaries, NEVER touches the binary, NEVER writes feature code.\n\n**PROCESS-TOOL OWNERSHIP (v0.4.87 Toolsmith carve-out):** CLI tools that\nautomate OUR process steps (sealing state files, presence gates, roster\npulls, job-name verification, health receipts) are the TOOLSMITH lane's to\nCREATE, FIX, and MAINTAIN (toolsmith.md) — ops tooling, NOT opencrabs\nfeature code. Tools live in\n`skills/opencrabs-dev/tools/` (`./tools/<name>`, next to these files), one\nscript per job, single-command interface. Build only what RECURS (≥3 manual hits or one incident-class burn);\nYAGNI applies — never automate a one-off or a human-judgment call. **Guard\n(S3-rewired 2026-08-28):** the build-cycle tools (`oc-deploy`\nship/poll/swa","s":true}] -->
<!-- reasoning -->
Let me read the middle part of hq.md (the omitted 212 lines) which likely covers Duty 6 mechanics.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md","o":"this session, no deputization. Analysis, reports, simulations, and skill work\nstay here. Expected reply shape: \"routed to <worker>\", not done-work.\n\n**PRIORITY AUTHORITY (owner order 2026-09-15):** HQ has complete, independent authority over skill revision sequencing, review cycle cadence, and codification batching — never ask the human operator about priorities.\n\n## Duty 1 — Update the skill\n\n- Owner directive or validated poll proposal → surgical `edit_file` → VERIFY on\n  disk (grep the markers; parallel writers are a standing hazard) → append the\n  `## v<v>` entry to `CHANGELOG.md` (the C8 sync gate REFUSES a bump without\n  it, v0.4.65) → bump the version in `SKILL.md` frontmatter.\n- One coherent revision per owner-verdict batch (one `v0.4.x`), never scattered\n  patches. Editors' accepted proposals ride the next version, they do not open\n  their own.\n- `tools/**` CODE authorship moved to the TOOLSMITH lane at v0.4.87 (owner \"Go\n  toolsmith\" 2026-09-06): tool fixes / extensions / new tools execute THERE with\n  battery receipts; HQ keeps skill markdown, CHANGELOG, version\n  bumps, and fleet-directives (single-writer law for skill text unchanged).\n- Provenance = the `## v<v>` CHANGELOG entry, written at ship time (fleet-\n  directives §Rule-text provenance, F13 — rule text carries NO biography).\n- **Checkable Completion Formula**: `DONE = edit verified on disk + battery tools/tests/run.sh PASS + CHANGELOG.md entry present + git commit in skill repo + oc-ledger sync --version <v> returns rc=0.`\n\n## Duty 2 — Worker registry: identity + versions, NEVER live status\n\n**Ownership only — full schema, write rules, and seed law live in\ntriage.md §Duty T6** (lens B-F10 v0.4.96 cross-role move; A-M1 v0.4.116\npointer collapse — this file no longer restates the field list). Scope here:\nthe registry answers \"who exists and which version are they on\"; discovery\nanswers \"who is alive right now\".\n\n- **LIVE STATUS IS NEVER STORED:** whenever liveness or freshness matters,\n  DISCOVER i","s":true}] -->
<!-- reasoning -->
Let me continue reading hq.md for Duty 6 and the review cycle structure.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md","o":"   gap is stronger signal than any single proposal — merge them into one rule.\n- **Checkable Completion Formula**: `DONE = poll fanout dispatched + submissions read from reviews/<cycle-id>/proposals/ and oc-ledger events --kind proposal + verdict recorded in review state.`\n\n## Duty 5 — Procedure rulings (decision 6)\n\nOn protocol disputes — role boundaries, exception clauses, gate semantics —\nHQ issues BINDING rulings, each logged as an event entry in\n`workers-ledger.json` (`rulings`) with evidence and reasoning. Owner veto\noverrides retroactively. Precedents: ROLE_EXCEPTION #1 waived-once,\ncondition-2 unevidenced; fabrication deviation #3 processing + P1/P2 routing;\nRULING-CORRECTION #1: PR-open denial ruling was overturned by consent msg\nfound in-topic AFTER issuing — lesson lives in SKILL.md §CONSENT REGISTER\n(deploy gate retired 2026-08-28; the lesson survives for NON-deploy ruling\ndiscipline: never deny from codified text without checking the live record).\n- **Checkable Completion Formula**: `DONE = ruling reasoning recorded in workers-ledger.json rulings event + notification delivered to involved lanes via session_notify.`\n\n## Duty 6 — Periodic subagent skill review\n\nCadence: after every FIVE shipped version bumps, on owner request, or when an\nincident suggests drift.\n\nMethod:\n0. **Cycle State Durability & Step-0 Recovery** (v0.4.170, owner order 2026-09-13):\n   Every Duty 4+6 cycle maintains a machine-readable state file at `reviews/<cycle-id>/state.json` (under `$OC_DEV_STATE`).\n   Schema:\n   `{ \"cycle_id\": \"<id>\", \"cadence\": \"<cadence-string>\", \"started_at\": \"<ts>\", \"status\": \"IN_PROGRESS|COMPLETED\", \"proposals\": [...], \"lenses\": { \"<lens>\": { \"status\": \"PENDING|COMPLETED\", \"report_path\": \"...\", \"verdict\": \"...\" } }, \"codification_plan\": [...], \"updated_at\": \"<ts>\" }`\n   Before spawning reviewers or codifying findings, HQ initializes `state.json`.\n   **Step-0 Recovery Mandate:** After ANY context compaction or session restart during Duty 4+6, HQ must first c","s":true}] -->
<!-- reasoning -->
Now I have the key law: `reviews/<cycle-id>/state.json` schema, initialized by HQ. And report corpus location `reviews/<cycle>/reports/` (I-5.1). And index log precedence.

Now let me check the 20260918-cycle: it has only reports/ with two files, NO state.json. That's a candidate finding: a cycle dir created 2026-09-18 but no state.json. But wait — the law says "Every Duty 4+6 cycle maintains a machine-readable state file at reviews/<cycle-id>/state.json". Was 20260918-cycle a Duty 4+6 cycle? It was created during the fleet-directives split work, holding two reports. Hmm.

Also the 20260919-cycle has state.json but empty reports/ (reports dir exists, empty).

Let me check the content of the relevant files: 20260918-cycle reports, 20260919-cycle/state.json, and the index logs.

Also need to check: is there a law requiring `reviews/<cycle>/reports/` to contain the reports named `skill-review-<lens>-<date>.md`? The lens catalog says "durable reports live in reviews/<cycle>/reports/".

Let me read the two 20260918 reports and the 20260919 state.json.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260918-cycle/reports/lens-B-redundancy-20260918.md","o":"# Lens B — redundancy — 2026-09-18\n\n> Recovered from sub-agent session `01bbc6db-37ed-47b6-b4a6-ee9342a7dd41` (report never delivered;\n> session ended 2026-09-18T22:46:09Z). Raw 256334 chars, 25470 after stripping harness comment blocks.\n\nI'll start by reading my lens brief and surveying the directory.\n\n\nNow let me read the target file in full. I'll chunk it.\n\n\n\\n## Remotes &\",\"s\":true}] -->\n\n\nThe output truncates. Let me read in smaller chunks. I'll grab several chunks in parallel.\n\n\nLet's read further chunks of `fleet-directives.md`. I can read lines 240-400, 400-560, 560-720, 720-803.\n\n\nLet's read lines 400-803.\n\n\nLet's read lines 500-803 in chunks.\n\n\n|Queues| R2[\\\"Carrier Build 2 (Pending on B)\\\"]\\n    E3[\\\"Editor 3 (Push C)\\\"] -->|Replaces Pending| R3[\\\"Carrier Build 3 (Pending on C)\\\"]\\n    R1 -->|Build 1 Finishes| S1[\\\"Swap A to Host\\\"]\\n    R3 -->|Build 3 Finishes on C| S2[\\\"Swap C to Host (Coalesced B+C)\\\"]\\n    S2 -.->|Ancestry Match| ACK2[\\\"Editor 2 Acknowledged (B in C)\\\"]\\n    S2 -.->|Direct Match| ACK3[\\\"Editor 3 Acknowledged (C)\\\"]\\n```\\n\\n## Features-compat gate — no silent feature-loss swaps (HQ ruling 2026-09-04, MANDATORY) [LANE]\\n\\n`oc-deploy swap-execute` **refuses** any artifact whose feature set drops a feature present in `deployed.meta.json` (exit 4, journal `features-drop-gate`, markers untouched) unless the operator passes `--allow-features-drop` explicitly. Feature *additions* pass freely; *drops* are the failure class. Enforced in-code (selftest 17p/17q). Rationale: the 06:36:06Z rogue swap (run `33844429519`, `features=\\\"telegram\\\"` over a live `telegram,code-graph` binary) killed structural memory for 12h — and the 18:57Z f3c03269 swap was the same class (no-tests artifact, auto-consumed). The gate would have refused both.\\n\\n## Carrier hotfix gates are build-no-tests — expect BASE-FAULT REDs (harvest, A3 lane 2026-09-03)\\n\\nA green main gate does **not** prove a test-GREEN base: carrier hotfix gates run build-no-tests, so a lane whose ","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md","o":"# Lens S — staleness-archaeology — 2026-09-18\n\n> Recovered from sub-agent session `1f2be5e3-76e1-4dd9-970d-74d01b854520` (report never delivered;\n> session ended 2026-09-18T22:46:09Z). Raw 262798 chars, 62958 after stripping harness comment blocks.\n\n\\n## Remotes &\",\"s\":true}] -->\n\n\n\\n## Remotes &\",\"s\":true}] -->\n\n\n\\n## Swap-head signature for rebase/synthesis/merge-derived binaries (owner 2026-09-03 \\\"Land 1+2 only, keep version as-is\\\")\\n\\nGate 4 (Session-Id trailer, `quick-build-linux.yml` ORDER gates) applies to every swap head. **Rebase, synthesis and merge heads cannot carry trailers**, so a bare (unsigned) head must never be dispatched to the build leg (2026-09-03: bare merge `d02f4e08` passed pr-checks GREEN, swap blocked exit 2 pre-install; fixed forward-only with empty marker `1d0dd4cc`. 2026-09-11: the atomic cutover head `12d25260` hit the same wall — `oc-order-validate: UNSIGNED`, chain rc 6 — and stranded main undeployed until marker `70b04864` was landed). **Every upstream sync produces such a head, so this recurs on every sync.** Standing law:\\n\\n1. **Marker, not waiver** — the marker-commit procedure (tree-identical empty trailer-signed commit before the build dispatch) lives in upstream-merge-runbook.md **step 9** — this file carries the RULING only: never dispatch a bare (unsigned) head, never loosen gate 4. Owner's swap ruling carries over; the marker changes no bytes.\\n2. **pr-checks mirrors gate 4 in swap mode** — `pr-checks.yml` (carrier branch `ci/quick-build-linux`, landed `464f77c4`) takes `swap=true`: runs the exact gate-4 regex on the gated ref before fmt/clippy/tests. Swap-mode GREEN ⇒ swappable — the build leg has no remaining semantic failure mode (clippy+tests subsume build success; the binary build itself stays quick-build's job, no duplicate artifact per the 2026-08-31 de-dup ruling). Input-gated: ordinary PR-lane runs unchanged.\\n3. **Version stays put on merges/swaps** — merge-derived binaries ship with the tree's standing version;","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260919-cycle/state.json","o":"{\n  \"cycle_id\": \"20260919-cycle\",\n  \"cadence\": \"15/5 FIRE (boundary n=6643)\",\n  \"started_at\": \"2026-09-19T04:09:54Z\",\n  \"status\": \"IN_PROGRESS\",\n  \"owner_order\": \"/goal run duty 6, no approval needed - run the lenses, validate and fix (2026-09-19)\",\n  \"proposals\": [],\n  \"lenses\": {\n    \"A\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"B\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"C\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"D\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"E\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"F\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"G\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"H\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"I\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"J\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"brain-scrub\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    }\n  },\n  \"codification_plan\": [],\n  \"updated_at\": \"2026-09-19T04:09:54Z\"\n}","s":true}] -->
<!-- reasoning -->
Now, key observation: `reviews/20260918-cycle/` has NO state.json. The law (hq.md Duty 6 step 0) says: "Every Duty 4+6 cycle maintains a machine-readable state file at `reviews/<cycle-id>/state.json` (under `$OC_DEV_STATE`)."

But wait — was 20260918-cycle a Duty 4+6 cycle? It holds two lens reports from the fd-split work. Hmm. The brief says "on 2026-09-18 fleet-directives.md was SPLIT and a new cycle dir reviews/20260918-cycle/ was created holding two reports from that work (lens-B-redundancy-20260918.md, lens-S-staleness-archaeology-20260918.md). Note lens S is NOT a catalog lens."

So the 20260918-cycle is a cycle dir that lacks state.json. That's a finding: the law requires state.json in every cycle dir. But is it a Duty 4+6 cycle? It's named `<cycle-id>` with reports/. Hmm, I should be careful — I need to quote the law. The law says "Every Duty 4+6 cycle maintains a machine-readable state file at reviews/<cycle-id>/state.json". If 20260918-cycle isn't a Duty 4+6 cycle, the law doesn't bind. It contains lens reports, which are Duty 6 artifacts. So arguably it is.

Hmm, but there's also the possibility that 20260918-cycle is not a "cycle" per se but a directory created ad-hoc during the split work. Let me check the CHANGELOG and hq.md for the split and cycle dir conventions. Let me look at CHANGELOG.md top entries.

Also: the reports are named `lens-B-redundancy-20260918.md` and `lens-S-staleness-archaeology-20260918.md`, whereas the corpus convention is `skill-review-<lens>-<date>.md` (persisted by oc-review-persist) or `lens-<X>.md` in the report dir. And lens S is not a catalog lens — it's a one-off lens.

Let me check oc-review-persist tool to see the LENSES list and the naming/verification law.

Also, the reports contain a header note "Recovered from sub-agent session ... report never delivered". Interesting.

Let me now look at the root index log and cycle-local index logs to find divergence, and check the "reviews/skill-review-index.log" (root) vs cycle-local.

Let me read the root index log.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/skill-review-index.log","o":"2026-09-06T04:43:56Z|deletion-safety|/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/skill-review-deletion-safety-20260906.md|62fce251c6a369544845ffe0daf29c22ac6d3bf5f55f59e2895fa15b399e3474|2189\n2026-09-06T04:43:56Z|G|/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/skill-review-G-20260906.md|8fdd849a0a0d2a5ef4e3a965198a3d8389f99f93801439fa9f48fa0c6e614080|4440\n2026-09-06T04:50:59Z|E|/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/skill-review-E-20260906.md|155c8acd9398e1684a04e5f7bbe5416eb7c7adce0398ec1154966e5bd8289a70|3117\n2026-09-06T04:57:56Z|C|/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/skill-review-C-20260906.md|d7f2a3730ee439281d4232a23eae3f52839198abe93521454c50297896d6e0b9|5510\n2026-09-06T05:04:41Z|brain-scrub|/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/skill-review-brain-scrub-20260906.md|971f362029ed9e224bc7be4b6ae12c52d8a03f0a88432cc46b8580e9693ecd3a|2784\n2026-09-06T05:10:20Z|F|/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/skill-review-F-20260906.md|944bf957fbfbc7a28b51adac4a701e5446048375c731313c8d18b6fbf886e4fd|4827\n2026-09-06T05:30:34Z|B|/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/skill-review-B-20260906.md|d804a804fcafcc9fc33f23ad5cd077f2d0a97211e6176b65a3b4059cb21a6dce|5175","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260919-cycle/reports","o":"Path is not a regular file: /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260919-cycle/reports (directory) — file tools read regular files only; devices, pipes and directories are not readable","s":false}] -->
<!-- reasoning -->
The root index log has 7 entries from 2026-09-06, pointing at files under reviews/ root. Per I-5.1, durable reports live in reviews/<cycle>/reports/, and "when two skill-review-index.log files diverge, the CYCLE-LOCAL index wins over the root one." So the root index log is a legacy/divergent artifact.

Let me check the cycle-local index logs to see the divergence, e.g. 20260915-c17/reports/skill-review-index.log.

Also, let me check oc-review-persist tool to see where it writes the index and what the LENSES are.

Let me look at tools/oc-review-persist.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Glob oc-review-persist*","o":"Found 1 files matching 'oc-review-persist*':\n\n  oc-review-persist\n","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260915-c17/reports/skill-review-index.log","o":"File not found: /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260915-c17/reports/skill-review-index.log","s":false}] -->
<!-- reasoning -->
Interesting: the earlier `ls` showed `20260915-c17/reports/` containing cohort1-docs.md, cohort2-tools.md, cohort3-artifacts-meta-brain.md, skill-review-index.log. But the read says file not found. Hmm — maybe the ls listing I saw for 20260915-c17 was under skills/... wait. Let me re-check. In the skills reviews listing:

```
20260915-c17/
  reports/
    cohort1-docs.md
    cohort2-tools.md
    cohort3-artifacts-meta-brain.md
    skill-review-index.log
  state.json
  verdict.md
```

Hmm, that was the skills dir listing. Wait no — look again. The skills/reviews listing showed:

20260915-c17/ → verdict.md (only)
20260915-c18/ → reports/ (empty), state.json, verdict.md

Wait, let me re-read. In the FIRST listing (skills/reviews):

```
20260915-c17/
  /root/.../skills/opencrabs-dev/reviews/20260915-c17:
  verdict.md
20260915-c18/
  /root/.../skills/opencrabs-dev/reviews/20260915-c18:
  reports/
  state.json
  verdict.md
```

And in the SECOND listing (state dir reviews), 20260915-c17 has reports/ with cohort files + index log, state.json, verdict.md.

So both dirs exist: skills/.../reviews/20260915-c17/verdict.md AND state/.../reviews/20260915-c17/reports/... So there are TWO reviews trees! One under the skill dir (skills/opencrabs-dev/reviews/) and one under the state dir (opencrabs-dev/reviews/).

Hmm wait, the task says "Root: /root/.opencrabs/profiles/ops/skills/opencrabs-dev/". But hq.md says state.json lives under `$OC_DEV_STATE`. And the state dir is `/root/.opencrabs/profiles/ops/opencrabs-dev/`. So there's `$OC_DEV_STATE/reviews/` = `/root/.opencrabs/profiles/ops/opencrabs-dev/reviews/`.

Hmm, so the reviews corpus has migrated from the skill dir to the state dir. That's a big deal. Let me verify by checking `$OC_DEV_STATE`.

Let me find OC_DEV_STATE. Let me grep for OC_DEV_STATE in the skill files.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'OC_DEV_STATE' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:180:\n  178: Method:\n  179: 0. **Cycle State Durability & Step-0 Recovery** (v0.4.170, owner order 2026-09-13):\n>    Every Duty 4+6 cycle maintains a machine-readable state file at `reviews/<cycle-id>/state.json` (under `$OC_DEV_STATE`).\n  181:    Schema:\n  182:    `{ \"cycle_id\": \"<id>\", \"cadence\": \"<cadence-string>\", \"started_at\": \"<ts>\", \"status\": \"IN_PROGRESS|COMPLETED\", \"proposals\": [...], \"lenses\": { \"<lens>\": { \"status\": \"PENDING|COMPLETED\", \"report_path\": \"...\", \"verdict\": \"...\" } }, \"codification_plan\": [...], \"updated_at\": \"<ts>\" }`\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:119:\n  117: ### Duty 4+6 Review Cycle 20260916-c20 Master Codification\n  118: - **Changelog Ordering & Direction SSOT**: Reconciled all documentation (`README.md`, `SKILL.md`, `hq.md`) to reflect the true newest-first prepended convention and updated sync policy references to the REBASE sync model.\n> - **Portability & Path Sanitization**: Replaced hardcoded `/root/` path fallbacks with `${OC_DEV_STATE:-$HOME/.opencrabs/profiles/ops/opencrabs-dev}` and dynamic `$HOME` paths across 16 CLI tools (`oc-attrib`, `oc-commit`, `oc-deploy`, `oc-drift-check`, `oc-health`, `oc-ledger`, `oc-order-validate`, `oc-ping-proof`, `oc-prchecks`, `oc-seal-state`, `oc-shadow-rotate`, `oc-ship-audit`, `oc-ship-chain`, `oc-smoke`, `oc-smoke-evidence`, `oc-tg-audit`).\n  120: - **Battery Test Parallel Optimization**: Defaulted `tools/tests/run.sh` to parallel chunk execution (`JOBS=$(nproc 2>/dev/null || echo 4)`), cutting suite execution time.\n  121: - **Smoke Schema Standardization**: Standardized `oc-smoke` verdict rows to use canonical keyed schema tokens (`issue=`, `sha=`, `run=`, `target=`, `actor=`, `evidence=`) matching `RC-CONTRACT.md`.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-seal-state:43:\n  41: trap 'oc_log_finish $?' EXIT\n  42: \n> BASE=\"${OC_BASELINE:-${OC_DEV_STATE:-$HOME/.opencrabs/profiles/ops/openc","s":true}] -->
<!-- reasoning -->
There is a HEALTH-CHECKS.md tool doc that enumerates artifact classes with SAFE/QUARANTINE/etc. This is very relevant to my lens (deletion safety of artifacts). Let me read tools/HEALTH-CHECKS.md fully.

Also the CHANGELOG mentions a "state split" post-v0.4.60 — the state dir moved to `$OC_DEV_STATE`.

Let me read HEALTH-CHECKS.md.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/HEALTH-CHECKS.md","o":"# HEALTH-CHECKS.md — hourly fleet health & cleanliness\n\n**Owner order 2026-09-11.** Toolsmith owns the cleanup/health process. This file\nis the operational runbook and remediation catalog mechanized by `tools/oc-health`\n(see `tools/HEALTH-CLASSES.md` for the 8-class architecture and CLI contract).\n\n**Primary rule (owner):** *workers clean after themselves.* A lane that leaves\ndebris behind owns that debris. This process exists to (a) catch mechanical\ndebris automatically, and (b) **warn** on quirks — not to silently tidy up\nafter sloppy lanes and hide the pattern.\n\n**Discipline for every check below:**\n- **Report first, remediate only the SAFE class.** Safe = provably dead\n  (age > threshold AND no live owner). Never delete anything a live lane may\n  still hold; never delete evidence (see *Never touch* at the end).\n- **Warn, don't silently fix, on the QUIRK class** — a lane leaving debris is a\n  process signal; the health check names the lane/object, it does not erase the symptom.\n- **Every remediation prints a receipt line** (what, count, bytes freed). A\n  cleanup with no receipt is indistinguishable from a no-op.\n- **Idempotent:** running twice in succession must be a no-op the second time.\n\n---\n\n## 1. Stale fanout & wave locks — `SAFE` (reap) + `QUIRK` (warn)\n\n- **Where:** `$OC_DEV_STATE/fanout.<runid>.lock` (legacy `fanout.lock.<runid>` still swept), `$OC_DEV_STATE/run/wave-*.lock`\n- **Content:** `pid=<n> ts=<ISO> run=<n>`\n- **Invariant:** Lock age >24h **and** associated PID dead (`kill -0`), or recorded run completed.\n- **Remediation (`--reap`):** Remove stale lock; report `reaped N locks`.\n- **Quirk form:** A lock whose PID is active but age >24h $\\to$ warn, do not reap.\n\n## 2. Orphaned / unregistered worktrees — `SAFE` (report) + `QUIRK` (warn)\n\n- **Where:** `git -C ~/opencrabs worktree list` vs `/root/oc-wt-*` + `/root/oc-work/*`\n- **Invariant:** Count registered worktrees vs directories on disk. Flag directories\n  with no registration (crashed `oc-wt remov","s":true}] -->
<!-- reasoning -->
Excellent. HEALTH-CHECKS.md is a key law. It says "Never touch (evidence / live state): workers-ledger.json itself, tools.log, journal/, incident-evidence-*, reviews/, designs/, smoke-verdicts.log, orders.json, baseline.json."

And check 3: "Ledger backups — SAFE (prune old, keep newest N)". Where: `$OC_DEV_STATE/workers-ledger.json.bak.*`, `*.corrupt-*.bak`, `*.20*.bak`.

Interesting: the `.bak` files I saw are like `291-smoke-state.md.2026-09-18T040237.bak`, `harvest-registry.json.bak-325-...`, `smoke-verdicts.log.bak-oc226`, `sync-cutover-state-20260918.md.2026-09-18T014153.bak`. These are state-dir artifacts. Note the glob patterns in HEALTH-CHECKS §3 are about ledger backups specifically. But smoke-verdicts.log is in the "Never touch" list — so its .bak is arguably evidence.

Hmm, but my scope per the brief is: "artifacts, state, ledgers and flags produced by the skill AS THEY ARE NOW (post-split, 2026-09-19). Root: /root/.opencrabs/profiles/ops/skills/opencrabs-dev/. Look at: reviews/** (cycle dirs, state.json files, report corpora, index logs), the state dir (workers-ledger.json, journals, markers, locks, tools.log), CHANGELOG.md, war-stories.md, and any artifact a law says must exist."

So the state dir IS in scope. Good.

Now, there are MANY artifacts. I need to prioritize and give a bounded set of findings with verbatim law quotes. Max 6000 chars. So maybe 6-10 findings.

Let me identify the strongest candidates:

1. **`reviews/20260918-cycle/` has no `state.json`** — hq.md Duty 6 step 0: "Every Duty 4+6 cycle maintains a machine-readable state file at `reviews/<cycle-id>/state.json`". KEEP-required? Actually it's a MISSING artifact — the law says it must exist and it doesn't. My family is the deletion owner gate but the brief says: "Ask of each: does the law say it must exist and does it exist; is it orphaned; is it safe to delete?" So a missing law-required artifact is a finding (HIGH).

2. **`reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md`** — lens S is NOT a catalog lens. The lens catalog enumerates A–J + brain-scrub. hq.md step 1: "one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub)". So lens S is outside the catalog → an orphaned/unregistered report. Hmm, but is there a law forbidding it? The lens census anti-rules: "no lens-per-incident (incidents become rules/proposals, not lenses); no auto-growth." That's a law I can quote for lens S! "Anti-rules: no lens-per-incident (incidents become rules/proposals, not lenses); no auto-growth."

Hmm, but careful: is lens S a "lens"? The report is named lens-S-staleness-archaeology. The brief says "Note lens S is NOT a catalog lens." So yes.

But hold on — a deletion verdict on a report requires the governing law. The governing law for reports is the corpus law (I-5.1) and the catalog enumeration. Hmm.

3. **Report naming**: `lens-B-redundancy-20260918.md` vs the convention. The corpus law says durable reports live in `reviews/<cycle>/reports/`. Naming isn't strictly mandated in the quoted text. Hmm.

4. **`reviews/20260919-cycle/reports/` is empty** — but state.json exists and status is IN_PROGRESS. Not a finding (cycle in progress). Actually it's fine.

5. **Root `reviews/skill-review-index.log`** — diverges from cycle-local. Law: I-5.1 "when two skill-review-index.log files diverge, the CYCLE-LOCAL index wins over the root one." So the root index log is non-authoritative. But is it deletable? Hmm. Need care.

6. **`reviews/inbox/`** (20260907-duty6-lens-*.md) — orphaned? Need a law.

7. **Root-level reports `reviews/skill-review-B-20260906.md` etc.** — these are referenced by the root index log (2026-09-06 entries). Per I-5.1 the durable corpus is reviews/<cycle>/reports/. So root-level reports are legacy. Hmm.

8. **`run/` wave locks and `.sent`/`.targets`** — HEALTH-CHECKS §1: `$OC_DEV_STATE/run/wave-*.lock` — "Lock age >24h AND associated PID dead, or recorded run completed" → SAFE reap. So the wave-*.lock files in run/ are covered. But the `.sent` and `.targets` files are not covered by any check → orphaned?

Hmm, actually wait. The `run/` dir is under skills/opencrabs-dev/run/, not $OC_DEV_STATE/run/. Hmm: `/root/.opencrabs/profiles/ops/skills/opencrabs-dev/run/`. HEALTH-CHECKS says `$OC_DEV_STATE/run/wave-*.lock`. $OC_DEV_STATE = /root/.opencrabs/profiles/ops/opencrabs-dev. So the run/ dir under the SKILL dir is a different location! Let me check whether $OC_DEV_STATE/run/ exists.

Actually wait — hmm. Is it possible the skill dir IS the state dir historically? No. Let me check.

Let me check if /root/.opencrabs/profiles/ops/opencrabs-dev/run exists.

Also, note that HEALTH-CHECKS §6 says the shared skill repository is `/root/.opencrabs/profiles/ops/skills/opencrabs-dev` and "git status --porcelain must be clean of unexpected untracked/modified files."

So the `run/` dir inside the skill dir (untracked?) is a candidate finding — debris in the shared skill checkout. Let me verify with .gitignore.

Let me check the skill repo .gitignore and git status... but I can't run git (no shell). I can read .gitignore.

Let me look for .gitignore in skill dir.

Actually the ls didn't show a .gitignore in the skill dir root (show_hidden was true, and no .gitignore listed at root of skills/opencrabs-dev). Hmm, wait, the top-level ls with show_hidden didn't show .gitignore. So run/ and reviews/ may be tracked or untracked.

Hmm, let me focus. Let me check what's in the skill repo git index? I can't run git. But I can check .git/info/exclude or .gitignore.

Let me read /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.gitignore — doesn't exist per ls. Let me check the state dir .gitignore (exists, 7 bytes).

OK. Let me gather more targeted evidence. Priorities:

A. state.json missing in 20260918-cycle (law: hq.md Duty 6 step 0).
B. lens-S report — non-catalog lens (law: hq.md step 1 enumeration + anti-rule "no lens-per-incident").
C. Root reviews/skill-review-index.log + root-level skill-review-*.md reports (law: I-5.1 corpus + precedence).
D. run/ wave locks & .sent/.targets markers (law: HEALTH-CHECKS §1).
E. fd-split-20260918/ working dir (blocks/parts/__pycache__) — scratch artifacts, law? Maybe HEALTH-CHECKS §6 shared-checkout cleanliness.
F. `.bak` backups in state dir (law: HEALTH-CHECKS §3).
G. `reviews/inbox/` orphan.
H. Empty cycle dirs: 20260909-cycle/ (totally empty), 20260915-c18/reports/ (empty).
I. Old cycle dirs with duplicate report naming (20260915-c13 has reports in both cycle root AND reports/).

Let me verify a few of these. Let me check the git status indirectly — maybe there's a .gitignore in state dir and skill dir.

Let me read state dir .gitignore.

Also let me check the SKILL.md for laws about the reviews corpus and "artifact a law says must exist".

Let me grep SKILL.md for "reviews/" and "artifact".

Actually, let me read SKILL.md — it's 46882 bytes, ~600 lines. Let me grep for key terms first.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'reviews/|artifact|ledger|state dir|index\\.log' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"No matches found for pattern: 'reviews/|artifact|ledger|state dir|index\\.log'","s":true},{"d":"Read ~/.opencrabs/profiles/ops/opencrabs-dev/.gitignore","o":"*.lock","s":true}] -->
<!-- reasoning -->
The state dir .gitignore contains `*.lock`. So lock files in state dir are gitignored.

Hmm, SKILL.md grep returned no matches — odd. Maybe the grep pattern with `|` needs regex=true. Let me redo with regex.

Let me grep SKILL.md with regex=true.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'reviews/|artifact|ledger|index\\.log' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:6:\n  4:   OpenCrabs source ops (~/opencrabs): roles EDITOR (fork issues, per-task\n  5:   worktrees, CI gate (pr-checks), signed commits, push + sha hand-off, oc-deploy ship,\n>   smoke-test-on-notify, upstream PR), HQ (skill set + worker ledger),\n  7:   TRIAGE (interrupt lane: idea/QUIRK intake, fix routing, enforcement — carved out of HQ at v0.4.86),\n  8:   TOOLSMITH (CLI tool lane: owns tools/ — makes and fixes the CLI tools every other role uses — carved out at v0.4.87); the Compiler role is retired — re-enable trigger in STEP ZERO).\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:9:\n  7:   TRIAGE (interrupt lane: idea/QUIRK intake, fix routing, enforcement — carved out of HQ at v0.4.86),\n  8:   TOOLSMITH (CLI tool lane: owns tools/ — makes and fixes the CLI tools every other role uses — carved out at v0.4.87); the Compiler role is retired — re-enable trigger in STEP ZERO).\n>   Use when editing/fixing OpenCrabs Rust code, debugging quick-build-linux carrier or other CI runs, fetching CI artifacts, or swapping /usr/local/bin/opencrabs.\n  10:   (/opencrabs-dev)\n  11: globs:\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:51:\n  49: |------|------|----------------|\n  50: | **EDITOR** | Commits + error fixes: claim issue → worktree → code → CI gate → sign → push → ff-merge into fork `main` → `oc-deploy ship` → smoke on notify; feature COMPLETE → upstream PR filed on smoke PASS (procedure `editor-upstream-pr.md` Phase 7) | `editor.md` |\n> | **HQ** | Skill set maintenance, worker ledger, Duty 4 worker polls, Duty 6 periodic 11-lens reviews (details in `hq.md` and `review-lenses.md`) | `hq.md` |\n  52: | **TRIAGE** | Intake & hygiene: issue assignment, repo hygiene patrols, rebase/merge execution delegated from HQ, upstream lifecycle tracking (delta watch, PR census, dependency tracking folded from Harvester v0.4.176) | `triage.md` |\n  53: | **TOOLSMITH** | CLI tools author & maintainer: ","s":true}] -->
<!-- reasoning -->
I need to find the law about the reviews corpus and the skill scope. Let me look at SKILL.md §Hard rules which likely lists the skill file census. Let me read SKILL.md around lines 30-100 and the Hard rules section.

Actually, more efficient: grep for "reviews" case-insensitively in all skill .md files with regex.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'reviews/' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:65:\n  62:   triage.md §Duty T1. You propose; Triage ACKs, stamps the ledger, and routes.\n  63: - Duty 4 Skill Review Proposals (owner order 2026-09-11): When HQ broadcasts a Duty 4 poll,\n  64:   do NOT send proposals via `session_notify` to HQ. Write your proposal directly to disk at\n>   `~/.opencrabs/profiles/ops/opencrabs-dev/reviews/<cycle-id>/proposals/<session-uuid>.md`\n  66:   or append to the ledger via `oc-ledger stamp proposal \"ADD|CHANGE <rule> in <file+section> BECAUSE <evidence>\"`.\n  67: - Tool PROBLEMS (QUIRK:) → the active **TOOLSMITH** lane directly (v0.4.130 Direct Dispatch Law; v0.4.133):\n  68:   `session_notify` (target resolved dynamically — `oc-ledger roster --live --role toolsmith`, never a uuid from memory),\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:132:\n  129: Workers do NOT submit Duty 4 proposals via `session_notify` to HQ. Inbound notify\n  130: floods pollute HQ's context window, accelerate context compactions, and duplicate\n  131: the freeze-ACK anti-pattern. Workers write proposals directly to disk in the\n> cycle review directory (`~/.opencrabs/profiles/ops/opencrabs-dev/reviews/<cycle-id>/proposals/<session-uuid>.md`)\n  133: or record them onto the ledger via `oc-ledger stamp proposal \"ADD|CHANGE <rule> in <file+section> BECAUSE <evidence>\"`.\n  134: \n  135: 1. Live roster FIRST (`session_search` / `oc-ledger roster --live`, same turn).\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/hq.md:158:\n  155: 5. Consolidated verdict table to the owner; ships ONLY on his word.\n  156: 6. Convergence beats volume: several workers burning independently on the same\n  157:    gap is stronger signal than any single proposal — merge them into one rule.\n> - **Checkable Completion Formula**: `DONE = poll fanout dispatched + submissions read from reviews/<cycle-id>/proposals/ and oc-ledger events --kind proposal + verdict recorded in review state.`\n  159: \n  160: ## Duty 5 — Pr","s":true}] -->
<!-- reasoning -->
I'm burning a lot of context. Let me be strategic. I have the key laws:

1. hq.md Duty 6 step 0: state.json per cycle under $OC_DEV_STATE.
2. review-lenses.md I-5.1: durable reports live in reviews/<cycle>/reports/; cycle-local index wins over root.
3. review-lenses.md anti-rules: no lens-per-incident.
4. hq.md step 1: one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub).
5. HEALTH-CHECKS.md: SAFE classes (fanout/wave locks, ledger backups, /tmp), "Never touch" list.
6. hq.md Duty 4: proposals dir path.
7. Rule-text provenance: CHANGELOG at ship time.

Now let me check specific artifacts to ground findings. Key checks:

(a) 20260918-cycle: no state.json. Confirm by ls. Already confirmed (only reports/ dir).

(b) lens-S report: is "S" a catalog lens? No. Law: hq.md step 1 enumeration.

(c) Root reviews/skill-review-index.log: 7 entries, 2026-09-06, pointing to root-level files. Law I-5.1 precedence.

(d) Root-level reports reviews/skill-review-*.md (2026-09-06) and reviews/2026-09-05-A-redundancy.md, reviews/inbox/*.

(e) Empty dirs: reviews/20260909-cycle/ (empty), reviews/20260915-c18/reports/ (empty), reviews/20260915-c17/reports/ (empty).

Wait — need to double check: in skills/reviews, 20260915-c17 has only verdict.md; 20260915-c18 has reports/ (empty) + state.json + verdict.md. Let me confirm 20260909-cycle is empty.

(f) run/ dir with wave locks. Is run/ under skill dir tracked? HEALTH-CHECKS says `$OC_DEV_STATE/run/wave-*.lock`. Let me check if $OC_DEV_STATE/run exists.

(g) fd-split-20260918/ — big scratch dir (blocks/, parts/, __pycache__, *.bin). Law: HEALTH-CHECKS §6 shared-checkout cleanliness (skill repo must be clean of unexpected untracked files). But is fd-split tracked? Hmm.

(h) The `.bak` files: HEALTH-CHECKS §3 covers `$OC_DEV_STATE/workers-ledger.json.bak.*` etc. The bak files present: harvest-registry.json.bak-*, smoke-verdicts.log.bak-oc226, 291-smoke-state.md.*.bak, sync-cutover-state-20260918.md.*.bak, 302-fast-follow-state.md.*.bak. These are not ledger backups, and smoke-verdicts.log is in "Never touch". Hmm.

(i) `.lock` files in state dir: host-swap.lock, ship.lock, tools.log.lock, workers-ledger.json.lock, .oc-prchecks-dispatch.lock, fanout.*.lock. HEALTH-CHECKS §1 covers fanout/wave locks. Note: `*.lock` is gitignored in state dir.

Given the 6000-char limit, I should pick ~6-8 high-value findings. Let me prioritize artifacts that are clearly law-governed:

1. HIGH: reviews/20260918-cycle/ missing state.json — law hq.md step 0 verbatim. Actually is this a "deletion" verdict? The brief asks deletion verdicts on orphaned artifacts, but also "does the law say it must exist and does it exist". So this is a MISSING law-required artifact → verdict KEEP (i.e., must be created). I'll phrase as KEEP/must-create.

2. HIGH: reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md — lens S not in the catalog (law hq.md step 1 + review-lenses anti-rule "no lens-per-incident"). Verdict: KEEP as evidence? Hmm. Actually the report is a legitimate recovered report. The finding is that it's an unregistered lens name. The deletion verdict: KEEP (reports/ is "never touch"), but flag naming/lens registration.

Hmm, careful: HEALTH-CHECKS "Never touch: ... reviews/". So reviews/ is never touched by the health cleanup. So DELETE verdicts on reviews artifacts are weak. But the brief explicitly asks me to give deletion verdicts on artifacts I find orphaned. Hmm. And the D brief says classify DELETE-SAFE / ARCHIVE / KEEP.

Wait, "Never touch" is about the health-check tool's remediation, not about a human/HQ deletion. Still, it's a law I can quote.

3. MED: root reviews/skill-review-index.log — divergent legacy index (law I-5.1: cycle-local index wins).

4. MED: reviews/20260909-cycle/ empty dir (law: state.json + reports required per cycle).

5. MED: run/ wave-*.lock + .sent/.targets markers (law HEALTH-CHECKS §1).

6. MED: fd-split-20260918/ scratch dir in skill repo (law HEALTH-CHECKS §6).

7. LOW: reviews/inbox/ orphan.

8. LOW: .bak debris (law HEALTH-CHECKS §3 pattern).

Hmm, I need to verify each. Let me do targeted checks efficiently:

- Confirm reviews/20260909-cycle empty and 20260915-c17/18 contents (skill dir).
- Check whether $OC_DEV_STATE/run exists (to decide if skill-dir run/ is the law's location).
- Check .gitignore / tracked status of run/ and fd-split in the skill repo. I can't run git, but I could check .git/info/exclude, or look for a .gitignore. Hmm, ls showed no .gitignore at skill root. Let me glob for .gitignore in skill dir.

Let me also check the oc-review-persist tool to see the LENSES list and where it writes (to confirm lens S isn't registered and the index path).

Let me do these in parallel.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist","o":"#!/usr/bin/env bash\n# =============================================================================\n# oc-review-persist — Duty-6 lens reports land on disk the moment they exist.\n# Born from the 2026-08-29 ghost incident + the 16:45Z \"all four persisted\"\n# correction: a report that lives only in session memory is NOT persisted.\n#\n# usage: oc-review-persist <lens> <text | @file | -> [--dir DIR]\n#   lens ∈ A-J + self + named lenses (see LENSES whitelist below)\n#          deletion-safety\n#   @file reads the report body from a file; - reads stdin; anything else is\n#         literal report text (quote it).\n#   DIR defaults to the I-5.1 CORPUS: reviews/<YYYYMMDD>-cycle/reports/ in the\n#   skill repo (cycle-local index.log - the one that wins on divergence).\n#   OC_REVIEW_DIR=/tmp restores the volatile fallback. Writes\n#   skill-review-<lens>-<YYYYMMDD>.md (same-day\n#   re-run OVERWRITES, noted in the file header) and appends ONE index line:\n#       skill-review-index.log:  ts|lens|path|sha256|bytes\n#   The index line is the receipt Duty-6/7 quote — no receipt, no \"persisted\".\n#\n# Exit codes: 0 persisted + re-read verified · 2 usage (bad lens/empty input)\n#   · 3 re-read sha256 mismatch (storage NOT trusted) · 4 write failure.\n#\n# usage: oc-review-persist check-cycle <cycle-dir> [--catalog DIR] [--strict-receipt]\n#   The Duty-6 CENSUS GATE (I-6.1 remedy 2, v0.4.162). \"Did every catalog lens\n#   run?\" is a pure function of state on disk, so it is a gate, not a reviewer's\n#   memory -- assigning it to a reviewer is agent-memory-as-gate-input, the exact\n#   defect class lens J exists to kill.\n#   Derives the expected lens set from the CATALOG AT GATE TIME: reviewer letters\n#   from review-lenses.md, standing lenses from the `## Review lens <name>`\n#   headings in fleet-directives.md. Hardcoding A-J + brain-scrub here would be\n#   the same rot class as the docs-only 21-path list -- the catalog moves, the\n#   gate must move with it.\n#   A deliberately-skipped lens is a DECISION,","s":true},{"d":"ls ~/.opencrabs/profiles/ops/opencrabs-dev/run","o":"Path does not exist: /root/.opencrabs/profiles/ops/opencrabs-dev/run","s":false},{"d":"Glob .gitignore","o":"No files found matching pattern: .gitignore","s":true}] -->
<!-- reasoning -->
Very important:
- `$OC_DEV_STATE/run` does NOT exist. The `run/` dir is inside the SKILL repo: `/root/.opencrabs/profiles/ops/skills/opencrabs-dev/run/`. HEALTH-CHECKS §1 says the wave locks live at `$OC_DEV_STATE/run/wave-*.lock`. So the skill-repo `run/` dir is NOT the location the law names → the run/ dir (with wave-*.lock, .sent, .targets) is at a non-canonical path → orphaned debris in the shared skill checkout.

Hmm wait, but maybe HEALTH-CHECKS's `$OC_DEV_STATE` was historically the skill dir? The CHANGELOG said "post-v0.4.60 state split". So the state dir was split out. The `run/` dir in the skill repo is likely leftover from before the split (or an accidental write). Let me verify: are wave-*.lock files recent? The ls showed wave-* files with no timestamps in the detailed listing? Actually the recursive listing didn't show sizes/times. Let me ls the run dir detailed.

Also, oc-review-persist: LENSES whitelist includes A-J + self + named lenses + deletion-safety. Let me see the LENSES variable. The output was truncated; let me grep for LENSES= in the tool.

Let me also confirm: `check-cycle` derives expected lens set from review-lenses.md reviewer letters + standing lenses from fleet-directives.md `## Review lens <name>` headings. So lens S would be "non-catalog".

Let me grep LENSES in oc-review-persist.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'LENSES=' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist:51:\n  48: if [ -f \"$_OC_LIB\" ]; then source \"$_OC_LIB\"; oc_log_init \"oc-review-persist\" \"$@\"; else oc_log_finish() { :; }; fi\n  49: trap 'oc_log_finish $?' EXIT\n  50: \n> LENSES=\" A B C D E F G H I J self redundancy-ontology efficiency-creep cli-automation deletion-safety brain-scrub \"   # E F G added v0.4.72; H (ledger health) v0.4.114; I (meta-review) v0.4.115; J (mechanical enforcement) v0.4.161 — whitelist var itself missed in v0.4.114 (message-only edit), fixed v0.4.115. F-6 v0.4.119: single letters A–J are now ENFORCED whitelist entries — adding a letter here is the only path to accepting it (previously the case-glob short-circuit made these 9 entries dead). v0.4.161: the case-globs in the dispatch below MUST widen in the same edit — a whitelist-only change leaves J accepted (via the *) arm) while J1 still dies on the stale [A-I][0-9] glob.\n  52: die() { echo \"oc-review-persist: $2\" >&2; exit \"$1\"; }\n  53: [ \"${1:-}\" = \"-h\" ] || [ \"${1:-}\" = \"--help\" ] && { echo \"usage: oc-review-persist <lens> <text | @file | -> [--dir DIR]\"; echo \"       oc-review-persist check-cycle <cycle-dir> [--catalog DIR] [--strict-receipt]\"; echo \"Exit: 0 persisted + re-read verified / 2 usage / 3 re-read sha-mismatch / 4 write-fail\"; echo \"      check-cycle: 0 census complete / 2 usage / 3 catalog underivable / 5 lenses missing (with --strict-receipt: unreceipted/unpersisted)\"; exit 0; }  # C-#3: help=0\n  54: \n\n(1 matches)","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/run","o":"     <DIR>  2026-09-18 13:57:02  t4-20260918T1322Z/\n     <DIR>  2026-09-18 16:59:53  t4-20260918T1700Z/\n     <DIR>  2026-09-18 20:13:18  t4-20260918T1944Z/\n      1036  2026-09-13 10:40:59  wave-04c5173aaa04.targets\n        74  2026-09-14 00:24:17  wave-20b1140d2aff.targets\n        32  2026-09-18 21:01:14  wave-230f0db95dea.lock\n      1036  2026-09-12 20:00:58  wave-2593ade96011.targets\n       518  2026-09-14 16:54:20  wave-2a69309c81ba.targets\n        32  2026-09-17 07:32:50  wave-36f9c396e0b6.lock\n        74  2026-09-17 07:35:33  wave-36f9c396e0b6.sent\n       111  2026-09-17 07:35:33  wave-36f9c396e0b6.targets\n        32  2026-09-17 08:09:33  wave-3c7a4460b03e.lock\n        37  2026-09-17 08:12:28  wave-3c7a4460b03e.sent\n        74  2026-09-17 08:12:28  wave-3c7a4460b03e.targets\n        32  2026-09-18 14:08:15  wave-50e7112a05cd.lock\n      1110  2026-09-18 14:43:28  wave-50e7112a05cd.sent\n      1110  2026-09-18 14:42:13  wave-50e7112a05cd.targets\n        32  2026-09-17 18:42:13  wave-571b09a0f2e2.lock\n        74  2026-09-16 14:04:11  wave-5c0792d39150.sent\n       111  2026-09-16 14:04:11  wave-5c0792d39150.targets\n        32  2026-09-18 20:29:59  wave-7b71e9ba0cfe.lock\n       333  2026-09-18 20:54:58  wave-7b71e9ba0cfe.sent\n       481  2026-09-18 20:56:14  wave-7b71e9ba0cfe.targets\n      1036  2026-09-13 09:44:51  wave-809e74a02813.targets\n      1036  2026-09-13 16:53:10  wave-8e40aea3d1e0.targets\n      1036  2026-09-13 08:52:42  wave-9857092b1d26.targets\n      1036  2026-09-12 21:34:33  wave-9fa8ff6abae3.targets\n      1036  2026-09-13 08:01:02  wave-a9561c346258.targets\n       222  2026-09-12 10:36:35  wave-bef2ecc3bd9f.targets\n       222  2026-09-16 00:27:49  wave-c31ab1cccd02.sent\n       259  2026-09-16 00:27:49  wave-c31ab1cccd02.targets\n        37  2026-09-16 18:47:21  wave-cdc1aec7c6d6.sent\n        74  2026-09-16 18:47:21  wave-cdc1aec7c6d6.targets\n        37  2026-09-16 11:35:39  wave-dd7f9a903b7d.sent\n        74  2026-09-16 11:35:39  wave-dd7f9a903b7d.target","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260909-cycle","o":"","s":true}] -->
<!-- reasoning -->
Confirmed:
- `run/` in the SKILL repo contains wave-*.lock/.sent/.targets from 2026-09-12 → 2026-09-18. HEALTH-CHECKS §1 names `$OC_DEV_STATE/run/wave-*.lock` as the location. But `$OC_DEV_STATE/run` doesn't exist. So either the health check looks in the wrong place (a tool defect, not my family) or the wave files are written to the skill repo (a writer defect). Either way, from MY lens: these wave-*.lock files sit in a location no law names, are up to 7 days old, and the law says locks >24h with dead PID are SAFE to reap. But I can't verify PIDs (no shell). So verdict: ARCHIVE/candidate-reap, needs HQ triple-check. I can quote the law.

Hmm, careful: my brief says "a zero-hit claim from a |-pattern grep in literal mode is UNVERIFIED — quote the query + scope for every negative-existence claim". So I should state my grep query and scope when claiming "no law names the skill-repo run/ dir".

- 20260909-cycle is empty (ls returned nothing). Confirmed empty dir.

- LENSES whitelist: " A B C D E F G H I J self redundancy-ontology efficiency-creep cli-automation deletion-safety brain-scrub ". No "S". So lens S is not in the persist whitelist → a report named lens-S-* could not have been persisted via the tool. Confirmed.

Now let me check the 20260918-cycle dir more carefully — is there really no state.json? And check for a proposals/ dir. And check whether the fd-split work is documented as creating this cycle dir. Let me check CHANGELOG for 20260918-cycle.

Also check war-stories.md (in scope) — it's small (15578 bytes, last modified 2026-09-11).

Let me look at CHANGELOG top and search for "20260918" and "cycle".

Also, I want to verify: does the 20260919-cycle state.json's cadence say "15/5 FIRE (boundary n=6643)" — fine.

Let me grep CHANGELOG for "20260918-cycle" and "reviews/".
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep '20260918|staleness-archaeology|lens S|lens-S' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:1007:\n  1003: - 1b dead paths (5): fanout journal path + editor brake path + shadow-log location repointed to the state dir (v0.4.60 migration residue — the brake doc armed NOTHING at the old path); 2 false \"archived at tools/archive/oc-consent-check\" claims corrected (archive holds only compiler.md; blob in git history).\n  1004: - 1d dead test-leg prose (4): test-ontology CODE TESTS cells repointed to pr-checks.yml as the ONLY test locus (carrier leg removed e71dba58); cargo flags made verbatim (`--locked --profile ci --all-features`) at SKILL.md UPSTREAM CI GATE + editor Phase 5 + Phase 6 comment.\n  1005: - 1a unmarked retired concepts (2): \"CI is the compiler\" present-tense -> CI-is-the-only-executor with Compiler RETIRED 2026-08-28 marker (x2).\n  1006: - class-2 unclear terms: NEW SKILL.md section \"Glossary — official terms\" (CI gate incl. legacy synonyms, ORDER gates, S2/S3, lane, roster, lens, selftest vs battery, GREEN/RED terminal truth); \"4-lens\" -> \"5-lens (A–E)\"; ontology-rule parenthetical now cites the real ontology terms; lint-gate name variants normalized.\n> - supervisor.md: Reviewer A lens STRENGTHENED (owner word same turn) with the churn-drift checklist: one-concept-one-name, glossary conformance, post-migration ROOT-literal path sweep, enumeration consistency, retired-concepts-marked.\n  1008: \n  1009: Docs-only; battery 97/0; sync+tag v0.4.62; mirrors at parity.\n  1010: \n  1011: ## v0.4.63 (2026-08-31) — sync payload root-fix (incident n=1405)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:1027:\n  1023: - **P2 docs:** tool-table rows corrected to real interfaces (oc-job-verify, oc-artifact-verify, oc-seal-state, oc-post-receipts, oc-deploy rc register, branch-sweep rc register); ship wording = dispatch confirmation, not GREEN+run-id; worktree recreate/teardown re-pointed at oc-wt in all six sites (raw-bypass closed; Phase 7 keeps its raw -b add but chains the UN-SKIP","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md","o":"# Changelog — opencrabs-dev\n\n## v0.4.205 (2026-09-18)\n\n- **Owner Push Freeze — the soak groups are held from upstream harvest; T6 released (owner order 2026-09-18 17:33Z, release 18:01Z)**: *\"freeze all these groups from pushing - I want to review them first and will release them later\"*, then *\"Telegram flow cluster T6 - release for harvesting\"*. New canonical section `fleet-directives.md §Owner Push Freeze — soaking groups held from upstream harvest` [LANE]. The frozen set is the group list the owner was reading in the delivered live-test plan (`/tmp/live-test-plan-2026-09-18.md`, board topic 30220, `msg=67358`): **18 T-groups (T1–T18) + 7 Tier-3 items**, of which **17 T-groups and all 7 Tier-3 items are frozen** and **T6 (Telegram flow cluster) is released**. Counts derived in python from the plan file, never by eye.\n  - **Release is an OWNER action, never a lane decision** — a group leaves the freeze only on an explicit owner message naming it, exactly as T6 did. Soak maturity elapsing, a green census, a lane's own confidence, or an idle editor release nothing. The released set currently holds exactly one member.\n  - **The freeze binds the machinery, not just the prose**: Triage's 4h harvest patrol (`oc-harvest-dispatch-4h`, job id `73158e43-3b04-4464-bf82-8d9065a191bb`) must not dispatch a frozen group; `oc-harvest-census` / `oc-harvest-dispatch` must read a frozen group as NOT harvest-eligible; a holder of frozen work stops short of Phase 7 (upstream PR filing).\n  - **Distinguished from the existing carrier FREEZE** (`§Remotes & sync` guard 2 — mechanical: no sync while a carrier chain sits between dispatch and swap). Same word, different concept; write **owner push freeze (harvest hold)** when you mean this one. **Scope boundary:** the freeze holds HARVEST, not development — fixes, commits, ships and smokes inside fork `main` continue normally; only the upstream push of a frozen group is withheld.\n- **Early Claim — claim at domain recognition, not at dispatch","s":true}] -->
<!-- reasoning -->
CHANGELOG has no mention of "20260918-cycle" or "lens S". So the 20260918-cycle dir and the lens-S report are NOT recorded in CHANGELOG. Note: hq.md Duty 1 requires CHANGELOG entry at ship time. But these are review artifacts, not rule changes.

Hmm, but wait: the fd-split work on 2026-09-18 — the split of fleet-directives.md — should have a CHANGELOG entry (it's a law restructure). Let me check: CHANGELOG v0.4.205 is top (2026-09-18). Is there an entry about the fd split? Let me grep CHANGELOG for "split".

Actually, hold on. Let me reconsider the brief's framing: "on 2026-09-18 fleet-directives.md was SPLIT and a new cycle dir reviews/20260918-cycle/ was created holding two reports from that work". So the split happened and the reports (lens B redundancy + lens S staleness-archaeology) were the evidence behind it. But the reports were "recovered from sub-agent session ... report never delivered; session ended 2026-09-18T22:46:09Z" — so they were recovered post-hoc.

So findings:
- The 20260918-cycle has no state.json (law requires it).
- The lens-S report is a non-catalog lens.
- The reports live in `reports/` but were not persisted via oc-review-persist (no index.log in that cycle dir) → no receipt. Law: oc-review-persist "The index line is the receipt Duty-6/7 quote — no receipt, no 'persisted'." And I-5.1: durable reports live in reviews/<cycle>/reports/. Also "A report on disk under a NON-canonical name (e.g. review-lens-B.md, the pre-tool convention) is UNPERSISTED, never 'missing'".

So `lens-B-redundancy-20260918.md` is a non-canonical name → UNPERSISTED per the tool's own words. That's a strong quote.

Now let me also verify: is there a `skill-review-index.log` in 20260918-cycle? ls showed only reports/ with two files. So no index.log, no state.json, no verdict.md. Compare with other cycles which have state.json + verdict.md + reports/skill-review-index.log.

Let me check the CHANGELOG for the fd-split entry to see if it's recorded (provenance law). grep "fleet-directives" and "split" near top.

Also I should check war-stories.md (in scope) briefly — is it referenced by a law as must-exist? SKILL.md says war-stories.md is disclosed v0.4.80. Fine, KEEP.

Let me also check `reviews/inbox/` and the root-level reports and `reviews/2026-09-05-A-redundancy.md`, `reviews/20260907-duty46/`, etc.

Given the char budget, let me settle on ~7 findings. Let me now verify a couple more things quickly:

1. CHANGELOG entry for fd-split (grep "split" / "fleet-directives").
2. The 20260918-cycle dir — confirm no state.json, no proposals, no index log (ls again).
3. reviews/inbox content + whether any law names it.
4. Root-level reviews/skill-review-*.md files.

Let me batch.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'split|SPLIT' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:135:\n  133: \n  134: - **Continuous Issue Relationship Linking Across Lifecycle (Owner Order 2026-09-16, `SKILL.md`, `fleet-directives.md`, `editor.md`, `triage.md`):**\n>   - Expanded the native issue linking mandate from harvest/creation to the entire issue lifecycle: whenever parent subsystem relationships, blocker dependencies, or child sub-issues are established, split, or discovered at ANY point in the lifecycle (issue creation, triage intake sweeps, in-flight editor implementation, task decomposition, or upstream PR staging), the lane identifying it MUST establish native links in the same turn via `gh issue edit <issue> --parent <parent-issue>` and/or `gh issue edit <issue> --add-blocked-by <blocker-issue>`.\n  136:   - Codified into `SKILL.md §Issue-first`, `editor.md §Phase 1 step 2`, `triage.md §Duty T5 step 5`, and `fleet-directives.md §Upstream-merge cadence`.\n  137: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:160:\n  158:   - Codified in `triage.md` Duty T5 and `fleet-directives.md §Zero-Ack & Dispatch Discipline` that Triage and patrol watchers MAY send a progress nudge via `session_notify` (`delivery.mode=\"turn-end\"`) to an active claim holder if expected deliverables have not arrived or progress has stalled beyond the patrol window.\n  159: - **Docs Family Codification (Cycle 20260916-c19, Findings A-6, B-3, G-1, A-9, A-10, G-4, A-2, A-11):**\n>   - **`editor-upstream-pr.md`**: Repaired text splice splitting PR lifecycle sentence.\n  161:   - **`editor.md`**: Mandated imperative `memory_search scope=\"external\"` exploration & DRY check before bugfixing in Phase 6-Fix loop; pruned manual plumbing commands.\n  162:   - **`triage.md`**: Fixed severed list item 6, mislocated `DONE = ...` formula in Duty T7, and dangling orphaned sentence in Retired Duties.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:439:\n  437:   - **Append-only shared log staging carve-out ","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260918-cycle","o":"     <DIR>  2026-09-18 23:09:46  reports/\n","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/inbox","o":"      2140  2026-09-07 12:49:57  20260907-duty6-lens-A.md\n      3471  2026-09-07 13:17:12  20260907-duty6-lens-B.md\n      2097  2026-09-07 12:51:21  20260907-duty6-lens-C.md\n      2239  2026-09-07 13:18:00  20260907-duty6-lens-D.md\n      1217  2026-09-07 12:51:22  20260907-duty6-lens-E.md\n      3068  2026-09-07 13:16:14  20260907-duty6-lens-F.md\n      1640  2026-09-07 12:50:42  20260907-duty6-lens-G.md\n","s":true}] -->
<!-- reasoning -->
Important: `run/ gitignored` (CHANGELOG v0.4.131). So run/ is intentionally gitignored — meaning the run/ dir in the skill repo is a known, sanctioned location? Hmm, "run/ gitignored" — so the skill repo's .gitignore has run/. But my glob for .gitignore found nothing in the skill dir... Let me check .git/info/exclude.

Actually the CHANGELOG says "run/wave-<id>.lock flock+pid+ts" — and "run/ gitignored". So the run/ dir is the canonical wave-lock location, and it's gitignored. But HEALTH-CHECKS §1 says `$OC_DEV_STATE/run/wave-*.lock`. Hmm — contradiction? Or maybe $OC_DEV_STATE's run/ is also used. Since $OC_DEV_STATE/run doesn't exist, the skill-repo run/ is the live one. So HEALTH-CHECKS §1's path may be stale (a defect). Hmm, this is a lens-J or lens-A matter, not deletion. But from my lens: the wave-*.lock files are orphaned per the §1 invariant (>24h, run completed). They're SAFE to reap per the law. But the law names a different path... I can still quote §1's invariant and note the path mismatch as a finding (MED).

Hmm, careful. Actually maybe the run/ dir path in the law is deliberately relative-ish. Let me not overclaim. I'll quote: "**Where:** `$OC_DEV_STATE/fanout.<runid>.lock` (legacy `fanout.lock.<runid>` still swept), `$OC_DEV_STATE/run/wave-*.lock`" and "**Invariant:** Lock age >24h **and** associated PID dead (`kill -0`), or recorded run completed." Then note: skill-repo run/ holds 41 files (locks/sent/targets) dated 2026-09-12..2026-09-18, and $OC_DEV_STATE/run does not exist. Verdict: DELETE-SAFE for the .lock files matching the invariant, ARCHIVE the .sent/.targets (no law covers them).

Hmm, but the brief says quote-or-no-finding; a deletion verdict on an artifact whose governing law I didn't quote isn't a verdict. For .sent/.targets I don't have a law → I should report them as uncovered (coverage gap) rather than a deletion verdict. Actually the .sent file IS named in CHANGELOG v0.4.131 LAW 8: "per-lane idempotency: run/wave-<id>.sent; DUPLICATE skips". So .sent has a law. And the wave-id = sha256(title+brief) first-12-hex; run/wave-<id>.lock flock+pid+ts. OK so run/wave-*.lock and run/wave-*.sent are law-named. The .targets isn't. 

Hmm — but this CHANGELOG text is a historical record, not live law. The live law would be in RC-CONTRACT.md or fleet-directives. Let me check tools/RC-CONTRACT.md for wave law.

Given budget constraints, let me now check the skill repo's git exclude for run/ and check RC-CONTRACT for wave. Actually, let me limit scope. I have enough for a solid report. Let me do a few final checks:

1. `.git/info/exclude` in skill repo (to confirm run/ ignored).
2. RC-CONTRACT.md grep for "wave" and "run/".
3. The 20260915-c17/c18 dirs in the SKILL repo (verdict.md only / empty reports) vs state repo.
4. reviews/2026-09-05-A-redundancy.md and 20260907-duty46/ (root-level legacy).

Let me batch these.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'wave|run/' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/RC-CONTRACT.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/RC-CONTRACT.md:29:\n  27: | oc-commit | 0 | 2 | 0 committed / 3 gate-fail / 4 git-fail / 5 comment-fail · **Defect #335 (2026-09-18, Toolsmith):** Issue-Ref derivation now reads `oc-ledger claim-ref <actor> --open` — a claim whose issue already carries a done/close row is RELEASED, and deriving the ref from it posted the implementation comment onto a FINISHED issue. rc 3 now also covers \"latest claim is CLOSED\"; an explicit `--issue <N>` still overrides. Selftest gains case 6b; negative control on the pre-fix tool fails it (`closed-claim derivation != 3`). |\n  28: | oc-deploy | 0 | 1 | 0 ok-noop / 2 rebase-gate-push-verify-rollback AND usage/validation diags (flag-validation `die 2`, e.g. poll `--wait` non-integer, `--notify-session` empty; ship rc-2 gate deaths carry machine-readable `OC_DEPLOY_GATE=<cause>` tokens: missing-sha / wait-plan-mode / notify-poll-only / rebase-needed / feature-mismatch / fetch-fail) AND ship FEATURE-DEFAULT explicit-mismatch (`--features` != deployed.meta.json, refused pre-dispatch; default path auto-adopts deployed set) / 3 retired / 4 stage-gate-launch + ship features-compat gate (silent feature-drop refused pre-dispatch; `--allow-features-drop` override) / 5 poll-wait-timeout + ship `--wait` timeout (ship --execute --wait N bounded-polls dispatched run: GREEN rc 0, timeout rc 5, terminal-RED rc 6; plan-mode `--wait` refuses rc 2) / 9 kill-file · `status [--json]`: inspects running binary vs on-disk target sha, uptime, and last-swap metadata; rc 0 running matches disk / rc 1 mismatch-or-unswapped / rc 2 usage · `contributors` verb RETIRED (rc 1 + loud pointer to `oc-attrib --contributors`) · **Carrier Build Coalescence & Ancestry Matching:** In GitHub Actions, carrier workflow `ci/quick-build-linux` uses `concurrency: group: quick-build-linux` (1 active, 1 pending; 3rd push cancels/replaces pending 2nd). `oc-deploy ship/poll` uses **ancestry-aware matching** (`git merge-base --is","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/.git/info/exclude","o":"# git ls-files --others --exclude-from=.git/info/exclude\n# Lines that start with '#' are comments.\n# For a project mostly in C, the following would be a good set of\n# exclude patterns (uncomment them if you want to use them):\n# *.[oa]\n# *~","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260915-c18","o":"     <DIR>  2026-09-15 15:10:12  reports/\n       271  2026-09-15 15:23:12  state.json\n      3022  2026-09-15 15:23:12  verdict.md\n","s":true}] -->
<!-- reasoning -->
OK. The `.git/info/exclude` is default (no run/ entry). Hmm, but CHANGELOG says "run/ gitignored". Maybe there's a .gitignore in the skill repo that I missed — the glob for `.gitignore` with base_dir skill dir returned nothing. Maybe it's at the git root which could be higher? No, the skill dir has its own .git. Hmm. Maybe .gitignore was deleted. Or the glob pattern needs the file to exist; it doesn't.

Wait, maybe the skill repo's git root is the skill dir, and .gitignore exists but my glob's base_dir + pattern ".gitignore" only matches top-level. It returned "No files found". So no .gitignore at skill root. Hmm, then run/ is NOT gitignored currently → it's untracked debris → HEALTH-CHECKS §6 "Shared-checkout cleanliness — QUIRK (warn, loud)... `git status --porcelain` must be clean of unexpected untracked/modified files." That's a solid law to quote for run/ and fd-split-20260918/!

Hmm, but I can't run git status to confirm untracked. I can only note the absence of .gitignore. Let me be careful and phrase precisely: I did not verify git tracking (no shell); I cite the absence of a skill-repo .gitignore (glob query) as a negative-existence claim with scope.

Hmm, this is getting deep. Let me be pragmatic and pick findings where I have solid verbatim law + verified on-disk facts:

FINDING 1 (HIGH): `reviews/20260918-cycle/` — no `state.json`. Law: hq.md Duty 6 step 0 verbatim. Verified: dir contains only reports/. Verdict: the law says it must exist; it doesn't → must be created (KEEP the dir, ADD state.json). Also no index.log → reports unreceipted.

FINDING 2 (HIGH): `reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md` — non-catalog lens. Laws: hq.md step 1 enumeration "one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub)"; review-lenses.md anti-rule "no lens-per-incident (incidents become rules/proposals, not lenses); no auto-growth"; oc-review-persist LENSES whitelist (no S). Verdict: KEEP (evidence) but flag: it's outside the catalog → either fold into a catalog lens or record a waiver. Not DELETE (reviews/ is "never touch").

FINDING 3 (MED): `reviews/20260918-cycle/reports/lens-B-redundancy-20260918.md` — non-canonical filename → UNPERSISTED. Law: oc-review-persist header "Writes skill-review-<lens>-<YYYYMMDD>.md ... appends ONE index line" + "A report on disk under a NON-canonical name (e.g. review-lens-B.md, the pre-tool convention) is UNPERSISTED, never 'missing'". Verdict: KEEP text, but re-persist under canonical name / or record waiver.

Hmm, 2 and 3 are similar. Maybe merge into one finding about the 20260918-cycle corpus being unreceipted + non-canonical + one non-catalog lens.

FINDING 4 (MED): root `reviews/skill-review-index.log` — legacy 2026-09-06 index pointing at root-level reports; I-5.1 says cycle-local index wins on divergence. Verdict: ARCHIVE (keep as history) or DELETE? I-5.1 only says which wins. Hmm. Weak. Actually there's a stronger angle: the root-level report files `reviews/skill-review-B-20260906.md` etc. live OUTSIDE any `reviews/<cycle>/reports/` dir → they violate the I-5.1 corpus law. And the root index log is their receipt. Verdict: ARCHIVE (move into reviews/20260906-cycle/reports/). Hmm, but I-5.1 says "durable reports live in reviews/<cycle>/reports/". These 7 reports + index log at reviews/ root are pre-corpus-convention. So: KEEP-as-history / ARCHIVE; not DELETE because they're the only copy (per "reviews/" never-touch). Hmm.

FINDING 5 (MED): skill-repo `run/` — 41 wave-*.lock/.sent/.targets files, 2026-09-12→09-18, at a path that is neither `$OC_DEV_STATE/run` (doesn't exist) nor gitignored. Law: HEALTH-CHECKS §1 (wave locks SAFE reap if >24h + dead PID) + §6 (shared-checkout cleanliness). Verdict: DELETE-SAFE for stale .lock (pending HQ triple-check + PID check I cannot run); .sent/.targets = ARCHIVE (law-named by RC-CONTRACT law 10/8).

FINDING 6 (MED): `fd-split-20260918/` — scratch working dir (60 blk_*.bin, 61 sec_*.bin, __pycache__, *.py, header bins) inside the shared skill repo. Law: HEALTH-CHECKS §6 + primary rule "workers clean after themselves. A lane that leaves debris behind owns that debris." Verdict: ARCHIVE (it's the split's working evidence; receipts/ has the durable proof) or DELETE-SAFE after HQ confirms no reader. Hmm — need to check if any law requires it. The split's durable artifacts would be CHANGELOG + the reports. Let me check if fd-split is referenced anywhere. Probably not. I'll mark ARCHIVE-candidate.

FINDING 7 (LOW): `reviews/20260909-cycle/` empty dir; `reviews/20260915-c18/reports/` empty; `reviews/20260915-c17/reports/` empty. Law: hq.md Duty 6 step 0 (state.json + reports per cycle). Hmm, empty cycle dirs. Actually 20260915-c18 in skill repo has state.json (271 bytes) + verdict.md but empty reports/. Let me check its state.json.

Hmm, I'm at risk of a bloated report. Let me limit to ~7 findings and keep each tight.

Let me do a couple final verifications:
- 20260915-c18/state.json content (skill repo).
- reviews/20260907-duty46/ content (verdict-table.md only).
- reviews/2026-09-05-A-redundancy.md (root-level).
- Whether fd-split-20260918 is referenced by any law/doc (grep "fd-split").

Let me batch.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260915-c18/state.json","o":"{\n  \"cycle\": \"20260915-c18\",\n  \"base_version\": \"v0.4.184\",\n  \"base_commit\": \"e211c544\",\n  \"status\": \"ANALYZED\",\n  \"started_at\": \"2026-09-15T15:20:00Z\",\n  \"completed_at\": \"2026-09-15T15:23:12.309923Z\",\n  \"findings_count\": {\n    \"high\": 7,\n    \"med\": 12,\n    \"low\": 4\n  }\n}","s":true},{"d":"Grep 'fd-split' in ~/.opencrabs/profiles/ops","o":"/root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/fd_index_check.py:19:\n  17: SKILL = os.path.join(HOME, \"skills\", \"opencrabs-dev\")\n  18: FD = os.path.join(SKILL, \"fleet-directives.md\")\n> ROUTE = os.path.join(HOME, \"opencrabs-dev\", \"fd-split-20260918\", \"route.tsv\")\n  20: \n  21: \n\n/root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/receipts/task6-rewrite-inventory.md:37:\n  35: ```\n  36: \n> Resolver: `/root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/fd_xref.py`\n  38: Raw output: `xref_v2_report_final.txt`.\n  39: \n\n/root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/xref_resolver.py:2:\n  1: #!/usr/bin/env python3\n> \"\"\"fd-split Task 6 — cross-reference resolver for the fleet-directives.md split.\n  3: \n  4: Design v3 of the split moved 25 of 61 top-level `##` sections out of\n\n/root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/xref_resolver.py:29:\n  27: HOME = \"/root/.opencrabs/profiles/ops\"\n  28: SKILL = os.path.join(HOME, \"skills\", \"opencrabs-dev\")\n> WORKDIR = os.path.join(HOME, \"opencrabs-dev\", \"fd-split-20260918\")\n  30: ROUTE_TSV = os.path.join(WORKDIR, \"route.tsv\")\n  31: \n\n/root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/fd_xref.py:2:\n  1: #!/usr/bin/env python3\n> \"\"\"fd-split Task 6 — cross-reference resolver (v2) for the fleet-directives.md split.\n  3: \n  4: Design v3 moved 25 of 61 top-level `##` sections out of `fleet-directives.md`\n\n/root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/fd_xref.py:40:\n  38: HOME = \"/root/.opencrabs/profiles/ops\"\n  39: SKILL = os.path.join(HOME, \"skills\", \"opencrabs-dev\")\n> WORKDIR = os.path.join(HOME, \"opencrabs-dev\", \"fd-split-20260918\")\n  41: ROUTE_TSV = os.path.join(WORKDIR, \"route.tsv\")\n  42: FD = \"fleet-directives.md\"\n\n/root/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/BASELINE.md:1:\n> # fd-split-20260918 — BASELINE RECEIPT (step 1)\n  2: \n  3: Sealed 2026-09-19 (session 0117dd29-5f4b-4184-9bf4-d19dc74ac266, HQ lane).\n\n/root/.opencrabs/prof","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260907-duty46","o":"      3815  2026-09-07 13:22:35  verdict-table.md\n","s":true}] -->
<!-- reasoning -->
Key: fd-split-20260918 lives in the STATE dir (`~/.opencrabs/profiles/ops/opencrabs-dev/fd-split-20260918/`), not the skill dir! I earlier thought it was in the skill dir because the ls output was ambiguous. Let me recheck: the earlier `ls /root/.opencrabs/profiles/ops/opencrabs-dev` (state dir) listed `fd-split-20260918/`. And the second `ls` for fd-split was on the state path. Yes — fd-split is in the STATE dir. Good, so it's not in the shared skill checkout. That changes finding 6.

Hmm, so what's in the skill repo that's debris? The `run/` dir (confirmed via ls on skills path). And `reviews/` (sanctioned).

fd-split-20260918 is in $OC_DEV_STATE. It's a WORKDIR (a lane's working dir) with BASELINE.md sealed 2026-09-19 (HQ lane 0117dd29). It's a legit artifact (baseline receipt). But it also holds 121 .bin files, __pycache__. Hmm — a "BASELINE RECEIPT (step 1)" is a law-relevant artifact. So fd-split is arguably KEEP (evidence of the split). But the .bin blocks/parts are scratch. Hmm.

Given the split is described in my brief as the 2026-09-18 event, and fd-split-20260918 was sealed 2026-09-19... it's the in-flight work. So KEEP.

OK, let me now reconsider and finalize. I need to be careful about the state dir vs skill dir. Let me re-verify which artifacts are in the skill dir:

Skill dir (/root/.opencrabs/profiles/ops/skills/opencrabs-dev/):
- reviews/ (20260907-duty46, 20260907-duty46-cycle2, 20260909-cycle [EMPTY], 20260910-cycle, 20260910-writing-for-agents, 20260911-cycle, 20260912-cycle, 20260915-c17, 20260915-c18, 20260918-cycle, 20260919-cycle, inbox/, + root-level files)
- run/ (wave-* locks/sent/targets + t4-* dirs)
- tools/, CHANGELOG.md, README.md, SKILL.md, editor*.md, fleet-directives.md, hq.md, review-lenses.md, s2-swap-journal-spec.md, toolsmith.md, triage.md, upstream-merge-runbook.md, war-stories.md

State dir (/root/.opencrabs/profiles/ops/opencrabs-dev/):
- workers-ledger.json (+ .lock), tools.log (+ .lock), journal/, reviews/ (20260908-c1 ... 20260916-c20), run/ does NOT exist, fd-split-20260918/, many .md state files, .bak files, locks, harvest-registry.json, smoke-verdicts.log, etc.

Hmm wait — so there are TWO reviews trees: skill-repo/reviews (with 20260910-cycle, 20260912-cycle, 20260915-c17/18, 20260918-cycle, 20260919-cycle, inbox, root files) and state-repo/reviews (20260908-c1..20260916-c20). That's exactly the I-6.1 finding quoted in CHANGELOG: "the corpus is **unaddressable** — two repos, four report-naming conventions, closing artifacts that disagree". Good — that's a documented, open issue.

Now, my brief says root = skill dir, and "reviews/**" — so focus on the skill-repo reviews tree.

Let me now check the skill-repo reviews tree details I haven't: 20260910-cycle, 20260911-cycle, 20260912-cycle, 20260910-writing-for-agents, root files. And whether 20260909-cycle is truly empty (confirmed).

Let me quickly check the root-level files and 20260910-writing-for-agents.

Actually, I have enough. Let me do one more targeted check: the root-level reviews files (2026-09-05-A-redundancy.md, skill-review-B-20260906.md, skill-review-deletion-safety-20260906.md, 20260907-duty46/verdict-table.md) and the inbox. And whether any law names `reviews/inbox/`.

Also — a key question: does any law require the cycle-local index.log? The oc-review-persist header says it appends ONE index line to `$DIR/skill-review-index.log`. And I-5.1 says cycle-local index wins. So each cycle's reports/ should have an index.log. 20260918-cycle/reports has NO index.log → its two reports are unreceipted.

Let me verify which skill-repo cycles have index.log: from the earlier listing, 20260907-duty46-cycle2 has skill-review-index.log; 20260910-cycle/reports has skill-review-index.log; 20260911-cycle/reports has it; 20260912-cycle/reports has it; 20260915-c17/reports has it; 20260915-c18/reports — empty (no). 20260909-cycle — empty. 20260910-writing-for-agents — just report.md. 20260907-duty46 — just verdict-table.md.

OK. Now let me write the report. I must keep under 6000 chars. Let me be disciplined: 7 findings.

Let me double check one thing: the brief says "the state dir (workers-ledger.json, journals, markers, locks, tools.log)". I should mention at least one state-dir artifact. Candidates:
- `workers-ledger.json.lock` (0 bytes, 2026-09-19 04:10:23) — flock lock; law? hq.md step 2 "inside the same flock as the write". Not really a "must exist" law. It's a transient lock. Verdict: KEEP (live, currently held).
- `tools.log.lock` (0 bytes, 2026-09-15) — stale? tools.log is written continuously (mtime 2026-09-19 04:11:11). The .lock file is 4 days old → stale. Law: HEALTH-CHECKS §1? No, that's fanout/wave locks. Hmm. Is there a law about tools.log.lock? lib/oc-log.sh uses flock on the logfile... Let me check. Actually `oc_log` in lib/oc-log.sh: "logf=...; mkdir -p; if command -v flock; then ...". It may create a lock file. Let me check the lock name.

Given budget, let me pick the state-dir finding as: `harvest-registry.json.bak-*` and other `.bak` files — law HEALTH-CHECKS §3 (ledger backups SAFE prune). Hmm, but §3 is scoped to `workers-ledger.json.bak.*`. The actual .bak files present are for harvest-registry.json, smoke-verdicts.log, 291-smoke-state.md, sync-cutover-state, 302-fast-follow-state. §3's glob `*.20*.bak` would match `291-smoke-state.md.2026-09-18T040237.bak` and `sync-cutover-state-20260918.md.2026-09-18T014153.bak` and `302-fast-follow-state.md.2026-09-18T022323.bak`! And `*.bak.*`? No, §3 says `$OC_DEV_STATE/workers-ledger.json.bak.*`, `*.corrupt-*.bak`, `*.20*.bak`. So `*.20*.bak` matches `291-smoke-state.md.2026-09-18T040237.bak` (contains "2026-09-18" → "20" yes). Hmm, that's the ledger-backup check though, titled "Ledger backups". Ambiguous whether the check applies to non-ledger .bak files. I'd flag it as MED: `.bak` debris, the only law that names `*.20*.bak` is §3, which is scoped to ledger backups → these files sit in a gray zone (no law assigns them) → recommend ARCHIVE/DELETE after HQ ruling. Hmm, but a deletion verdict needs governing law quoted. §3's glob is the governing law, even if scoped oddly. Hmm.

Also `smoke-verdicts.log.bak-oc226` — smoke-verdicts.log is in "Never touch" list → its backup is evidence-adjacent → KEEP.

I think I'll include a state-dir finding on the `.bak` files citing HEALTH-CHECKS §3's invariant + the "Never touch" list, verdict: mixed — DELETE-SAFE for the 3 timestamped state-file .baks (they're superseded snapshots), KEEP for smoke-verdicts.log.bak.

Hmm, that's reasonable but the "governing law" is thin. Let me instead check whether there's a law about backup files more broadly. Let me grep for ".bak" in skill files.

Let me also check the `reviews/` root-level legacy files quickly and grep for ".bak" law.

Two more calls, then write.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep '\\.bak' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:428:\n  426: | **1. Non-Fast-Forward Push** | `rc=0` (Auto) / `rc=5` (Conflict) | **100% Automated by tool** on clean rebase: `oc-deploy`/`oc-ship-chain` auto-fetches `origin/main`, rebases topic commits, audits with `oc-rebase-safety audit`, and retries push in 3s. | Only if git hits a **semantic merge conflict**: agent inspects conflicting files (`git status`), resolves diff, re-runs chain. | `REBASE_CLEAN: auto-pushed rebased SHA` (clean) OR `REBASE_CONFLICT: manual diff needed in <file>` (conflict) |\n  427: | **2. Carrier Compilation Failure** | `rc=3` (`build-failed`) | **Auto-log extraction**: Tool automatically runs `gh run view <id> --log-failed`, parses `error[E...]` and rustc diagnostic lines, and prints the exact compiler error and file:line in tool stderr. | Agent fixes the Rust syntax, borrow checker, or missing module error in the worktree, commits, and re-runs `oc-ship-chain`. | `CARRIER_BUILD_FAILED (rc=3): Run <id>` followed by extracted compiler error block |\n> | **3. Daemon Boot Panic / Swap Failure** | `rc=4` (`swap-failed`) | **Auto-rollback & Auto-diag**: `oc-deploy swap-execute` **automatically rolls back** to the previous binary (`/usr/local/bin/opencrabs.bak`), restarts the service, and automatically extracts the panic backtrace from `journalctl -u opencrabs-ops.service -n 30` into tool output. | Agent inspects the auto-extracted panic trace, reproduces/fixes the startup bug or bad unwrap in the worktree, commits, and re-chains. Host remains 100% healthy. | `SWAP_FAILED (rc=4): Auto-rolled back to previous binary. Daemon boot panic: <extracted log>` |\n  429: | **4. Daemon Bounce Task Interruption** | Restart signal / `[BACKGROUND TASK INTERRUPTED]` | **State file + recovery re-run** (⚠️ there is **no `--resume` flag** — `oc-ship-chain` dies `rc=2` on an unknown arg): `oc-deploy swap-execute` writes the deployment result to `/root/.opencrabs/profiles/ops/opencrabs-dev/deployed.sha`. ","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260910-writing-for-agents","o":"     12717  2026-09-10 05:35:29  report.md\n","s":true}] -->
<!-- reasoning -->
Excellent — I now have a strong law for `.bak` handling:

CHANGELOG v0.4.183: "**State Hygiene**: Pruned stale `fanout.*.lock`, `ship.lock`, `.oc-prchecks-dispatch.lock`, and archived `.bak` files older than 24h."
CHANGELOG v0.4.184: "Pruned 0-byte `harvest-census.db`, cleaned stale `fanout.*.lock` files, and moved stale `.bak` files to `archive/`."

Hmm, these are CHANGELOG entries (provenance), not live law. But they establish the standing practice. Also the D-lens precedent: "deletion only after Supervisor triple-check + owner word (git history retains it)".

And the key D-lens precedent from the prior report: "the skill .gitignore excludes only 'oc-deploy-shadow.log' and '*.lock'" — so the skill repo DOES have a .gitignore! But my glob found none... Maybe the .gitignore was removed, or the glob is buggy. Hmm. The prior report (2026-08-29) says skill .gitignore excludes only "oc-deploy-shadow.log" and "*.lock". So run/ is NOT gitignored (unless the CHANGELOG v0.4.131 "run/ gitignored" entry was later reverted). Hmm, contradictory. Let me just check by reading the skill .gitignore if it exists — glob said no. Let me try reading it directly.

Actually, I've spent a lot. Let me do a final couple of verification calls and then write:
1. read_file on /root/.opencrabs/profiles/ops/skills/opencrabs-dev/.gitignore (to settle).
2. ls the skill reviews root files with details (2026-09-05-A-redundancy.md etc.).

Then write the report.

Actually, I realize I should also double-check: is `reviews/` in the skill repo the canonical corpus, or is the state-repo `reviews/` canonical? I-5.1 says durable reports live in `reviews/<cycle>/reports/` — the oc-review-persist DEFAULT_DIR = `$_SKILL_ROOT/reviews/$(date -u +%Y%m%d)-cycle/reports` where _SKILL_ROOT = parent of tools dir = the skill dir. So the canonical corpus IS the skill repo's reviews/. Good. And hq.md Duty 4 says proposals go to `~/.opencrabs/profiles/ops/opencrabs-dev/reviews/<cycle-id>/proposals/` — the STATE dir! Contradiction: reports in skill repo, proposals in state repo. That's a documented "unaddressable corpus" issue (I-6.1). Interesting but that's lens I's class.

OK. Let me finalize with the checks.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/.gitignore","o":"oc-deploy-shadow.log\n*.lock\nrun/\n__pycache__/\n*.pyc\n*.pyo","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews","o":"     <DIR>  2026-09-07 13:22:35  20260907-duty46/\n     <DIR>  2026-09-07 21:25:09  20260907-duty46-cycle2/\n     <DIR>  2026-09-09 21:43:35  20260909-cycle/\n     <DIR>  2026-09-10 14:42:54  20260910-cycle/\n     <DIR>  2026-09-10 05:35:29  20260910-writing-for-agents/\n     <DIR>  2026-09-11 17:56:36  20260911-cycle/\n     <DIR>  2026-09-14 12:25:02  20260912-cycle/\n     <DIR>  2026-09-15 14:05:34  20260915-c17/\n     <DIR>  2026-09-15 15:23:12  20260915-c18/\n     <DIR>  2026-09-18 23:09:46  20260918-cycle/\n     <DIR>  2026-09-19 04:09:54  20260919-cycle/\n     <DIR>  2026-09-07 13:18:00  inbox/\n      3918  2026-09-05 22:13:51  2026-09-05-A-redundancy.md\n      5175  2026-09-06 05:30:34  skill-review-B-20260906.md\n      5510  2026-09-06 04:57:56  skill-review-C-20260906.md\n      3117  2026-09-06 04:50:59  skill-review-E-20260906.md\n      4827  2026-09-06 05:10:20  skill-review-F-20260906.md\n      4440  2026-09-06 04:43:56  skill-review-G-20260906.md\n      2784  2026-09-06 05:04:41  skill-review-brain-scrub-20260906.md\n      2189  2026-09-06 04:43:56  skill-review-deletion-safety-20260906.md\n      1301  2026-09-06 05:30:34  skill-review-index.log\n","s":true}] -->
<!-- reasoning -->
So the skill .gitignore DOES exist and contains `run/`, `*.lock`, `__pycache__/`, `*.pyc`, `*.pyo`, `oc-deploy-shadow.log`. My earlier glob with base_dir=skill dir and pattern ".gitignore" returned nothing — that's a glob tool quirk (hidden file handling). So run/ IS gitignored (as CHANGELOG v0.4.131 said). Good — so run/ is sanctioned. That kills my "run/ is debris" angle partially: run/ is gitignored so it doesn't violate §6. But §1's invariant (>24h + dead PID → SAFE reap) still applies to wave-*.lock. And the .sent/.targets are law-named (RC-CONTRACT law 10/8). So run/ → KEEP, but the stale locks are reap-candidates per §1.

Hmm, and importantly: HEALTH-CHECKS §1 names `$OC_DEV_STATE/run/wave-*.lock`, but the actual (and gitignored-per-skill-.gitignore) location is `skills/opencrabs-dev/run/`. So there IS a path discrepancy between the health-check law and reality → the hourly health check never sees these locks. That's a real MED finding (and it's an artifact-state law question, arguably mine or J's). I'll report it as an artifact finding with the quote.

Hmm, careful — the .gitignore has run/ but does the skill dir have a run/ that's gitignored... yes. But which tool writes run/wave-*? oc-notify-fanout. Let me not over-verify.

Now, also note: reviews/ is NOT gitignored in the skill repo → reviews/ is tracked in git. Good, so reports are version-controlled.

Root-level reviews files: `2026-09-05-A-redundancy.md` + 7 `skill-review-*-20260906.md` + `skill-review-index.log`. These sit at reviews/ root, not in a `<cycle>/reports/` dir. I-5.1 corpus law says durable reports live in reviews/<cycle>/reports/. So these 8 files violate the corpus layout (pre-convention, 2026-09-05/06). Verdict: ARCHIVE (move to reviews/20260906-cycle/reports/) — not DELETE (they're the only copy; reviews/ = never touch).

`reviews/inbox/` — 7 files 20260907-duty6-lens-*.md (2026-09-07). No law names an inbox. These duplicate the cycle2 reports? Let me check whether the same content is in 20260907-duty46-cycle2/reports/. The inbox has lens-A..G (no D? actually A,B,C,D,E,F,G). cycle2/reports has skill-review-A/B/C/D/E/F/G + A2/B2/C2/D2/E2/E2b/F2/G2 + brain-scrub. So inbox files are likely earlier drafts (12:49-13:18) and cycle2 reports are the persisted versions. Hmm. Verdict: orphaned drafts, ARCHIVE candidate. No governing law → I should report as a coverage gap / low finding with the "reviews/ never touch" quote.

Now the empty `reviews/20260909-cycle/` (empty dir, 2026-09-09). And 20260915-c17 (verdict.md only, no reports/), 20260915-c18 (state.json + verdict.md, empty reports/). Hmm — 20260915-c17 in the SKILL repo has only verdict.md; its reports live in the STATE repo (20260915-c17/reports/). So the skill-repo 20260915-c17/verdict.md is a stray/mirror. Similarly 20260915-c18 in skill repo has state.json + verdict.md but no reports (reports are in state repo). And 20260918-cycle exists ONLY in the skill repo (not in state repo) — wait, is that right? The state-repo reviews listing went up to 20260916-c20. So 20260918-cycle and 20260919-cycle exist only in the skill repo. Hmm, but hq.md says state.json lives "under $OC_DEV_STATE". So 20260919-cycle/state.json is at the WRONG location (skill repo instead of state repo)! Hmm, that's interesting but... the corpus is documented as unaddressable. Careful.

Hmm. Actually, oc-review-persist's DEFAULT_DIR = skill_repo/reviews/<date>-cycle/reports. So reports → skill repo. hq.md Duty 6 step 0 says state.json → `reviews/<cycle-id>/state.json` (under `$OC_DEV_STATE`) → state repo. So the two halves of a cycle are split across two repos. 20260919-cycle has state.json in the SKILL repo (wrong repo per hq.md) and empty reports/. Hmm — so either the state.json is misplaced, or "$OC_DEV_STATE" is being read as the skill dir. Hmm. This is a genuine finding: cycle state and cycle reports live in different repos → the "Step-0 Recovery Mandate" (read state.json to restore cycle state) can't find the reports, and check-cycle takes the corpus root from the caller (documented defect).

I'll report: 20260919-cycle/state.json present but at a path that contradicts hq.md's `under $OC_DEV_STATE`, while its reports/ is empty → the cycle's two halves are in two repos.

Hmm, I need to be careful not to overreach. Let me check: does `$OC_DEV_STATE/reviews/20260919-cycle/` exist? From the state-repo reviews listing, the last was 20260916-c20. So no. Let me verify with ls.

Actually, let me be economical. I'll do one final ls on the state repo reviews dir to confirm no 20260918/20260919 cycle there, then write.

Let me also double check the 20260918-cycle is absent from the state repo.

One more: I should check whether hq.md or fleet-directives mentions the cycle dir naming convention `reviews/<YYYYMMDD>-cycle/`. oc-review-persist uses `$(date -u +%Y%m%d)-cycle`. So 20260918-cycle matches. Good.

Final call.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"ls ~/.opencrabs/profiles/ops/opencrabs-dev/reviews","o":"20260908-c1/\n20260908-c2/\n20260909-c3/\n20260909-c4/\n20260911-c5/\n20260911-c6/\n20260911-c7/\n20260911-c8/\n20260913-c9/\n20260914-c10/\n20260914-c11/\n20260914-c12/\n20260914-c13/\n20260915-c14/\n20260915-c15/\n20260915-c16/\n20260915-c17/\n20260915-c18/\n20260916-c19/\n20260916-c20/\n","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/2026-09-05-A-redundancy.md","o":"# Duty-6 Lens A report — REDUNDANCY + ONTOLOGY (v0.4.84 doc set) — reviewer 232a6084, 2026-09-05\n\nPersisted verbatim from wait_agent receipt. Supervisor spot-verification pending (Duty 6 step 4).\n\n## F1 — P2 (borders P1): REBASE-PORT still presented as LIVE sync model in 3 files; contradicts owner 2026-09-02 merge-on-arrival law; SKILL.md contradicts itself (intro points at merge runbook, §Upstream relations item 2 names REBASE-PORT + \"merge-sync retired\").\n\nQuotes: SKILL.md §Upstream relations item 2; supervisor.md §Upstream sync header + step 5 force-push-with-lease; editor.md Phase 0. Contradicting law: fleet-directives.md sync policy (owner 2026-09-02 \"Land it\": fork main MERGES adolfousier/main; rebase-port = PR chains only).\nResolution: restyle 3 sites around merge-on-arrival → upstream-merge-runbook.md; mark REBASE-PORT RETIRED 2026-09-02 / PR-chains-only.\n\n## F2 — P1: DRIFT PERMANENT rule verbatim ×2 (SKILL.md §Upstream relations item 6 = supervisor.md §Parity).\nResolution: one home (SKILL.md item 6), supervisor §Parity keeps exit-code register + pointer.\n\n## F3 — P2: \"seven lenses / A–G\" in 3 files vs registered 8th lens brain-scrub.\nResolution: add brain-scrub brief to review-lenses.md + counts → eight, or cross-pointer + reword counts.\n\n## F4 — P2: war-stories.md advises deleted oc-consent-check in present tense + \"Ask early.\"\nResolution: parenthetical (RETIRED 2026-08-28; tool deleted v0.4.58; incident history only).\n\n## F5 — P2: watcher-exit-code incident duplicated in war-stories.md (table row + gotchas bullet).\nResolution: table keeps it; bullet reduces to command lesson or cross-links.\n\n## F6 — P2: \"items 1–9\" frozen in 2 pointers vs editor.md's actual 13 CI-wait items (10–13 load-bearing).\nResolution: open-ended range or drop enumeration from pointers.\n\n## F7 — P3: BUILD TRIGGERS fully restated in editor.md Phase 7 vs SKILL.md canonical; carrier-yml fact in 3 homes.\nResolution: cite SKILL.md for the ruling; keep Phase-7-specific detail.\n\n## F8 — P3:","s":true}] -->
<!-- reasoning -->
Confirmed: state repo reviews has cycles 20260908-c1 … 20260916-c20 — no 20260918-cycle, no 20260919-cycle. And skill repo reviews has 20260918-cycle, 20260919-cycle.

So the two repos hold disjoint cycle corpora. That's the documented "unaddressable corpus" issue.

Also `2026-09-05-A-redundancy.md` is a root-level report (2026-09-05) — pre-convention, "Persisted verbatim from wait_agent receipt". No cycle dir.

OK, I have plenty. Now write the report, ≤6000 chars.

Let me structure:

# Lens D - cycle 20260919-cycle

## Verdict: one line.

Something like: "The 20260919 corpus skeleton is lawful and empty; the 2026-09-18 split left a cycle dir with reports but no state.json, no index receipt, and one non-catalog lens — 2 law-required artifacts missing, 1 orphan class (root-level legacy corpus), rest KEEP."

## Findings

I'll do ~7 findings. Each: **[SEV] title** . locator `<path>` . VERBATIM QUOTE from law . verdict KEEP|DELETE + reason . fix.

Let me draft carefully with verbatim quotes:

F1 [HIGH] `reviews/20260918-cycle/` has no `state.json`.
Law (hq.md:180): "Every Duty 4+6 cycle maintains a machine-readable state file at `reviews/<cycle-id>/state.json` (under `$OC_DEV_STATE`)." and "Before spawning reviewers or codifying findings, HQ initializes `state.json`."
Verdict: KEEP the dir; the missing artifact must be created (law says it must exist; it does not). Fix: HQ writes state.json for 20260918-cycle or records a waiver.

F2 [HIGH] lens-S report is not a catalog lens.
Locator: reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md
Law (hq.md:186): "one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub)" + review-lenses.md: "Anti-rules: no lens-per-incident (incidents become rules/proposals, not lenses); no auto-growth." + oc-review-persist LENSES whitelist (verbatim): `LENSES=" A B C D E F G H I J self redundancy-ontology efficiency-creep cli-automation deletion-safety brain-scrub "`.
Verdict: KEEP the report as evidence (reviews/ is on the never-touch list) — but it is UNREGISTERED: oc-review-persist would reject lens `S` (rc 2). Fix: re-label under a catalog lens (A or D) or record a waiver in `<cycle-dir>/waivers.log`.

F3 [MED] Both 20260918-cycle reports are UNPERSISTED (non-canonical names, no index receipt).
Law (oc-review-persist header): "Writes skill-review-<lens>-<YYYYMMDD>.md ... appends ONE index line: skill-review-index.log: ts|lens|path|sha256|bytes. The index line is the receipt Duty-6/7 quote — no receipt, no 'persisted'." + "A report on disk under a NON-canonical name (e.g. review-lens-B.md, the pre-tool convention) is UNPERSISTED, never 'missing'".
Locator: reviews/20260918-cycle/reports/ (2 files, no skill-review-index.log).
Verdict: KEEP text; re-persist via oc-review-persist to mint the receipt, or record waiver.

F4 [MED] Root-level legacy corpus outside any cycle dir.
Locator: reviews/2026-09-05-A-redundancy.md, reviews/skill-review-{B,C,E,F,G,brain-scrub,deletion-safety}-20260906.md, reviews/skill-review-index.log
Law (review-lenses.md I-5.1): "CORPUS (I-5.1 v0.4.116): durable reports live in `reviews/<cycle>/reports/`; when two skill-review-index.log files diverge, the CYCLE-LOCAL index wins over the root one."
Verdict: ARCHIVE (move into reviews/20260906-cycle/reports/), NOT delete — reviews/ is on HEALTH-CHECKS' never-touch list; the root index is the only receipt for those 7 reports.

F5 [MED] Empty/vestigial cycle dirs.
Locators: reviews/20260909-cycle/ (empty), reviews/20260915-c18/reports/ (empty), reviews/20260915-c17/ (verdict.md only).
Law: hq.md step 0 quote again + oc-review-persist DEFAULT_DIR "reviews/<YYYYMMDD-cycle>/reports/".
Verdict: DELETE-SAFE for reviews/20260909-cycle/ (zero files) — pending HQ triple-check; KEEP 20260915-c17/c18 (they carry verdict.md/state.json).

Hmm, "DELETE-SAFE ... pending HQ triple-check + owner word" per D brief. But HEALTH-CHECKS says never touch reviews/. Conflict. I'll note the conflict: "empty dir carries no evidence, but reviews/ is never-touch — HQ ruling required".

F6 [MED] Cycle halves split across two repos; 20260919-cycle/state.json sits in the skill repo.
Locator: reviews/20260919-cycle/state.json (skill repo); state repo reviews/ holds 20260908-c1…20260916-c20 only.
Law: hq.md step 0 "(under `$OC_DEV_STATE`)" + oc-review-persist DEFAULT_DIR = skill repo reviews/. 
Verdict: KEEP (live cycle) but flag: state.json is at a path hq.md does not name, and the two halves (state vs reports) live in different repos — Step-0 Recovery cannot restore a cycle from one root. Fix: HQ picks one root; record in law.

F7 [MED] Stale wave locks sit where the health check does not look.
Locator: `run/wave-*.lock` (7 files, 2026-09-17→09-18; e.g. run/wave-230f0db95dea.lock)
Law (HEALTH-CHECKS.md §1): "**Where:** `$OC_DEV_STATE/fanout.<runid>.lock` (legacy `fanout.lock.<runid>` still swept), `$OC_DEV_STATE/run/wave-*.lock` ... **Invariant:** Lock age >24h **and** associated PID dead (`kill -0`), or recorded run completed."
Verified: `$OC_DEV_STATE/run` does not exist (ls rc "Path does not exist"); the locks live in the skill repo's gitignored `run/` (skill `.gitignore`: `run/`).
Verdict: DELETE-SAFE for the .lock files once HQ confirms PIDs dead (I cannot run `kill -0`); `.sent`/`.targets` KEEP (law-named idempotency/manifest artifacts, RC-CONTRACT oc-notify-fanout laws 8 & 10).

F8 [LOW] `reviews/inbox/` drafts.
Locator: reviews/inbox/20260907-duty6-lens-{A..G}.md
Law: no law names an inbox → quote the never-touch list instead: "Never touch (evidence / live state): ... `reviews/` ...".
Verdict: KEEP (uncovered class — flag to lens I for a corpus-gap ruling).

Maybe drop F8 to save chars, or keep short.

Also maybe add state-dir .bak finding:
F9 [LOW] `.bak` snapshots in the state dir — law: CHANGELOG v0.4.184 "moved stale `.bak` files to `archive/`" (provenance, not live law). Hmm, weak. HEALTH-CHECKS §3 quotes the ledger-backup glob. I'll include a short one citing §3 + the never-touch list, verdict: mixed.

Hmm, char budget. Let me estimate. Each finding ~500-700 chars. 8 findings ≈ 5000. Plus headers ≈ 400. Should fit in 6000. Let me trim to 7 findings and keep quotes tight.

I'll merge F8 into a coverage note.

Let me be careful about "quote-or-no-finding" — every finding must have a verbatim quote. F8's "law" is the never-touch list which names `reviews/` — that's a quote. OK, I can keep it briefly.

Let me write it now, counting roughly.

Draft:

# Lens D - cycle 20260919-cycle

## Verdict: The 20260919 corpus is lawful-but-empty and the 2026-09-18 split left one cycle with reports and no state.json, no index receipt, and one non-catalog lens; two law-required artifacts are missing, one legacy corpus sits outside any cycle dir, and the remaining artifacts are KEEP.

Hmm, keep it to one line.

## Findings

**[HIGH] 20260918-cycle has no state.json** . locator `reviews/20260918-cycle/` (dir holds only `reports/`) . LAW (hq.md §Duty 6 step 0): "Every Duty 4+6 cycle maintains a machine-readable state file at `reviews/<cycle-id>/state.json` (under `$OC_DEV_STATE`). ... Before spawning reviewers or codifying findings, HQ initializes `state.json`." . verdict KEEP the dir; the artifact the law says must exist does not — create it or record a waiver . fix: HQ writes `state.json` for 20260918-cycle.

**[HIGH] lens S is not a catalog lens** . locator `reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md` . LAW (hq.md §Duty 6 step 1): "one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub)"; review-lenses.md: "Anti-rules: no lens-per-incident (incidents become rules/proposals, not lenses); no auto-growth."; oc-review-persist: `LENSES=" A B C D E F G H I J self redundancy-ontology efficiency-creep cli-automation deletion-safety brain-scrub "` — `S` would be refused rc 2 . verdict KEEP the report (reviews/ is never-touch) — it is UNREGISTERED, not deletable . fix: re-label under a catalog lens (A/D) or log a waiver.

**[MED] 20260918-cycle reports carry no persistence receipt** . locator `reviews/20260918-cycle/reports/` — 2 files, no `skill-review-index.log` . LAW (oc-review-persist header): "Writes skill-review-<lens>-<YYYYMMDD>.md ... appends ONE index line: skill-review-index.log: ts|lens|path|sha256|bytes. The index line is the receipt Duty-6/7 quote — no receipt, no 'persisted'."; and "A report on disk under a NON-canonical name ... is UNPERSISTED, never 'missing'" . verdict KEEP text; re-persist under canonical names . fix: `oc-review-persist <lens> @<file>` to mint the receipt.

**[MED] legacy report corpus sits outside any cycle dir** . locator `reviews/2026-09-05-A-redundancy.md`, `reviews/skill-review-{B,C,E,F,G,brain-scrub,deletion-safety}-20260906.md`, `reviews/skill-review-index.log` . LAW (review-lenses.md I-5.1): "CORPUS (I-5.1 v0.4.116): durable reports live in `reviews/<cycle>/reports/`; when two skill-review-index.log files diverge, the CYCLE-LOCAL index wins over the root one." . verdict ARCHIVE — move into `reviews/20260906-cycle/reports/`; do NOT delete (HEALTH-CHECKS "Never touch ... `reviews/`") . fix: HQ relocates + re-indexes.

**[MED] vestigial cycle dirs** . locator `reviews/20260909-cycle/` (0 files), `reviews/20260915-c18/reports/` (0 files), `reviews/20260915-c17/` (verdict.md only) . LAW (hq.md step 0, quoted above) + oc-review-persist: "DIR defaults to the I-5.1 CORPUS: reviews/<YYYYMMDD-cycle>/reports/" . verdict DELETE-SAFE for `20260909-cycle/` (empty, zero readers) ONLY after HQ triple-check + owner word; KEEP c17/c18 (carry verdict.md/state.json) . fix: HQ ruling; note reviews/ is on the never-touch list, so the empty-dir reap needs an explicit carve-out.

**[MED] cycle halves split across two repos; 20260919-cycle/state.json is in the skill repo** . locator `reviews/20260919-cycle/state.json` vs state-repo `reviews/` (holds `20260908-c1`…`20260916-c20` only) . LAW (hq.md step 0): "...at `reviews/<cycle-id>/state.json` (under `$OC_DEV_STATE`)"; oc-review-persist: "DIR defaults to the I-5.1 CORPUS: reviews/<YYYYMMDD-cycle>/reports/ in the skill repo" . verdict KEEP (live cycle) but the state file is at a root hq.md does not name — Step-0 Recovery cannot restore one cycle from one root . fix: HQ fixes the corpus root in law.

**[MED] stale wave locks live where the health check does not look** . locator `run/wave-*.lock` (7 files, 2026-09-17→18, e.g. `run/wave-230f0db95dea.lock`) . LAW (tools/HEALTH-CHECKS.md §1): "**Where:** `$OC_DEV_STATE/fanout.<runid>.lock` (legacy `fanout.lock.<runid>` still swept), `$OC_DEV_STATE/run/wave-*.lock` ... **Invariant:** Lock age >24h **and** associated PID dead (`kill -0`), or recorded run completed." . verified: `$OC_DEV_STATE/run` does not exist (ls: "Path does not exist"); the locks are in the skill repo's gitignored `run/` (skill `.gitignore`: `run/`) . verdict DELETE-SAFE for the `.lock` files once HQ confirms PIDs dead (I cannot run `kill -0`); `.sent`/`.targets` KEEP (law-named — RC-CONTRACT oc-notify-fanout "wave-<id>.sent resume semantics" / "run/wave-<id>.targets ... manifest") . fix: repoint §1 at the real path.

**[LOW] reviews/inbox/ orphan drafts** . locator `reviews/inbox/20260907-duty6-lens-{A..G}.md` . LAW: no law names an inbox; governing list is HEALTH-CHECKS.md: "Never touch (evidence / live state): `workers-ledger.json` itself, `tools.log`, `journal/`, `incident-evidence-*`, `reviews/`, `designs/`, `smoke-verdicts.log`, `orders.json`, `baseline.json`." . verdict KEEP (uncovered artifact class) . fix: lens I corpus-gap ruling.

## Coverage
Read: review-lenses.md (D brief + I-5.1 + brain-scrub), hq.md (Duty 1–6), SKILL.md (grep), tools/HEALTH-CHECKS.md (full), tools/oc-review-persist (header + LENSES), tools/RC-CONTRACT.md (grep), CHANGELOG.md (head + greps), skill-repo `reviews/**` (full tree, both dirs), `run/**`, state dir listing + `.gitignore`/skill `.gitignore`, fd-split-20260918 receipts (grep), 20260918-cycle reports (full), 20260919-cycle/state.json (full).
NOT read: workers-ledger.json (2.7 MB), tools.log (9.7 MB), journal/, designs/, incident-evidence-*, oc-deploy/, smoke-verdicts.log, harvest-registry.json, war-stories.md body, the 20260910/20260911/20260912 report bodies, editor.md/triage.md/toolsmith.md full text, state-repo report bodies. No shell → no `git status`/`kill -0`/`find`; negative-existence claims above are from `ls` on the named path and `grep` over the skill dir (literal+regex), scope stated.

That's long. Let me count approximate: I'll estimate ~5900. Risky. Let me trim coverage and some findings.

Let me trim: drop F5 (vestigial dirs) or shorten. Actually keep it but shorten. Shorten coverage.

Let me write final and count more carefully. I'll aim ~5500.

I'll trim the verdict line and some quotes.

Let me finalize.
<!-- /reasoning -->

# Lens D - cycle 20260919-cycle

## Verdict: The 20260919 corpus skeleton is lawful but empty; the 2026-09-18 split left one cycle holding reports and no `state.json`, no persistence receipt, and one non-catalog lens — two law-required artifacts missing, one legacy corpus outside any cycle dir, the rest KEEP.

## Findings

**[HIGH] `20260918-cycle` has no `state.json`** . locator `reviews/20260918-cycle/` (dir holds only `reports/`) . LAW (hq.md §Duty 6 step 0): *"Every Duty 4+6 cycle maintains a machine-readable state file at `reviews/<cycle-id>/state.json` (under `$OC_DEV_STATE`). … Before spawning reviewers or codifying findings, HQ initializes `state.json`."* . verdict KEEP the dir; the artifact the law says must exist does not exist . fix: HQ writes `state.json` for 20260918-cycle, or records an explicit waiver.

**[HIGH] lens S is not a catalog lens** . locator `reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md` . LAW (hq.md §Duty 6 step 1): *"one per lens (A/B/C/D/E/F/G/H/I/J + standing brain-scrub)"*; review-lenses.md: *"Anti-rules: no lens-per-incident (incidents become rules/proposals, not lenses); no auto-growth."*; `oc-review-persist`: `LENSES=" A B C D E F G H I J self redundancy-ontology efficiency-creep cli-automation deletion-safety brain-scrub "` — `S` is refused rc 2 . verdict KEEP the report (it is evidence; reviews/ is never-touch) — it is UNREGISTERED, not deletable . fix: re-label under a catalog lens (A or D) or log a waiver.

**[MED] `20260918-cycle` reports carry no persistence receipt** . locator `reviews/20260918-cycle/reports/` (2 files, no `skill-review-index.log`) . LAW (`oc-review-persist` header): *"Writes skill-review-<lens>-<YYYYMMDD>.md … appends ONE index line: skill-review-index.log: ts|lens|path|sha256|bytes. The index line is the receipt Duty-6/7 quote — no receipt, no 'persisted'."*; and *"A report on disk under a NON-canonical name (e.g. review-lens-B.md, the pre-tool convention) is UNPERSISTED, never 'missing'"* . verdict KEEP text, re-persist . fix: `oc-review-persist <lens> @<file>` mints the receipt.

**[MED] legacy report corpus sits outside any cycle dir** . locator `reviews/2026-09-05-A-redundancy.md`, `reviews/skill-review-{B,C,E,F,G,brain-scrub,deletion-safety}-20260906.md`, `reviews/skill-review-index.log` . LAW (review-lenses.md I-5.1): *"CORPUS (I-5.1 v0.4.116): durable reports live in `reviews/<cycle>/reports/`; when two skill-review-index.log files diverge, the CYCLE-LOCAL index wins over the root one."* . verdict ARCHIVE — relocate into `reviews/20260906-cycle/reports/`; do NOT delete (HEALTH-CHECKS: *"Never touch (evidence / live state): … `reviews/` …"*) . fix: HQ relocates and re-indexes.

**[MED] cycle halves split across two repos** . locator `reviews/20260919-cycle/state.json` (skill repo) vs state-repo `reviews/` (holds `20260908-c1`…`20260916-c20` only) . LAW (hq.md step 0): *"…at `reviews/<cycle-id>/state.json` (under `$OC_DEV_STATE`)"*; `oc-review-persist`: *"DIR defaults to the I-5.1 CORPUS: reviews/<YYYYMMDD-cycle>/reports/ in the skill repo"* . verdict KEEP (live cycle) but state.json sits at a root hq.md does not name, and state vs reports live in different repos — Step-0 Recovery cannot restore one cycle from one root . fix: HQ fixes the corpus root in law.

**[MED] stale wave locks sit where the health check does not look** . locator `run/wave-*.lock` (7 files, 2026-09-17→18, e.g. `run/wave-230f0db95dea.lock`) . LAW (tools/HEALTH-CHECKS.md §1): *"**Where:** `$OC_DEV_STATE/fanout.<runid>.lock` (legacy `fanout.lock.<runid>` still swept), `$OC_DEV_STATE/run/wave-*.lock` … **Invariant:** Lock age >24h **and** associated PID dead (`kill -0`), or recorded run completed."* . verified: `$OC_DEV_STATE/run` does not exist (ls: "Path does not exist"); the locks are in the skill repo's gitignored `run/` (skill `.gitignore`: `run/`) . verdict DELETE-SAFE for the `.lock` files once HQ confirms PIDs dead (I cannot run `kill -0`); `.sent`/`.targets` KEEP — law-named (RC-CONTRACT oc-notify-fanout: *"per-lane idempotency: `wave-<id>.sent` resume semantics"*, *"`run/wave-<id>.targets` … manifest"*) . fix: repoint §1 at the real path.

**[LOW] vestigial / orphan review dirs** . locator `reviews/20260909-cycle/` (0 files), `reviews/20260915-c18/reports/` (0 files), `reviews/inbox/20260907-duty6-lens-{A..G}.md` . LAW: hq.md step 0 (quoted above) names the cycle's required files; no law names an inbox — governing rule is HEALTH-CHECKS.md: *"Never touch (evidence / live state): `workers-ledger.json` itself, `tools.log`, `journal/`, `incident-evidence-*`, `reviews/`, `designs/`, `smoke-verdicts.log`, `orders.json`, `baseline.json`."* . verdict DELETE-SAFE for the empty `20260909-cycle/` ONLY after HQ triple-check + owner word; KEEP c18 (carries `state.json`+`verdict.md`) and `inbox/` (uncovered class) . fix: HQ ruling; an empty-dir reap inside `reviews/` needs an explicit carve-out from the never-touch list.

## Coverage
Read: review-lenses.md (D brief, I-5.1, brain-scrub, META), hq.md (Duties 1–6), tools/HEALTH-CHECKS.md (full), tools/oc-review-persist (header + LENSES + corpus default), tools/RC-CONTRACT.md (grep), CHANGELOG.md (head + greps), the whole skill-repo `reviews/**` tree, `run/**`, both `.gitignore`s, state-dir root listing, `fd-split-20260918/` (grep + BASELINE), both 20260918-cycle reports, `20260919-cycle/state.json`, SKILL.md (grep only).
NOT read: `workers-ledger.json` (2.7 MB), `tools.log` (9.7 MB), `journal/`, `designs/`, `incident-evidence-*`, `oc-deploy/`, `smoke-verdicts.log`, `harvest-registry.json`, `war-stories.md` body, report bodies of cycles 20260910–20260912, full editor.md/triage.md/toolsmith.md, state-repo report bodies.
No shell: no `git status`, `kill -0`, or `find` — every negative-existence claim above rests on `ls` of the named path plus literal+regex `grep` scoped to `skills/opencrabs-dev/`, as stated inline.

