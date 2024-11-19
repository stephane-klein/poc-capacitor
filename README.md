# Capacitor POC

See this note in french: https://notes.sklein.xyz/Projet%2017/

## Prerequisite

- [Mise](https://mise.jdx.dev/installing-mise.html)
- yq
- java-21-openjdk

On Fedora, follow these instructions:

```sh
$ dnf install -y dnf-plugins-core
$ dnf config-manager --add-repo https://mise.jdx.dev/rpm/mise.repo
$ dnf install -y mise yq java-21-openjdk-devel java-21-openjdk
```

## Getting started

### Android requirements installation

```sh
$ mise plugins install android-sdk https://github.com/Syquel/mise-android-sdk.git
$ mise install
$ rehash
$ sdkmanager --install \
    "emulator" \
    "platform-tools" \
    "build-tools;35.0.0" \
    "cmdline-tools;16.0" \
    "platforms;android-29" \
    "system-images;android-29;google_apis_playstore;x86_64"
$ avdmanager create avd \
    --name Pixel_Emulator \
    --package "system-images;android-31;google_apis_playstore;x86_64" \
    --device "pixel"
```

### Start Android emulator device

Before running the `npx cap run android` command, as described later in this README, you must to launch an Android terminal emulator.  
To launch this terminal, run the following command and wait about 1min for the device to be ready.

```sh
$ $ANDROID_HOME/emulator/emulator -avd Pixel_Emulator
```

### Launch app mobile in Android emulator

```sh
$ npm install
$ npx cap sync
$ npx cap run android
```
