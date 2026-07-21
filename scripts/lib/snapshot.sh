#!/usr/bin/env bash

###############################################################################
# DevOps Lab Platform
# File    : snapshot.sh
# Purpose : Snapshot Management Engine
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_SNAPSHOT_LOADED:-}" ]] && return 0
readonly DEVOPS_SNAPSHOT_LOADED=1

###############################################################################
# Public API
###############################################################################

snapshot_create() {

    local snapshot_dir

    snapshot_dir="$(_snapshot_directory)"

    mkdir -p \
        "${snapshot_dir}/volumes" \
        "${snapshot_dir}/logs" \
        "${snapshot_dir}/manifests"

    echo "$snapshot_dir"
}

snapshot_list() {
    :
}

snapshot_exists() {
    :
}

snapshot_delete() {
    :
}

snapshot_metadata() {
    :
}

###############################################################################
# Private API
###############################################################################

_snapshot_timestamp() {
    date +"${SNAPSHOT_DATE_FORMAT}"
}

_snapshot_directory() {
    printf "%s/%s\n" \
        "$BACKUP_ROOT" \
        "$(_snapshot_timestamp)"
}
