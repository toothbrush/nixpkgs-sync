#!/usr/bin/env bash
# Render README.md from git-sync JSON.
# Needs RUN_URL; failed rows link to it.
set -euo pipefail

result=$1
upstream=https://github.com/NixOS/nixpkgs
now=$(date -u '+%Y-%m-%d %H:%M UTC')
failed="❌ [failed](${RUN_URL:?RUN_URL is required})"

branches=$(grep -vE '^[[:space:]]*(#|$)' branches.txt | jq -R . | jq -s .)

if jq -e '.plans' "$result" > /dev/null 2>&1; then
  rows=$(jq -r --arg now "$now" --arg up "$upstream" --arg failed "$failed" --argjson branches "$branches" '
    .plans as $plans
    | $branches[] as $b
    | ([$plans[] | select(.sourceRef == "refs/heads/" + $b)][0]) as $p
    | ($p.sourceHash // "") as $sha
    | (if (($p.action // "") | IN("skip", "create", "update")) then "✅" else $failed end) as $ok
    | (if $sha == "" then "–" else "[`\($sha[0:12])`](\($up)/commit/\($sha))" end) as $link
    | "| `\($b)` | \($link) | \($now) | \($ok) |"
  ' "$result")
else
  # No sync result: keep last commit
  rows=$(jq -r '.[]' <<< "$branches" | while IFS= read -r b; do
    old=$(grep -F "| \`$b\` |" README.md | head -n 1 || true)
    link=$(awk -F ' [|] ' '{print $2}' <<< "$old")
    synced=$(awk -F ' [|] ' '{print $3}' <<< "$old")
    printf '| `%s` | %s | %s | %s |\n' "$b" "${link:-–}" "${synced:-–}" "$failed"
  done)
fi

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
