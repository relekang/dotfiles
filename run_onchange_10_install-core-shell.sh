#!/usr/bin/env bash
set -euo pipefail

have_cmd() {
  command -v "$1" >/dev/null 2>&1
}

install_with_brew() {
  local formula="$1"

  if have_cmd brew && ! brew list "$formula" >/dev/null 2>&1; then
    brew install "$formula"
  fi
}

install_with_apt() {
  local package="$1"

  if have_cmd apt-get && ! dpkg -s "$package" >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y "$package"
  fi
}

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

case "$(uname -s)" in
  Darwin)
    install_with_brew starship
    install_with_brew tmux
    install_with_brew jj
    install_with_brew neovim
    install_with_brew fzf
    install_with_brew zoxide
    install_with_brew zsh-syntax-highlighting
    install_with_brew mise
    ;;
  Linux)
    install_with_apt tmux
    install_with_apt fzf
    install_with_apt zsh-syntax-highlighting
    ;;
esac
