#!/bin/bash

input=$(cat)

eval "$(echo "$input" | jq -r '
  @sh "model=\(.model.display_name)",
  @sh "effort=\(.effort.level // "")",
  @sh "cwd=\(.workspace.current_dir)",
  @sh "ctx=\(.context_window.used_percentage)",
  @sh "limit=\(.rate_limits.five_hour.used_percentage)"
')"

parts=("$model")

if [ -n "$effort" ]; then
  # high is the norm, so it stays default-colored and the others stand out.
  case "$effort" in
    low)    parts+=($'\033[34m'"$effort"$'\033[0m') ;;
    medium) parts+=($'\033[33m'"$effort"$'\033[0m') ;;
    xhigh)  parts+=($'\033[36m'"$effort"$'\033[0m') ;;
    max)    parts+=($'\033[31m'"$effort"$'\033[0m') ;;
    *)      parts+=("$effort") ;;
  esac
fi

if command -v jj >/dev/null 2>&1 && cd "$cwd" 2>/dev/null; then
  bookmark=$(jj log --ignore-working-copy --no-graph --color=never \
    -r 'heads(::@ & bookmarks())' -T 'bookmarks.join(",")' 2>/dev/null)
  empty=$(jj log --ignore-working-copy --no-graph --color=never \
    -r '@' -T 'if(empty, "(empty)", "")' 2>/dev/null)
  wc="${bookmark:+$bookmark }${empty}"
  [ -n "$wc" ] && parts+=("$wc")
fi

parts+=("ctx ${ctx}%")

# The 5h limit only matters as it gets close, so stay quiet below half.
[ "$limit" -ge 50 ] && parts+=("5h ${limit}%")

printf '%s\n' "$(IFS=$'\x1f'; echo "${parts[*]}")" | sed $'s/\x1f/ · /g'
