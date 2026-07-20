#!/usr/bin/env bash

VALIDATION_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${VALIDATION_LIB_DIR}/colors.sh"

check_command() {

    command -v "$1" >/dev/null 2>&1 || {
        error "$1 is not installed."
        exit 1
    }
}

check_docker() {

    docker info >/dev/null 2>&1 || {
        error "Docker is not running."
        exit 1
    }
}

check_compose() {

    docker compose version >/dev/null 2>&1 || {
        error "Docker Compose is unavailable."
        exit 1
    }
}

check_kind_network() {

    docker network inspect kind >/dev/null 2>&1 || {
        error "Kind Docker network not found."
        exit 1
    }
}
