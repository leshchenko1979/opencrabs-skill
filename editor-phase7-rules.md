# editor-phase7-rules.md — Phase 7 reference rules (B12 split, v0.4.78)

Reference detail behind editor.md §Phase 7 (progressive disclosure — reviewer
G, Duty-6 2026-09-01: in-skill steps stay inline, load-bearing reference moves
here behind a one-line pointer). Load when harvesting onto an upstream base,
resolving conflicts on a PR head, or writing text for upstream surfaces.

- **HARVEST VERIFICATION SWEEP (Duty-4, v0.4.71):** after
  conflict resolution on a harvested branch, BEFORE the first gate dispatch:
  (a) `git diff origin/main...HEAD` symbol sweep — grep the branch diff for
  fork-renamed/fork-only symbols and verify each has a live caller in the
  UPSTREAM tree (a write-side helper whose fork-paired read side lived in a
  renamed caller is a guaranteed clippy dead-code RED);
  (b) fork-side-only attribute sweep — diff fork-main vs PR-tree for
  `#[allow(clippy::…)]`/cfg gates on every function the PR touches, port them
  explicitly (trailer-matched cherry-picks miss attributes that rode a
  trailer-less fork commit);
  (c) foreign-hunk conflicts (a hunk on fork `main` but absent on the target
  base) resolve by DROPPING the foreign side, verified by diffstat delta vs the
  fork-side pick;
  (d) verify a rebase-ported commit by `git patch-id` before cherry-pick —
  post-port shas differ from lane records while content is identical.

- **QUALIFIED FORK REFS on upstream surfaces (fork [#54](https://github.com/leshchenko1979/opencrabs/issues/54)):**
  a bare `#N` where N is a FORK issue number must never appear on an upstream
  surface (PR body, PR title, issue body, comment) OUTSIDE a code span — GitHub
  autolinks it against adolfousier's issue space and the tooltip points at an
  unrelated upstream issue (upstream #29 = memory-process question vs fork #29 =
  compaction signal). Write `leshchenko1979/opencrabs#N` or the full URL. Bare
  `#N` stays reserved for UPSTREAM-local references. Code spans are exempt
  (GitHub does not autolink inside backticks) — literal log-line quotes stay
  verbatim. Fork-side surfaces are unaffected (bare #N resolves correctly there).
