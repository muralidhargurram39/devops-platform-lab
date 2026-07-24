#!/usr/bin/env bash

PROJECT_NAME="DevOps Lab Platform"
PROJECT_VERSION="1.0.0"
CLI_NAME="platform"

require_service() {

    local service="$1"

    if [[ "$service" == "all" ]]; then
        return
    fi

    if compose_service_exists "$service"; then
        return
    fi

    die "Unknown service: ${service}"
}
