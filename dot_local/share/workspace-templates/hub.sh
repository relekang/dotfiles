w_source_repo="$HOME/dev/crdbrd/hub"
w_destination_prefix="$HOME/dev/crdbrd/hub-"
w_tmux_project="hub"

# Since hub#5803 ports and the Redis cache DB derive from INSTANCE_NUMBER,
# the trailing digits of the checkout directory name. Workspaces keep
# descriptive names instead, so each claims a free instance number in a
# mise.local.toml (gitignored globally). Instance 0 is the main hub checkout.
w_instance_number_claimed() {
  local n="$1" dir
  for dir in "$HOME"/dev/crdbrd/hub*/; do
    if [[ -f "$dir/mise.local.toml" ]]; then
      if grep -q "^INSTANCE_NUMBER = \"$n\"\$" "$dir/mise.local.toml"; then
        return 0
      fi
    elif [[ "$(basename "$dir" | grep -oE '[0-9]+$')" == "$n" ]]; then
      return 0
    fi
  done
  return 1
}

w_pick_instance_number() {
  local n
  for n in 1 2 3 4 5 6 7 8 9; do
    if ! w_instance_number_claimed "$n" && ! port_in_use $((8000 + n * 10)); then
      printf '%s\n' "$n"
      return 0
    fi
  done
  echo "Error: no free instance number (1-9)" >&2
  return 1
}

w_post_create() {
  local instance_number
  instance_number="$(w_pick_instance_number)"

  # The ports are recomputed here because mise evaluates .mise/config.toml
  # before this file, so the upstream derivations use the wrong number.
  cat >mise.local.toml <<EOF
[env]
INSTANCE_NUMBER = "$instance_number"
WEB_PORT = "{{ 8000 + (env.INSTANCE_NUMBER | int) * 10 }}"
VITE_PORT = "{{ 8002 + (env.INSTANCE_NUMBER | int) * 10 }}"
WORKER_METRICS_PORT = "{{ 9000 + (env.INSTANCE_NUMBER | int) * 10 }}"
REDIS_CACHE_URL = "{{ 'redis://localhost:6380/' ~ env.INSTANCE_NUMBER }}"
EOF
  echo "Wrote mise.local.toml (instance $instance_number)"

  mise trust
  mise r install
  ln -s "$w_source_repo/src/local_scripts" "$destination/src/local_scripts"
  ln -s "$w_source_repo/ty.toml" "$destination/ty.toml"
  ln -s "$w_source_repo/.plans" "$destination/.plans"
  ln -s "$w_source_repo/.results" "$destination/.results"
  ln -s "$w_source_repo/.reviews" "$destination/.reviews"
}
