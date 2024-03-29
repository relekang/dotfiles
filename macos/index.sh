#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

. "$DIR/../utils/shell-utils.sh"

if [[ "$(uname)" == 'Darwin' ]]; then

  if [ ! -f /Library/Apple/usr/share/rosetta/rosetta ]; then
    echo -e $(lightred "Installing rosetta (requires sudo)\033[0m")
    sudo softwareupdate --install-rosetta
  fi

  . "$DIR/macos.sh"
  . "$DIR/homebrew.sh"
  . "$DIR/brews.sh"
  . "$DIR/mas.sh"
  . "$DIR/iterm.sh"


  if [[ ! -f ~/.bun/bin/bun ]]; then 
    curl -fsSL https://bun.sh/install | bash
  fi

  if command -v defaultbrowser &> /dev/null; then
    if [ -d "/Applications/Velja.app" ]; then
      echo -e $(bold "Setting Velja as default browser")
      defaultbrowser Velja
    else
      echo -e $(bold "Setting firefox as default browser")
      defaultbrowser firefox
    fi
  else
    echo "Missing defaultbrowser command"
  fi
fi
