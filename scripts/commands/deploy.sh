#!/usr/bin/env bash

platform_deploy() {

    platform_validate

    local service="${1:-all}"

    require_service "$service"

    info "Deploying ${service}..."

    if [[ "$service" == "all" ]]; then
        compose_up
    else
        compose_up "$service"
    fi

    info "Deployment completed."
}
