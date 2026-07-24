#!/usr/bin/env bash

platform_start() {

    platform_setup

    local service="${1:-all}"

    require_service "$service"

    info "Starting ${service}..."

    if [[ "$service" == "all" ]]; then
        compose_start_all
    else
        compose_start_service "$service"
    fi

    info "Start completed."
}
