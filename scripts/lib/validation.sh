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
