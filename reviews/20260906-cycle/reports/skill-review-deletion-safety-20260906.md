# Duty-6 Reviewer D — DELETION SAFETY (re-persisted 2026-09-06; original persist claim was phantom, recovered verbatim via wait_agent id bd0e7adf)

Verdict: no CRITICAL/HIGH. 2 MEDIUM, 4 LOW, 2 INFO. Deletion posture unusually strong.

MEDIUM:
D-1 oc-shadow-rotate:42-43 truncate-after-append race vs oc-deploy shadow_log() — no lock either side; a line appended between cat and truncate is destroyed; live file gitignored single-copy. Fix: flock $LIVE.lock both sides.
D-2 oc-seal-state:226-232 fixed .tmp name, no lock — concurrent runs lost-update on deployment baseline/orders. Fix: flock + mktemp in target dir (atomic_jq pattern).

LOW:
D-3 oc-branch-sweep:55 uses -D where -d would suffice post-ancestor-proof (KEEP; -d defense-in-depth).
D-4 oc-wt remove --force: untracked destroyed, receipt journal-only (acceptable; optional state-dir receipt).
D-5 supervisor.md:253/269 small-clean PORT force-push-with-lease runs without owner word — guard chain sound (backup ref, pinned lease, GREEN seam), mass path owner-gated. KEEP; flagged: documents the RETIRED sync model (see lens A F1 / lens G G1).
D-6 editor.md:757 blocker table "force-push head" missing -with-lease qualifier (procedure at :467 correct). One-line fix.

INFO:
D-7 oc-deploy:150-154 ledger_stamp mktemp in /tmp, no jq-validate/read-back vs oc-ledger atomic_jq — cross-fs mv non-atomic on the live ledger. Fix: align atomic_jq.
D-8 oc-ledger:344 sync git add -A sweeps skill tree into bump commit (warns loudly; commit-only). Narrow paths.

VERIFIED-CLEAN: ledger append-only flock+validate+readback; oc-deploy swap chain (kill-file exit 9, plan-only default, backup-before-install, per-leg-rc rollback, --drill); mirror pushes NON-FORCE; oc-wt add clobber-refusal; all rm -rf sites are mktemp fixtures; historic sweeps owner-gated w/ blob-identity (CHANGELOG :14/:25); read-only tools confirmed report-only (oc-issue-sweep, oc-ship-audit, oc-harvest-sweep, oc-upstream-delta, oc-log-search, oc-tg-audit, oc-prchecks, oc-waiter, oc-commit, oc-attrib, oc-drift-check, oc-toolaccum, oc-skew-scan, oc-smoke-evidence).

Priority: D-1, D-2 route to Supervisor mechanical fix batch (lock/addition-only changes).
