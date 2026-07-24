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
