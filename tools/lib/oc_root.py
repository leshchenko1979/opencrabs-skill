"""oc_root.py — the python twin of lib/oc-root.sh.

Walk UP from a script to the first ancestor holding lib/oc-root.sh. The marker
is oc-root.sh itself (not a bare lib/), and a SYMLINKED lib/ is rejected — a
borrowed lib/ means that ancestor is not our root. That guard is load-bearing:
/tmp/lib was found symlinked to the real tools/lib (2026-09-25), which made a
symlink-following walk stop at /tmp for every script beneath it.

Falls back to the start path's own directory when no root is found above it,
so a fixture copy beside fake siblings keeps its historical semantics.

Usage in a pure-python tool (the bash-wrapper case reads $OC_TOOLS_DIR instead):

    import os, sys
    _d = os.path.dirname(os.path.abspath(__file__))
    while _d != "/" and not (os.path.isfile(os.path.join(_d, "lib", "oc-root.sh"))
                             and not os.path.islink(os.path.join(_d, "lib"))):
        if os.path.basename(_d) == "tools":
            break
        _d = os.path.dirname(_d)
    if os.path.isfile(os.path.join(_d, "lib", "oc-root.sh")) and not os.path.islink(os.path.join(_d, "lib")):
        TOOLS_DIR = _d
    else:
        TOOLS_DIR = os.path.dirname(os.path.abspath(__file__))
"""

import os


def resolve(start):
    """Return the tools dir for `start` (a file path). Never raises."""
    d = os.path.dirname(os.path.abspath(start))
    here = d
    while d and d != "/":
        if os.path.isfile(os.path.join(d, "lib", "oc-root.sh")) and not os.path.islink(os.path.join(d, "lib")):
            return d
        if os.path.basename(d) == "tools":
            break
        d = os.path.dirname(d)
    return here
