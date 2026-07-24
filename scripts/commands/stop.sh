#!/usr/bin/env bash

platform_stop() {

    platform_validate

    local service="${1:-all}"

    require_service "$service"

    info "Stopping ${service}..."

    if [[ "$service" == "all" ]]; then
        compose_stop
    else
        compose_stop "$service"
    fi

    info "Stop completed."
}
