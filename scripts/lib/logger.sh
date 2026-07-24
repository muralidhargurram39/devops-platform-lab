#!/usr/bin/env bash

info() {
    echo "[INFO] $*"
}

warn() {
    echo "[WARN] $*"
}

error() {
    echo "[ERROR] $*" >&2
}

log_info() {
    echo "[INFO] $1"
}

die() {
    error "$@"
    exit 1
}
