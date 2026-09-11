*Bwoop-beep!* Full picture assembled. Every line number below is from a **same-turn `grep -n`** on the live file — no section-anchors carried over. Report follows.

---

# Reviewer A — REDUNDANCY + ONTOLOGY · Duty 6 / Cycle 5

**Scope:** 7 role files under `~/.opencrabs/profiles/ops/skills/opencrabs-dev/` — `SKILL.md` (v0.4.143), `fleet-directives.md`, `editor.md`, `hq.md`, `triage.md`, `upstream-merge-runbook.md`, `editor-upstream-pr.md`.
**Checks:** (1) duplicate rules across files; (2) glossary & ontology conformance; (3) retired concepts / stale path references.
**Citation rule:** `file:line` + verbatim quote. All line numbers below were re-read from disk this turn. Verdicts: **9 HIGH · 6 MEDIUM · 3 LOW** (+1 INFO out-of-scope).

---

## HIGH

### H1 — Sync model: the retired MERGE policy is still taught as live in three in-scope files
- **MERGE (retired) side:** `SKILL.md:423` — verbatim: `2. **Sync model = MERGE-ON-ARRIVAL** (owner 2026-09-02 "Land it"; supersedes the` / `:424` `2026-08-26 REBASE-PORT, which is RETIRED — historical, PR chains only):` / `:426` `fork main **merges** \`adolfousier/main\` when upstream shifts.` · `hq.md:266` heading — `## Upstream sync — watch, MERGE-ON-ARRIVAL, parity (re-homed v0.4.80; sync model re-ruled 2026-09-02; merge execution delegated to Triage 2026-09-11)` · `editor.md:256` — `- Branch off fresh \`origin/main\`; merge-sync RETIRED (2026-08-26, REBASE-PORT —` / `:257` `  SKILL.md §Upstream relations): NEVER \`merge --ff-only adolfousier/main\` into` (cites REBASE-PORT as the live model **and** points at the SKILL.md section that teaches the opposite).
- **REBASE (live) side:** `fleet-directives.md:11` — `**sync policy (REBASE MODEL — owner-approved transition 2026-09-11, plan "Fork Rebase Transition and Sync Workflow"; the 2026-09-02 "Land it" MERGE policy is RETIRED).**` · `upstream-merge-runbook.md:3` — `Procedure for the **REBASE sync model** (owner-approved transition 2026-09-11,` · corroborated by `CHANGELOG.md:37` (v0.4.138): `the MERGE sync model is RETIRED for the REBASE model`.
- **Why HIGH:** the sync model decides whether the fleet *merges* or *rebases* fork `main`. A lane reading `SKILL.md:423` performs the exact act `fleet-directives.md:11` now voids. Same defect class as the prior cycle's `skill-review-G-20260906.md` G1 — **the polarity flipped on 2026-09-11 and the defect recurred unchanged.**

### H2 — Upstream-PR filing gate: "owner word required" vs "pre-authorized, no owner wait"
- **Owner-word side:** `fleet-directives.md:38` — verbatim: `Core: PRs-only upstream, never \`Closes #N\`, fork-issue link at body end, smoke-PASSED owner word BEFORE PR creation, silence ≠ consent, no ad-hoc PRs, branch namespace \`leshchenko1979/<slug>\``. · `SKILL.md:235` — `**SMOKE TEST** is the ONLY evidence that may back an upstream PR approval request`.
- **No-wait side:** `SKILL.md:526` (PR SHIPMENT row) — `feature COMPLETE + smoke PASS (v0.4.104 four-leg rubric) → Editor harvests fork-only commits, posts smoke evidence to forum topic, and files the upstream PR.` · `triage.md:127` — `files the ready PR — NO owner wait needed (PR SHIPMENT law).` · `editor.md:529` — `under the PR SHIPMENT law (SKILL.md §ISSUE ROUTING, PR SHIPMENT row) smoke PASS` / `:530` `proceeds to upstream PR preparation; no owner wait.` · `editor-upstream-pr.md:214` — `Editor is **pre-authorized** to file the upstream PR` … `No human pre-confirmation turn needed.`
- **Why HIGH:** a live mechanical gate with two mutually exclusive answers. SKILL.md resolves it internally (§CONSENT REGISTER points to the PR SHIPMENT row), but the **binding law file** (`fleet-directives.md:38`) still demands owner word — a lane citing the law file blocks a filing the rest of the set pre-authorizes.

### H3 — Dead cross-reference: `hq.md §CI-wait & waiter discipline, items W1–W6` does not exist
- `editor.md:77-79` — verbatim: `*(Waiter-discipline items — poll floor, --wait ceiling, invocation verify, notify wiring, log-window cuts, REST casing — are HQ-scoped: hq.md §CI-wait & waiter discipline, items W1–W6.)*` · `editor.md:248` — `the ≥60s detached-poll floor (hq.md §CI-wait & waiter discipline, item W1).`
- **Verified absent:** `hq.md`'s complete heading set is `Duty 1` (:45) … `Duty 7` (:229), `## Upstream sync` (:266), `## Detached command execution (background: true)` (:305) — and that is the last section. There is **no** `§CI-wait & waiter discipline` heading and **no** W1–W6 items anywhere in `hq.md`.
- **Why HIGH:** the editor's hot path points at a non-existent procedure for the poll floor, `--wait` ceiling, notify wiring and log-window cuts; a lane hits a dead end mid-wait. (Mirror of prior `reviews/inbox/20260907-duty6-lens-B.md` B-5 — the canon was moved to hq.md but never landed.)

### H4 — Dead cross-reference: `editor.md §Execution discipline` does not exist
- `fleet-directives.md:256` — verbatim: `- Backed out in: editor.md §Execution discipline (one line, pointer), triage.md (T2 re-role note).`
- **Verified absent:** `editor.md`'s headings include `## CI-wait discipline & actor attribution` (:75), `## Mid-cycle skill drift…`, `## Decision Rollcall duty…`, `## Tool reference…`, `## Phase 0` … `## Phase 7 + 7b`, `## CI Watcher Discipline & Throttling (v0.4.143)`. There is no `§Execution discipline` heading; the Direct-Dispatch backout line actually lives inside **§Telegram surface law**.
- **Why HIGH:** the law file's own backout pointer is unresolvable.

### H5 — Ontology collision: one word "Carrier" = two concepts, one declared retired
- `SKILL.md:314` — verbatim: `- **HQ** — the skill-owning lane. The former name *Supervisor* is RETIRED` / `:315` `  (owner order 2026-09-11 folded the term into HQ — one role, one term); unofficial variants ("Author lane", "Carrier") seen in lane files are also retired — lens A-L3 v0.4.116.`
- vs `SKILL.md:271` — verbatim: `- **carrier** — the single build lane: branch \`ci/quick-build-linux\` + its` / `:272` `  \`quick-build-linux.yml\` + dispatches from it.`
- **Why HIGH:** the same glossary declares "Carrier" retired **and** live. Case-insensitive use compounds it (`fleet-directives.md:11` "the workflow lives ONLY on carrier branch"; SKILL.md "CARRIER tip"; runbook "carrier proof-dispatch"). A reader cannot tell whether "Carrier" means the retired role-name or the live build lane.

### H6 — Decision Rollcall format law triplicated (violates the "one concept, one home" law the same file declares)
- Canonical: `fleet-directives.md:294-306` — verbatim items: `:294` `5. **No acks.** A lane posts its decisions and nothing else …` `:296` `6. **No telegram_send.** …` `:302` `8. **One decision per message.** Present 1 by 1 …` `:304` `9. **Owner gates designs and special cases.** …`
- Restated at `triage.md:231-233` — `6. Enforce the format law on coverage check (owner amendment 2026-09-08, topic 30220): no acks, no telegram_send in Rollcall posts, context + mermaid diagrams per decision, ONE decision per message presented 1 by 1,`
- Restated at `editor.md:209-219` — five bullets: `:209` `- **No acks** — your decisions post IS the acknowledgment…`, `:211` `- **No telegram_send** — your post is the topic's final chat message…`, `:215` `- **Context + diagrams** …`, `:217` `- **1 by 1** …`, `:218` `- **Designs and special cases are OWNER-GATED** …`
- **Why HIGH:** `fleet-directives.md:3` declares the discipline — verbatim: `Where a ruling's full text already lives canonically in another skill file, this file carries only a pointer — one concept, one home.` The Rollcall format law has **three** near-verbatim homes; drift in any one silently diverges the others (editor.md even annotates that a *previous* dedup pass was needed).

### H7 — PHOP (Parallel Harvest Orchestration Protocol) triplicated, all tagged v0.4.136
- `fleet-directives.md:40-92` — full home: `## Parallel Harvest Orchestration Protocol (PHOP) (v0.4.136, 2026-09-10)` (:40), `Mechanized via \`tools/oc-harvest-dispatch\`.` (:42), the 4-stage lifecycle table (:46-51), the dispatch wire envelope (:53-60), and a `mermaid sequenceDiagram` (:~85-92).
- `triage.md:85-88` — `- **Parallel Harvest Orchestration Patrol (PHOP) & Pre-Dispatch Vetting (v0.4.136, 2026-09-10):**` (:85) + 3 vetting steps (`oc-harvest-dispatch vet` :87, `dispatch … [--to <uuid>]` :88).
- `editor-upstream-pr.md:205-215` — `## Phase 7c — Autonomous Harvest Execution (v0.4.136, 2026-09-10)` (:205) + the 5-step editor contract (:211-215).
- **Why HIGH:** three homes, no pointer discipline, and the copies disagree on **who creates the harvest worktree** — `fleet-directives.md:51` row 4 assigns it to the Editor (`Dedicated worktree off \`adolfousier/main\``), `editor-upstream-pr.md:211` step 1 shows the Editor running `tools/oc-wt add …`, while `triage.md:86` says Triage vets `before creating worktrees or notifying editor lanes`.

### H8 — Atomicity contradiction: a trailer-without-`Issue-Ref` commit is sanctioned inside an upstream PR
- `fleet-directives.md:320-322` — verbatim: `Before filing an upstream PR, poll base-main Lint state and pre-claim any` / `OWNERLESS red files by carrying a sweep commit in the PR itself` / `(Session-Id-only trailer, no Issue-Ref).`
- Contradicted by `editor-upstream-pr.md:147-148` — `Every harvested commit carries an \`Issue-Ref: #N\` trailer matching EXACTLY the single issue the PR claims; no commit without one, no PR claiming more than one.` · `editor.md:579` — `(Session-Id = you; Issue-Ref = the ONE issue this change fixes — atomicity, v0.4.15: every commit links to exactly one issue…)`
- **Gate consequence:** `editor-upstream-pr.md:150` — `Gate with \`./tools/oc-pr-atomicity <pr>\` (trailer scan + body claim cross-check) BEFORE closing the issue.` → the sanctioned sweep commit makes that gate fail.

---

## MEDIUM

### M1 — "29 tools" inventory count is stale in two in-scope sites (disk shows 37)
- `editor.md:166` — verbatim: `the role-DAILY subset, not the inventory — the full tool list (29 tools)` · `editor.md:224` — `Canonical descriptions + selftest contracts: \`tools/RC-CONTRACT.md\` (full` / `inventory, all 29 tools) + SKILL.md tool table.`
- Disk truth (same-session `ls`): **37** `oc-*` executables in `tools/`.
- **Why MEDIUM:** the count is cited as a contract in the editor's reload path; a lane trusting it under-searches the register by 8 tools. (Adjacent, out-of-scope: `README.md:24`, `README.md:55` carry the same "29".)

### M2 — SKILL.md §Canonical tooling contradicts itself on which artifact is "the register"
- `SKILL.md:49` — verbatim: `register + test source of truth (archived compiler-step anchors stripped` (the section claims register ownership)
- `SKILL.md:51` — verbatim: `Fleet-wide rc conventions + FULL per-tool rc register: \`tools/RC-CONTRACT.md\` — the SOLE register (lens A H1/B F1, v0.4.79; rows below carry purpose only):`
- **Why MEDIUM:** two sentences 2 lines apart both claim register ownership; `editor.md:224` compounds it by naming `+ SKILL.md tool table` as an additional source.

### M3 — SKILL.md tool register omits five live tools
- **Verified by grep:** zero register rows in `SKILL.md` for `oc-health`, `oc-harvest-census`, `oc-harvest-dispatch`, `oc-waiter`, `oc-roster-selftest` (all present on disk; `oc-harvest-dispatch` is the named mechanism of PHOP at `fleet-directives.md:42`).
- **Why MEDIUM:** the register is the "SOLE register" (M2); a lane grepping it to discover a purpose-built tool finds nothing for the harvest pipeline.

### M4 — Orphan tool + two-tools-one-patrol: `oc-harvest-census` named in no role file
- `oc-harvest-census` is named **nowhere** in the 7 in-scope files (verified by grep).
- Meanwhile the daily patrol is attributed to two different tools with no cross-pointer: `triage.md:110-111` — `**Harvest backlog patrol (owner 2026-09-08 "Go", v0.4.97 — DAILY):** run` / `  \`./tools/oc-upstream-delta\` and post the tiered backlog census…` and `fleet-directives.md:19` — `cron \`harvest-patrol-daily\` (03:00Z) runs \`oc-upstream-delta\`, posts the tiered backlog census…` — vs `fleet-directives.md:42` — `Mechanized via \`tools/oc-harvest-dispatch\`.`
- **Why MEDIUM:** an orphan binary plus a patrol whose owning tool is ambiguous.

### M5 — The "v0.4.104 rubric" has two names; the ontology names it by neither
- `editor-upstream-pr.md:10` — `smoke test PASS (v0.4.104 four-leg rubric)`
- `fleet-directives.md:19` — `file PRs AS SOON AS tests are green AND smokes are confirmed (v0.4.104 behavioral rubric)` (and, same line, `the behavioral smoke (v0.4.104 rubric)`)
- `SKILL.md:256` defines the same thing as `**Bookkeeping legs ≠ smoke PASS (owner order 2026-09-08 12:16Z):**` with no version tag.
- **Why MEDIUM:** one gate, two adjectival names ("four-leg" vs "behavioral") plus an untagged canonical definition — a lane searching for "four-leg rubric" misses the canonical text. (Note: `triage.md` does **not** carry the version tag — verified by grep — correcting the prior cycle's catalogue which cited it.)

### M6 — Retired concept presented as live: `oc-waiter` decommissioned but still advertised
- `CHANGELOG.md:63` (v0.4.135) — verbatim: `RETIREMENT: decommissioned \`tools/oc-waiter\` in favor of native detached bash execution (\`background: true\`).`
- Yet `README.md:48` — verbatim: `- \`oc-waiter\` — lane wake service: arm/_run/sweep/list, systemd transient scopes (cgroup-escape, 2026-09-08)` and `toolsmith.md:14` — ``\`oc-prchecks\`, \`oc-order-validate\`, \`oc-tg-audit\`, \`oc-waiter\`, the`` (names it among tools the lane owns).
- **Why MEDIUM:** a retired tool is still listed as a live highlight and as Toolsmith-owned inventory; SKILL.md correctly omits it (consistent with retirement), so README/toolsmith are the stale side.

---

## LOW

### L1 — README declares "CHANGELOG newest entry LAST" but the top block is newest-FIRST
- `README.md:23` — `| \`CHANGELOG.md\` | Version history, **newest entry LAST** |` · `README.md:69` — `- **CHANGELOG is newest-LAST.**`
- Disk: `CHANGELOG.md:1` = `## v0.4.143`, `:8` = `## v0.4.142`, … `:70` = `## v0.4.134` (descending), then the body resumes ascending at `:96` = `## v0.4.60`. The declared contract is violated by the recent block. *(README/CHANGELOG are out of the 7-file scope — flagged for HQ as the surface owner.)*

### L2 — README lists a non-existent hq.md section (H3 mirror)
- `README.md:16` — `| \`hq.md\` | HQ role — worker roster, duty cadence, CI-wait & waiter discipline, review lenses |` — but `hq.md` has no `CI-wait & waiter discipline` section (H3).

### L3 — README describes the runbook by the retired policy (H1 mirror)
- `README.md:21` — `| \`upstream-merge-runbook.md\` | Procedure for the merge-on-arrival policy: gates, roles, conflict classes, migration-union rule |` — stale after the 2026-09-11 REBASE re-ruling.

---

## INFO — verified CLEAN (do not "fix" these; recorded so the next pass does not re-file them)

- **Test ontology** — the four kinds (SMOKE TEST / CODE TESTS / FEATURE-PRESENCE CHECK / EXECUTION SANITY SIGNAL) are used consistently across the in-scope files; no fifth-kind coinage found.
- **CI-wait enumeration is CONSISTENT (prior-cycle family CLOSED).** `editor.md` §CI-wait now carries exactly items **1–9** (verified by full read of :75-165), and `fleet-directives.md:171` enumerates exactly those same 9 in the same order. The old "editor has 1–16 / fd says 1–9" defect is dead — the v0.4.135 purge (`CHANGELOG.md:66`) landed. **No finding here.**
- **§Seam-resolution rename LANDED.** `fleet-directives.md:13` heading reads `## Seam-resolution shape (REBASE model — replaces the retired merge-resolution shape)` and `:6` index reads `**Seam-resolution shape**` — no residual `Merge-resolution shape` heading in the in-scope files.

---

**Method note:** read-only pass; no file written, no bash. Every line number re-derived this turn via `grep -n` / `read_file` on disk (the prior catalogue's section-anchored findings were upgraded to exact lines). Two catalogue claims were **corrected against disk** before filing: (a) the CI-wait count (now consistent — not a finding); (b) the M5 `triage.md` citation (the version tag is absent there). Per `hq.md` §Duty 6 item 3, this read-only reviewer cannot write files — HQ persists via `oc-review-persist A @<this message>`.

---

**What now/next**
- **In flight:** this report is the deliverable; the review pass is complete.
- **Next step + owner:** **HQ** — persist this report (`oc-review-persist A @…`, byte+sha256 verified), verify each quote against disk (Duty 6 item 1), then fold the ACCEPT-mechanical set into the next bump. **Owner of the fix is HQ** (all 7 files are HQ-only authorship); no lane action owed.
- **Blocked on Alexey:** H1/H2/H8 need a *polarity ruling* (which side is canon) before HQ edits — they are direct contradictions, not typos. H6/H7 need an owner call on which file keeps the full text and which become pointers (a one-concept-one-home dedup). Everything else is mechanical.
