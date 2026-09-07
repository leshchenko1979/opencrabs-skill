# Reviewer E — INTERFACE/TOPOLOGY report
Duty-6 skill review, 2026-09-01 · base skill v0.4.78 (HEAD 63977f14) · scope: `tools/` surface (27 live tools + register rows in SKILL.md). Read-only. Lens: merge candidates, verb moves, duplicate flags, half-covered rituals. Exclusions honored: one-off chains, approval-gated steps, shell bugs (lens F), duplicate rules (lens A).

### E-1 · editor.md:581-585 (Phase 7 harvest) vs tools/oc-wt:19 · ritual two covers cover in half · HIGH
Raw `git worktree add -b` + standalone `oc-index-worktree` ritual persists AFTER E8 shipped `oc-wt add --create [--from REF]` for exactly this case; comment asserts now-false "never creates them"; harvest lanes bypass rc-5 create-gates + creation journaling; flag dead in its built-for site.
→ `tools/oc-wt add up-<feature> leshchenko1979/<feature> --create --from adolfousier/main` (index chain un-skippable inside).

### E-2 · editor.md:155,165 (quick table) · chainable pair left standing after its merge shipped · MED
E5 folded RED triage into `oc-prchecks --fault-scope PR` (SKILL.md:68; oc-prchecks:479-489) but the editor table omits the flag and lists oc-pr-fault-scope as a peer row — the two-piece bound pair remains the taught invocation.
→ row `tools/oc-prchecks <branch> --fault-scope <pr>`; re-label oc-pr-fault-scope row as RED-triage backend / standalone re-run form.

### E-3 · editor.md:73-77 (CI-wait 1) + supervisor.md:215-221 (W1–W2 silence) · tool flag vs hand-rolled script · MED
C-#2 shipped `oc-deploy poll --wait N [--notify-session UUID]` ("hand-rolled detached poll loops retired", oc-deploy:1457-1469/1567/1586, selftests 10b/10c/10d) but role files still put the detached `/tmp/swap-*.sh` poller on the books and name neither flag.
→ `tools/oc-deploy poll --execute --wait N --notify-session <uuid>` as background task (`--wait 0` = classic single pass).

### E-4 · (tail) oc-<ledger-attrib wrapper vs oc-attrib> · duplicate surface · LOW
Wrapper diverges from oc-attrib contract (usage rc 1 vs 2, bad range rc 1 vs 3, `--repo` default `$HOME/opencrabs` vs `.`); only added value = `--ledger` defaulting (oc-attrib:37 lacks it — unset → roster join silently degrades to `(unmapped)`).
→ single-command shape: `oc-attrib --contributors (--range <A..B> | --deployed)` with `--ledger` defaulted to canonical workers-ledger.json (fleet pattern; oc-order-validate/oc-drift-check already do); demote wrapper row SKILL.md:51 to DEPRECATED alias → oc-attrib.

### E-5 · tools/oc-harvest-sweep:12-15 + tools/oc-pr-atomicity:19-23 + editor.md:659,670-673 · ritual two tools cover in half · LOW
Per-commit trailer sweep pre-gate (Session-Id leg via oc-attrib --trailers-only) but Issue-Ref-match half exists ONLY in oc-pr-atomicity which needs an OPEN PR — PR-BASE-PRE-OPEN's pre-open atomicity demand has no mechanical invocation shape today.
→ `tools/oc-harvest-sweep <pr-branch> --issue-ref N [--port-of …]` adding leg (I): every commit's Issue-Ref == #N (pure git, no PR object); oc-pr-atomicity keeps post-open body-claim/one-issue checks.

## Counts
HIGH: 1 · MED: 2 · LOW: 2 · total 5 findings

## Empty checks (explicit)
1. E5 oc-prchecks --fault-scope — folded correctly, no new ritual; standalone backend survives. Clean.
2. E6 oc-attrib --contributors — delegation verified (oc-deploy:823/827, rc passthrough, awk deleted); residual duplicate surface = E-4.
3. E8 oc-wt --create/--from — implemented + registered (SKILL.md:70), journaled, no flag dup. Residual = stale editor.md ritual (E-1).
4. C-#2 poll --wait/--notify-session — implemented + selftested; three fleet --wait flags wait on three different objects, not duplication. Residual = role-file lag (E-3).
5. oc-seal-state --contrib-from/--contrib-to — CLEAN: delegates to oc-attrib --trailers-only.
6. Considered and rejected (no finding): oc-drift-check vs oc-skew-scan vs oc-ledger check-version (distinct sources); oc-tg-audit vs oc-toolaccum (different evidence bases); oc-smoke-evidence vs oc-artifact-verify (running daemon vs downloaded artifact); oc-artifact-verify embed check vs oc-job-verify (swap gate self-contained); oc-index-worktree standalone (documented INTERNAL legacy fallback); oc-ship-audit vs oc-deploy watch; standalone oc-issue-log after oc-commit fold (rc-5 comment-retry backend, fold documented); raw `gh workflow run` fallback row (explicit precedence, one-off fallback).
