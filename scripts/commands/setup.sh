#!/usr/bin/env bash

platform_setup() {

    info "Checking Docker..."

    if ! docker_is_installed; then
        die "Docker is not installed."
    fi

    if ! docker_is_running; then
        die "Docker daemon is not running."
    fi

    info "Checking Docker Compose..."

    if ! compose_is_available; then
        die "Docker Compose is unavailable."
    fi

    info "Checking docker-compose.yml..."

    if [[ ! -f "${PROJECT_ROOT}/docker-compose.yml" ]]; then
        die "docker-compose.yml not found."
    fi

    mkdir -p \
        "${PROJECT_ROOT}/backups" \
        "${PROJECT_ROOT}/logs" \
        "${PROJECT_ROOT}/tmp"

    info "Platform setup completed."
}
