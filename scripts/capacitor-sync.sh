#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

source ./scripts/load-variables.sh

gomplate -f capacitor.config.json.tmpl -o capacitor.config.json
gomplate -f android/app/build.gradle.tmpl -o android/app/build.gradle
gomplate -f android/app/src/main/AndroidManifest.xml.tmpl -o android/app/src/main/AndroidManifest.xml
gomplate -f android/app/src/main/strings.xml.tmpl -o android/app/src/main/res/values/strings.xml

npm run sync
