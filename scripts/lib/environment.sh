#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : environment.sh
# Purpose : Runtime environment configuration
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_ENVIRONMENT_LOADED:-}" ]] && return 0
readonly DEVOPS_ENVIRONMENT_LOADED=1

###############################################################################
# Runtime Paths
###############################################################################

readonly SCRIPT_DIR="$(
    cd "$(dirname "${BASH_SOURCE[1]}")/.." && pwd
)"

readonly PROJECT_ROOT="$(
    cd "${SCRIPT_DIR}/.." && pwd
)"

readonly LIB_DIR="${SCRIPT_DIR}/lib"
readonly COMMANDS_DIR="${SCRIPT_DIR}/commands"
readonly PROVIDERS_DIR="${SCRIPT_DIR}/providers"
readonly DOCS_DIR="${PROJECT_ROOT}/docs"
readonly TESTS_DIR="${PROJECT_ROOT}/tests"
readonly LOGS_DIR="${PROJECT_ROOT}/logs"

###############################################################################
# Runtime Initialization
###############################################################################

init_environment() {

    mkdir -p "${LOGS_DIR}"

}
