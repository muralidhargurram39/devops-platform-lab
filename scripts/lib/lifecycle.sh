#!/usr/bin/env bash

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_RESTART_LOADED:-}" ]] && return 0
readonly DEVOPS_RESTART_LOADED=1

###############################################################################
# Private Helpers
###############################################################################

_lifecycle_action() {

    local service="$1"
    local action="$2"

    if ! service_exists "$service"; then
        log_error "Unknown service: $service"
        return 1
    fi

    local container
    local display_name

    container="$(service_container_name "$service")"
    display_name="$(service_display_name "$service")"

    local status
    local success_message
    local failure_message

    case "$action" in

        restart)

            status="Restarting"
            success_message="Restart completed successfully."
            failure_message="Restart failed."
            ;;

        start)

            status="Starting"
            success_message="Start completed successfully."
            failure_message="Start failed."
            ;;

        stop)

            status="Stopping"
            success_message="Stop completed successfully."
            failure_message="Stop failed."
            ;;

        *)

            log_error "Unsupported lifecycle action: $action"
            return 1
            ;;

    esac

    ###########################################################################
    # Header
    ###########################################################################

    print_service_header \
        "$display_name" \
        "$container" \
        "$status"

    ###########################################################################
    # Execute Action
    ###########################################################################

    case "$action" in

        restart)

            if container_restart "$container"; then

                print_success "$success_message"

            else

                print_error "$failure_message"
                return 1

            fi
            ;;

        start)

            if container_start "$container"; then

                print_success "$success_message"

            else

                print_error "$failure_message"
                return 1

            fi
            ;;

        stop)

            if container_stop "$container"; then

                print_success "$success_message"

            else

                print_error "$failure_message"
                return 1

            fi
            ;;

    esac

    printf "\n"

    ###########################################################################
    # Footer
    ###########################################################################

    print_engine_footer \
        "$display_name" \
        "${action^}"

}

###############################################################################
# Private Helpers
###############################################################################

_lifecycle_all() {

    local action="$1"

    local service

    for service in "${PLATFORM_SERVICES[@]}"; do

        _lifecycle_action \
            "$service" \
            "$action"

    done

}

###############################################################################
# Public API
###############################################################################

restart_service() {

    _lifecycle_action \
        "$1" \
        restart

}

restart_all_services() {

    _lifecycle_all restart

}

###############################################################################
# Future Public API
###############################################################################

start_service() {

    _lifecycle_action \
        "$1" \
        start

}

start_all_services() {

    _lifecycle_all start

}

stop_service() {

    _lifecycle_action \
        "$1" \
        stop

}

stop_all_services() {

    _lifecycle_all stop

}
