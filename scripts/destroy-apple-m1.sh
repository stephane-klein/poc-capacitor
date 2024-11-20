#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

SERVER_ID=$(scw apple-silicon server list -o json | jq -r '.[] | select(.name == "capacitor") | .id')

scw apple-silicon server delete $SERVER_ID zone=fr-par-3 --wait
