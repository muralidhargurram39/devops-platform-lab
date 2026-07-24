#!/usr/bin/env bash

platform_stop() {

    platform_validate

    local service="${1:-all}"

    require_service "$service"

    info "Stopping ${service}..."

    if [[ "$service" == "all" ]]; then
        compose_stop_all
    else
        compose_stop_service "$service"
    fi

    info "Stop completed."
}
