#!/usr/bin/env bash

service_exists() {

    [[ "$1" != "invalid" ]]

}

service_container_name() {

    echo "mock-container"

}

service_display_name() {

    echo "Mock Service"

}
