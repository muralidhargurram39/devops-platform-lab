#!/usr/bin/env bash

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_LOGS_LOADED:-}" ]] && return 0
readonly DEVOPS_LOGS_LOADED=1

###############################################################################
# Public API
###############################################################################

logs_show_service() {

    local service="${1:-}"
    local tail="${2:-}"
    local follow="${3:-false}"
    local since="${4:-}"

    if ! service_exists "$service"; then
        log_error "Unknown service: $service"
        return 1
    fi

    local container
    local mode

    container="$(service_container_name "$service")"

    ###########################################################################
    # Container Status
    ###########################################################################

    if ! container_running "$container"; then

        print_header "$(service_display_name "$service")"

        printf "%-15s : %s\n" "Container" "$container"
        printf "%-15s : %s\n" "Status" "Stopped"

        diagnostics_print_separator

        printf "No logs available.\n\n"

        return 1

    fi

    ###########################################################################
    # Determine Display Mode
    ###########################################################################

    if [[ "$follow" == "true" ]]; then

        mode="Follow"

    elif [[ -n "$since" ]]; then

        mode="Since (${since})"

    elif [[ -n "$tail" ]]; then

        mode="Tail (${tail} lines)"

    else

        mode="Default (${DEFAULT_LOG_TAIL} lines)"

    fi

    ###########################################################################
    # Header
    ###########################################################################

    print_header "$(service_display_name "$service")"

    printf "%-15s : %s\n" "Container" "$container"
    printf "%-15s : %s\n" "Status" "Running"
    printf "%-15s : %s\n" "Mode" "$mode"

    diagnostics_print_separator

    ###########################################################################
    # Display Logs
    ###########################################################################

    if [[ "$follow" == "true" ]]; then

        container_logs_follow "$container"

    elif [[ -n "$since" ]]; then

        container_logs_since \
            "$container" \
            "$since"

    elif [[ -n "$tail" ]]; then

        container_logs_tail \
            "$container" \
            "$tail"

    else

        container_logs "$container"

    fi

    printf "\n"

    ###########################################################################
    # Footer
    ###########################################################################

    print_engine_footer \
        "$(service_display_name "$service")" \
        "Logs"

}

###############################################################################
# Platform Logs
###############################################################################

logs_show_platform() {

    local tail="${1:-}"
    local follow="${2:-false}"
    local since="${3:-}"

    local service

    for service in "${PLATFORM_SERVICES[@]}"; do

        logs_show_service \
            "$service" \
            "$tail" \
            "$follow" \
            "$since"

    done

}
