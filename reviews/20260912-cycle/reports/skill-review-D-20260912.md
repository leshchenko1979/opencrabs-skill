*bwoop — census complete.* Everything's on the bench, quotes pulled live. Emitting the report.

---

# Lens D — DELETION SAFETY (ARTIFACTS family) — Duty-6 cycle 20260912 — 2026-09-12

**Reviewer:** D · **Family:** ARTIFACTS (with H = ledger health) · **Mode:** READ-ONLY, no writes performed
**Brief:** `review-lenses.md` §FAMILY: ARTIFACTS → Reviewer D, including the folded evidence law (zero-hit `|`-pattern literal greps are UNVERIFIED) and the **BOUNDARY vs J** clause (v0.4.162). **No finding in this report is about law TEXT that assigns a state-derivable decision — that is J's scope; every finding here is an artifact on disk and its DELETE/ARCHIVE/KEEP verdict.**

## Scope actually covered

| File | Lines | Method |
|---|---|---|
| `SKILL.md` | 555 | `read_file` `start_line: 99999` overflow (returns true length) |
| `fleet-directives.md` | 651 | same (read to end this pass: lines 1–651) |
| `editor.md` | 633 | same (count only; not read in full this pass) |
| `hq.md` | 317 | same |
| `toolsmith.md` | 105 | same |
| `triage.md` | 245 | same |
| `review-lenses.md` | 264 | same (D/H/I briefs + family headers read in full) |
| `editor-upstream-pr.md` | 227 | same |
| `editor-phase7-rules.md` | 33 | same |
| `README.md` | 76 | same |
| `CHANGELOG.md` | 887 | same |
| `war-stories.md` | 112 | same |
| `s2-swap-journal-spec.md` | 99 | same |
| `upstream-merge-runbook.md` | 220 | same |
| `tools/RC-CONTRACT.md` | 113 | same (read lines 1–113 this pass) |

**Method disclosure (mandatory):** `wc -l` is **NOT available** in this session — the tool registry is read-restricted (#1173: file reads, search, web research only; no shell, no writes). Line counts were recovered via the `read_file start_line:99999` overflow error, which reports the reader's line count. This can differ from `wc -l` by one where a file lacks a trailing newline — the `I-20260912` verdict table §3 records `SKILL.md`=554 and `CHANGELOG.md`=876 via `wc -l`; my overflow read gives 555 and 887. The SKILL.md delta (1) is consistent with a missing trailing newline; the CHANGELOG delta (11) is consistent with CHANGELOG growth between that reading (12:58Z) and this one (CHANGELOG appends newest-first). I do not claim either number is "the" number — the two methods measure different things.

Also read this session: the full state-dir listing (`opencrabs-dev/`), the full `reviews/` trees in both repos, `tools/` and `tools/archive/` listings, `tools/oc-review-persist`, `tools/oc-ledger` (battery-receipt region), `tools/tests/run.sh` (battery sections 5 + the `oc-waiter` section), `tools/oc-notify-fanout` header, and the current-cycle `reviews/20260912-cycle/verdict-table.md` + `reports/skill-review-index.log`.

---

## Findings

### D-1 · MED — `README.md` advertises the RETIRED `oc-waiter` as a live tool
- **(a) Severity:** MED
- **(b) Law site — `tools/RC-CONTRACT.md:59`, verbatim:**
  > `| oc-waiter | 0 | 1 (retired) | RETIRED in v0.4.135: replaced by native detached bash execution (background: true); --help returns 0, subcommands return 1 |`
- **(c) Artifact:** `tools/oc-waiter` (1372 B on disk). **Readers:** `README.md:48`, `toolsmith.md:14`, `toolsmith.md:75`, `tools/RC-CONTRACT.md:16` ("`oc-waiter` 1 (retired)"), `tools/tests/run.sh` §`oc-waiter` (battery asserts it). **Writers:** none — tombstone, selftest-asserted. The offending reader, verbatim `README.md:48`:
  > `- oc-waiter — lane wake service: arm/_run/sweep/list, systemd transient scopes (cgroup-escape, 2026-09-08)`
  This advertises a retired tool as a live lane wake service. (`toolsmith.md:14/75` name it among tools the lane owns — also stale, lower impact.)
- **(d) Cost:** `unpriced` (no incident row found; the cost is that a fresh reader is pointed at a retired tool).
- **(e) Verdict:** the **FILE = KEEP** (tombstone with an RC-CONTRACT row the battery asserts — deleting it orphans the register row). The **actionable artifact is the stale PROSE READER** at `README.md:48`.
- **(f) Remedy:** reword `README.md:48` to mark it RETIRED (one line). This is a wording edit → HQ-only authorship (lens-A/B territory). **Not a deletion.**

### D-2 · MED — `CHANGELOG.md` carries a verbatim DUPLICATE entry (lines 768 and 772)
- **(a) Severity:** MED
- **(b) Law site — `CHANGELOG.md:214` (the immutability rule the remedy must respect), verbatim:**
  > `- **CHANGELOG CORRECTION (forward-only — the v0.4.135 block is immutable and stands as written).** … Correction recorded here rather than by editing a shipped entry.`
- **(c) Artifact:** `CHANGELOG.md`. The identical line appears twice, once under `## v0.4.113 (2026-09-08)` and once under `## v0.4.114`; both read verbatim:
  > `- Duty-6 lens H — LEDGER HEALTH added (owner "go" 2026-09-08 20:16Z, on HQ proposal after "what lens analyses ledger?"): reviews workers-ledger.json AS A WHOLE — lesson-extraction completeness (incident rows → codified laws), phantom-row families, open claims on closed chains, contradiction pairs, version/cadence sync. Slice tools (oc-ledger claims / oc-ship-audit / oc-waiter-sweep) stay the enforcement surface. Brief in review-lenses.md; family map updated to A–H (supervisor.md, SKILL.md router row, glossary). Joins the next Duty-6 cycle (due 25/5 FIRE).`
  **Readers:** every Duty-6 pass (`oc-lint-laws` corpus **excludes** `CHANGELOG.md` — `RC-CONTRACT.md:40`). **Writers:** HQ only. The duplication also re-asserts `oc-waiter-sweep` as a live slice tool — which `CHANGELOG.md:214` says **does not exist on disk** ("`tools/oc-waiter-sweep` does not exist on disk (`tools/oc-waiter` does, 1372 B)").
- **(d) Cost:** `unpriced`.
- **(e) Verdict:** **NOT delete-safe** — CHANGELOG is forward-only immutable; removing a line would rewrite a shipped record. It is a *duplicate-looking artifact that may not be deleted*.
- **(f) Remedy:** a forward-only correction note (the same pattern `CHANGELOG.md:214` already uses), **or** leave as-is if HQ judges the v0.4.114 re-statement intentional. HQ authorship.

### D-3 · MED — `tools/archive/oc-post-receipts` ARCHIVE verdict held by battery section 5 (unchanged, 4th consecutive cycle)
- **(a) Severity:** MED
- **(b) Law site — `tools/tests/run.sh:230` and `:244`, verbatim:**
  > `if tool archive/oc-post-receipts; then`
  > `"$TOOLS_DIR/archive/oc-post-receipts" --bogus >/dev/null 2>&1; [ $? -eq 3 ] && ok "bad args -> 3" || bad "bad args -> expected 3"`
- **(c) Artifact:** `tools/archive/oc-post-receipts` (5446 B). **Readers:** `tools/tests/run.sh:228–244` (the battery dry-runs it live), `tools/archive/compiler.md:232`. **Writers:** none.
- **(d) Cost:** `unpriced`; carried across cycles (D-20260901/20260907/20260910 all land the same ARCHIVE verdict).
- **(e) Verdict:** **ARCHIVE** (unchanged). DELETE-SAFE becomes available only after `run.sh` section 5 is retired — that section is the blocker, named and unchanged.
- **(f) Remedy:** no action; the blocker is the battery section, not the artifact.

### D-4 · LOW — empty directory `reviews/20260909-cycle/` in the skill repo
- **(a) Severity:** LOW
- **(b) Law site — `review-lenses.md:255` (corpus definition), verbatim:**
  > `` `reviews/<cycle>/reports/`; when two skill-review-index.log files ``
- **(c) Artifact:** `skills/opencrabs-dev/reviews/20260909-cycle/` — **empty** (verified: `ls` returned no entries). **Readers:** none (the real 09-09 Duty-6 cycles live in the STATE repo as `reviews/20260909-c3/c4`, per the `I-20260912` verdict-table §5 CORRECTION). **Writers:** `oc-review-persist` creates `reviews/<YYYYMMDD>-cycle/reports/` on demand — it would not leave a bare empty parent.
- **(d) Cost:** `unpriced`.
- **(e) Verdict:** **DELETE-SAFE (harmless)** — a directory stub with no readers; the corresponding real cycle store is elsewhere. Low blast radius: nothing writes into it.
- **(f) Remedy:** remove the empty dir (or leave — harmless). Any removal needs HQ's poll triple-check + owner word per the family gate.

### D-5 · LOW — state `archive/disabled-crons-20260911.json` is a 0-byte placeholder
- **(a) Severity:** LOW
- **(b) Law site — no law governs it; the artifact's own defining fact, verified live:**
  > `0  2026-09-11 19:56:54  disabled-crons-20260911.json` (0 bytes)
- **(c) Artifact:** `opencrabs-dev/archive/disabled-crons-20260911.json` (0 B). **Readers/writers:** a reference sweep across the whole workspace returns zero (precedent `reviews/20260911-c8/reports/review-lens-D.md:63`: `grep -rn "disabled-crons-20260911" tools/ crons/ skills/ -> 0 hits`).
- **(d) Cost:** `unpriced`.
- **(e) Verdict:** **DELETE-SAFE — already adjudicated** by prior D passes (`review-lens-D.md` c7 D4 MEDIUM "delete"; c8 D3 "DELETE-SAFE, 0 readers/writers"). I do **not** re-litigate; I record that it is still on disk and the prior verdict has **NOT EXECUTED** (consistent with the c7 I-lens note "NOT EXECUTED (consistent)"). This is a member of the D deletion **queue (QUEUE-1..6)** awaiting owner word.
- **(f) Remedy:** execute the queued delete on owner word (HQ poll triple-check first). No new action.

### D-6 · LOW — orphan wave lock `run/wave-230f0db95dea.lock` (no `.sent` twin)
- **(a) Severity:** LOW
- **(b) Law site — `tools/oc-notify-fanout:576-578`, verbatim:**
  > `LOCK_FILE="$RUN_DIR/wave-${wave_id}.lock"`
  > `SENT_FILE="$RUN_DIR/wave-${wave_id}.sent"`
  > `TARGETS_FILE="$RUN_DIR/wave-${wave_id}.targets"   # law 10: one uuid per send ATTEMPT`
  and law 7 (same file): a lock "(pid dead OR >15 min) is auto-cleared with a receipt line".
- **(c) Artifact:** `skills/opencrabs-dev/run/wave-230f0db95dea.lock` (32 B, mtime 2026-09-12 11:20:41) — **no** matching `.sent`. Sibling `.lock`/`.sent`/`.targets` files are live mechanisms: `.sent` is the ONLY evidence of partial delivery (`CHANGELOG.md:87`), `.targets` is the law-10 manifest. `run/` is gitignored (`CHANGELOG.md:874`), so these are unrecoverable if lost.
- **(d) Cost:** `unpriced`.
- **(e) Verdict:** the wave-file FAMILY = **KEEP** (mechanism). The orphan `.lock` = **stale-lock class** → reap via `oc-health --reap` (SAFE class, `RC-CONTRACT.md:34`), **never manual delete**.
- **(f) Remedy:** none needed — `oc-health --reap` already owns this class. Report-only.

### D-7 · LOW — 2026-09-12-dated `.bak` duplicates in the state dir (8 files)
- **(a) Severity:** LOW
- **(b) Law site — `tools/RC-CONTRACT.md:34` (`--reap` SAFE class), verbatim:**
  > `` `--reap` applies ONLY the provably-dead SAFE class (stale locks, backups beyond keep older than 24h, stale tmp `/tmp/oc-*`, leaked `mktemp` WORKDIRs) ``
- **(c) Artifact (all state dir, verified live):** `155-checkpoint.md.{081456,083126,101832}.bak`; `187-ship-state.md.2026-09-12T133553.bak`; `m2-3-recon-20260912.md.2026-09-12T151520.bak`; `mechanical-audit-20260912.md.2026-09-12T140715.bak`; `designs/20260912-191-tasks-list-scope-leak.md.{151130,151140}.bak`; `toolsmith-queue-20260912-postplan.md.2026-09-12T170501.bak`. **Readers:** none programmatic — these are pre-write backups of live working docs. **Writers:** the `write_file`/edit backup path.
- **(d) Cost:** `unpriced`.
- **(e) Verdict:** **ARCHIVE** — "backups beyond keep older than 24h" are the reap SAFE class. All are same-day (2026-09-12), so none is reap-eligible yet. Note the `151130`/`151140` pair (10 s apart) — the write-twice signature.
- **(f) Remedy:** none — `oc-health --reap` after 24 h. Report-only.

### D-8 · INFO — three stores a prior cycle listed as present are ABSENT from the live state dir
- **(a) Severity:** INFO
- **(b) Law site — `SKILL.md` §Glossary (state-dir definition), verbatim:**
  > `The state dir has NO tools/ — tools always resolve next to the invoking script.`
- **(c) Artifacts — verified live this session (each a positive existence test, not an empty result):**
  - `opencrabs-dev/waiters/` → **`Path does not exist`** (the D-20260907 report listed `waiters/ ~95 … KEEP`; the 176→165 archive-then-wipe + the `oc-waiter` retirement left it gone; the surviving store is `incident-evidence-20260909/waiters-journal-archive/`, per `fleet-directives.md:25` journal-retention law).
  - `opencrabs-dev/tools/` → **`Path does not exist`** (by design; prior D passes already recorded "QUEUE-2 moot by absence").
  - Ledger backups → `glob '*ledger*'` returns **exactly 2**: `workers-ledger.json`, `workers-ledger.json.lock`. The `.bak` / `.corrupt-2doc*` / `.ejected-n2187.json` files present in the **2026-09-10 H-lens snapshot** are **not at top level now**.
- **(d) Cost:** `unpriced`.
- **(e) Verdict:** no action on artifacts — this is a **citation warning**: any report that cites the 2026-09-10 H-lens `ls` snapshot as current state is citing a **snapshot, not live truth**. I verified each absence with an explicit path test, not by reading an empty grep.
- **(f) Remedy:** none.

---

## Checked and CLEAN

- **`tools/tests/battery-last.json`** — KEEP. Live reader `tools/oc-ledger:356` (`battery_receipt() { echo "$SKILL_DIR/tools/tests/battery-last.json"; }`), live writer `tools/tests/run.sh:72/793`, gitignored runtime artifact `tools/oc-ledger:802` (`RUNTIME_ARTIFACTS="tools/tests/battery-last.json"`), and `README.md:71` declares it "committed on purpose — it is the durable ship receipt". The `CHANGELOG.md:50` dirty-receipt incident is a *staging* hazard, not a staleness signal.
- **`fanout.lock.*` (30 files)** — KEEP. Never-unlinked by design (`CHANGELOG.md:255`, flock single-flight); writer `oc-deploy:1962`; reaper `oc-health:420`. Cleanup only via `oc-health --reap`. Count vs the 20260907 D pass (33): the mechanism is the same; no manual action.
- **`tools/archive/compiler.md` (24489 B)** — KEEP. Archived reference for the retired Compiler role; the battery covers the archaeology.
- **`host-swap.lock` (0 B) / `ship.lock` (0 B) / `tools.log.lock` / `workers-ledger.json.lock`** — KEEP. Live flock control files, read/written (`mechanical-audit-20260912.md:86-87` names `host-swap.lock` the swap mutex and `ship.lock` the Leg-3 merge serialization lock).
- **`oc-deploy-shadow.log` (0 B) + `oc-deploy-shadow.archive.log` (145 KB)** — KEEP. The rotated-tail pair (`oc-shadow-rotate`); an empty live tail after rotation is expected.
- **`oc-deploy/journal/` (~550 `fanout-*.jsonl` + `swap-*.jsonl`)** — KEEP. Reconstructability store (the per-run journals the unified `tools.log` aggregate does not replace).
- **`incident-evidence-20260909/`** (`duty6-drafts/`, `gate-logs/`, `scratch/`, `waiters-journal-archive/`, `skill-repo-smoke-verdicts.pre-canonical-20260909`) and **`incident-evidence-20260912/smoke-verdicts.log.decoy-20260912.bak` (49853 B)** — KEEP. The decoy retirement is a **completed ARCHIVE** (`fleet-directives.md:27`: "Decoy RETIRED 2026-09-12: archived to `incident-evidence-20260912/smoke-verdicts.log.decoy-20260912.bak`"); confirmed on disk — recorded, not re-proposed.
- **`reviews/` store (both repos)** — KEEP all. `reviews/20260912-cycle/` holds only the I report so far (indexed `2026-09-12T12:58:02Z`, sha `7da3a97f…`); `reviews/20260911-cycle/reports/` is the skill-repo mirror (4 reports).
- **`reviews/20260911-c5/` (state repo)** — KEEP. 40 reports incl. per-worker/per-project lens files; live cycle store.
- **`merge-20260906-state.md`** — **ARCHIVE** (prior D verdict stands; unchanged).
- **`triage-dossier-oc-waiter-batch-2026-09-06.md`** — **ARCHIVE** (prior D verdict stands; unchanged).
- **`OC_PR_SKIPPED_DISPATH` old spelling** — CLEAN/KEEP (historical ledger row only; live code+docs use `OC_PR_SKIPPED_DISPATCH`). Prior D verdict; not re-litigated.
- **`oc-contributors` / `oc-ci-parity` retirements** — the *verbs* are gone; the only surviving mentions are RETIRED markers in `SKILL.md:149`, `hq.md:306`, `README.md:55`, `CHANGELOG.md` — CLEAN (no live artifact to delete; the prose is the marker itself).

---

## NOT checked (scope limits)

1. **`fleet-directives.md` and `RC-CONTRACT.md` were read to their ends this pass; `editor.md`, `editor-upstream-pr.md`, `hq.md`, `toolsmith.md`, `triage.md`, `SKILL.md` were counted but not read line-by-line this pass** — artifact references inside their unread bodies are not enumerated here.
2. **No reference sweep of the state-repo `journal/` jsonl contents** — I listed the directory but did not grep inside `merge-upstream-*.jsonl`, `swap-*.jsonl`, `modum-gate-retired.jsonl`, `watchdog-13e4e1da.log` for reader/writer edges.
3. **`oc-deploy/journal/` was counted, not swept** — ~550 files; I did not sample their contents for dangling references.
4. **The `roster/2026-09-11/` subtree and `hooks/pre-push` were listed but not read.**
5. **No browser / external verification** — all claims rest on same-turn reads of the two local repos.
6. **I did not re-litigate any prior D verdict** (the 20260901/20260907/20260910/20260911-c6..c8 D passes); where a verdict stands unchanged I say so and cite it, per the family rule that a re-litigation is worse than a KEEP.
7. **The BOUNDARY vs J was respected** — I filed no finding about a law sentence assigning a state-derivable decision.

---

### Footer — evidence discipline
Every negative-existence claim above quotes its query + scope (or is a positive path-existence test, which is the stronger form). Every finding carries a `file:LINE` verbatim quote read **this session**. Verdicts DELETE-SAFE / ARCHIVE / KEEP are **proposals only** — nothing deletes without HQ's poll triple-check + owner word, per `review-lenses.md` §Reviewer D.
