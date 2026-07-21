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

        list-volumes)
            platform_backup_volumes
            ;;

        *)
            die "Unknown backup action: ${action}"
            ;;
    esac
}
