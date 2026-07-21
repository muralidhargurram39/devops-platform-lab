#!/usr/bin/env bash

container_running() {

    return 0

}

container_logs() {

    cat <<EOF
Mock Jenkins Log 1
Mock Jenkins Log 2
EOF

}

container_logs_tail() {

    echo "Tail $2"

}

container_logs_since() {

    echo "Since $2"

}

container_logs_follow() {

    echo "Following..."

}
