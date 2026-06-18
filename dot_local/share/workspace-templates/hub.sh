w_source_repo="$HOME/dev/crdbrd/hub"
w_destination_prefix="$HOME/dev/crdbrd/hub-"
w_tmux_project="hub"
w_base_ports=(8010 8020 8030 8040 8050 8060 8070 8080 8090)

w_extra_env_lines() {
  local base_port="$1"
  local vite_port

  vite_port=$((base_port + 1))
  if port_in_use "$vite_port"; then
    vite_port=$((base_port + 2))
  fi

  if port_in_use "$vite_port"; then
    echo "Error: no available VITE_PORT for base port $base_port" >&2
    return 1
  fi

  printf 'VITE_PORT=%s\n' "$vite_port"
}

w_post_create() {
  mise trust
  mise r install
  ln -s "$w_source_repo/src/local_scripts" "$destination/src/local_scripts"
  ln -s "$w_source_repo/ty.toml" "$destination/ty.toml"
  ln -s "$w_source_repo/.plans" "$destination/.plans"
  ln -s "$w_source_repo/.results" "$destination/.results"
  ln -s "$w_source_repo/.reviews" "$destination/.reviews"
}
