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

logs_show_service jenkins >/dev/null 2>&1

assert_equals \
    0 \
    $? \
    "Logs engine executed successfully"

logs_show_service invalid >/dev/null 2>&1

assert_equals \
    1 \
    $? \
    "Logs engine rejects unknown service"

print_summary
