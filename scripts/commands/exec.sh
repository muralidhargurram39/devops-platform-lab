#!/usr/bin/env bash

###########################################################
# DevOps Lab Platform
# Execute Command
###########################################################

platform_exec() {

    local service="${1:-}"

    if [[ -z "$service" ]]; then
        echo
        echo "Usage:"
        echo "  ./scripts/platform exec <service> <command>"
        echo
        echo "Example:"
        echo "  ./scripts/platform exec jenkins ls -la"
        echo
        return 1
    fi

    shift

    if [[ $# -eq 0 ]]; then
        die "No command specified."
    fi

    platform_validate service "$service"

    echo
    ui_header "Execute Command"

    ui_key_value "Service" "$service"
    ui_key_value "Command" "$*"

    echo

    info "Executing command..."

    if compose_exec "$service" "$@"; then
        echo
        success "Command completed."
    else
        echo
        die "Command execution failed."
    fi
}
