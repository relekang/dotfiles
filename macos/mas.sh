#!/bin/bash

# Install Mac App Store Applications

INSTALLED=$(mas list)

function install() {
  if ! echo $INSTALLED | grep $1 > /dev/null; then
    mas install $1
  fi
}

install 413857545   # Divvy
install 409183694   # Keynote
install 803453959   # Slack
install 1263070803  # Lungo
install 568494494   # Pocket
install 1082624744  # Gifox
install 1471867429  # OTP Auth
install 904280696   # Things 3
install 1607635845  # Velja
install 1529448980  # Reeder
