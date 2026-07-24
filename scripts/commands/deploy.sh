#!/usr/bin/env bash

platform_deploy() {

    platform_validate

    local build=false
    local service="all"

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --build)
                build=true
                ;;
            *)
                service="$1"
                ;;
        esac
        shift
    done

    require_service "$service"

    info "Deploying ${service}..."

    if [[ "$build" == true ]]; then
        if [[ "$service" == "all" ]]; then
            compose_up_build
        else
            compose_up_build "$service"
        fi
    else
        if [[ "$service" == "all" ]]; then
            compose_up
        else
            compose_up "$service"
        fi
    fi

    info "Deployment completed."
}
