#!/usr/bin/env bash
# Negative control for #307 — anchored Issue-Ref in-flight fencing.
# Proves: the OLD unanchored `git log --grep=#N` manufactures a file overlap
# from commit PROSE, and the NEW oc_claims resolver does not.
#
# Harness guards (AGENTS.md §Repro harnesses): explicit tool path, recursion
# guard, process budget cap.
set -u
[ "${OC_REPRO_DEPTH:-0}" -ge 1 ] && exit 99
export OC_REPRO_DEPTH=1
ulimit -u $(( $(ps -e --no-headers | wc -l) + 200 )) 2>/dev/null || true

SKILL_DIR="/root/.opencrabs/profiles/ops/skills/opencrabs-dev"
TOOLS="$SKILL_DIR/tools"
REPO="/root/opencrabs"
ISSUE=297

export OC_TOOLS_DIR="$TOOLS"
python3 - "$TOOLS" "$REPO" "$ISSUE" <<'PYEOF'
import os, subprocess, sys
tools_dir, repo, issue = sys.argv[1], sys.argv[2], int(sys.argv[3])
sys.path.insert(0, os.path.join(tools_dir, "lib"))
import oc_claims

def sh(*args):
    p = subprocess.run(args, capture_output=True, text=True)
    return p.returncode, p.stdout

fails = 0
def check(name, got, want_pred, detail=""):
    global fails
    ok = want_pred(got)
    print(("  ok   " if ok else "  FAIL ") + name)
    if not ok:
        fails += 1
        print("        got: %r" % (got,))
    if detail:
        print("        " + detail)

print("=== #307 negative control: issue #%d ===" % issue)

# --- NEW: anchored resolver -------------------------------------------------
new_files = oc_claims.resolve_issue_files(repo, issue)
new_commits = oc_claims.resolve_issue_commits(repo, issue)
print("\n[NEW] anchored resolver")
print("  commits: %d" % len(new_commits))
for c in new_commits:
    print("    %s" % c)
print("  files  : %s" % new_files)

check("new resolver returns the lane's real single file",
      new_files, lambda f: f == ["src/tests/memory_recall_test.rs"])
check("new resolver returns the lane's real commit",
      new_commits,
      lambda c: "f95566776fc2389ec51a8b9f792b42e8f3c8c162" in c)

# --- OLD: unanchored grep (the code #307 removed) ---------------------------
rc, out = sh("git", "-C", repo, "log", "-n", "10", "--grep=#%d" % issue, "--format=%H")
old_commits = [s.strip() for s in out.split() if s.strip()]
old_files = set()
if old_commits:
    rc2, out2 = sh("git", "-C", repo, "log", "--no-walk=unsorted", "--name-only",
                   "--format=", *old_commits)
    old_files = {l.strip() for l in out2.splitlines() if l.strip()}
old_files = sorted(old_files)

print("\n[OLD] unanchored `git log -n 10 --grep=#%d`" % issue)
print("  commits: %d" % len(old_commits))
for c in old_commits:
    print("    %s" % c)
print("  files  : %s" % old_files)

check("old grep pulls in MORE commits than the anchored resolver",
      len(old_commits), lambda n: n > len(new_commits),
      "old=%d new=%d" % (len(old_commits), len(new_commits)))
check("old grep manufactures files the lane never touched",
      old_files, lambda f: set(f) - set(new_files),
      "fabricated: %s" % sorted(set(old_files) - set(new_files)))

# --- Prose-only control: a commit that MENTIONS the number must not anchor ---
print("\n[PROSE] commit citing the number in prose must NOT anchor")
# upstream commit 1e34378050: subject (#478), body prose (#300)
sha = "1e34378050e81ff8c6e8a552645e0d7ecd714304"
idx = oc_claims.issue_ref_index(repo)
check("prose-only upstream commit is absent from the anchor index",
      idx, lambda i: sha not in i)
check("prose-only commit does not anchor to #300",
      oc_claims.resolve_issue_commits(repo, 300, index=idx),
      lambda c: sha not in c)

print("\n%s (failures=%d)" % ("CONTROL PASSED" if fails == 0 else "CONTROL FAILED", fails))
sys.exit(1 if fails else 0)
PYEOF
