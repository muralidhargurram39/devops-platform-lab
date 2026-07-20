#!/usr/bin/env bash

[[ -n "${DEVOPS_BOOTSTRAP_LOADED:-}" ]] && return 0
readonly DEVOPS_BOOTSTRAP_LOADED=1

source "${SCRIPT_DIR}/lib/environment.sh"
init_environment

source "${LIB_DIR}/colors.sh"

source "${LIB_DIR}/constants.sh"

source "${LIB_DIR}/logger.sh"

source "${LIB_DIR}/common.sh"

source "${LIB_DIR}/ui.sh"

source "${LIB_DIR}/services.sh"

source "${LIB_DIR}/docker.sh"

source "${LIB_DIR}/compose.sh"

source "${LIB_DIR}/network.sh"

source "${LIB_DIR}/validation.sh"

source "${LIB_DIR}/diagnostics.sh"

source "${LIB_DIR}/health.sh"

source "${LIB_DIR}/doctor.sh"

source "${LIB_DIR}/platform.sh"

for file in "${COMMANDS_DIR}"/*.sh; do
    source "$file"
done
