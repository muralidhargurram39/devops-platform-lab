#!/usr/bin/env bash

platform_sleep() {

    info "Putting platform to sleep..."

    platform_setup

    if ! compose_project_exists; then
        warn "Platform has not been created yet."
        return 0
    fi

    info "Stopping containers..."

    compose_stop

    info "Platform is now sleeping."
}
