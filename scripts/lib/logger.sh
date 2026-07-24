#!/usr/bin/env bash

log() {
    local level="$1"
    shift
    echo "[${level}] $*"
}

info() {
    log INFO "$@"
}

warn() {
    log WARN "$@"
}

error() {
    log ERROR "$@" >&2
}

success() {
    log SUCCESS "$@"
}

die() {
    error "$@"
    exit 1
}
