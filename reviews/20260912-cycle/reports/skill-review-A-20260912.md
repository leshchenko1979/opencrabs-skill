# Reviewer A — REDUNDANCY + ONTOLOGY (DOCS family)

**Lens:** A · **Cycle:** 20260912 · **Date:** 2026-09-12 · **Mode:** read-only sub-agent, no file written, no command run.

---

## Scope actually covered

Corpus root: `/root/.opencrabs/profiles/ops/skills/opencrabs-dev/`

| File | Lines | Extent read this session |
|---|---|---|
| `review-lenses.md` | 264 | FULL (brief source; Reviewer A at `review-lenses.md:17`) |
| `SKILL.md` | 555 | FULL |
| `editor.md` | 633 | FULL |
| `hq.md` | 317 | FULL |
| `triage.md` | 245 | FULL |
| `toolsmith.md` | 105 | FULL |
| `editor-upstream-pr.md` | 227 | FULL |
| `README.md` | 76 | FULL |
| `tools/RC-CONTRACT.md` | 113 | FULL |
| `war-stories.md` | 112 | FULL |
| `CHANGELOG.md` | 887 | v0.4.145–v0.4.162 (≈lines 1–160) + full `## ` heading index |
| `fleet-directives.md` | 651 | PARTIAL (~50 kB of 99.8 kB; lines ≈1–35, 428–472, 471–560, 561–655 + full heading index) |
| `editor-phase7-rules.md` | 33 | **not read** (length only) |
| `upstream-merge-runbook.md` | 220 | **not read** (length only) |
| `s2-swap-journal-spec.md` | 99 | **not read** (length only) |

**Method notes (disclosed because claims rest on them).**
- This toolset has **no shell** — `wc -l` is unavailable. Lengths were obtained with the `read_file` oracle (`start_line: 99999` → *"exceeds file length N"*), re-run **this turn** for SKILL.md (555), review-lenses.md (264), triage.md (245), hq.md (317); the rest are from this session's earlier identical calls.
- **Counts in this report are counts of printed tool enumerations, not independently computed** (no `python3`, per the no-mental-arithmetic law I flag this rather than pass a computed number off as verified).
- One evidence-tool caveat: a `grep` call with `limit: 10` reported *"10 matches shown, 11 total"* for a pattern whose full enumeration (limit 60) is **40 rows at `SKILL.md:86–125`**. I used the printed enumeration, not the count line. My own tooling, not the corpus — no finding filed on it.
- **No tool source was read.** Every tool-behaviour statement below is DOC-vs-DOC; the arbiter is the tool itself.

---

## Findings

### F-A1 · MED · Enumeration consistency — one tool register, four numbers
**(b) Law sites, verbatim:**
- `README.md:24` — `| `tools/` | The `oc-*` tool fleet (29 executables) + `lib/` + `tests/` |`
- `README.md:55` — `  29 executables in `tools/` (31 − `oc-toolaccum` v0.4.110 − `oc-ci-parity` v0.4.117; owner-ordered additions 2026-09-01) — full inventory in `tools/RC-CONTRACT.md`.`
- `editor.md:175` — `   the role-DAILY subset, not the inventory — the full tool list (38 tools)`
- `editor.md:233` — `inventory, all 38 tools) + SKILL.md tool table. The`
- `SKILL.md:86–125` — the canonical-tooling table, **40 rows** (grep receipt: 40 matches); rows 91/92 name `oc-deploy` twice and rows 98/106/119 name `oc-ledger` three times.
**(c) Artifact:** the tool register itself (`README.md` + `SKILL.md §Canonical tooling` + `editor.md`).
**(d) Cost:** `unpriced`. Note the arithmetic at `README.md:55` still subtracts only v0.4.110 and v0.4.117 — the v0.4.135 `oc-waiter` retirement was never folded in.
**(e) Remedy:** one count, produced by the tool that owns the register at docs-update time; `editor.md` and `README.md` cite `tools/RC-CONTRACT.md` instead of restating a numeral.

### F-A2 · MED · RETIRED concept still described present-tense
**(b)** `README.md:48` — ``- `oc-waiter` — lane wake service: arm/_run/sweep/list, systemd transient scopes (cgroup-escape, 2026-09-08)``
against `tools/RC-CONTRACT.md:59` — `| oc-waiter | 0 | 1 (retired) | RETIRED in v0.4.135: replaced by native detached bash execution (background: true); --help returns 0, subcommands return 1 |` and `tools/RC-CONTRACT.md:16` — ``  `oc-waiter` 1 (retired) — long-documented, selftest-asserted vocabularies;``
**(c)** the README tool-fleet section. **(d)** `unpriced`. **(e)** mark RETIRED at `README.md:48` or delete the bullet (retired-concepts-marked checklist).

### F-A3 · MED · Contradiction — `oc-roster --selftest` count
**(b)** `SKILL.md:125` — ``… a claim author absent from the session DB is reported PHANTOM and excluded. `--selftest` = 44 checks. **`--role` is REJECTED (rc 2) …**``
against `tools/RC-CONTRACT.md:48` — `… Stores nothing; `--selftest` runs 31 offline fixture checks |`
**(c)** the `oc-roster` contract. **(d)** `unpriced`.
**(e)** I read no tool source, so I do **not** assert which number is right — this is a DOC-vs-DOC contradiction only. Run `oc-roster --selftest` once and correct the wrong file.

### F-A4 · MED · Contradiction — "never appends" vs the sanctioned append verb
**(b)** `fleet-directives.md:27` — ``… `oc-smoke-evidence` PRINTS a leg and never appends — the write is hand-typed, which is why the path must be copied, never resolved.``
against `tools/RC-CONTRACT.md:55` — ``**`--append-log <path>` (2026-09-12, defect #13, lane c10cd97b)**: the SANCTIONED append path for state smoke-verdicts.log — appends the evidence block newline-safely …``
**(c)** the `oc-smoke-evidence` interface. **(d)** The sentence is the fossil of the very defect the tool fixed the same day (defect #13, lane c10cd97b).
**(e)** Retire the sentence — this is the "prescribing text must be RETIRED when the named defect is fixed" pattern (`fleet-directives.md:199` §Tool-problem reports).

### F-A5 · MED · REDUNDANCY — same rule at N sites while each declares a single home
Four instances, each with a **self-declared single home that the restatement contradicts**:
**(a) Decision-Rollcall format law.** Home `fleet-directives.md:463` — ``5. **No acks.** A lane posts its decisions and nothing else — no "Rollcall`` and `fleet-directives.md:465` — ``6. **No telegram_send.** Lane posts as its topic's final chat message`` (section headed `fleet-directives.md:461` `**Format law (owner amendment 2026-09-08 ~06:3xZ, topic 30220):**`; item 3 declares *"This criterion is the single home; triage.md T7 points here."*). Restated at `triage.md:226` — `   topic 30220): no acks, no telegram_send in Rollcall posts, context +` and `editor.md:220` — `- **No telegram_send** — your post is the topic's final chat message (text`.
**(b) Registry bullets.** Home `triage.md:189` — `- **LIVE STATUS IS NEVER STORED:** a stored ACTIVE/DORMANT/UNREACHABLE is stale`, `triage.md:195` — `- Ack contract (v0.4.91): acks NOT expected; delivery proof = notify receipt,`, `triage.md:197` — `- Version-skew policy: any version valid until acked; chase only if a worker`. Restated at `hq.md:69` — `- **LIVE STATUS IS NEVER STORED:** whenever liveness or freshness matters,`, `hq.md:80` — `- **Version-skew policy (decision 2a, grace):** any version stays valid until`, `hq.md:83` — `- **Ack contract (decision 3, REVISED v0.4.91):** acks are NO LONGER EXPECTED.` — while `hq.md:63` itself says `**Ownership only — full schema, write rules, and seed law live in` / `triage.md §Duty T6**`.
**(c) Checkout-ref terminal truth.** `editor.md:106` — `4. **Checkout-ref is terminal truth (Duty-4 P2, v0.4.77):** the job NAME only`; `hq.md:316` — `- **Checkout-ref verification:** Checkout log lines identify the tested tree; verify checkout-ref matches the expected head SHA before treating a verdict as final evidence.`; `fleet-directives.md:562` — `## CI-run identity + verdict laws (v0.4.109, …)`.
**(d) Park-don't-chase.** Full law `fleet-directives.md:298` — `## Owner-Dependent Smoke Legs — Park, Don't Chase (v0.4.152, owner order 2026-09-12) [LANE]`; restated at `SKILL.md:268` — `` `PARKED-OWNER-EYE` row naming the owner action and the packaging sha, and RELEASE``, `editor.md:576` — `` `PARKED-OWNER-EYE` row to `smoke-verdicts.log` naming the owner action required``, and in full again at `editor-upstream-pr.md:217` — `- **Owner-dependent leg → PARK, don't chase (v0.4.152, owner order 2026-09-12)**: if the remaining behavioral evidence needs the OWNER …`.
**(c) Artifact:** role-file reading load. **(d)** `unpriced`.
**(e)** Keep ONE normative copy per rule; the others become one-line pointers naming the home — the pattern already used correctly at `hq.md:63`.

### F-A6 · MED · ONE CONCEPT = ONE NAME — the night window has three names, plus a stale heading
**(b)** `fleet-directives.md:603` — `## Daytime-Editing & Nighttime-Batch-Sync Cadence (v0.4.146)`; `fleet-directives.md:606` — `1. **The SOLE trigger for the Night Shift (Batch Merge, Harvest & Issue Triage Window) is an explicit operator command.**`; `fleet-directives.md:611` — `3. **Nighttime (Batch Merge, Harvest & Issue Triage Window — Operator-Initiated ONLY):**`; `fleet-directives.md:624` — `**Position:** the CLOSING phase of the Night Shift window —`; canonical, `CHANGELOG.md:32` — ``- **Canonical name is now `Batch Merge, Harvest & Issue Triage Window`** — one word per phase, in phase order …``
**(c)** the cadence section. **(d)** The v0.4.162 rename landed in the body's parentheticals but the section heading kept the v0.4.146 name, and two body names survive ("Night Shift", "Nighttime").
**(e)** Heading → the canonical window name; body uses the canonical name or one declared short alias.

### F-A7 · MED · Undefined coinage + spelling split — the four-leg smoke rubric
**(b)** `SKILL.md:487` — `| PR SHIPMENT — **PR SHIPMENT LAW (single home): feature COMPLETE + smoke PASS (v0.4.104 four-leg rubric) → …**`; `fleet-directives.md:39` — `… autonomous filing on smoke PASS (v0.4.104 4-leg rubric; …`; `editor-upstream-pr.md:215` — `- **4-Leg Smoke Pass**: Verify full 4-leg smoke pass (Lineage, Identity, CI Gate, Behavioral probe) is recorded with live receipts in `smoke-verdicts.log`. NEVER file an unsmoked PR.`; unexpanded uses at `fleet-directives.md:52`, `:66`, `:266`, `:613`.
**(c)** the ship gate's vocabulary. **(d)** `unpriced` — the expansion exists **only** at `editor-upstream-pr.md:215`, so a lane searching `fleet-directives.md` for "four-leg" finds the term and not its content.
**(e)** One spelling; gloss the four legs on first use per file, or add the rubric to §Glossary (`SKILL.md:282`).

### F-A8 · LOW · POST-MIGRATION PATH SWEEP not run — `smoke-verdicts.log` written bare, then reinterpreted
**(b)** `fleet-directives.md:27` — ``- **Canonical smoke log — ABSOLUTE PATH, stamp it literally (QUIRK from lane 6cd8175f, 2026-09-12):** `/root/.opencrabs/profiles/ops/opencrabs-dev/smoke-verdicts.log`. Every `smoke-verdicts.log` reference in this file and in `editor.md`/`triage.md` means THAT path.`` — while `fleet-directives.md:26` defines the same object a second time, relatively: ``- **Canonical smoke log:** the single `smoke-verdicts.log` lives in the STATE repo (`opencrabs-dev/smoke-verdicts.log`) …``; a third form at `fleet-directives.md:145` — ``the DRIVING lane appends its verdict to the smoke ledger file (`opencrabs-dev/smoke-verdicts.log` — the canonical state dir; …``. Bare references remain at `fleet-directives.md:52`, `:66`, `:266`, `:307`, `:329`, `:613`; `editor.md:280`, `:576`; `triage.md:114`.
**(c)** the canonical smoke log path. **(d)** Same class as the incident the bullet documents: a bare filename resolved from the profile root hit a stale decoy and captured 2 rows (lane c10cd97b 22:38:00Z; lane 6cd8175f 09:09:39Z BLOCKED-INFRA), both SUPERSEDED and not merged; the decoy is now a symlink to canonical.
**(e)** Replace every bare/relative reference with the absolute path (or define ONE alias token) so the interpretation clause is unnecessary; two adjacent bullets (`:26`, `:27`) currently define the same object twice.

### F-A9 · LOW · False negative claim — "no war-story entry exists"
**(b)** `SKILL.md:422` — ``  branch literally named `<sha>*` — the live incident behind this rule; no war-story entry exists). PASS THE FULL SHA ALWAYS —``
against `war-stories.md:15` — ``| `source_ref` = FULL 40-char sha, never short | run #32882515561: short sha → checkout fetched a branch literally named `<sha>*`, dead in 51 s |``
**(c)** the war-story corpus. **(d)** `unpriced` — a reader who trusts SKILL.md stops looking. **(e)** Delete the clause or point at `war-stories.md:15`.

### F-A10 · LOW · Duty-4 destination carries two names
**(b)** `fleet-directives.md:229` — ``| **Duty 4 Skill Gap** | Process rule ambiguity, runbook edge case | **Cycle Inbox** | Write to `reviews/<cycle-id>/proposals/<uuid>.md` OR `oc-ledger stamp proposal` | **0 turns** (processed in 1 turn at Duty 6 review) |``
against `hq.md:127` — `## Duty 4 — Poll workers for skill input (Direct Persistence & Ledger Intake)` (and `hq.md:132` — `**Zero Session Notify Law for Worker Proposals (owner order 2026-09-11):**`).
**(c)** the Duty-4 intake surface. **(d)** `unpriced`. **(e)** One name — `Cycle Inbox` is the codified one in the routing table; the duty title should use it.

### F-A11 · LOW · §Glossary conformance — load-bearing terms absent
**(b)** `SKILL.md:282` — `## Glossary — official terms (v0.4.62; one concept = one name)`; absent from it while used as law vocabulary: `PARKED-OWNER-EYE` (`SKILL.md:268`, `editor.md:576`, `fleet-directives.md:307`, `:310`, `:317`), the four-leg smoke rubric (`SKILL.md:487` et al.), "Night Shift" (`fleet-directives.md:606`, `:624`).
**(c)** the glossary. **(d)** `unpriced`. **(e)** Add the three, or state in §Glossary that status tokens are defined at their law site.

### F-A12 · LOW · Dead dispatch rule kept present-tense in the re-homed lessons
**(b)** `war-stories.md:43` — ``- **quick-build-linux.yml inputs**: needs BOTH `-f source_repository=leshchenko1979/opencrabs -f source_ref=<branch>`; missing repo input → checkout defaults to upstream → fetch dies pre-compile.``
**(c)** the war-stories table (whose own preamble, `war-stories.md:4–5`, says *"history is reference, not procedure"*). **(d)** `unpriced` — dispatch is now exclusively `oc-deploy ship` (`SKILL.md` §Hard rules: *"BUILD TRIGGERS = exactly TWO"*), so a lesson teaching a raw `gh workflow run … -f source_repository=…` reads as live procedure.
**(e)** Mark it historical or move it behind the CHANGELOG pointer.

### F-A13 · LOW · PROVENANCE SEDIMENT in live rule text
**(b)** Law: `fleet-directives.md:511` — `## Rule-text provenance — CHANGELOG at ship time (F13 resolution, owner "Approve all" 2026-09-06)` → *"Rule text carries NO biography — provenance (date, origin quote, war story) lives in CHANGELOG.md, written at ship time of the version carrying the rule."* Offenders:
- `editor.md:440` — ``**Local fmt drift on files you did NOT touch is EXPECTED — and it is not yours to fix (SKILL.md §Box law; sharpened 2026-09-12, lane `462181e9` re-derived it from scratch because this rule lives in the box-law bullet while the check runs here).** …``
- `editor.md:457` — `` `Option::take()`). Lane `facd50af` (2026-09-11, #111) burned a whole gate budget``
- `fleet-directives.md:15` — ``Historical (MERGE mechanism, RETIRED with the merge policy): first applied at merge `247fed2b` (2026-09-02) — 32/32 conflicted files upstream-verbatim, 0-byte fidelity check; superseded resolution preserved at ref `merge/upstream-20260902-forkwin`. Recorded as precedent for the byte-exact principle, not as a live procedure.``
- `fleet-directives.md:11` — ``… the compiler role is RETIRED 2026-08-28 — this line updated per Duty-6 lens B, 2026-08-31).``
- `fleet-directives.md:27` — ``**Canonical smoke log — ABSOLUTE PATH, stamp it literally (QUIRK from lane 6cd8175f, 2026-09-12):** … silently captured 2 rows (c10cd97b 22:38:00Z; 6cd8175f 09:09:39Z BLOCKED-INFRA) — both already SUPERSEDED in canonical (the BLOCKED-INFRA by a 09:46:44Z PASS; the 22:38:00Z row was a pre-screenshot draft), so neither was merged.``
**(c)** live rule text. **(d)** `unpriced`. **(e)** Move the incident narrative (dates, lane ids, ledger timestamps) to `CHANGELOG.md` at ship time; keep the rule.

---

## What I checked and found CLEAN

- **Test-ontology count is correct, not drifted.** `SKILL.md:220` — `## Test ontology (v0.4.2 — three kinds + one sanity signal, NEVER conflate)` — the table carries exactly three kinds, and the sanity signal is explicitly excluded at `SKILL.md:238` (*"is NONE of the three kinds"*). I drafted this as a finding and it is a **false** one; the heading matches the table.
- **The eleven-reviewer enumeration now agrees.** `review-lenses.md:3` — `Full briefs for the eleven Duty-6 review lenses (A–J + standing brain-scrub; …)` and `SKILL.md:51` — `… eleven-lens skill review (Duty 6, Reviewers A–J + standing brain-scrub = ELEVEN reviewers, …)`. The v0.4.162 I-6.2 fix landed.
- **The four-leg expansion does exist somewhere** — `editor-upstream-pr.md:215` spells out (Lineage, Identity, CI Gate, Behavioral probe). F-A7 is about spelling/co-location, not a missing definition.
- **`editor.md:98`** (`ledger-beats-memory guard (the CONSENT REGISTER live-record rule: ledger`) reads as a **pointer** to the SKILL.md CONSENT REGISTER rule, not a restatement — clean on the one line of context I saw.
- **Pointer discipline is applied correctly in places** — `hq.md:63` and `triage.md:204` both defer to a named home; the problem in F-A5 is that the deferral is contradicted by the bullets that follow.

## What I did NOT check (scope limits)

- **`fleet-directives.md` was read only partially** (~50 kB of 99.8 kB; the read truncates at 50 000 bytes). Regions I did **not** read continuously: ≈lines 36–427 and ≈473–510. Findings touching those regions rest on `grep` hits, not full context.
- **`editor-phase7-rules.md` (33), `upstream-merge-runbook.md` (220), `s2-swap-journal-spec.md` (99): contents not read** — lengths only.
- **`CHANGELOG.md`: only v0.4.145–v0.4.162 + a heading index** (~730 lines unread) — so I cannot claim a provenance item is *missing* from the CHANGELOG, only that it is present in live law.
- **No tool source was read**, so F-A3 (44 vs 31) and F-A4 (append) are reported as **DOC-vs-DOC contradictions only**; the arbiter is `tools/oc-roster` / `tools/oc-smoke-evidence`, which I did not open.
- `tools/HEALTH-CHECKS.md`, `tools/HEALTH-CLASSES.md`, and the historical `reviews/**` reports surfaced incidentally in greps; **not read, not treated as corpus**.
- **No count in this report was independently computed** (no shell/python in this toolset); counts are counts of printed tool enumerations, and one `grep` count line disagreed with its own enumeration (disclosed above).
