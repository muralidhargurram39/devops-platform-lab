#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : services.sh
# Purpose : Platform service metadata
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_SERVICES_LOADED:-}" ]] && return 0
readonly DEVOPS_SERVICES_LOADED=1

###############################################################################
# Platform Services
###############################################################################

readonly PLATFORM_SERVICES=(
    "jenkins"
    "sonarqube"
    "sonar-postgres"
    "nexus"
    "tomcat"
)

###############################################################################
# Service Ports
###############################################################################

declare -Ar SERVICE_PORTS=(
    [jenkins]=8080
    [sonarqube]=9000
    [sonar-postgres]=5432
    [nexus]=8081
    [tomcat]=9090
)

###############################################################################
# Service URLs
###############################################################################

declare -Ar SERVICE_URLS=(
    [jenkins]="http://localhost:8080"
    [sonarqube]="http://localhost:9000"
    [nexus]="http://localhost:8081"
    [tomcat]="http://localhost:9090"
)

###############################################################################
# Public API
###############################################################################

service_container_name() {

    local service="$1"

    printf "%s-%s-1" "$PROJECT_NAME" "$service"

}

service_port() {

    local service="$1"

    printf "%s" "${SERVICE_PORTS[$service]}"

}

service_url() {

    local service="$1"

    printf "%s" "${SERVICE_URLS[$service]:-}"

}

service_exists() {

    local service="$1"

    for item in "${PLATFORM_SERVICES[@]}"; do
        [[ "$item" == "$service" ]] && return 0
    done

    return 1
}

list_services() {

    printf "%s\n" "${PLATFORM_SERVICES[@]}"

}
