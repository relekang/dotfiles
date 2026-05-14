#!/usr/bin/env bash
set -euo pipefail

repo_ssh="git@github.com:relekang/dotfiles.git"

have_cmd() {
  command -v "$1" >/dev/null 2>&1
}

open_url() {
  local url="$1"

  if have_cmd open; then
    open "$url"
  elif have_cmd xdg-open; then
    xdg-open "$url" >/dev/null 2>&1 || true
  else
    echo "Open this URL manually: $url"
  fi
}

install_chezmoi() {
  if have_cmd chezmoi; then
    return
  fi

  echo "Installing chezmoi"
  sh -c "$(curl -fsLS get.chezmoi.io)"

  if [ -x "$HOME/bin/chezmoi" ]; then
    export PATH="$HOME/bin:$PATH"
  elif [ -x "$HOME/.local/bin/chezmoi" ]; then
    export PATH="$HOME/.local/bin:$PATH"
  fi
}

ensure_ssh_key() {
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"

  if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
    echo "SSH key already exists"
    return
  fi

  echo "Creating SSH key"
  ssh-keygen -t ed25519 -C "me@rolflekang.com" -f "$HOME/.ssh/id_ed25519" -N ""

  if have_cmd pbcopy; then
    pbcopy < "$HOME/.ssh/id_ed25519.pub"
    echo "Copied public key to clipboard"
  elif have_cmd wl-copy; then
    wl-copy < "$HOME/.ssh/id_ed25519.pub"
    echo "Copied public key to clipboard"
  elif have_cmd xclip; then
    xclip -selection clipboard < "$HOME/.ssh/id_ed25519.pub"
    echo "Copied public key to clipboard"
  else
    echo "Public key:"
    cat "$HOME/.ssh/id_ed25519.pub"
  fi
}

ensure_ssh_agent() {
  if [ -z "${SSH_AUTH_SOCK:-}" ]; then
    eval "$(ssh-agent -s)" >/dev/null
  fi

  ssh-add "$HOME/.ssh/id_ed25519" >/dev/null 2>&1 || true
}

ensure_github_ssh() {
  if ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new -T git@github.com 2>&1 | grep -Eq "successfully authenticated|Hi "; then
    echo "GitHub SSH access is ready"
    return
  fi

  echo "GitHub SSH access is not ready yet"
  open_url "https://github.com/settings/ssh/new"
  read -r -p "Add the SSH key in GitHub, then press enter to continue..."
}

install_chezmoi
ensure_ssh_key
ensure_ssh_agent
ensure_github_ssh

exec chezmoi init --apply "$repo_ssh"
