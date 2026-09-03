hp_setup_workspace() {
  local workspace_id="$1"
  local app_result app_pane_id ui_result ui_pane_id tasks_result tasks_pane_id

  app_result="$(
    hp_herdr tab create \
      --workspace "$workspace_id" \
      --cwd "$PWD" \
      --label app \
      --no-focus
  )"
  app_pane_id="$(jq -r '.result.root_pane.pane_id' <<<"$app_result")"

  ui_result="$(
    hp_herdr pane split "$app_pane_id" \
      --direction right \
      --cwd "$PWD" \
      --no-focus
  )"
  ui_pane_id="$(jq -r '.result.pane.pane_id' <<<"$ui_result")"

  tasks_result="$(
    hp_herdr pane split "$ui_pane_id" \
      --direction down \
      --cwd "$PWD" \
      --no-focus
  )"
  tasks_pane_id="$(jq -r '.result.pane.pane_id' <<<"$tasks_result")"

  hp_herdr pane run "$app_pane_id" "mise r app:server" >/dev/null
  hp_herdr pane run "$ui_pane_id" "mise r app:ui" >/dev/null
  hp_herdr pane run "$tasks_pane_id" "mise r app:tasks" >/dev/null
}
