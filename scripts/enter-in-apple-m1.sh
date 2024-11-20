#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

SERVER_IP=$(./scripts/apple-m1-get-ip.sh)
ssh-keyscan -H ${SERVER_IP} >> ~/.ssh/known_hosts
ssh m1@${SERVER_IP}
