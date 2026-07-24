#!/usr/bin/env bash

compose_is_available() {
    docker compose version >/dev/null 2>&1
}

compose_project_exists() {
    docker compose ps -a --format json 2>/dev/null | grep -q .
}

compose_up() {
    local service="${1:-}"

    if [[ -n "$service" ]]; then
        docker compose up -d "$service"
    else
        docker compose up -d
    fi
}

compose_start() {

    local service="${1:-}"

    if [[ -n "$service" ]]; then
        docker compose start "$service"
    else
        docker compose start
    fi
}

compose_stop() {

    local service="${1:-}"

    if [[ -n "$service" ]]; then
        docker compose stop "$service"
    else
        docker compose stop
    fi
}

compose_restart() {

    local service="${1:-}"

    if [[ -n "$service" ]]; then
        docker compose restart "$service"
    else
        docker compose restart
    fi
}

compose_service_exists() {
    local service="$1"

    docker compose config --services | grep -Fxq "$service"
}

compose_ps() {

    docker compose ps --format json
}

compose_ps_all() {
    docker compose ps -a --format json
}

compose_running_count() {
    compose_ps | jq -r 'select(.State == "running") | .Service' | wc -l
}

compose_stopped_count() {
    compose_ps_all | jq -r 'select(.State != "running") | .Service' | wc -l
}

compose_status() {

    compose_ps |
    jq -r '
        [
            .Service,
            .State,
            (if .Health == "" then "-" else .Health end)
        ] | @tsv
    '

}

compose_running_count() {

    compose_ps |
    jq -r '
        select(.State=="running")
        | .Service
    ' |
    wc -l

}

compose_stopped_count() {

    compose_ps_all |
    jq -r '
        select(.State!="running")
        | .Service
    ' |
    wc -l

}

compose_service_state() {

    local service="$1"

    compose_ps |
    jq -r \
        --arg service "$service" \
        '
        select(.Service == $service)
        | .State
        '

}

compose_service_health() {

    local service="$1"

    local health

    health=$(
        compose_ps |
        jq -r \
            --arg service "$service" \
            '
            select(.Service == $service)
            | .Health
            '
    )

    if [[ -z "$health" || "$health" == "null" ]]; then
        echo "-"
    else
        echo "$health"
    fi

}

normalize_health_status() {

    local status="$1"

    case "$status" in
        running|healthy)
            echo "Healthy"
            ;;
        starting)
            echo "Starting"
            ;;
        exited|dead|unhealthy)
            echo "Unhealthy"
            ;;
        *)
            echo "Unknown"
            ;;
    esac
}
