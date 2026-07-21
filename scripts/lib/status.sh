#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : status.sh
# Purpose : Platform status engine
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_STATUS_LOADED:-}" ]] && return 0
readonly DEVOPS_STATUS_LOADED=1

###############################################################################
# Public API
###############################################################################

status_show_platform() {

    print_header "Platform Status"

    _status_print_table

}

status_show_service() {

    local service="$1"

    validate_service "$service"

    local container
    container="$(service_container_name "$service")"

    printf "%-18s %-12s %-12s\n" \
        "SERVICE" \
        "STATUS" \
        "HEALTH"

    printf "%-18s %-12s %-12s\n" \
        "-------" \
        "------" \
        "------"

    printf "%-18s %-12s %-12s\n" \
        "$service" \
        "$(container_status "$container")" \
        "$(container_health "$container")"

}

###############################################################################
# Private Helpers
###############################################################################

_status_collect() {

    local service="$1"

    local container
    container="$(service_container_name "$service")"

    printf "%s|%s|%s\n" \
        "$service" \
        "$(container_status "$container")" \
        "$(container_health "$container")"

}

_status_print_table() {

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

        result="$(_status_collect "$service")"

        IFS='|' read -r \
            service_name \
            service_status \
            service_health <<< "$result"

        printf "%-18s %-12s %-12s\n" \
            "$service_name" \
            "$service_status" \
            "$service_health"

    done

}
