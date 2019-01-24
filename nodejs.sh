#!/bin/bash

URL=https://github.com/Schniz/fnm/releases/download/v1.0.0/fnm-macos.zip

set -exu

wget $URL -O /tmp/fnm.zip
unzip -o /tmp/fnm.zip -d /tmp
mv /tmp/fnm-macos/fnm /usr/local/bin/fnm
chmod +x /usr/local/bin/fnm
