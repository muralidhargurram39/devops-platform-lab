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

source "$PROJECT_ROOT/tests/test_common.sh"

PLATFORM="$PROJECT_ROOT/scripts/platform"

###############################################################################
# Platform Metrics
###############################################################################

"$PLATFORM" metrics >/dev/null 2>&1

assert_equals \
    0 \
    $? \
    "CLI platform metrics"

###############################################################################
# Jenkins Metrics
###############################################################################

"$PLATFORM" metrics jenkins >/dev/null 2>&1

assert_equals \
    0 \
    $? \
    "CLI Jenkins metrics"

###############################################################################
# Invalid Service
###############################################################################

"$PLATFORM" metrics invalid >/dev/null 2>&1

assert_equals \
    1 \
    $? \
    "CLI invalid service"

###############################################################################
# Summary
###############################################################################

print_summary
