#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ -d "/Applications/BitBar.app" ]]; then
  echo "BitBar already installed"
else
  brew cask install bitbar
fi

mkdir -p ~/.bitbar

for path in "$DIR"/scripts/*; do
  file="$(basename "$path")"
  if [[ ! -f "$HOME/.bitbar/$file" ]]; then
    echo "Creating symlink for $file"
    ln -s "$DIR/scripts/$file" "$HOME/.bitbar/$file"
  fi
done

open -a Bitbar
