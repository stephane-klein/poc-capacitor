#!/usr/bin/env bash
set -e

echo "{{ .Env.M1_SUDO_PASSWORD }}" | sudo -S echo "Authentification success"

sleep 1

RULE="m1 ALL=(ALL) NOPASSWD: ALL"

sudo grep -q "^$RULE$" /etc/sudoers || echo "$RULE" | sudo tee -a /etc/sudoers >/dev/null

if ! command -v brew &> /dev/null; then
    echo "Homebrew installation…"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

touch ~/.zprofile
if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile; then
    echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew outdated

# Script based on https://capacitorjs.com/docs/getting-started/environment-setup#ios-requirements

brew install cocoapods
sudo arch -x86_64 gem install ffi
