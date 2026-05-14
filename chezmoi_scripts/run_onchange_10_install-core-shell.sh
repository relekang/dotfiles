#!/usr/bin/env bash
set -euo pipefail

apt_updated=false

have_cmd() {
  command -v "$1" >/dev/null 2>&1
}

ensure_homebrew() {
  if have_cmd brew; then
    return
  fi

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_with_brew() {
  local formula="$1"

  if ! brew list "$formula" >/dev/null 2>&1; then
    brew install "$formula"
  fi
}

ensure_apt_updated() {
  if [[ "$apt_updated" == false ]]; then
    sudo apt-get update
    apt_updated=true
  fi
}

install_with_apt() {
  local package="$1"

  if ! dpkg -s "$package" >/dev/null 2>&1; then
    ensure_apt_updated
    sudo apt-get install -y "$package"
  fi
}

install_starship() {
  if ! have_cmd starship; then
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y
  fi
}

install_mise() {
  if ! have_cmd mise; then
    curl -fsSL https://mise.run | sh
  fi
}

install_jj_if_available() {
  if have_cmd jj; then
    return
  fi

  if have_cmd apt-cache && apt-cache show jj >/dev/null 2>&1; then
    install_with_apt jj
  else
    echo "warning: jj package not available via apt; install it manually" >&2
  fi
}

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

case "$(uname -s)" in
  Darwin)
    ensure_homebrew
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
    install_with_apt neovim
    install_with_apt zsh-syntax-highlighting
    install_starship
    install_mise
    install_jj_if_available
    ;;
esac
