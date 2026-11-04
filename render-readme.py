#!/usr/bin/env python3
"""Render README.md from git-sync JSON."""
import json
import os
import re
import sys
from datetime import datetime, timezone

UPSTREAM = "https://github.com/NixOS/nixpkgs"
OK_ACTIONS = {"skip", "create", "update"}

now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC")
failed = f"❌ [failed]({os.environ['RUN_URL']})"
branches = [b.strip() for b in open("branches.txt") if b.strip() and not b.startswith("#")]
template = open("README.md.template").read()
old = open("README.md").read()

try:
    plans = {p["sourceRef"]: p for p in json.load(open(sys.argv[1]))["plans"]}
except (OSError, ValueError, KeyError):
    plans = None  # No sync result: keep old rows

rows = ["| Branch | Upstream commit | Last sync | Status |", "|---|---|---|---|"]
for b in branches:
    if plans is None:
        m = re.search(rf"^\| `{re.escape(b)}` \| (.*?) \| (.*?) \|", old, re.M)
        link, synced = m.groups() if m else ("–", "–")
        status = failed
    else:
        p = plans.get(f"refs/heads/{b}", {})
        sha = p.get("sourceHash", "")
        link = f"[`{sha[:12]}`]({UPSTREAM}/commit/{sha})" if sha else "–"
        synced = now
        status = "✅" if p.get("action") in OK_ACTIONS else failed
    rows.append(f"| `{b}` | {link} | {synced} | {status} |")

open("README.md", "w").write(template.replace("{{SYNC_TABLE}}", "\n".join(rows)))
