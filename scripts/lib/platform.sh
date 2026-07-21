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

    validate_platform

    compose_up

    platform_summary
}

platform_stop() {

    print_header "Stopping DevOps Lab Platform"

    compose_down

    print_success "Platform stopped successfully."
}

platform_status() {

    print_header "Platform Status"

    status_show_platform
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
# Platform Restart
###############################################################################

platform_restart() {

    local service="${1:-}"

    if [[ -z "$service" || "$service" == "all" ]]; then

        restart_all_services

    else

        restart_service "$service"

    fi

}

platform_backup() {
    backup_create
}

platform_snapshots() {
    backup_list
}

platform_backup_volumes() {

    backup_list_volumes

}
