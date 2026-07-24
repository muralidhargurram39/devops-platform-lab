#!/usr/bin/env bash

platform_start() {

    platform_validate

    local service="${1:-all}"

    require_service "$service"

    info "Starting ${service}..."

    if [[ "$service" == "all" ]]; then
        compose_start
    else
        compose_start "$service"
    fi

    info "Start completed."
}
