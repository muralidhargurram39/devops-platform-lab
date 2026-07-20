#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : health.sh
# Purpose : Platform health checks
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_HEALTH_LOADED:-}" ]] && return 0
readonly DEVOPS_HEALTH_LOADED=1

###############################################################################
# Private Helpers
###############################################################################

_check_container_running() {

    local container="$1"

    if container_running "$container"; then
        printf "running"
    else
        printf "stopped"
    fi

}

_check_container_health() {

    local container="$1"

    if ! container_exists "$container"; then
        printf "N/A"
        return
    fi

    local health

    health="$(docker inspect \
        --format '{{if .State.Health}}{{.State.Health.Status}}{{else}}n/a{{end}}' \
        "$container" 2>/dev/null)"

    printf "%s" "$health"

}

_check_port() {

    local service="$1"
    local port

    port="$(service_port "$service")"

    if [[ -z "$port" ]]; then
        printf "N/A"
        return
    fi

    if tcp_port_open localhost "$port"; then
        printf "open"
    else
        printf "closed"
    fi

}

_check_http() {

    local service="$1"
    local url

    url="$(service_health_url "$service")"

    if [[ -z "$url" ]]; then
        printf "N/A"
        return
    fi

    http_status "$url"

}

###############################################################################
# Public API
###############################################################################

health_check_service() {

    local service="$1"
    local container

    local status
    local health
    local port
    local http

    container="$(service_container_name "$service")"

    status="$(_check_container_running "$container")"
    health="$(_check_container_health "$container")"
    port="$(_check_port "$service")"
    http="$(_check_http "$service")"

    printf "%s|%s|%s|%s|%s\n" \
        "$service" \
        "$status" \
        "$health" \
        "$port" \
        "$http"

}

health_check_platform() {

    printf "%-18s %-12s %-12s %-10s %-8s\n" \
        "SERVICE" \
        "STATUS" \
        "HEALTH" \
        "PORT" \
        "HTTP"

    printf "%-18s %-12s %-12s %-10s %-8s\n" \
        "-------" \
        "------" \
        "------" \
        "----" \
        "----"

    local service

    for service in "${PLATFORM_SERVICES[@]}"; do

        local result
        local name
        local status
        local health
        local port
        local http

        result="$(health_check_service "$service")"

        IFS='|' read -r \
            name \
            status \
            health \
            port \
            http <<< "$result"

        printf "%-18s %-12s %-12s %-10s %-8s\n" \
            "$name" \
            "$status" \
            "$health" \
            "$port" \
            "$http"

    done

}

health_print_summary() {

    local total=0
    local running=0

    local service

    for service in "${PLATFORM_SERVICES[@]}"; do

        ((++total))

        local container
        container="$(service_container_name "$service")"

        if container_running "$container"; then
            ((++running))
        fi

    done

    printf "\n"

    if [[ "$running" -eq "$total" ]]; then
        printf "✔ Overall Platform Health : HEALTHY (%d/%d)\n" \
            "$running" \
            "$total"
    else
        printf "⚠ Overall Platform Health : DEGRADED (%d/%d)\n" \
            "$running" \
            "$total"
    fi

}
