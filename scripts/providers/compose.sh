#!/usr/bin/env bash

compose_is_available() {
    docker compose version >/dev/null 2>&1
}

compose_project_exists() {
    docker compose ps -a --format json 2>/dev/null | grep -q .
}

compose_up() {
    docker compose up -d
}

compose_start() {
    docker compose start
}

compose_stop() {
    docker compose stop
}

compose_restart() {
    docker compose restart
}

compose_service_exists() {
    local service="$1"

    docker compose config --services | grep -Fxq "$service"
}

compose_start_service() {
    local service="$1"

    docker compose start "$service"
}

compose_stop_service() {
    local service="$1"

    docker compose stop "$service"
}

compose_restart_service() {
    local service="$1"

    docker compose restart "$service"
}

compose_start_all() {
    docker compose start
}

compose_stop_all() {
    docker compose stop
}

compose_restart_all() {
    docker compose restart
}
