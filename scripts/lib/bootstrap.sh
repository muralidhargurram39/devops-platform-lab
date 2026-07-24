#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "${PROJECT_ROOT}/scripts/lib/common.sh"
source "${PROJECT_ROOT}/scripts/lib/logger.sh"

source "${PROJECT_ROOT}/scripts/commands/version.sh"
source "${PROJECT_ROOT}/scripts/commands/help.sh"
