# writing-for-agents audit of opencrabs-dev skill — 2026-09-10

Reference: `skills/writing-for-agents/SKILL.md` (upstream mattpocock/skills, post-rename, f054def+3216582) + SKILL-MECHANICS.md.
Executor: read-only sub-agent 66fa4d95 (session a95ae836-da29-4a6c-9d24-3b4cc5701288), dispatched by HQ per owner order 05:14Z ("Find writing good skill from matt pockock on GitHub. Update our local version. Update lenses. Run that skill for our opencrabs-dev skill via a subagent.").
Evidence law: every finding cites file + locator + verbatim quote (quote-or-no-finding). Read-only — no files edited by the reviewer.

## Sizes observed
SKILL.md ≈ 52 kB (re-read in full by every role per RELOAD LAW) · editor.md ≈ 60 kB · fleet-directives.md ≈ 56 kB · triage.md ≈ 13 kB.

## TOP-5 priority fixes
1. **Collapse the AUTO-SHIP law to one home** (SKILL.md §ISSUE ROUTING row); reduce the other 5+ sites to one-line pointers, no re-quoted owner words, no re-announced retirements. Copies already drifted in detail. (HIGH)
2. **Slim SKILL.md §Canonical tooling table to purpose-only rows** + `tools/RC-CONTRACT.md` pointer; move §Unified tools log (schema + jq recipes) behind a pointer. ~90 lines off the always-re-read router. (HIGH)
3. **Collapse editor.md §Telegram surface law to the two editor-specific bullets** (IDEA/QUIRK routing) + pointer to SKILL.md §209; delete the re-enumerated NEVERTs. Worst negation pile-up in the corpus. (HIGH)
4. **Sharpen the Rollcall coverage criterion** (triage T7 item 2 / fleet-directives item 3): "legitimately silent" is unverifiable and sits on the duty's critical path. Adopt chase-receipt-or-zero-decision-statement bound; make fleet-directives §Decision Rollcall the single home with pointers. (HIGH)
5. **Purge env-truth caches**: raw carrier-yml git-show line (SKILL.md), editor tool-table rc columns + oc-waiter env-knob defaults, triage raw grep fallback, fleet-directives MTProto incantation + chat ids. Keep genuine gotchas ("`messages.*` not `channels.*`", "`headSha` reports the carrier tip"). (MED-HIGH)

Also noted: editor.md's own split note (Phase 7/7b → `editor-upstream-pr.md`) is the largest disclosed-but-unexecuted disclosure; the two `telegram_send` TO-BE sections in fleet-directives should leave the reload path until they ship.

## Full findings (per file × 5 classes)

### 1. SKILL.md (router — always loaded)

**CONTEXT LOAD**
- HIGH — Canonical tooling table (lines 38–92) is flag-level procedure in the router despite its own concession ("rows below carry purpose only"): `oc-prchecks` row carries "rc=2 repeats back off within 120s. Adoption/lock/fmt-soft-fail lore: RC-CONTRACT.md"; `oc-deploy` row carries "`--wait N` bounded in-process poll … GREEN rc 0 / timeout rc 5 / RED rc 6"; `oc-attrib` row carries "the `oc-deploy contributors` wrapper is retired; use `oc-attrib --contributors` directly". ~75 lines × every role × every reload.
- HIGH — §Unified tools log (lines 93–114): schema + three jq recipes are audit-role lookup material, not every-turn routing.
- MED — §Shared environment facts (lines 355–423) mixes ontology with per-role procedure (daemon-PID smoke concern, dispatch-mechanics block duplicated in editor.md Phase 6a).
- MED — §Upstream relations items 4–7 (~436–482) are editor Phase 7/7b procedure; the blocker-class table appears again in editor.md §Phase 7b.
- LOW — §Session-notify mechanics (176–208): channel plumbing, disclosure candidate.

**COMPLETION CRITERIA (worst 5)**
1. STEP ZERO (~117): "Ask the operator which role this session employs before doing anything" → sharper: `DONE = role name echoed back + its procedure file named before any other tool call`.
2. §Session-notify loop (~166): smoke duty stated without its checkable shape (probe + identity receipt live only in editor.md 6b).
3. SMOKE-EVIDENCE PRECEDENCE: "logs genuinely cannot cover the claim" is the fuzzy bound → `human confirmation only for claims whose evidence class has no log/CLI producer; the request names the observable in imperative form`.
4. Issue-first: "before any fix work starts" unobserved → `no non-read tool call between discovery and the gh issue create receipt`.
5. Red-run triage: "count brace DEPTH, not brace counts" has no done bound → `the renamed symbol's usages under the enclosing item's brace span all resolve`.

**CACHE (worst 3)**
1. Carrier-features raw form (~391): raw `git show origin/ci/quick-build-linux:...yml | grep -A2 'features:'` — second, staleable copy of what `tools/oc-carrier-features` does.
2. CI-gate flags: "flags VERBATIM from pr-checks.yml" — caches the yml's own content while citing it as source.
3. Tools-log schema + jq recipes (98–113) — restates `tools/lib/oc-log.sh`.

**NEGATION (worst 3)**
1. ISSUE ROUTING: "NEVER `Closes #N` (wrong issue space)" — positive target in the same row; elephant re-spoken in editor.md 7 and fleet-directives.
2. P1 REJECTED: "Do not re-propose P1 in any form." — pure negation; positive one sentence up.
3. OFFICIAL ONTOLOGY: "No ad-hoc synonyms" — restates the bullet's own positive opener.

### 2. editor.md

**CONTEXT LOAD**
- HIGH — §Telegram surface law (50–87) re-carries SKILL.md §209 nearly item for item (first bullet admits: "canonical enumeration: SKILL.md §Telegram surface law").
- MED — Phase 7 + 7b (~748–960, ~30% of file): own SPLIT NOTE says "designated split candidate → editor-upstream-pr.md"; correctly diagnosed, still unloaded.
- MED — §CI-wait items 4–16 (~107–211) are supervisor-scoped per their own header, yet live in the editor file.

**COMPLETION CRITERIA (worst 5)**
1. Phase 6b step 3: "end-to-end … Happy path plus one edge case" → `named probe = the corrected path's observable output captured verbatim, recorded in the smoke evidence`.
2. Phase 6 conflict gate item 2: "Match crate-wide type aliases" has no done state → `every hand-resolved return expression type-checks against the alias before the gate dispatch`.
3. Phase 5: "named and justified" is agent-judged → `each new finding carries a one-line rationale citing the parent-sha run it is absent from`.
4. Phase 5 gate-idle sweep: "anything unresolved" unfalsifiable → `post the open-question list (may be empty) as the first action of the gate wait`.
5. Mid-cycle drift item 3: ack stamps a version, not a diff → `after ack, read the CHANGELOG entry and enumerate the rules that changed before the next phase boundary`.

**CACHE (worst 3)**
1. Tool reference table (289–313): 14 rows with per-tool rc columns beneath the pointer to RC-CONTRACT.md.
2. CI-wait item 11: seven oc-waiter env-knob defaults cached in the sentence naming the register that owns them.
3. Phase 7 step 2c raw `gh workflow run` block survives although the comment concedes "one command does all of it".

**NEGATION (worst 3)**
1. Telegram surface bullet 1 — the negation-to-positive ratio is the worst in the corpus; positive target stated once, adjacent.
2. Phase 6 "never bare line numbers" — positive in the same sentence; rationale re-explains.
3. BUILD TRIGGERS bullet says "do not restate here", then restates consequences.

**SEDIMENT** — Rollcall format law restates fleet-directives items 5–9 nearly verbatim, self-annotated ("restated here only because the Rollcall format adds the media ban").

### 3. triage.md

**CONTEXT LOAD** — LOW overall, best-shaped of the four.
- MED — §NEVER list (26–36): each bullet cites its law home elsewhere; STEP ZERO already carries the same NEVERTs.
- LOW — Duty T2 scope note re-carries fleet-directives Rule 4 (acknowledged duplication by design).

**COMPLETION CRITERIA (worst 5)**
1. HIGH — Duty T7 item 2: "legitimately silent (zero owner decisions = sanctioned silence)" is unverifiable — nothing distinguishes "zero decisions" from "didn't post yet". The decisive branch of the coverage duty. → `a silent lane counts as covered only with a same-turn lane-targeted chase receipt or the lane's own zero-decision statement on the ledger`.
2. Duty T2 item 2: "coherence with the register" has no observable → `each leg names the artifact read; a leg that cannot name its artifact is failed, not waived`.
3. Duty T1 item 3: ACK sent ≠ proven → `ACK counts only with a same-turn injection-verified session_notify receipt`.
4. Duty T4 cadence patrol: "flag with evidence" → `each flag cites ≥1 log row (ts, from, mode)`.
5. Duty T5 item 3: two non-equivalent mechanics behind an "or" → `parse claim rows via oc-ledger (authoritative); grep only as sanity cross-check`.

**CACHE (worst 3)**
1. T4 raw fallback grep with banned-tool enumeration — caches log format + tool list `oc-tg-audit` embodies (banned list stated a third time in fleet-directives).
2. T6 canonical ledger path — duplicated with fleet-directives ×2.
3. T5 raw `gh issue list` + `grep -c` commands — the durable part is the diff-and-route rule.

**NEGATION (worst 3)**
1. T2 double negation ("Do NOT silently retry…; do NOT self-patch…") — positive opener in the same paragraph; stated 3rd time in editor.md, again in fleet-directives.
2. NEVER item 1 — positive form is inside the negation bullet, cited, and already in SKILL.md twice. Strongest one-line-pointer candidate.
3. T7 items 4 and 7 are one law twice.

**SEDIMENT** — T4 carries AUTO-SHIP twice within one bullet, re-announcing the same retirement twice two sentences apart.

### 4. fleet-directives.md

**CONTEXT LOAD**
- MED — §Decision Rollcall (196–238, ~43 lines): full procedure duplicate-shaped with editor.md §Rollcall and triage T7; three files carry the same 9-point law.
- MED — the two `telegram_send` TO-BE sections (308–333): explicitly not law yet — zero-behavioral-impact load in a file every lane re-reads.
- LOW — §Remotes & sync bundles four eras in one paragraph; historical clauses belong in CHANGELOG (per this file's own provenance rule).

**COMPLETION CRITERIA (worst 5)**
1. §Upstream-merge cadence: "watch `channels/`, `brain/agent/service/` first" — no mechanism, no done bound → `detection = cron upstream-shift-watch diff; merge leg DONE when `git diff adolfousier/main` over conflicted files is empty + pr-checks GREEN receipt`.
2. §Cross-lane delivery escalation: "genuinely time-critical" gates the exception path → `time-critical = the blocked lane cannot reach its next phase boundary without the ruling; name the blocked boundary`.
3. §Decision Rollcall item 3: same unverifiable-silence flaw as triage T7 (two copies).
4. (Contrast noted: §Tool logging rule's "the tool is NOT DONE" is what a real completion criterion looks like — most neighbors lack one.)
5. §HARVEST LAW: Tier-1/2/3 used without definition in either file — "census posted" can't be judged correct.

**CACHE (worst 3)**
1. §Creating new editors step 2: full MTProto incantation + envelope-parse recipe + chat id; durable law is topic-first/spawn-second/brief-via-notify. Keep the gotcha: "forum methods live under `messages.*`, NOT `channels.*`".
2. H-3 push remote URL — one `git remote -v` away; keep "pushes name `mirror2`, not the org slug".
3. §telegram_send TO-BE: owner chat id inside a not-yet-live target state (double cache).

**NEGATION (worst 3)**
1. §Remotes & sync: "direct `gh workflow run` … FORBIDDEN" — restates SKILL.md BUILD TRIGGERS; both files carry the rule a second time in their own words.
2. §Direct dispatch Rule 2: "never from memory or a remembered prefix" — positive is the first clause of the same bullet; re-spoken fleet-wide (editor ×1, triage ×2, SKILL Glossary ×2).
3. §Upstream PR base Lint: "Do NOT rely on sequencing comments…" — positive rule is the preceding sentence; war story already proves the negative.

**SEDIMENT** — §Rule-text provenance forbids biography ("Rule text carries NO biography") while dozens of sections carry owner-quote biographies inline — the file violates its own newest rule.

## TOP-3 cross-file duplications
1. **AUTO-SHIP law / PR-filing gate — ≥6 statements** (SKILL ×2, editor ×2, triage T4 ×2 in one bullet, fleet-directives; each re-quotes owner words + re-announces the retirement; copies already drifted).
2. **Single-writer / lanes-never-edit — ≥6 statements** (SKILL role-table ×2, "Roles DO NOT intersect" ×2, Hard-rules census, editor, triage NEVER, fleet-directives).
3. **Telegram surface law + QUIRK format** (SKILL §209 canonical → editor §50–87 verbatim → editor Rollcall fourth restatement → fleet-directives pointer (correct) → triage T4 enforcement; QUIRK format + "never uuid-from-memory" + "do not self-patch" stated in all three of editor, triage T2, fleet-directives).
