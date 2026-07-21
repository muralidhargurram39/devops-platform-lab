#!/usr/bin/env bash

command_backup() {

    local action="${1:-create}"

    case "$action" in
        create)
            platform_backup
            ;;

        list)
            platform_snapshots
            ;;

        *)
            print_error "Unknown backup command: $action"
            return 1
            ;;
    esac
}
