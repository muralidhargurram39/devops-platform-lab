#!/usr/bin/env bash
#
# =============================================================================
# DevOps Lab Platform
# File    : services.sh
# Purpose : Platform service definitions and helpers.
# =============================================================================

readonly PLATFORM_SERVICES=(
    "jenkins"
    "sonarqube"
    "sonar-postgres"
    "nexus"
    "tomcat"
)

list_services() {

    printf "%s\n" "${PLATFORM_SERVICES[@]}"

}

service_exists() {

    local service="$1"

    for s in "${PLATFORM_SERVICES[@]}"; do
        [[ "$s" == "$service" ]] && return 0
    done

    return 1

}
