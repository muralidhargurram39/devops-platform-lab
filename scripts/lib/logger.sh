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

die() {
    error "$@"
    exit 1
}
