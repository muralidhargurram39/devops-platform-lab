#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : compose.sh
# Purpose : Docker Compose SDK
###############################################################################

###############################################################################
# Private
###############################################################################

_compose() {

    docker compose "$@"

}

###############################################################################
# Public API
###############################################################################

compose_available() {

    _compose version >/dev/null 2>&1

}

compose_up() {

    _compose up -d

}

compose_down() {

    _compose down

}

compose_restart() {

    _compose restart

}

compose_ps() {

    _compose ps

}

compose_logs() {

    _compose logs "$@"

}

compose_exec() {

    local service="$1"

    shift

    _compose exec "$service" "$@"

}
