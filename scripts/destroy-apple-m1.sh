#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

SERVER_ID=$(scw apple-silicon server list -o json | jq -r '.[] | select(.name == "capacitor") | .id')

read -p "Confirm that you want to destroy the server? ? (y/n) : " response

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Destroy the server…"
    scw apple-silicon server delete $SERVER_ID zone=fr-par-3
else
    echo "Server destroy canceled"
fi

