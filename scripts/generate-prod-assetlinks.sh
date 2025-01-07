#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

source .envrc

SHA256_FINGERPRINT=$(keytool -list -v \
  -keystore "./keystore" \
  -alias "$PROD_CERTIFICATE_ALIAS_NAME" \
  -storepass "$PROD_CERTIFICATE_KEYSTORE_PASSWORD" 2>/dev/null | grep "SHA256:" | awk '{print $2}')

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

echo "dummy-website/.well-known/assetlinks.json file generate with success"
