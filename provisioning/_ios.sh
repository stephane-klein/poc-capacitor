#!/usr/bin/env bash
set -e

echo "{{ .Env.M1_SUDO_PASSWORD }}" | sudo -S echo "Authentification success"

RULE="m1 ALL=(ALL) NOPASSWD: ALL"
sudo grep -q "^$RULE$" /etc/sudoers || echo "$RULE" | sudo tee -a /etc/sudoers >/dev/null

if ! command -v brew &> /dev/null; then
    echo "Homebrew installation…"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

touch ~/.zprofile
if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

if ! grep -q 'export LANG=en_US.UTF-8' ~/.zprofile; then
  echo 'export LANG=en_US.UTF-8' >> ~/.zprofile
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew outdated

# Script based on https://capacitorjs.com/docs/getting-started/environment-setup#ios-requirements

brew install cocoapods rsync mise yq xcodesorg/made/xcodes aria2 nvim jq

grep -qxF 'export JAVA_HOME="$(brew --prefix openjdk)/libexec/openjdk.jdk/Contents/Home"' ~/.zprofile || echo 'export JAVA_HOME="$(brew --prefix openjdk)/libexec/openjdk.jdk/Contents/Home"' >> ~/.zprofile
grep -qxF 'export PATH="$JAVA_HOME/bin:$PATH"' ~/.zprofile || echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zprofile

command -v mise &> /dev/null && ! grep -qxF 'eval "$(mise activate zsh)"' ~/.zprofile && echo 'eval "$(mise activate zsh)"' >> ~/.zprofile

mise plugins install android-sdk https://github.com/Syquel/mise-android-sdk.git
sudo arch -x86_64 gem install ffi

xcodes runtimes install "iOS 17.4"
