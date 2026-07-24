#!/usr/bin/env bash

platform_cleanup() {

    platform_validate

    clear

    ui_header "DevOps Lab Platform Cleanup"

    echo
    echo "Cleaning unused Docker resources..."
    echo

    docker_cleanup_containers >/dev/null
    printf "%-20s %s\n" "Containers" "✓"

    docker_cleanup_images >/dev/null
    printf "%-20s %s\n" "Images" "✓"

    docker_cleanup_networks >/dev/null
    printf "%-20s %s\n" "Networks" "✓"

    docker_cleanup_builder >/dev/null
    printf "%-20s %s\n" "Builder Cache" "✓"

    echo
    echo "Cleanup completed successfully."
}
