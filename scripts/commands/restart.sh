#!/usr/bin/env bash

platform_restart() {

    platform_validate

    local service="${1:-all}"

    require_service "$service"

    info "Restarting ${service}..."

    if [[ "$service" == "all" ]]; then
        compose_restart_all
    else
        compose_restart_service "$service"
    fi

    info "Restart completed."
}
