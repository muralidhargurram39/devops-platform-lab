#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

CONFIG_DIR="${PROJECT_ROOT}/config"

BACKUP_ROOT="${PROJECT_ROOT}/backups"

source "${CONFIG_DIR}/environment.conf"

source "${CONFIG_DIR}/${ACTIVE_ENV}.conf"

source "${CONFIG_DIR}/services.conf"

# Libraries
source "${PROJECT_ROOT}/scripts/lib/common.sh"
source "${PROJECT_ROOT}/scripts/lib/logger.sh"
source "${PROJECT_ROOT}/scripts/lib/ui.sh"
source "${PROJECT_ROOT}/scripts/lib/validate.sh"
source "${PROJECT_ROOT}/scripts/lib/doctor.sh"
source "${PROJECT_ROOT}/scripts/lib/backup.sh"
source "${PROJECT_ROOT}/scripts/lib/restore.sh"

# Providers
source "${PROJECT_ROOT}/scripts/providers/docker.sh"
source "${PROJECT_ROOT}/scripts/providers/compose.sh"
source "${PROJECT_ROOT}/scripts/providers/http.sh"
source "${PROJECT_ROOT}/scripts/providers/http_provider.sh"
source "${PROJECT_ROOT}/scripts/providers/filesystem_provider.sh"

# Commands
source "${PROJECT_ROOT}/scripts/commands/version.sh"
source "${PROJECT_ROOT}/scripts/commands/help.sh"
source "${PROJECT_ROOT}/scripts/commands/setup.sh"
source "${PROJECT_ROOT}/scripts/commands/deploy.sh"
source "${PROJECT_ROOT}/scripts/commands/wake.sh"
source "${PROJECT_ROOT}/scripts/commands/sleep.sh"
source "${PROJECT_ROOT}/scripts/commands/start.sh"
source "${PROJECT_ROOT}/scripts/commands/stop.sh"
source "${PROJECT_ROOT}/scripts/commands/restart.sh"
source "${PROJECT_ROOT}/scripts/commands/status.sh"
source "${PROJECT_ROOT}/scripts/commands/health.sh"
source "${PROJECT_ROOT}/scripts/commands/logs.sh"
source "${PROJECT_ROOT}/scripts/commands/cleanup.sh"
source "${PROJECT_ROOT}/scripts/commands/config.sh"
source "${PROJECT_ROOT}/scripts/commands/shell.sh"
source "${PROJECT_ROOT}/scripts/commands/exec.sh"
source "${PROJECT_ROOT}/scripts/commands/doctor.sh"
source "${PROJECT_ROOT}/scripts/commands/backup.sh"
source "${PROJECT_ROOT}/scripts/commands/restore.sh"
