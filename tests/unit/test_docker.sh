#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(
    cd "$(dirname "${BASH_SOURCE[0]}")" &&
    pwd
)"

PROJECT_ROOT="$(
    cd "$SCRIPT_DIR/../.." &&
    pwd
)"

source "$PROJECT_ROOT/scripts/lib/bootstrap.sh"
source "$PROJECT_ROOT/tests/test_common.sh"

assert_true \
    "$(container_exists "$(service_container_name jenkins)"; echo $?)" \
    "Jenkins container exists"

assert_true \
    "$(container_running "$(service_container_name jenkins)"; echo $?)" \
    "Jenkins container is running"

print_summary
