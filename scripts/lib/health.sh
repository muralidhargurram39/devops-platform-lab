#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : health.sh
# Purpose : Platform Health Engine
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_HEALTH_LOADED:-}" ]] && return 0
readonly DEVOPS_HEALTH_LOADED=1

###############################################################################
# Private Helpers
###############################################################################

_check_container_exists() {

    local container="$1"

    if container_exists "$container"; then
        printf "yes"
    else
        printf "no"
    fi

}

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

    container_health "$container"

}

_check_port() {

    printf "N/A"

}

_check_http() {

    printf "N/A"

}

###############################################################################
# Public API
###############################################################################

health_check_service() {

    local service="$1"

    local container

    container="$(service_container_name "$service")"

    local status
    local health

    status="$(_check_container_running "$container")"
    health="$(_check_container_health "$container")"

    printf "%s|%s|%s\n" \
        "$service" \
        "$status" \
        "$health"

}

health_check_platform() {

    printf "%-18s %-12s %-12s\n" \
        "SERVICE" \
        "STATUS" \
        "HEALTH"

    printf "%-18s %-12s %-12s\n" \
        "-------" \
        "------" \
        "------"

    local service

    for service in "${PLATFORM_SERVICES[@]}"; do

        local result
        local name
        local status
        local health

        result="$(health_check_service "$service")"

        IFS='|' read -r \
            name \
            status \
            health <<< "$result"

        printf "%-18s %-12s %-12s\n" \
            "$name" \
            "$status" \
            "$health"

    done

}

health_print_summary() {

    local total="${#PLATFORM_SERVICES[@]}"
    local running=0

    local service

    for service in "${PLATFORM_SERVICES[@]}"; do

        local container

        container="$(service_container_name "$service")"

        if container_running "$container"; then
            ((running++))
        fi

    done

    echo

    if [[ "$running" -eq "$total" ]]; then
        print_success "Overall Platform Health : HEALTHY (${running}/${total})"
    else
        print_warning "Overall Platform Health : DEGRADED (${running}/${total})"
    fi

}
