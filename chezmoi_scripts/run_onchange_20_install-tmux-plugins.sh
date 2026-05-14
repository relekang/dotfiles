#!/usr/bin/env bash
set -euo pipefail

plugin_dir="$HOME/.tmux/plugins/tpm"

if [[ -d "$plugin_dir/.git" ]]; then
  exit 0
fi

mkdir -p "$HOME/.tmux/plugins"

if ! git clone --depth 1 https://github.com/tmux-plugins/tpm "$plugin_dir"; then
  echo "warning: failed to install tmux plugin manager" >&2
fi
