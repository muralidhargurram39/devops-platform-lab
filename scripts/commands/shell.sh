#!/usr/bin/env bash

###########################################################
# Interactive Shell Command
###########################################################

platform_shell() {

    local service="${1:-}"

    if [[ -z "$service" ]]; then
        echo
        echo "Usage:"
        echo "  ./scripts/platform shell <service>"
        echo
        echo "Example:"
        echo "  ./scripts/platform shell jenkins"
        echo
        return 1
    fi

    # Validate platform and service
    platform_validate service "$service"

    echo
    ui_header "Interactive Shell"

    ui_key_value "Service" "$service"

    echo

    info "Opening interactive shell..."

    compose_shell "$service"

    echo
    success "Exited shell from ${service}"
}
