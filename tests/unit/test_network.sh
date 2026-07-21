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

tcp_port_open localhost 8080
assert_true $? "Jenkins port is open"

status="$(http_status http://localhost:8080/login)"

assert_equals \
    "200" \
    "$status" \
    "Jenkins HTTP endpoint"

print_summary
