#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

./scripts/setup-sshkeys.sh
scw apple-silicon server create name=capacitor project-id=$SCW_PROJECT_ID type=M1-M os-id=e08d1e5d-b4b9-402a-9f9a-97732d17e374 zone=fr-par-3 --wait
