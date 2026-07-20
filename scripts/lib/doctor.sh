#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : doctor.sh
# Purpose : Platform diagnostics engine
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_DOCTOR_LOADED:-}" ]] && return 0
readonly DEVOPS_DOCTOR_LOADED=1

###############################################################################
# Private Helpers
###############################################################################

_doctor_container_status() {

    local status="$1"

    if [[ "$status" != "running" ]]; then
        printf "ERROR|Container is not running|Run ./scripts/platform start"
        return
    fi

    printf "OK|Container is running|None"

}

_doctor_container_health() {

    local health="$1"

    case "$health" in

        unhealthy)
            printf "ERROR|Container health check failed|Inspect container logs"
            ;;

        healthy)
            printf "OK|Container health check passed|None"
            ;;

        *)
            printf ""
            ;;

    esac

}

_doctor_port_status() {

    local service="$1"
    local port="$2"

    if [[ "$service" == "sonar-postgres" ]]; then
        printf "INFO|Internal Docker service|Expected configuration"
        return
    fi

    if [[ "$port" == "closed" ]]; then
        printf "WARNING|Host port is closed|Verify Docker port mapping"
        return
    fi

    printf ""

}

_doctor_http_status() {

    local code="$1"

    case "$code" in

        2*)
            printf "OK|Service responding normally|None"
            ;;

        3*)
            printf "OK|HTTP redirect is expected|None"
            ;;

        4*)
            printf "INFO|Authentication may be required|Login to the service"
            ;;

        5*)
            printf "ERROR|HTTP server error|Inspect application logs"
            ;;

        000)
            printf "ERROR|HTTP endpoint unreachable|Verify service startup"
            ;;

        *)
            printf ""
            ;;

    esac

}

_doctor_select_diagnosis() {

    local container="$1"
    local health="$2"
    local port="$3"
    local http="$4"

    #
    # Priority 1 : ERROR
    #

    [[ "$container" == ERROR* ]] && {
        printf "%s" "$container"
        return
    }

    [[ "$health" == ERROR* ]] && {
        printf "%s" "$health"
        return
    }

    [[ "$port" == ERROR* ]] && {
        printf "%s" "$port"
        return
    }

    [[ "$http" == ERROR* ]] && {
        printf "%s" "$http"
        return
    }

    #
    # Priority 2 : WARNING
    #

    [[ "$container" == WARNING* ]] && {
        printf "%s" "$container"
        return
    }

    [[ "$health" == WARNING* ]] && {
        printf "%s" "$health"
        return
    }

    [[ "$port" == WARNING* ]] && {
        printf "%s" "$port"
        return
    }

    [[ "$http" == WARNING* ]] && {
        printf "%s" "$http"
        return
    }

    #
    # Priority 3 : INFO
    #

    [[ "$container" == INFO* ]] && {
        printf "%s" "$container"
        return
    }

    [[ "$health" == INFO* ]] && {
        printf "%s" "$health"
        return
    }

    [[ "$port" == INFO* ]] && {
        printf "%s" "$port"
        return
    }

    [[ "$http" == INFO* ]] && {
        printf "%s" "$http"
        return
    }

    #
    # Priority 4 : OK
    #

    [[ -n "$http" ]] && {
        printf "%s" "$http"
        return
    }

    [[ -n "$health" ]] && {
        printf "%s" "$health"
        return
    }

    [[ -n "$port" ]] && {
        printf "%s" "$port"
        return
    }

    printf "%s" "$container"

}

_doctor_collect_summary() {

    local ok=0
    local info=0
    local warning=0
    local error=0
    local total=0

    local service

    for service in "${PLATFORM_SERVICES[@]}"; do

        ((++total))

        local result
        local name
        local level

        result="$(doctor_check_service "$service")"

        IFS='|' read -r \
            name \
            level \
            _ \
            _ <<< "$result"

        case "$level" in
            OK)
                ((++ok))
                ;;
            INFO)
                ((++info))
                ;;
            WARNING)
                ((++warning))
                ;;
            ERROR)
                ((++error))
                ;;
        esac

    done

    printf "%s|%s|%s|%s|%s\n" \
        "$total" \
        "$ok" \
        "$info" \
        "$warning" \
        "$error"

}

###############################################################################
# Public API
###############################################################################

doctor_check_service() {

    local service="$1"

    local result
    local name
    local status
    local health
    local port
    local http

    result="$(health_check_service "$service")"

    IFS='|' read -r \
        name \
        status \
        health \
        port \
        http <<< "$result"

    local container_result
    local health_result
    local port_result
    local http_result
    local diagnosis

    container_result="$(_doctor_container_status "$status")"

    health_result="$(_doctor_container_health "$health")"

    port_result="$(_doctor_port_status "$service" "$port")"

    http_result="$(_doctor_http_status "$http")"

    diagnosis="$(
        _doctor_select_diagnosis \
            "$container_result" \
            "$health_result" \
            "$port_result" \
            "$http_result"
    )"

    printf "%s|%s\n" \
        "$service" \
        "$diagnosis"

}


doctor_check_platform() {

    printf "%-18s %-10s %-40s %s\n" \
        "SERVICE" \
        "STATUS" \
        "MESSAGE" \
        "RECOMMENDATION"

    printf "%-18s %-10s %-40s %s\n" \
        "-------" \
        "------" \
        "-------" \
        "--------------"

    local service

    for service in "${PLATFORM_SERVICES[@]}"; do

        local result
        local name
        local status
        local message
        local recommendation

        result="$(doctor_check_service "$service")"

        IFS='|' read -r \
            name \
            status \
            message \
            recommendation <<< "$result"

        printf "%-18s %-10s %-40s %s\n" \
            "$name" \
            "$status" \
            "$message" \
            "$recommendation"

    done

}

doctor_print_summary() {

    local summary

    local total
    local ok
    local info
    local warning
    local error
    local status

    summary="$(_doctor_collect_summary)"

    if [[ -z "$summary" ]]; then
        log_error "Failed to collect doctor summary."
        return 1
    fi

    IFS='|' read -r \
        total \
        ok \
        info \
        warning \
        error <<< "$summary"

    printf "\n"

    diagnostics_print_separator

    printf "Summary\n\n"

    diagnostics_print_summary_line "Services Checked" "$total"
    diagnostics_print_summary_line "OK" "$ok"
    diagnostics_print_summary_line "INFO" "$info"
    diagnostics_print_summary_line "WARNING" "$warning"
    diagnostics_print_summary_line "ERROR" "$error"

    printf "\n"

    status="$(
        diagnostics_summary_status \
            "$warning" \
            "$error"
    )"

    printf "✔ Platform Status : %s\n" "$status"

}
