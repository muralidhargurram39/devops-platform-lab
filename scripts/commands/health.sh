#!/usr/bin/env bash

platform_health() {

    ####################################################
    # Platform Validation
    ####################################################

    platform_validate

    clear

    ####################################################
    # Header
    ####################################################

    ui_header "DevOps Lab Platform Health"

    ####################################################
    # Docker
    ####################################################

    ui_section "Docker"

    ui_health_header

    ui_health_row "Docker Engine" "$(docker_engine_health)"
    ui_health_row "Docker Compose" "$(docker_compose_health)"

    ####################################################
    # Services
    ####################################################

    ui_section "Services"

    ui_health_header

    overall_status="Healthy"

    for service in "${SERVICES[@]}"
    do
        IFS='|' read -r name docker_service url http_enabled <<< "$service"

        state="$(compose_service_state "$docker_service")"
        status="$(normalize_health_status "$state")"

        ui_health_row "$name" "$status"

        if ! health_is_ok "$status"; then
            overall_status="Unhealthy"
        fi
    done

    ####################################################
    # Internal Services
    ####################################################

    postgres_status="$(
        normalize_health_status \
        "$(compose_service_health "sonar-postgres")"
    )"

    ui_health_row "PostgreSQL" "$postgres_status"

    if ! health_is_ok "$postgres_status"; then
        overall_status="Unhealthy"
    fi

    ####################################################
    # HTTP Endpoints
    ####################################################

    echo

    ui_section "HTTP Endpoints"

    ui_health_header

    for service in "${SERVICES[@]}"
    do
        IFS='|' read -r name docker_service url http_enabled <<< "$service"

        if [[ "$http_enabled" == "true" ]]; then

            http_result="$(http_status "$url")"

            ui_health_row "$name" "$http_result"

            if ! health_is_ok "$http_result"; then
                overall_status="Unhealthy"
            fi
        fi
    done

    ####################################################
    # Summary
    ####################################################

    echo
    echo "------------------------------------------------------"

    printf "Overall Health : %s\n" "$overall_status"

}
