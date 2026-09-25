#!/usr/bin/env python3
"""oc_parent_propose — mechanically-derived candidate parents for fork issues.

Owner order 2026-09-25 ("go filing gate"). The Continuous Issue Relationship
Linking Mandate lapsed because nothing enforced it; this module supplies the
candidates the gate prints.

TWO SOURCES, because the two callers have different information:

  propose_by_scope(title)      a NEW issue has no commits yet, so the only
                               mechanical signal is the `(scope)` token in its
                               own title, matched against open issues. Works
                               BEFORE filing, which is when the gate runs.

  propose_by_blame(repo, N)    an EXISTING issue can be traced through its
                               commits: blame the pre-image lines each fix
                               commit touched, at that commit's parent, and take
                               the blamed commit's issue token. This is the
                               engine whose yield was measured over 137
                               parentless issues.

NEITHER AUTO-LINKS. Blame is confidently WRONG when a fix adds new plumbing
whose pre-image lines were written by unrelated infrastructure (live specimen:
#487's top-1 blamed candidate was #405; the real feature is #286). Candidates
are an INPUT to a lane's judgement.

TWO INSTRUMENT TRAPS, both reproduced live and both producing a confident 0%
rather than an error -- the class this cycle has been closing:
  (a) `git blame -s` emits ABBREVIATED shas, so a 40-hex regex matches nothing.
      Always pass --abbrev=40.
  (b) a hunk regex `^@@` without re.M anchors to string start and matches ZERO
      hunks on every file. Always pass re.M.
Both have positive controls in the selftest.
"""
import collections
import os
import re
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import oc_claims  # noqa: E402

#: The title prefix the mandate scopes to: ^(fix|bug)[(:]
FIX_TITLE_RE = re.compile(r"^(fix|bug)[(:]", re.IGNORECASE)
#: `type(scope): subject` -- the scope is what we match on.
SCOPE_RE = re.compile(
    r"^\s*(?:fix|feat|bug|docs|chore|test|refactor|perf|build|ci)\s*\(([^)]+)\)",
    re.IGNORECASE)
HUNK_RE = re.compile(r"^@@ -(\d+)(?:,(\d+))? \+\d+(?:,\d+)? @@", re.M)
FULL_SHA_RE = re.compile(r"\b[0-9a-f]{40}\b")


def _git(repo, *args):
    try:
        p = subprocess.run(["git", "-C", repo] + list(args),
                           capture_output=True, text=True, timeout=120)
    except Exception:
        return None
    return p.stdout if p.returncode == 0 else None


def title_scope(title):
    """The `(scope)` token of a conventional-commit title, lowercased."""
    m = SCOPE_RE.match(title or "")
    return m.group(1).strip().lower() if m else None


def is_fix_title(title):
    """Does the title carry the prefix the linking mandate scopes to?"""
    return bool(FIX_TITLE_RE.match(title or ""))


def propose_by_scope(title, open_issues):
    """Candidates from the title's own scope token.

    `open_issues` is a list of {number, title}. Returns (scope, candidates) where
    candidates are [(number, title)] of OPEN issues sharing the scope, newest
    first. An absent scope, or one no open issue shares, returns an empty list --
    never a guess.
    """
    scope = title_scope(title)
    if not scope:
        return None, []
    out = []
    for r in open_issues:
        if title_scope(r.get("title", "")) == scope:
            out.append((r["number"], r.get("title", "")))
    out.sort(key=lambda t: t[0], reverse=True)
    return scope, out


def fix_commits(repo, iss, index=None):
    """The commits whose Issue-Ref trailer names `iss`."""
    try:
        return sorted(oc_claims.resolve_issue_commits(repo, iss, index=index) or [])
    except Exception:
        return []


def blame_candidates(repo, commit, index):
    """Blamed commits for one fix commit's pre-image lines.

    Returns (counts, hunk_total). counts maps full sha -> hits. hunk_total is the
    number of hunks parsed -- a ZERO here with a non-empty diff is trap (b), so
    it is returned rather than swallowed.
    """
    parent = (_git(repo, "rev-parse", commit + "^") or "").strip()
    if not parent:
        return {}, 0
    files = (_git(repo, "show", "--name-only", "--format=", commit) or "").split()
    counts = collections.Counter()
    hunk_total = 0
    for f in files:
        diff = _git(repo, "diff", parent, commit, "--", f)
        if not diff:
            continue
        for m in HUNK_RE.finditer(diff):          # trap (b): re.M is load-bearing
            start = int(m.group(1))
            n = int(m.group(2) or 1)
            bl = _git(repo, "blame", "-s", "--abbrev=40",   # trap (a)
                      "-L%d,+%d" % (start, max(n, 1)), parent, "--", f)
            if not bl:
                continue
            hunk_total += 1
            for line in bl.splitlines():
                tok = line.split(" ", 1)[0]
                if FULL_SHA_RE.fullmatch(tok):     # only FULL shas count
                    counts[tok] += 1
    return counts, hunk_total


def propose_by_blame(repo, iss, index=None, limit=5):
    """Candidates from the blame engine, ranked by hit count.

    Returns a dict with the yield classification so a caller can SAY WHY it has
    nothing rather than printing an empty list: `no_commit` (structurally blind
    -- ~44% of parentless issues have no commit on main), `no_hunk` (trap (b)),
    `no_originator` (commit found, no issue token -- ~25%).
    """
    index = index if index is not None else oc_claims.issue_ref_index(repo)
    commits = fix_commits(repo, iss, index=index)
    if not commits:
        return {"status": "no_commit", "candidates": [], "blamed": 0, "hunks": 0}
    total = collections.Counter()
    hunks = 0
    for c in commits:
        counts, h = blame_candidates(repo, c, index)
        total.update(counts)
        hunks += h
    if hunks == 0:
        return {"status": "no_hunk", "candidates": [], "blamed": sum(total.values()),
                "hunks": 0}
    if not total:
        return {"status": "no_originator", "candidates": [], "blamed": 0, "hunks": hunks}
    # Rank by hit count, then resolve each blamed commit to its issue tokens.
    ranked = []
    for sha, hits in total.most_common():
        for tok in (index.get(sha) or []):
            if tok != iss:
                ranked.append((tok, hits, sha))
    # Collapse per issue, keeping the strongest hit count.
    per = {}
    for tok, hits, sha in ranked:
        if tok not in per or hits > per[tok][0]:
            per[tok] = (hits, sha)
    out = sorted(((t, v[0], v[1]) for t, v in per.items()),
                 key=lambda x: (-x[1], x[0]))[:limit]
    status = "ok" if len(out) == 1 else ("multiple" if out else "no_originator")
    return {"status": status, "candidates": out,
            "blamed": sum(total.values()), "hunks": hunks}
