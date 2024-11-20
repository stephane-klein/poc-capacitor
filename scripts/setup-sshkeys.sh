#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

if ! scw iam ssh-key list -o json | jq -e '.[] | select(.name == "stephane-klein")' > /dev/null; then
    scw iam ssh-key create name=stephane-klein public-key="$(cat ~/Téléchargements/id_rsa_2016.pub)" project-id=$SCW_PROJECT_ID
fi
