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

    if ! backup_export_volumes "$snapshot_dir"; then

        rm -rf "$snapshot_dir"

        die "Backup failed. Partial snapshot removed."

    fi

    ui_snapshot_created "$snapshot_dir"
}

backup_list() {
    echo "Backup list not implemented"
}

backup_list_volumes() {

    docker_list_platform_volumes

}

backup_export_volumes() {

    local snapshot_dir="$1"
    local volume_dir
    local archive
    local volume
    local index=0
    local total
    local -a volumes

    volume_dir="$(snapshot_volume_directory "$snapshot_dir")"

    mapfile -t volumes < <(backup_list_volumes)

    total="${#volumes[@]}"

    for volume in "${volumes[@]}"; do

        ((index++))

        print_info "[${index}/${total}] Exporting ${volume}"

        if ! docker_export_volume "$volume" "$volume_dir"; then
            log_error "Failed to export Docker volume: ${volume}"
            return 1
        fi

        archive="${volume_dir}/${volume}.tar.gz"

        if [[ ! -s "$archive" ]]; then
            log_error "Archive is empty: ${archive}"
            return 1
        fi

        if ! archive_verify "$archive"; then
            log_error "Archive verification failed: ${archive}"
            return 1
        fi

    done
}
