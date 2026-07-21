#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# UI Library
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_UI_LOADED:-}" ]] && return 0
readonly DEVOPS_UI_LOADED=1

###############################################################################
# Banner
###############################################################################

print_banner() {

    echo

    printf "%b\n" "${COLOR_BOLD_BLUE}"

    echo "============================================================"
    echo "            DevOps Lab Platform v${CLI_VERSION}"
    echo "============================================================"

    printf "%b" "${COLOR_RESET}"

    echo

}

###############################################################################
# Separators
###############################################################################

diagnostics_print_separator() {

    printf '%*s\n' "$TABLE_WIDTH" '' | tr ' ' '-'

    printf "\n"

}

###############################################################################
# Headers
###############################################################################

print_header() {

    local title="$1"

    echo

    printf "%b%s%b\n" \
        "${COLOR_BOLD}" \
        "$title" \
        "${COLOR_RESET}"

    diagnostics_print_separator

}

print_subheader() {

    local title="$1"

    printf "%b%s%b\n" \
        "${COLOR_BOLD}" \
        "$title" \
        "${COLOR_RESET}"

    diagnostics_print_separator

}

###############################################################################
# Service Headers
###############################################################################

print_service_header() {

    local service="$1"
    local container="$2"
    local status="$3"

    print_header "$service"

    printf "%-15s : %s\n" "Container" "$container"
    printf "%-15s : %s\n" "Status" "$status"

    diagnostics_print_separator

}

print_service_header_with_mode() {

    local service="$1"
    local container="$2"
    local status="$3"
    local mode="$4"

    print_header "$service"

    printf "%-15s : %s\n" "Container" "$container"
    printf "%-15s : %s\n" "Status" "$status"
    printf "%-15s : %s\n" "Mode" "$mode"

    diagnostics_print_separator

}

###############################################################################
# Table Helpers
###############################################################################

print_table_header() {

    printf "%-18s %-12s %-30s %-25s\n" "$@"

    diagnostics_print_separator

}

print_table_row() {

    printf "%-18s %-12s %-30s %-25s\n" "$@"

}

###############################################################################
# Summary
###############################################################################

print_summary_header() {

    printf "\n"

    diagnostics_print_separator

    printf "Summary\n"

    diagnostics_print_separator

}

diagnostics_print_summary_line() {

    printf "%-20s : %s\n" "$1" "$2"

}

diagnostics_summary_status() {

    local warning="$1"
    local error="$2"

    if (( error > 0 )); then

        printf "UNHEALTHY"

    elif (( warning > 0 )); then

        printf "WARNING"

    else

        printf "HEALTHY"

    fi

}

###############################################################################
# Footers
###############################################################################

print_engine_footer() {

    local service="$1"
    local engine="$2"

    diagnostics_print_separator

    printf "End of %s %s\n" \
        "$service" \
        "$engine"

    printf "\n"

}

print_platform_footer() {

    local section="$1"

    printf "\n"

    diagnostics_print_separator

    printf "End of Platform %s\n" "$section"

    printf "\n"

}

###############################################################################
# Status Messages
###############################################################################

print_success() {

    printf "%b✔ %s%b\n" \
        "${COLOR_SUCCESS}" \
        "$1" \
        "${COLOR_RESET}"

}

print_warning() {

    printf "%b⚠ %s%b\n" \
        "${COLOR_WARNING}" \
        "$1" \
        "${COLOR_RESET}"

}

print_error() {

    printf "%b✘ %s%b\n" \
        "${COLOR_ERROR}" \
        "$1" \
        "${COLOR_RESET}"

}

print_info() {

    printf "%b• %s%b\n" \
        "${COLOR_INFO}" \
        "$1" \
        "${COLOR_RESET}"

}
