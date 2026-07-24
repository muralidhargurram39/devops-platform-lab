#!/usr/bin/env bash

http_status() {

    local url="$1"
    local code

    code=$(
        curl \
            --silent \
            --output /dev/null \
            --write-out "%{http_code}" \
            --max-time 5 \
            "$url"
    )

    case "$code" in
        2*|3*|4*)
            echo "Reachable"
            ;;
        *)
            echo "Unreachable"
            ;;
    esac
}
