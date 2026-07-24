#!/usr/bin/env bash

platform_logs() {

    local option="${1:-}"
    local service="${2:-100}"

    platform_validate

    case "$option" in

        "")

            ui_header "DevOps Lab Platform Logs"

            compose_logs
            ;;

        -f|--follow)

            if [ -z "$service" ]; then
                log_error "Please specify a service."
                return 1
            fi

            ui_header "Following Logs - ${service}"

            compose_follow_logs "$service"
            ;;

        *)

            ui_header "Logs - ${option}"

            compose_service_logs "$option"
            ;;
    esac
}
