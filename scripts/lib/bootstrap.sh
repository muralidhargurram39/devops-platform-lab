#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

CONFIG_DIR="${PROJECT_ROOT}/config"

source "${CONFIG_DIR}/environment.conf"

source "${CONFIG_DIR}/${ACTIVE_ENV}.conf"

source "${CONFIG_DIR}/services.conf"

# Libraries
source "${PROJECT_ROOT}/scripts/lib/common.sh"
source "${PROJECT_ROOT}/scripts/lib/logger.sh"
source "${PROJECT_ROOT}/scripts/lib/ui.sh"

# Providers
source "${PROJECT_ROOT}/scripts/providers/docker.sh"
source "${PROJECT_ROOT}/scripts/providers/compose.sh"
source "${PROJECT_ROOT}/scripts/providers/http.sh"

# Commands
source "${PROJECT_ROOT}/scripts/commands/version.sh"
source "${PROJECT_ROOT}/scripts/commands/help.sh"
source "${PROJECT_ROOT}/scripts/commands/setup.sh"
source "${PROJECT_ROOT}/scripts/commands/wake.sh"
source "${PROJECT_ROOT}/scripts/commands/sleep.sh"
source "${PROJECT_ROOT}/scripts/commands/start.sh"
source "${PROJECT_ROOT}/scripts/commands/stop.sh"
source "${PROJECT_ROOT}/scripts/commands/restart.sh"
source "${PROJECT_ROOT}/scripts/commands/status.sh"
source "${PROJECT_ROOT}/scripts/commands/health.sh"
