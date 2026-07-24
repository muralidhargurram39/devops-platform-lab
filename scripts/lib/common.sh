#!/usr/bin/env bash

PROJECT_NAME="DevOps Lab Platform"
PROJECT_VERSION="1.0.0"
CLI_NAME="platform"

require_service() {

    local service="$1"

    if [[ "$service" == "all" ]]; then
        return
    fi

    if compose_service_exists "$service"; then
        return
    fi

    die "Unknown service: ${service}"
}

service_exists() {

    local service="$1"

    for entry in "${SERVICES[@]}"
    do
        IFS='|' read -r name docker_service url http_enabled <<< "$entry"

        if [[ "$docker_service" == "$service" ]]
        then
            return 0
        fi
    done

    return 1
}
