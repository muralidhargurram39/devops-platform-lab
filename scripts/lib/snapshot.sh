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

    local snapshot_dir="$1"

    mkdir -p \
        "${snapshot_dir}/logs" \
        "${snapshot_dir}/manifests" \
        "${snapshot_dir}/volumes"
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

    local snapshot_dir="$1"

    cat > "${snapshot_dir}/metadata.json" <<EOF
{
  "platform": "${PLATFORM_NAME}",
  "version": "${PLATFORM_VERSION}",
  "snapshot": "$(_snapshot_name "$snapshot_dir")",
  "created": "$(_snapshot_created_at)"
}
EOF

}

snapshot_copy_compose() {

    local snapshot_dir="$1"

    cp "${PROJECT_ROOT}/${COMPOSE_FILE}" \
       "${snapshot_dir}/docker-compose.yml"
}

snapshot_copy_env() {

    local snapshot_dir="$1"

    if [[ -f "$PROJECT_ROOT/.env" ]]; then
        cp "$PROJECT_ROOT/.env" "${snapshot_dir}/.env"
    fi

}

snapshot_volume_directory() {

    local snapshot_dir="$1"

    printf "%s/volumes\n" "$snapshot_dir"

}

###############################################################################
# Private API
###############################################################################

_snapshot_timestamp() {
    date +"${SNAPSHOT_DATE_FORMAT}"
}

_snapshot_directory() {

    local snapshot_name

    snapshot_name="$(_snapshot_timestamp)"

    printf "%s/%s\n" \
        "$BACKUP_ROOT" \
        "$snapshot_name"
}

_snapshot_name() {

    basename "$1"

}

_snapshot_created_at() {

    date -u +"%Y-%m-%dT%H:%M:%SZ"

}
