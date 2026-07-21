#!/usr/bin/env bash

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_CONFIG_LOADED:-}" ]] && return 0
readonly DEVOPS_CONFIG_LOADED=1

###############################################################################
# Project
###############################################################################

readonly PLATFORM_NAME="DevOps Lab Platform"
readonly PLATFORM_VERSION="1.0.0"

###############################################################################
# Docker
###############################################################################

readonly DEFAULT_COMPOSE_FILE="docker-compose.yml"
readonly COMPOSE_FILE="${DEFAULT_COMPOSE_FILE}"
readonly DEFAULT_NETWORK="devops-lab"

###############################################################################
# Runtime
###############################################################################

readonly DEFAULT_TIMEOUT=30
readonly DEFAULT_LOG_LINES=100
readonly DEFAULT_METRICS_INTERVAL=1

###############################################################################
# Docker Compose
###############################################################################

readonly DEFAULT_COMPOSE_PROJECT_NAME="devops-lab-platform"

###############################################################################
# Output
###############################################################################

readonly TABLE_WIDTH=60
readonly ENABLE_COLORS=true

###############################################################################
# Directories
###############################################################################

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
readonly LOG_DIR="$ROOT_DIR/logs"
readonly CONFIG_DIR="$ROOT_DIR/config"

###############################################################################
# Backup Configuration
###############################################################################

readonly BACKUP_ROOT="${PROJECT_ROOT}/backups"

readonly SNAPSHOT_DATE_FORMAT="%Y%m%d_%H%M%S"
