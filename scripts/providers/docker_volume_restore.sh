#!/usr/bin/env bash

###############################################################################
# Docker Volume Restore Provider
###############################################################################

docker_restore_volume() {

    local archive="$1"
    local volume="$2"

    print_info "Restoring ${volume}..."

    docker volume create "$volume" >/dev/null

    docker run --rm \
        -v "${volume}:/volume" \
        -v "$(dirname "$archive"):/backup:ro" \
        alpine:3.20 \
        sh -c "
            rm -rf /volume/* &&
            tar -xzf /backup/$(basename "$archive") -C /volume
        "

    print_success "${volume} restored."

}

###############################################################################

docker_restore_all_volumes() {

    local snapshot="$1"
    local archive
    local archive_path
    local volume

    while IFS= read -r archive; do

        archive_path="$(snapshot_path "$snapshot")/volumes/${archive}"

        volume="${archive%.tar.gz}"

        docker_restore_volume \
            "$archive_path" \
            "$volume"

    done < <(snapshot_list_archives "$snapshot")

}
