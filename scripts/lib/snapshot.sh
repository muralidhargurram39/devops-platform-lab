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

    find "$BACKUP_ROOT" \
        -mindepth 1 \
        -maxdepth 1 \
        -type d \
        -printf "%f\n" \
        | sort

}

snapshot_created_at() {

    local snapshot="$1"

    grep '"created"' \
        "$(snapshot_path "$snapshot")/metadata.json" \
        | cut -d'"' -f4

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

snapshot_exists() {

    local snapshot="$1"

    [[ -d "${BACKUP_ROOT}/${snapshot}" ]]

}

snapshot_path() {

    local snapshot="$1"

    printf "%s/%s\n" \
        "$BACKUP_ROOT" \
        "$snapshot"

}

snapshot_validate() {

    local snapshot="$1"

    snapshot_is_valid "$snapshot" ||
        die "Invalid snapshot: ${snapshot}"

}

snapshot_list_archives() {

    local snapshot="$1"

    find \
        "$(snapshot_path "$snapshot")/volumes" \
        -maxdepth 1 \
        -type f \
        -name "*.tar.gz" \
        -printf "%f\n" \
        | sort

}

snapshot_read_metadata() {

    local snapshot="$1"

    cat "$(snapshot_path "$snapshot")/metadata.json"

}

snapshot_is_valid() {

    local snapshot="$1"
    local dir

    dir="$(snapshot_path "$snapshot")"

    [[ -d "$dir" ]] &&
    [[ -f "${dir}/metadata.json" ]] &&
    [[ -f "${dir}/docker-compose.yml" ]] &&
    [[ -d "${dir}/volumes" ]]

}

snapshot_list_valid() {

    local snapshot

    while IFS= read -r snapshot; do

        if snapshot_is_valid "$snapshot"; then
            printf "%s\n" "$snapshot"
        fi

    done < <(snapshot_list)

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
