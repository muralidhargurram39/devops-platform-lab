#!/usr/bin/env bash

validate_platform() {

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
}

validate_service() {

    local service="${1:-}"

    if [[ -z "$service" ]]; then
        die "Service name is required."
    fi

    for entry in "${SERVICES[@]}"
    do
        IFS='|' read -r name docker_service url http_enabled <<< "$entry"

        if [[ "$docker_service" == "$service" ]]; then
            return 0
        fi
    done

    echo
    echo "Unknown service: ${service}"
    echo
    echo "Available services:"

    for entry in "${SERVICES[@]}"
    do
        IFS='|' read -r name docker_service url http_enabled <<< "$entry"
        echo "  - ${docker_service}"
    done

    return 1
}

validate_environment() {

    return 0
}

validate_compose() {

    return 0
}

validate_backup() {

    return 0
}

platform_validate() {

    local validation_type="${1:-platform}"
    shift || true

    case "$validation_type" in

        platform)
            validate_platform
            ;;

        service)
            validate_platform
            validate_service "$1"
            ;;

        environment)
            validate_platform
            validate_environment
            ;;

        compose)
            validate_platform
            validate_compose
            ;;

        backup)
            validate_platform
            validate_backup
            ;;

        *)
            die "Unknown validation type: ${validation_type}"
            ;;
    esac
}

