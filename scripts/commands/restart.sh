#!/usr/bin/env bash

platform_restart() {

    platform_validate

    local service="${1:-all}"

    require_service "$service"

    info "Restarting ${service}..."

    if [[ "$service" == "all" ]]; then
        compose_restart
    else
        compose_restart "$service"
    fi

    info "Restart completed."
}
