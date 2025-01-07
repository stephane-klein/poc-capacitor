#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

source .envrc
source ./scripts/load-variables.sh
./scripts/generate-dev-assetlinks.sh
npm run build
./scripts/capacitor-sync.sh
npx cap run android
