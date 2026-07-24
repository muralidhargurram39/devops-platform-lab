#!/usr/bin/env bash

platform_config() {

    platform_validate

    clear

    ui_header "DevOps Lab Platform Configuration"

    echo
    echo "Environment"
    echo "-----------"

    printf "%-20s %s\n" "Active Environment :" "$ACTIVE_ENV"

    printf "%-20s %s\n" "Compose File :" "${COMPOSE_FILE}"

    echo
    echo "Services"
    echo "--------"

    printf "%-22s %-16s %s\n" \
        "COMPONENT" \
        "CONTAINER" \
        "URL"

    printf "%-22s %-16s %s\n" \
        "---------" \
        "---------" \
        "---"

    for service in "${SERVICES[@]}"
    do
        IFS='|' read -r \
            name \
            docker_service \
            url \
            http_enabled <<< "$service"

        printf "%-22s %-16s %s\n" \
            "$name" \
            "$docker_service" \
            "$url"
    done

    echo
    echo "Configuration Files"
    echo "-------------------"

    printf "%s\n" "environment.conf"

    printf "%s\n" "${ACTIVE_ENV}.conf"

    printf "%s\n" "services.conf"
}
