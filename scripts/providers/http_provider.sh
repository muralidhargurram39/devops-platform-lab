#!/usr/bin/env bash

http_check() {

    local url="$1"

    local status

    status=$(
        curl \
            --silent \
            --output /dev/null \
            --write-out "%{http_code}" \
            --max-time 5 \
            "$url"
    )

    [[ "$status" =~ ^(200|301|302|401|403)$ ]]
}

wait_for_http() {

    local url="$1"
    local timeout="${2:-120}"
    local elapsed=0

    while (( elapsed < timeout )); do
        if http_check "$url"; then
            return 0
        fi

        sleep 2
        (( elapsed += 2 ))
    done

    return 1
}
