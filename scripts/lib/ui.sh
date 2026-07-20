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

print_banner() {

    echo
    printf "%b\n" "${COLOR_BOLD_BLUE}"
    echo "============================================================"
    echo "            DevOps Lab Platform v${CLI_VERSION}"
    echo "============================================================"
    printf "%b" "${COLOR_RESET}"
    echo

}

print_header() {

    echo
    printf "%b%s%b\n" \
        "${COLOR_BOLD}" \
        "$1" \
        "${COLOR_RESET}"

    printf "%0.s-" {1..60}

    echo

}

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
