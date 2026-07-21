#!/usr/bin/env bash

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_METRICS_LOADED:-}" ]] && return 0
readonly DEVOPS_METRICS_LOADED=1

###############################################################################
# Public API
###############################################################################

metrics_show_service() {

    local service="${1:-}"

    if ! service_exists "$service"; then
        log_error "Unknown service: $service"
        return 1
    fi

    local container
    local metrics

    local cpu
    local memory
    local memory_percent
    local network
    local block_io
    local pids

    container="$(service_container_name "$service")"

    ###########################################################################
    # Container Status
    ###########################################################################

    if ! container_running "$container"; then

        print_service_header \
            "$(service_display_name "$service")" \
            "$container" \
            "Stopped"

        printf "Metrics unavailable.\n\n"

        return 1

    fi

    ###########################################################################
    # Collect Metrics
    ###########################################################################

    metrics="$(container_stats "$container")"

    IFS='|' read -r \
        cpu \
        memory \
        memory_percent \
        network \
        block_io \
        pids \
        <<< "$metrics"

    ###########################################################################
    # Header
    ###########################################################################

    print_service_header \
        "$(service_display_name "$service")" \
        "$container" \
        "Running"

    ###########################################################################
    # Display Metrics
    ###########################################################################

    printf "%-15s : %s\n" "CPU" "$cpu"
    printf "%-15s : %s\n" "Memory" "$memory"
    printf "%-15s : %s\n" "Memory %" "$memory_percent"
    printf "%-15s : %s\n" "Network" "$network"
    printf "%-15s : %s\n" "Block I/O" "$block_io"
    printf "%-15s : %s\n" "PIDs" "$pids"

    printf "\n"

    ###########################################################################
    # Footer
    ###########################################################################

    print_engine_footer \
        "$(service_display_name "$service")" \
        "Metrics"

}

###############################################################################
# Platform Metrics
###############################################################################

metrics_show_platform() {

    local service

    for service in "${PLATFORM_SERVICES[@]}"; do

        metrics_show_service "$service"

    done

}
