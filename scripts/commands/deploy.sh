#!/usr/bin/env bash

platform_deploy() {
    require_docker
    require_compose

    log_info "Deploying platform..."

    compose_up "$@"

    log_success "Platform deployed successfully."
}
