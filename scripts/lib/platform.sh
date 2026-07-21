#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : platform.sh
# Purpose : Platform Core API
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_PLATFORM_LOADED:-}" ]] && return 0
readonly DEVOPS_PLATFORM_LOADED=1

###############################################################################
# Public API
###############################################################################

platform_start() {

    print_header "Starting DevOps Lab Platform"

    validate_environment

    compose_up

    platform_summary
}

platform_stop() {

    print_header "Stopping DevOps Lab Platform"

    compose_down

    print_success "Platform stopped successfully."
}

platform_restart() {

    print_header "Restarting DevOps Lab Platform"

    platform_stop

    printf "\n"

    platform_start

}

platform_status() {

    print_header "Platform Status"

    _display_status_table
}

platform_health() {

    print_header "Platform Health"

    health_check_platform
    health_print_summary
}

platform_urls() {

    print_header "Service URLs"

    printf "%-18s %s\n" "SERVICE" "URL"
    printf "%-18s %s\n" "-------" "---"

    local service

    for service in "${PLATFORM_SERVICES[@]}"; do

        local url

        url="$(service_url "$service")"

        [[ -z "$url" ]] && continue

        printf "%-18s %s\n" \
            "$service" \
            "$url"

    done
}

platform_summary() {

    platform_status

    echo

    platform_urls

    echo

    print_success "Platform started successfully."

}

platform_doctor() {

    print_header "Platform Doctor"

    doctor_check_platform

    doctor_print_summary

}

platform_logs() {

    local service="${1:-}"
    local tail="${2:-}"
    local follow="${3:-false}"
    local since="${4:-}"

    if [[ -z "$service" ]]; then

        logs_show_platform \
            "$tail" \
            "$follow" \
            "$since"

    else

        logs_show_service \
            "$service" \
            "$tail" \
            "$follow" \
            "$since"

    fi
}

###############################################################################
# Platform Metrics
###############################################################################

platform_metrics() {

    local service="${1:-}"

    if [[ -z "$service" ]]; then

        metrics_show_platform

    else

        metrics_show_service "$service"

    fi

}

###############################################################################
# Private Helpers
###############################################################################

_collect_service_status() {

    local service="$1"

    local container

    container="$(service_container_name "$service")"

    local status
    local health

    status="$(container_status "$container")"
    health="$(container_health "$container")"

    printf "%s|%s|%s\n" \
        "$service" \
        "$status" \
        "$health"

}

###############################################################################

_display_status_table() {

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

        result="$(_collect_service_status "$service")"

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
