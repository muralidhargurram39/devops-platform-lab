#!/usr/bin/env bash

platform_setup() {

    platform_validate

    mkdir -p \
        "${PROJECT_ROOT}/backups" \
        "${PROJECT_ROOT}/logs" \
        "${PROJECT_ROOT}/tmp"

    info "Platform setup completed."
}
