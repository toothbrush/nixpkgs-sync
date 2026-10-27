#!/usr/bin/env bash
# Render README.md from git-sync JSON.
set -euo pipefail

result=$1
upstream=https://github.com/NixOS/nixpkgs
now=$(date -u '+%Y-%m-%d %H:%M UTC')

# Skip when git-sync printed no JSON
if ! jq -e '.plans' "$result" > /dev/null 2>&1; then
  echo "no sync result; README unchanged" >&2
  exit 0
fi

branches=$(grep -vE '^[[:space:]]*(#|$)' branches.txt | jq -R . | jq -s .)
rows=$(jq -r --arg now "$now" --arg up "$upstream" --argjson branches "$branches" '
  .plans as $plans
  | $branches[] as $b
  | ([$plans[] | select(.sourceRef == "refs/heads/" + $b)][0]) as $p
  | ($p.sourceHash // "") as $sha
  | (if (($p.action // "") | IN("skip", "create", "update")) then "✅" else "❌" end) as $ok
  | (if $sha == "" then "–" else "[`\($sha[0:12])`](\($up)/commit/\($sha))" end) as $link
  | "| `\($b)` | \($link) | \($now) | \($ok) |"
' "$result")

table=$(printf '%s\n%s\n%s' \
  "| Branch | Upstream commit | Last sync | Status |" \
  "|---|---|---|---|" \
  "$rows")

while IFS= read -r line; do
  if [ "$line" = "{{SYNC_TABLE}}" ]; then
    printf '%s\n' "$table"
  else
    printf '%s\n' "$line"
  fi
done < README.md.template > README.md
