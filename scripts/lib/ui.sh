#!/usr/bin/env bash
#
# =============================================================================
# DevOps Lab Platform
# File    : ui.sh
# Purpose : UI rendering helpers.
# =============================================================================

print_banner() {

cat << EOF

============================================================
           DevOps Lab Platform CLI v${CLI_VERSION}
============================================================

EOF

}

print_separator() {

printf '%*s\n' "${COLUMNS:-60}" '' | tr ' ' '-'

}

print_header() {

echo
echo "▶ $1"
print_separator

}

print_success() {

printf "${COLOR_SUCCESS}✔ %s${COLOR_RESET}\n" "$1"

}

print_error() {

printf "${COLOR_ERROR}✘ %s${COLOR_RESET}\n" "$1"

}

print_warning() {

printf "${COLOR_WARNING}⚠ %s${COLOR_RESET}\n" "$1"

}

print_info() {

printf "${COLOR_INFO}ℹ %s${COLOR_RESET}\n" "$1"

}
