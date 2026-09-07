# Duty-6 Review — Reviewer B (LLM EFFICIENCY + RESPONSIBILITY CREEP)

Pass 2026-09-01 · base skill v0.4.78 (HEAD 63977f14) · scope: SKILL.md, editor.md, supervisor.md, review-lenses.md, CHANGELOG.md, README.md, tools/RC-CONTRACT.md · vocabulary: writing-great-skills/SKILL.md · read-only: no file was edited.

## Measured reading load (line counts verified against disk)

| File | Lines | Loaded by |
|---|---|---|
| SKILL.md | 570 (~53 KB) | EVERY role (mandatory) |
| editor.md | 712 | Editor |
| supervisor.md | 237 | Supervisor |
| review-lenses.md | 104 | Supervisor (Duty 6 only) |
| CHANGELOG.md | 234 | on demand (correctly disclosed) |
| README.md | 63 | humans |
| tools/RC-CONTRACT.md | 50 | on demand |

- Editor critical path: ~1,282 lines (SKILL.md + editor.md). Of SKILL.md, roughly 200 lines are weight an editor never acts on (tool-register rc essays ~120, fan-out leg internals ~25, war stories ~30, retired-Compiler rows ~10, supervisor-owned upstream items ~35).
- Supervisor path: ~807 lines (911 at Duty-6). supervisor.md itself is clean: 237 lines, no editor procedures in its critical path.
- No standalone "shipper" file exists; the ship lane is editor Phase 6a, so shipper weight = editor weight.
- Good pattern already in place (for contrast): editor.md §Tool reference quick-table + editor-phase7-rules.md disclosure (v0.4.78) — the fixes below extend that same discipline.

## Findings

**F1 — HIGH** — `SKILL.md §Canonical tooling`: intro sentence declares tools/RC-CONTRACT.md the per-tool register, then a ~30-row table duplicates every rc register inline anyway — double-maintained data already diverged (see F8); ~120-line table loads on every role although editor.md carries the editor-relevant subset. FIX: shrink rows to tool | one-line purpose; rc lists → RC-CONTRACT.md; mechanics → each tool's --help. HIGH

**F2 — HIGH** — `editor.md §Phase 0` (lines 180–182): rule text truncated mid-phrase — "…or in a fresh" then unrelated bullet. An agent cannot obey an instruction whose text is not there; editor may silently skip shipped-behavior verification. FIX: complete ("…or in a fresh worktree cut from it") or delete the dangling fragment. HIGH

**F3 — HIGH** — `SKILL.md §Upstream relations item 2` + `supervisor.md §Duty 7`: REBASE-PORT is a live supervisor-owned duty but its only procedure home is the ARCHIVED compiler runbook (stopgap "until re-homed" standing since 2026-08-28, ~18 versions). Responsibility creep: duty migrated across the scope line, procedure didn't. FIX: extract Step 7 rebase-port procedure into supervisor.md (or disclosed reference file); leave pointer in the archive. HIGH

**F4 — MED** — `SKILL.md §Session-notify loop`: ~25 lines of fan-out GREEN/RED leg internals + journal vocabulary load on every editor although the fan-out is fully mechanical (oc-deploy fanout, auto-fired); an editor needs only "notify arrives → Phase 6b". FIX: one line + re-home leg detail beside the oc-deploy row or s2-swap-journal-spec.md. MED

**F5 — MED** — `SKILL.md §session_notify mechanics`: DELIVERY MODES as four nested bullets (~25 lines) — exactly a lookup table. FIX: 4-row table mode | when | mechanics | use-for; keep failsafe-vs-deferred warning as one sentence. MED

**F6 — MED** — `SKILL.md §Shared war stories`: ~30 lines of incident history ride every role load (history is reference, not procedure — CHANGELOG is the declared home); secondary defect: two table fragments with blank line between, second has no header row and will not render. FIX: disclose to linked reference file (or fold into CHANGELOG); keep one-line pointer; reunite fragments if it stays. MED

**F7 — MED** — `SKILL.md` frontmatter + §STEP ZERO + §Roles DO NOT intersect: three sites pay archaeology for the Compiler retired 2026-08-28; only live content is the re-enable trigger, stated once in STEP ZERO. FIX: one line under role table; drop frontmatter duty description + archived-role bullet. MED

**F8 — MED** — `SKILL.md §Canonical tooling, oc-deploy row`: "per-mode rc see mode rows" — no mode rows exist anywhere (dead pointer); inline rc list already drifted from RC-CONTRACT.md (rc 3 and 5 missing). Direct cost of F1. FIX: replace rc cell with "full register: tools/RC-CONTRACT.md" (subsumed by F1). MED

**F9 — MED** — `editor.md §Phase 6a — Ship`: sentence wedges stage history, a retired consent tombstone, and an unreachable exit code ("exit 4 below S2" while stage is S3 since 2026-08-28) into the executed step. FIX: delete (facts live in SKILL.md §Glossary + oc-deploy --help); if kept, one line "ship is live S3 since 2026-08-28 — no consent step". MED

**F10 — MED** — `supervisor.md §CI-wait & waiter discipline (header)`: "the editor keeps items 1–3" is the v0.4.70 partition, now false — editor.md §CI-wait carries items 1–9 since v0.4.71. FIX: drop the count, name the split. MED

**F11 — MED** — `supervisor.md §Duty 3`: five case→action policies compressed into one wall paragraph + four bold micro-paragraphs; case→action shape is exactly a table. FIX: table situation | action; keep commit-discipline sentence + oc-work/oc-ledger-design-20260829.md pointer. MED

**F12 — MED** — `SKILL.md §Hard rules, CONSENT REGISTER`: live directive is two clauses; the middle is a deleted tool's obituary (oc-consent-check) no reader can act on. FIX: compress to two clauses + "(history: CHANGELOG.md)". MED

**F13 — MED** — `README.md`: "Current: v0.4.76" (HEAD is v0.4.78), CHANGELOG range stale, "(30 executables)" vs 29 live (oc-post-receipts archived v0.4.77); layout table missing rows for the three v0.4.78 files (missing rows = lens-G's call). FIX: update numbers; better, make "Current" a pointer to SKILL.md frontmatter. MED

**F14 — MED** — `CHANGELOG.md` (between v0.4.64 and v0.4.65): ~40-line block of raw quoted provenance strings (v0.4.43 frontmatter dump, v0.4.32–v0.4.59) mid-file OUT of order, different format from structured ## vX entries — violates the file's own newest-LAST contract. FIX: fold into matching ## entries at correct position, or sequester as one labeled "imported pre-v0.4.60 dump" block at the TOP. MED

**F15 — MED** — `SKILL.md` (whole file): 570 lines / ~53 KB load on EVERY role; self-description "router only" no longer true (router + shared facts + full tool register + notify-mechanics reference + war stories). FIX: apply F1/F4/F6/F7 (sheds ~180–220 lines); reassess — if still >~400 lines, split §Upstream relations execution detail behind the existing supervisor.md ownership pointer. Do NOT split the shared trunk. MED

**F16 — LOW** — `supervisor.md §PROCESS-TOOL OWNERSHIP`: "YAGNI applies — never automate a one-off" restates "Build only what RECURS"; only "nor a human-judgment call" is new. FIX: one sentence. LOW

**F17 — LOW** — `SKILL.md §session_notify mechanics`: "Neither role can forge or strip identity." — invariant no reader can act on. FIX: delete or fold into preceding mechanical statement. LOW

**F18 — LOW** — `editor.md §CI-wait item 3`: opening clause "inherent to a fix loop" is scene-setting with nothing to obey. FIX: "Re-dispatch via oc-prchecks only — never a second raw watcher (concurrency group auto-cancels the superseded run)." LOW

## Verified-LIVE references (checked, no action)

- supervisor.md Duty 3 → oc-work/oc-ledger-design-20260829.md — exists.
- editor.md Phase 7 → editor-phase7-rules.md — exists (disclosure working as designed).
- supervisor.md Duty 6 → review-lenses.md — exists; all 7 lens briefs present, family headers match SKILL.md role-table row.
- SKILL.md → tools/archive/compiler.md, tools/archive/oc-post-receipts — exist.
- editor.md → "supervisor.md §CI-wait & waiter discipline, items W1–W6" — resolves.
- review-lenses.md → skills/writing-great-skills/SKILL.md — exists, vocabulary matches.
- s2-swap-journal-spec.md — exists, referenced from README; orphan-adjacent (no inbound ref from SKILL.md/editor.md/supervisor.md) — deletion/keep verdict belongs to Reviewer D.

## Checklist coverage (explicit)

- Token weight per role / cross-role procedure in critical path: F1, F4, F5, F7, F12, F15 (+ load table).
- Prose that should be tables: F5, F11 (candidates found — not empty).
- Dead references: F2 (broken text), F8 (pointer to nonexistent rows), F10 (stale enumeration), F13 (stale facts), F14 (contract breach) — each verified with grep/glob before filing.
- Duties migrating across Supervisor/Editor scope lines: F3, F7, F15.
- NO-OP TEST sentence-by-sentence on role files: F9, F16, F17, F18 (remainder of role files passed).
- Progressive disclosure / SPRAWL: F1, F4, F6, F9, F15.

## Counts

- HIGH: 3 (F1, F2, F3)
- MED: 12 (F4–F15)
- LOW: 3 (F16, F17, F18)
- Total: 18 findings.

End of Reviewer B report.
