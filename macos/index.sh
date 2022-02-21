#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [[ "$(uname)" == 'Darwin' ]]; then

sudo softwareupdate --install-rosetta

  . "$DIR/macos.sh"
  . "$DIR/homebrew.sh"
  . "$DIR/brews.sh"
  . "$DIR/mas.sh"
  . "$DIR/iterm.sh"

fi
