## Lens B — SKILL.md

FINDING 1: oc-lint-laws row embeds internal parser bug narrative in router table
  CLASS: ROUTER-SCOPE
  QUOTE: Lines 117:
| `./tools/oc-lint-laws [--strict]` | mechanical syntax & tool existence lint of skill markdown laws. **`--strict` known limitation (v0.4.207, measured 2026-09-19):** `flag_known` demands the flag BE the whole case arm (`^[[:space:]]*--flag)`), so ALTERNATION arms (`--role\|--role=*)`, `--selftest\|selftest)`), INLINE tests (`[ "${1:-}" = "--bundle" ]`) and comments are not recognised. On this corpus that yields **5 false-positive PHANTOM-FLAG findings** (SKILL.md:99 `oc-roster --role`; SKILL.md:352 + hq.md:31 `oc-deploy --selftest`; hq.md:108 `oc-ledger --bundle`; tools/RC-CONTRACT.md:55 `oc-ledger --issue`), every one a real working flag: `oc-roster --role hq` rc=0 and `oc-deploy --selftest` rc=0 (283 pass/0 fail) checked live, `--bundle`/`--issue` each covered by passing selftest assertions at `tools/oc-ledger:1275` and `:1415`. Non-strict mode finds all five. **Do not "fix" these five as phantoms** — root fix dispatched to Toolsmith. |
  WHY: The canonical tool table in SKILL.md is restricted to purpose-only entries (RC-CONTRACT.md being the sole register), but this entry embeds an in-depth bug report with regex analysis, test assertions, and line numbers.
  FIX: Truncate row description to purpose only: `| `./tools/oc-lint-laws [--strict]` | mechanical syntax & tool existence lint of skill markdown laws. |`
  LOC: 0

FINDING 2: Obsolete refusal handling prescribes resend with inert flag
  CLASS: NO-OP
  QUOTE: Lines 206-208:
- Refusal handling: a mid-turn refusal is NOT delivery. Operational content →
  resend with `interrupt: true` in the same turn; deferrable content → ledger
  skip note + retry at your next boundary.
  WHY: Instructing lanes to resend messages using `interrupt: true` contradicts the canonical delivery discipline where `interrupt: true` is an inert legacy alias and mid-turn queues automatically at the target's tool-loop boundary.
  FIX: Remove the 3-line bullet point.
  LOC: -3

FINDING 3: HQ violation enforcement procedure placed in shared router
  CLASS: RESPONSIBILITY-CREEP
  QUOTE: Lines 227-230:
- Violation pattern for HQ: a TOOL_ACCUM row showing an editor
  lane calling a telegram send/edit tool → session_notify the rule; second
  offense → review toggled.
  WHY: Monitoring and enforcing telegram tool abuse via `TOOL_ACCUM` is an HQ/Triage operational duty loaded into context by all roles in the always-loaded router.
  FIX: Relocate this 4-line rule to `hq.md` / `triage.md Duty T4` and delete it from `SKILL.md`.
  LOC: -4

FINDING 4: Redundant bookkeeping legs paragraph with historical war story
  CLASS: SPRAWL
  QUOTE: Lines 272-280:
**Bookkeeping legs ≠ smoke PASS (owner order 2026-09-08 12:16Z):** lineage
(is-ancestor), identity (artifact==exe sha) and CI gate evidence are
bookkeeping legs — ALL THREE PASSING still does not constitute a successful
smoke test. Smoke PASS requires a live behavioral probe of the corrected
runtime path on the running box (full rule: editor.md Phase 6b). A verdict
citing only bookkeeping legs is INCOMPLETE — returned to the lane, never GREEN.
Origin: the ship-38585459 smoke (n=2036) passed all bookkeeping legs while its
"behavioral" leg was only CI test counts.
  WHY: This section repeats the behavioral probe mandate already stated in `Corrected-code presence ≠ smoke success` (lines 251-259) while carrying historical incident details that belong in `war-stories.md`.
  FIX: Delete the 9-line block and defer procedure to `editor.md Phase 6b`.
  LOC: -9

FINDING 5: Role-specific tool description smoke procedure in shared router
  CLASS: ROUTER-SCOPE
  QUOTE: Lines 291-298:
**Tool-description changes have no log-based probe (lane 1a63f103, 2026-09-12):** the
daemon's provider log records tool ARGS only (`[TOOL_ACCUM] name=bash`) and NEVER tool
schemas — so no log line can prove a description string was served. Smoking a
`Tool::description()`/`input_schema()` change uses **binary strings on the running exe +
the shipped constants in source**; any description fragment found in the log is
self-contamination from the prober's own commands. A "live schema served" receipt from
the log is a FALSE receipt.
  WHY: This is an Editor-specific behavioral testing technique for Rust method schemas that belongs in `editor.md Phase 6b` rather than the always-loaded router.
  FIX: Move this 8-line procedure into `editor.md §Phase 6b` and remove from `SKILL.md`.
  LOC: -8

FINDING 6: Basic Rust compilation diagnostic advice violates no-op test
  CLASS: NO-OP
  QUOTE: Lines 369-373:
- Fix unresolved-name/import errors FIRST (E0425/E0433...) — later errors are
  usually poisoned fallout. When scopes look shifted, count brace DEPTH, not
  brace counts.
- Match-arm narrowing does not inherit through outer arms — an inner match
  needs its own exhaustive arms regardless of the outer guard.
  WHY: Frontier LLM agents inherently know how to prioritize Rust compiler diagnostics and handle exhaustive match arm scopes by default, making these lines dead token weight.
  FIX: Delete the two bullet points (5 lines) from `SKILL.md`.
  LOC: -5

FINDING 7: Subsumed manual workflow dispatch plumbing in environment facts
  CLASS: SUBSUMED-PROCEDURE
  QUOTE: Lines 434-438:
- `source_ref` accepts a branch NAME (`main`) or the FULL 40-char commit sha —
  NEVER an 8-char short form: actions/checkout treats it as a glob and fetches a
  branch literally named `<sha>*` — the live incident behind this rule; no war-story entry exists). PASS THE FULL SHA ALWAYS —
  see next rule for why it is now the only auditable record of what was built.
  WHY: Low-level GitHub Actions dispatch argument handling (`actions/checkout` short-sha globbing) is an obsolete ritual subsumed by automated carrier dispatch in `oc-deploy ship` and `oc-ship-chain`.
  FIX: Remove the 5-line entry.
  LOC: -5

FINDING 8: Issue claiming instruction contradicts Hard Rules table and duplicates filing law
  CLASS: RESPONSIBILITY-CREEP
  QUOTE: Lines 551-561:
- Issue-first, no exceptions (2026-08-25): a DISCOVERED problem gets its issue
  FILED before any fix work starts — on the FORK `leshchenko1979/opencrabs`
  (ALL new issues — upstream-code bugs and fork-only infra alike; upstream
  receives PRs only). Discoverer
  files it (symptom + evidence); fixer claims via a `gh` comment on the issue +
  an `oc-ledger claim` row (the `Tackling`-comment instruction is RETIRED —
  upstream issue comments on OUR fork issues are the owner's lane only,
  2026-08-27). Covers
  task starts (`editor.md` Phase 1) AND mid-loop finds: red-build bugs, failed
  smoke tests, defects in another editor's feature.
  WHY: Line 555 instructs workers to claim issues via "a `gh` comment on the issue", directly contradicting the hard rule in §ISSUE ROUTING (line 501: "NEVER claimed on GitHub: no tackling comments..."), while duplicating the fork-issue filing rule from line 498.
  FIX: Remove the redundant 11-line paragraph and defer to the canonical §ISSUE ROUTING table.
  LOC: -11

TOTAL FINDINGS: 8 | NET LOC: -45
