#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

SERVER_ID=$(scw apple-silicon server list -o json | jq -r '.[] | select(.name == "capacitor") | .id')

scw apple-silicon server get $SERVER_ID -o json | jq
