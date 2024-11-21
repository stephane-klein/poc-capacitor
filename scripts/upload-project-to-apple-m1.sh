#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

SERVER_IP=$(./scripts/apple-m1-get-ip.sh)
ssh-keygen -R ${SERVER_IP}
ssh-keyscan -H ${SERVER_IP} >> ~/.ssh/known_hosts

rsync -avz --delete --exclude='.git/' ./ m1@${SERVER_IP}:project/
