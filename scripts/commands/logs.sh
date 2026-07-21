#!/usr/bin/env bash

###############################################################################
# Logs Command
###############################################################################

command_logs() {

    local service=""
    local tail=""
    local follow=false
    local since=""

    while [[ $# -gt 0 ]]; do

        case "$1" in

            --tail)

                [[ $# -lt 2 ]] && {
                    log_error "Missing value for --tail"
                    return 1
                }

                tail="$2"
                shift 2
                ;;

            --since)

                [[ $# -lt 2 ]] && {
                    log_error "Missing value for --since"
                    return 1
                }

                since="$2"
                shift 2
                ;;

            --follow)

                follow=true
                shift
                ;;

            --*)

                log_error "Unknown option: $1"
                return 1
                ;;

            *)

                service="$1"
                shift
                ;;

        esac

    done

    ###########################################################################
    # Validate options
    ###########################################################################

    if [[ -n "$tail" && ! "$tail" =~ ^[0-9]+$ ]]; then

        log_error "--tail must be a positive integer."

        return 1

    fi

    if [[ -n "$since" && ! "$since" =~ ^[0-9]+[smhd]$ ]]; then

        log_error "Invalid --since value."
        log_error "Expected format: 30s, 5m, 2h or 1d."

        return 1

    fi

    ###########################################################################
    # Execute
    ###########################################################################

    platform_logs \
        "$service" \
        "$tail" \
        "$follow" \
        "$since"

}
