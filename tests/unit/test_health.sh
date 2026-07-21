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

result="$(health_check_service jenkins)"

status="$(cut -d'|' -f2 <<< "$result")"

assert_equals \
    "running" \
    "$status" \
    "Health engine reports Jenkins running"

print_summary
