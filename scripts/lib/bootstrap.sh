#!/usr/bin/env bash

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_BOOTSTRAP_LOADED:-}" ]] && return 0
readonly DEVOPS_BOOTSTRAP_LOADED=1

###############################################################################
# Bootstrap Paths
###############################################################################

BOOTSTRAP_DIR="$(
    cd "$(dirname "${BASH_SOURCE[0]}")" &&
    pwd
)"

LIB_DIR="$BOOTSTRAP_DIR"
SCRIPT_DIR="$(dirname "$BOOTSTRAP_DIR")"

###############################################################################
# Initialize Environment
###############################################################################

source "${LIB_DIR}/environment.sh"

init_environment

###############################################################################
# Load Core Libraries
###############################################################################

source "${LIB_DIR}/config.sh"
source "${LIB_DIR}/colors.sh"
source "${LIB_DIR}/constants.sh"
source "${LIB_DIR}/logger.sh"
source "${LIB_DIR}/common.sh"
source "${LIB_DIR}/ui.sh"

###############################################################################
# Load SDK Libraries
###############################################################################

source "${LIB_DIR}/services.sh"
source "${LIB_DIR}/docker.sh"
source "${LIB_DIR}/compose.sh"
source "${LIB_DIR}/network.sh"
source "${LIB_DIR}/validation.sh"

###############################################################################
# Load Framework Libraries
###############################################################################

source "${LIB_DIR}/diagnostics.sh"

###############################################################################
# Load Engines
###############################################################################

source "${LIB_DIR}/health.sh"
source "${LIB_DIR}/doctor.sh"
source "${LIB_DIR}/logs.sh"
source "$LIB_DIR/metrics.sh"
source "$LIB_DIR/lifecycle.sh"
source "$LIB_DIR/snapshot.sh"
source "$LIB_DIR/backup.sh"
source "${LIB_DIR}/docker_provider.sh"

###############################################################################
# Load Platform API
###############################################################################

source "${LIB_DIR}/status.sh"
source "${LIB_DIR}/platform.sh"

###############################################################################
# Load Commands
###############################################################################

for file in "${COMMANDS_DIR}"/*.sh; do
    source "$file"
done
