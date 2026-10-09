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

install_with_pacman() {
  local package="$1"

  if ! pacman -Q "$package" >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm "$package"
  fi
}

install_linux_package() {
  local package="$1"

  if have_cmd apt-get && have_cmd dpkg; then
    install_with_apt "$package"
  elif have_cmd pacman; then
    install_with_pacman "$package"
  else
    echo "warning: no supported Linux package manager found" >&2
    return 1
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

run_herdr() {
  if have_cmd mise; then
    mise exec herdr -- herdr "$@"
  elif [[ -x "$HOME/.local/bin/mise" ]]; then
    "$HOME/.local/bin/mise" exec herdr -- herdr "$@"
  else
    return 127
  fi
}

install_herdr_integrations() {
  local integration

  for integration in pi claude codex opencode; do
    if have_cmd "$integration"; then
      run_herdr integration install "$integration"
    fi
  done
}

install_herdr_plugins() {
  if ! run_herdr plugin list | grep -q '^vim-herdr-navigation\b'; then
    run_herdr plugin install paulbkim-dev/vim-herdr-navigation -y
  fi

  run_herdr plugin action list --plugin vim-herdr-navigation
}

if [[ "$(uname -s)" == Linux ]]; then
  install_linux_package zsh
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

case "$(uname -s)" in
  Darwin)
    ensure_homebrew
    install_with_brew starship
    install_with_brew neovim
    install_with_brew zsh-syntax-highlighting
    install_with_brew mise
    install_herdr_integrations
    install_herdr_plugins
    ;;
  Linux)
    install_linux_package neovim
    install_linux_package zsh-syntax-highlighting
    install_starship
    install_mise
    install_herdr_integrations
    install_herdr_plugins
    ;;
esac
