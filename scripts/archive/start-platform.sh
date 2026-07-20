#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/validation.sh"

header "Starting DevOps Lab Platform"

check_command docker
check_docker
check_compose
check_kind_network

info "Starting platform..."

docker compose up -d

echo
docker compose ps

success "Platform started successfully."
