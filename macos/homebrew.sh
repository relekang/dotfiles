#!/bin/sh

if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" #> /tmp/homebrew-install.log

  brew tap phinze/cask
fi
