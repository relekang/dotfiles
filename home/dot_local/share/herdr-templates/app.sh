hp_setup_workspace() {
  local workspace_id="$1"
  local root_pane_id="$2"
  local editor_result editor_pane_id jjui_result jjui_pane_id

  editor_result="$(
    hp_herdr pane split "$root_pane_id" \
      --direction right \
      --cwd "$PWD" \
      --no-focus
  )"
  editor_pane_id="$(jq -r '.result.pane.pane_id' <<<"$editor_result")"

  jjui_result="$(
    hp_herdr pane split "$root_pane_id" \
      --direction down \
      --cwd "$PWD" \
      --no-focus
  )"
  jjui_pane_id="$(jq -r '.result.pane.pane_id' <<<"$jjui_result")"

  hp_herdr pane run "$root_pane_id" "claude" >/dev/null
  hp_herdr pane run "$editor_pane_id" "lv" >/dev/null
  hp_herdr pane run "$jjui_pane_id" "jjui" >/dev/null
}
