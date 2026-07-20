#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : docker.sh
# Purpose : Docker SDK
#
# This library provides Docker helper functions.
# No platform business logic belongs here.
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_DOCKER_LOADED:-}" ]] && return 0
readonly DEVOPS_DOCKER_LOADED=1

###############################################################################
# Docker Availability
###############################################################################

docker_available() {
    command -v docker >/dev/null 2>&1
}

docker_running() {
    docker info >/dev/null 2>&1
}

###############################################################################
# Container Helpers
###############################################################################

container_exists() {
    local container="$1"

    docker container inspect "$container" >/dev/null 2>&1
}

container_running() {
    local container="$1"

    [[ "$(docker inspect \
        -f '{{.State.Running}}' \
        "$container" 2>/dev/null)" == "true" ]]
}

container_status() {

    local container="$1"

    docker inspect \
        -f '{{.State.Status}}' \
        "$container" 2>/dev/null || echo "not-found"

}

container_health() {

    local container="$1"

    docker inspect \
        -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}n/a{{end}}' \
        "$container" 2>/dev/null || echo "n/a"

}

container_ports() {

    local container="$1"

    docker port "$container" 2>/dev/null

}

###############################################################################
# Image Helpers
###############################################################################

image_exists() {

    docker image inspect "$1" >/dev/null 2>&1

}

###############################################################################
# Network Helpers
###############################################################################

network_exists() {

    docker network inspect "$1" >/dev/null 2>&1

}

###############################################################################
# Volume Helpers
###############################################################################

volume_exists() {

    docker volume inspect "$1" >/dev/null 2>&1

}
