#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

SERVER_IP=$(./scripts/apple-m1-get-ip.sh)
ssh-keyscan -H ${SERVER_IP} >> ~/.ssh/known_hosts

SERVER_ID=$(scw apple-silicon server list -o json | jq -r '.[] | select(.name == "capacitor") | .id')
export M1_SUDO_PASSWORD=$(scw apple-silicon server get $SERVER_ID -o json | jq -r '.sudo_password')

gomplate -f ./provisioning/_ios.sh | ssh -t m1@${SERVER_IP} 'bash -s'
