#!/usr/bin/env bash
#
###############################################################################
# DevOps Lab Platform
# File    : network.sh
# Purpose : Network SDK
###############################################################################

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_NETWORK_LOADED:-}" ]] && return 0
readonly DEVOPS_NETWORK_LOADED=1

###############################################################################
# Public API
###############################################################################

tcp_port_open() {

    local host="$1"
    local port="$2"

    timeout 2 bash -c \
        ">/dev/tcp/${host}/${port}" \
        >/dev/null 2>&1

}

http_status() {

    local url="$1"

    curl \
        --silent \
        --output /dev/null \
        --write-out "%{http_code}" \
        "$url"

}

http_available() {

    local url="$1"
    local status

    status="$(http_status "$url")"

    [[ "${status}" =~ ^[234][0-9][0-9]$ ]]

}
