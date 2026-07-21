#!/usr/bin/env bash

###############################################################################
# DevOps Lab Platform
# File    : backup.sh
# Purpose : Backup Engine
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_BACKUP_LOADED:-}" ]] && return 0
readonly DEVOPS_BACKUP_LOADED=1

###############################################################################
# Public API
###############################################################################

backup_create() {

    validate_backup_directory

    local snapshot_dir

    snapshot_dir="$(_snapshot_directory)"

    snapshot_create "$snapshot_dir"

    snapshot_metadata "$snapshot_dir"

    snapshot_copy_compose "$snapshot_dir"

    snapshot_copy_env "$snapshot_dir"

    ui_snapshot_created "$snapshot_dir"

}

backup_list() {
    echo "Backup list not implemented"
}
