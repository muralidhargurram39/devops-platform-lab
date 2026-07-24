#!/usr/bin/env bash

platform_wake() {

    info "Preparing platform..."

    platform_setup

    if compose_project_exists; then

        info "Existing platform detected."

        info "Starting containers..."

        compose_start

    else

        info "Platform not found."

        info "Creating platform..."

        compose_up

    fi

    info "Platform is ready."
}
