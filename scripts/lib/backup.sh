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

    local snapshot

    snapshot="$(snapshot_create)"

    print_success "Snapshot created"

    echo "$snapshot"
}

backup_list() {
    echo "Backup list not implemented"
}
