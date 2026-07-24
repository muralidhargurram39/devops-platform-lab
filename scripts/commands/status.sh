#!/usr/bin/env bash

platform_status() {

    platform_validate

    local running
    local stopped

    ui_header "DevOps Lab Platform Status"

    ui_section "Docker"

    if docker_is_running; then
        echo "Status : Running"
    else
        echo "Status : Stopped"
    fi

    echo

    ui_section "Services"

    ui_table_header

    compose_status |
    while IFS=$'\t' read -r service state health
    do
        ui_table_row \
            "$service" \
            "$state" \
            "$health"
    done

    running="$(compose_running_count)"
    stopped="$(compose_stopped_count)"

    ui_summary \
        "$running" \
        "$stopped"
}
