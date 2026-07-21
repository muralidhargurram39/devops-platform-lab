#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : validation.sh
# Purpose : Platform environment validation
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_VALIDATION_LOADED:-}" ]] && return 0
readonly DEVOPS_VALIDATION_LOADED=1

###############################################################################
# Public API
###############################################################################

validate_environment() {

    check_docker_installed
    check_docker_running
    check_compose_available
    check_compose_file

}

###############################################################################
# Docker
###############################################################################

check_docker_installed() {

    docker_available || die "Docker is not installed."

}

check_docker_running() {

    docker_running || die "Docker daemon is not running."

}

###############################################################################
# Docker Compose
###############################################################################

check_compose_available() {

    compose_available || die "Docker Compose is unavailable."

}

###############################################################################
# Compose File
###############################################################################

check_compose_file() {

    [[ -f "${PROJECT_ROOT}/${COMPOSE_FILE}" ]] \
        || die "Compose file not found: ${COMPOSE_FILE}"

}

###############################################################################
# Future Validation Hooks
###############################################################################

check_required_ports() {

    return 0

}

check_disk_space() {

    return 0

}

check_memory() {

    return 0

}

###############################################################################
# Service Validation
###############################################################################

validate_service() {

    local service="$1"

    service_exists "$service" \
        || die "Unknown service: $service"

}

###############################################################################
# Container Validation
###############################################################################

validate_container() {

    local container="$1"

    container_exists "$container" \
        || die "Container not found: $container"

}

validate_running_container() {

    local container="$1"

    container_running "$container" \
        || die "Container is not running: $container"

}

###############################################################################
# Platform Validation
###############################################################################

validate_platform() {

    validate_environment

    check_required_ports
    check_disk_space
    check_memory

}
