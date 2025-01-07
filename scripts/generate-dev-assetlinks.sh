#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

source .envrc

SHA256_FINGERPRINT=$(keytool -list -v \
  -keystore "${HOME}/.android/debug.keystore" \
  -alias "androiddebugkey" \
  -storepass "android" 2>/dev/null | grep "SHA256:" | awk '{print $2}')

mkdir -p dummy-website/.well-known/
chmod -R 755 dummy-website

cat <<EOF > dummy-website/.well-known/assetlinks.json
[
  {
    "relation": [
        "delegate_permission/common.handle_all_urls"
    ],
    "target": {
      "namespace": "android_app",
      "package_name": "$PACKAGE_NAME",
      "sha256_cert_fingerprints": ["$SHA256_FINGERPRINT"]
    }
  }
]
EOF
chmod 755 dummy-website/.well-known/assetlinks.json

echo "dummy-website/.well-known/assetlinks.json file generate with success"
