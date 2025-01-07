#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

source .envrc

rm keystore

keytool -genkey -v \
  -keystore "keystore" \
  -alias "$ALIAS_NAME" \
  -keyalg RSA \
  -keysize 2048 \
  -validity "$VALIDITY_DAYS" \
  -storepass "$KEYSTORE_PASSWORD" \
  -keypass "$KEY_PASSWORD" \
  -dname "$DNAME"

echo "Keystore created in ./keystore file"
