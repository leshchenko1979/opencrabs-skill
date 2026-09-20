#!/usr/bin/env python3
"""NEGATIVE CONTROL for fork #462 -- the false `Delivery FAILED` defect.

    fix(tools): oc-issue-dispatch prints a false Delivery FAILED on a notify
    timeout, skips the ledger stamp, and duplicates the dispatch on the next run

PROPERTY UNDER TEST
  When the notify transport times out (rc 124) and NO receipt is yet in
  session-notify.journal, `dispatch_to_lane` must:

    POST-FIX  return RC_UNVERIFIED (6) AND record the dispatch in the ledger,
              so `recent_dispatches()` suppresses it and the next `--auto`
              run does NOT re-wire the issue to a second lane.
    PRE-FIX   return 3 AND record NOTHING.
              ^^^ ARM 2 IS THE LOAD-BEARING LEG. It must FAIL the post-fix
              expectation, or the control proves nothing (CODE.md: a probe
              that cannot name an input it would fail on measures its own
              constants). When the baseline cannot be materialised, this
              control reports INCONCLUSIVE rather than PASS -- see BELOW.

ARMS
  ARM 1  post-fix, empty journal           -> rc 6 + stamp saying "unverified"
  ARM 2  PRE-FIX,  empty journal           -> rc 3 + NO stamp   <-- the defect
  ARM 3  post-fix, receipt already present -> rc 0 + stamp, NOT "unverified"
  ARM 4  post-fix, rc 2 (no_route)         -> rc 3 + NO stamp   <-- the allowlist
  ARM 5  post-fix, rc 4 (catch-all, #418)  -> rc 6 + stamp      <-- #433

THE PRE-FIX BASELINE (why it comes from git, not from this tree)
  ARM 2 needs the revision BEFORE the #462 fix. A committed control cannot
  read that from a scratch file, so it materialises the blob at the immutable
  sha the fix was built on:

      git -C <repo> show <BASE_SHA>:tools/oc-issue-dispatch

  BASE_SHA is the last commit before the fix and is an ancestor of `main`, so
  the blob is present in any clone that carries this control. If git or the
  blob is unavailable the control SKIPS ARM 2 and exits 2 (INCONCLUSIVE) --
  never 0. Reporting PASS without the discriminating arm is exactly the
  failure mode this control exists to prevent.

TEST-SPEED NOTE (stated, not hidden)
  `check_journal_receipt` is shimmed to force its grace/budget to 0. The
  DURATION of the poll is orthogonal to the CLASSIFICATION under test -- an
  empty journal returns False after one pass either way -- and letting it run
  naturally would cost 150s (post-fix budget) / 30s (pre-fix grace) per arm.
  The shim is signature-adaptive so it works against both revisions, and the
  real classification code path runs unchanged.

GUARDS (AGENTS.md "Repro harnesses and scratch scripts")
  explicit tool path (never $0) / recursion guard / process budget / caller runs
  this under `timeout -s KILL`.
"""
import os
import sys
import time
import shutil
import inspect
import datetime
import tempfile
import subprocess
import importlib.machinery
import importlib.util

if os.environ.get("OC_REPRO_DEPTH"):
    print("REFUSING: recursion guard (OC_REPRO_DEPTH already set)")
    sys.exit(99)
os.environ["OC_REPRO_DEPTH"] = "1"

# Repo root derived from this file's own location (tools/tests/<this>) so the
# control is portable -- never a hardcoded absolute path.
REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
TOOL_POST = os.path.join(REPO, "tools", "oc-issue-dispatch")
#: Last commit before the #462 fix. Immutable, and an ancestor of main.
BASE_SHA = "11e5ca34"
TARGET = "40427d4f-1a2b-4c3d-8e9f-000000000001"
ISSUE = 459
ENVELOPE = "[ISSUE DISPATCH: #459] stub envelope body"

# Resolve the LIVE journal BEFORE redirecting HOME. Used only as a shape
# template for the fixture line, with a hardcoded fallback below.
REAL_JOURNAL = os.path.expanduser(
    "~/.opencrabs/profiles/ops/logs/session-notify.journal")

FAILS = []


def check(name, cond, detail=""):
    """Explicit comparison -- never pass a bare truthy value."""
    ok = (cond is True)
    print("  %s %s%s" % ("PASS" if ok else "FAIL", name,
                         ("  [" + detail + "]") if detail else ""))
    if not ok:
        FAILS.append(name)
    return ok


def load(path):
    loader = importlib.machinery.SourceFileLoader("oid_negctl", path)
    spec = importlib.util.spec_from_loader("oid_negctl", loader)
    mod = importlib.util.module_from_spec(spec)
    loader.exec_module(mod)
    return mod


def materialize_baseline():
    """Write the pre-fix revision to a temp file; return its path or None."""
    try:
        proc = subprocess.run(
            ["git", "-C", REPO, "show", "%s:tools/oc-issue-dispatch" % BASE_SHA],
            stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, timeout=60)
    except Exception as exc:
        print("  baseline: git invocation failed (%s)" % exc)
        return None
    if proc.returncode != 0 or not proc.stdout:
        print("  baseline: `git show %s:tools/oc-issue-dispatch` returned rc=%d, %d bytes"
              % (BASE_SHA, proc.returncode, len(proc.stdout or b"")))
        return None
    fd, path = tempfile.mkstemp(prefix="oid-pre-", suffix=".py")
    with os.fdopen(fd, "wb") as fh:
        fh.write(proc.stdout)
    return path


def shim_grace(mod):
    """Force the receipt poll's grace/budget to 0, preserving the real logic."""
    orig = mod.check_journal_receipt
    nparams = len(inspect.signature(orig).parameters)

    def shim(target, start, journal_path=None, poll_grace_secs=0,
             send_budget_secs=0):
        args = [target, start, journal_path, 0]
        if nparams >= 5:
            args.append(0)
        return orig(*args)

    mod.check_journal_receipt = shim
    return nparams


def seed_journal_line(journal_path, target, ts=None):
    """Write ONE receipt line in the journal's own field layout."""
    if ts is None:
        ts = datetime.datetime.now(datetime.timezone.utc).isoformat()
    # Copy the live line's layout when it is readable, so the fixture cannot
    # drift from the parser it feeds. Falls back to a literal 5-field row.
    template = None
    try:
        with open(REAL_JOURNAL, "r", encoding="utf-8", errors="replace") as fh:
            for line in fh:
                parts = line.rstrip("\n").split("\t")
                if len(parts) >= 5 and "outcome=delivered" in parts[3]:
                    template = parts
    except Exception:
        template = None
    if template is None:
        template = ["TS", "caller=a2a:stub", "target=STUB",
                    "outcome=delivered", "exit=0"]
    row = list(template)
    row[0] = ts
    row[2] = "target=" + target
    row[3] = "outcome=delivered"
    row[4] = "exit=0"
    os.makedirs(os.path.dirname(journal_path), exist_ok=True)
    with open(journal_path, "a", encoding="utf-8") as fh:
        fh.write("\t".join(row) + "\n")


def run_arm(label, tool_src, seed_receipt, stub_rc=124):
    """One arm in its own scratch HOME + scratch tools/ dir."""
    scratch = tempfile.mkdtemp(prefix="oid-neg-")
    tools = os.path.join(scratch, "tools")
    os.makedirs(os.path.join(tools, "lib"), exist_ok=True)
    shutil.copy2(tool_src, os.path.join(tools, "oc-issue-dispatch"))

    # The tool imports the canonical claim predicate from tools/lib/ and REFUSES
    # to run without it (that refusal is itself correct behaviour, #329), so the
    # scratch tree must carry the real library -- only the transport is stubbed.
    real_lib = os.path.join(REPO, "tools", "lib")
    for entry in os.listdir(real_lib):
        if entry.endswith(".py"):
            shutil.copy2(os.path.join(real_lib, entry),
                         os.path.join(tools, "lib", entry))

    # Stub the notify wrapper with the rc UNDER TEST. rc 124 (our own timeout)
    # is the defect's premise; rc 2 (`no_route`) is the one rc that PROVES
    # nothing was sent; rc 4 is the documented catch-all (#418) that was
    # measured delivering for 2 of 4 lanes while reporting failure (#433).
    notify = os.path.join(tools, "lib", "oc-notify.sh")
    with open(notify, "w") as fh:
        fh.write("#!/bin/sh\nexit %d\n" % stub_rc)
    os.chmod(notify, 0o755)

    # Stub the ledger: record every `stamp note <text>` invocation.
    stamp_log = os.path.join(scratch, "ledger-rows.txt")
    ledger = os.path.join(tools, "oc-ledger")
    with open(ledger, "w") as fh:
        fh.write('#!/bin/sh\nprintf "%s\\n" "$*" >> "' + stamp_log + '"\n')
    os.chmod(ledger, 0o755)

    journal = os.path.join(scratch, ".opencrabs", "profiles", "ops",
                           "logs", "session-notify.journal")

    os.environ["HOME"] = scratch
    mod = load(os.path.join(tools, "oc-issue-dispatch"))
    shim_grace(mod)

    if seed_receipt:
        seed_journal_line(journal, TARGET)

    rc = mod.dispatch_to_lane(TARGET, ENVELOPE, ISSUE)

    rows = []
    if os.path.exists(stamp_log):
        with open(stamp_log) as fh:
            rows = [r.rstrip("\n") for r in fh if r.strip()]
    shutil.rmtree(scratch, ignore_errors=True)
    return rc, rows


print("=" * 72)
print("NEGATIVE CONTROL -- oc-issue-dispatch / fork #462")
print("=" * 72)

# --- preflight: post-fix shape (always) -----------------------------------
post_src = open(TOOL_POST).read()
post_lines = sum(1 for _ in open(TOOL_POST))
check("preflight: post-fix HAS RC_UNVERIFIED", "RC_UNVERIFIED" in post_src)
check("preflight: post-fix dropped the dead 'session-notify' cmd shape",
      'cmd = [notify_bin, "session-notify"' not in post_src)
check("preflight: post-fix carries the ALLOWLIST in its pure predicate",
      "def classify_notify_rc(" in post_src and "if rc == 2:" in post_src)
check("preflight: post-fix has NO inline rc arm in dispatch_to_lane",
      "elif rc != 2:" not in post_src)

# --- preflight: the pre-fix baseline, from git ----------------------------
print("\n[preflight] materialising the pre-fix baseline from git")
pre_path = materialize_baseline()
pre_src = None
if pre_path:
    pre_src = open(pre_path).read()
    pre_lines = sum(1 for _ in open(pre_path))
    print("  baseline: %d lines at %s" % (pre_lines, pre_path))
    check("preflight: the pre-fix source is the SMALLER (older) revision",
          pre_lines < post_lines, "pre=%d post=%d" % (pre_lines, post_lines))
    check("preflight: pre-fix LACKS RC_UNVERIFIED",
          "RC_UNVERIFIED" not in pre_src)
    check("preflight: pre-fix uses the dead 'session-notify' cmd shape",
          'cmd = [notify_bin, "session-notify"' in pre_src)
    check("preflight: pre-fix has NEITHER the predicate nor the allowlist",
          "def classify_notify_rc(" not in pre_src and "if rc == 2:" not in pre_src)
else:
    print("  SKIP: the baseline is unavailable -- ARM 2 cannot run")

# --- ARM 1: post-fix, timeout, no receipt ---------------------------------
print("\n[ARM 1] post-fix | rc124 | empty journal  -> expect rc 6 + unverified stamp")
rc1, rows1 = run_arm("arm1", TOOL_POST, seed_receipt=False)
check("arm1 rc is RC_UNVERIFIED (6)", rc1 == 6, "got %r" % (rc1,))
check("arm1 DID stamp the dispatch", len(rows1) == 1, "%d row(s)" % len(rows1))
if rows1:
    check("arm1 stamp says the receipt is unverified",
          "receipt unverified" in rows1[0], rows1[0][:120])

# --- ARM 2: PRE-FIX, timeout, no receipt  (THE LOAD-BEARING LEG) ----------
if pre_path:
    print("\n[ARM 2] PRE-FIX | rc124 | empty journal  -> expect rc 3 + NO stamp")
    rc2, rows2 = run_arm("arm2", pre_path, seed_receipt=False)
    check("arm2 rc is 3 (nothing sent) -- the defect", rc2 == 3, "got %r" % (rc2,))
    check("arm2 stamped NOTHING -- the defect", len(rows2) == 0,
          "%d row(s): %r" % (len(rows2), rows2[:1]))
    check("CONTROL DISCRIMINATES: post-fix rc != pre-fix rc", rc1 != rc2,
          "post=%r pre=%r" % (rc1, rc2))
    check("CONTROL DISCRIMINATES: post-fix stamped, pre-fix did not",
          (len(rows1) == 1 and len(rows2) == 0))
else:
    print("\n[ARM 2] SKIPPED -- no pre-fix baseline; the control cannot name an")
    print("        input it FAILS on, so this run is INCONCLUSIVE, not PASS.")

# --- ARM 3: post-fix, receipt already present -----------------------------
print("\n[ARM 3] post-fix | rc124 | receipt PRESENT -> expect rc 0 + verified stamp")
rc3, rows3 = run_arm("arm3", TOOL_POST, seed_receipt=True)
check("arm3 rc is 0 (receipt confirmed)", rc3 == 0, "got %r" % (rc3,))
check("arm3 DID stamp the dispatch", len(rows3) == 1, "%d row(s)" % len(rows3))
if rows3:
    check("arm3 stamp is NOT flagged unverified",
          "unverified" not in rows3[0], rows3[0][:120])

# --- ARM 4: post-fix, rc 2 -- the ONE rc that PROVES non-delivery ----------
print("\n[ARM 4] post-fix | rc2 (no_route) | empty journal -> expect rc 3 + NO stamp")
rc4, rows4 = run_arm("arm4", TOOL_POST, seed_receipt=False, stub_rc=2)
check("arm4 rc is 3 (nothing sent -- the one PROVEN non-delivery)", rc4 == 3,
      "got %r" % (rc4,))
check("arm4 stamped NOTHING (a retry is correct)", len(rows4) == 0,
      "%d row(s): %r" % (len(rows4), rows4[:1]))

# --- ARM 5: post-fix, rc 4 -- the documented CATCH-ALL (#418/#433) ---------
print("\n[ARM 5] post-fix | rc4 (transport catch-all) | empty journal -> expect rc 6 + stamp")
rc5, rows5 = run_arm("arm5", TOOL_POST, seed_receipt=False, stub_rc=4)
check("arm5 rc is RC_UNVERIFIED (6) -- rc 4 is not a non-delivery signal (#433)",
      rc5 == 6, "got %r" % (rc5,))
check("arm5 DID stamp the dispatch", len(rows5) == 1, "%d row(s)" % len(rows5))
if rows5:
    check("arm5 stamp says the receipt is unverified",
          "receipt unverified" in rows5[0], rows5[0][:120])

# --- the predicate is rc-2-SPECIFIC, not "any non-zero" -------------------
check("PREDICATE: rc2 / rc124 / rc4 are classified DIFFERENTLY",
      rc4 == 3 and rc1 == 6 and rc5 == 6,
      "rc2=%r rc124=%r rc4=%r" % (rc4, rc1, rc5))

baseline_ok = pre_path is not None
if pre_path:
    try:
        os.unlink(pre_path)
    except OSError:
        pass

print("\n" + "=" * 72)
if FAILS:
    print("NEGATIVE CONTROL: FAIL (%d)" % len(FAILS))
    for f in FAILS:
        print("   - " + f)
    sys.exit(1)
if not baseline_ok:
    print("NEGATIVE CONTROL: INCONCLUSIVE (ARM 2 could not run)")
    print("=" * 72)
    sys.exit(2)
print("NEGATIVE CONTROL: PASS")
print("=" * 72)
sys.exit(0)
