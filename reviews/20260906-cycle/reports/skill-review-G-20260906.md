# Duty-6 Review — Lens G: ROLE-FILE STRUCTURE (re-persisted 2026-09-06; original persist claim was phantom, recovered verbatim via wait_agent id 472096d8)

Objects reviewed: SKILL.md, editor.md, supervisor.md vs fleet-directives.md, review-lenses.md, upstream-merge-runbook.md. Read-only.

## G1 — HIGH · Live procedure sections still teach the retired REBASE-PORT sync model, contradicting the binding 2026-09-02 merge directive
Evidence: fleet-directives.md §remotes: "sync policy (owner 2026-09-02 'Land it'): fork main MERGES adolfousier/main when upstream shifts. Merge, never rebase/reset, on fork main… historical: REBASE-PORT procedure". SKILL.md §Upstream relations item 2: "Sync model = REBASE-PORT (merge-sync retired 2026-08-26)… force-push-with-lease. Full procedure: supervisor.md §Upstream sync". supervisor.md:233/249: "## Upstream sync — watch, REBASE-PORT, parity" + "### Port — REBASE-PORT model" with step 5 force-push-with-lease. editor.md Phase 0: "merge-sync RETIRED (2026-08-26, REBASE-PORT…): NEVER merge --ff-only adolfousier/main into the shared checkout."
Why structural: SKILL.md intro (line 34) + upstream-merge-runbook.md teach merge-on-arrival; a supervisor executing §Upstream sync performs the exact act fleet-directives forbids. Section-vs-section contradiction + stale ownership pointer.
Resolution: re-home SKILL.md item 2 and supervisor.md §Upstream sync to pointer status ("sync law: fleet-directives.md; procedure: upstream-merge-runbook.md — REBASE-PORT historical, PR chains only"); fix editor.md Phase 0 bullet.

## G2 — HIGH · SKILL.md §DELIVERY MODES contradicts fleet-directives §Cross-lane message delivery discipline
Evidence: SKILL.md modes table "| immediate (default) | … |" + "NOT 'deferred mode' (owner correction 2026-08-31)". supervisor.md Duty 3: interrupt=true posture. fleet-directives (owner 2026-09-04 22:31Z): "MUST default to deferred delivery; immediate is the exception… quiet/turn-end/now… Do not start at now."
Why structural: two delivery-default laws coexist, unreconciled; quiet/turn-end/now vocabulary absent from role files.
Resolution: update SKILL.md modes table to the 2026-09-04 default + precedence line; fix supervisor.md Duty 3 escalation path (quiet → turn-end → now).

## G3 — MEDIUM · Two tool-register rows in SKILL.md truncated mid-cell
"| ./tools/oc-review-persist <lens> <text|@file| |" and "| ./tools/oc-wt add|remove| |" — rows end inside first cell; purpose column lost (unescaped pipes). Register declared "source of truth". Resolution: repair both rows.

## G4 — MEDIUM · Stale enumerations
supervisor.md §CI-wait cites "items 1–9 since v0.4.71" but editor.md now carries items 1–13. SKILL.md STEP ZERO says "7-lens (A–G)"; review-lenses.md header says "seven" — but oc-review-persist LENSES registers 12 incl. standing brain-scrub (owner 2026-09-05). Resolution: bump to "eight lenses (A–G + brain-scrub)" + pointer; "items 1–13".

## G5 — MEDIUM · editor.md §CI-wait intro partition contradicted by own items 10–13
Intro declares waiter items SUPERVISOR-scoped (W1–W6), but items 10–12 ARE waiter rules and item 13 (rev-parse shas) is evidence hygiene, not CI-wait. Resolution: regroup 11–13 to named homes (SKILL.md §Shared environment facts / evidence-hygiene block), reword intro.

## G6 — LOW · OC_ACTOR export law lives only in editor-scoped section
editor.md §CI-wait item 2 has it; supervisor.md and SKILL.md §Shared environment facts do not — but the stamp feeds supervisor-facing ledger-beats-memory guard. Resolution: one line in SKILL.md §Shared environment facts + pointer in editor.md.

## G7 — LOW · Authority/enumeration lists omit fleet-directives.md
SKILL.md §Hard rules: "ONLY the Supervisor edits skill files (SKILL.md / editor.md / tools/archive/compiler.md / supervisor.md / review-lenses.md)". supervisor.md Scope: same census. fleet-directives.md (binding rulings since 2026-09-02) in neither — authority gap on the law file itself. Resolution: extend both to current file census, one batch.

## G8 — INFO · Retired step-2b references point at a number the target no longer contains. Leave or reword "since removed". No urgency.

No-finding dimensions: checkable completion criteria (every STEP has checkable exits); role-boundary placement otherwise clean.

Verdict: 2 HIGH (G1, G2), 3 MEDIUM (G3, G4, G5), 2 LOW (G6, G7), 1 INFO (G8).
