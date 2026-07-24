#!/usr/bin/env bash

ui_header() {

    local title="$1"

    echo
    echo "======================================================"
    printf " %-52s\n" "$title"
    echo "======================================================"
    echo
}

ui_section() {

    local title="$1"

    echo "$title"
    printf "%0.s-" $(seq 1 ${#title})
    echo
}

ui_table_header() {

    printf "%-20s %-12s %-12s\n" \
        "SERVICE" \
        "STATE" \
        "HEALTH"

    printf "%-20s %-12s %-12s\n" \
        "-------" \
        "-----" \
        "------"
}

ui_table_row() {

    printf "%-20s %-12s %-12s\n" \
        "$1" \
        "$2" \
        "$3"
}

ui_summary() {

    local running="$1"
    local stopped="$2"

    echo
    echo "------------------------------------------------------"
    printf "%-22s %s\n" "Running Containers :" "$running"
    printf "%-22s %s\n" "Stopped Containers :" "$stopped"
    echo
}

ui_health_header() {

    printf "%-22s %-12s\n" "COMPONENT" "STATUS"
    printf "%-22s %-12s\n" "---------" "------"

}

ui_health_row() {

    printf "%-22s %-12s\n" "$1" "$2"

}

ui_key_value() {

    local key="$1"
    local value="$2"

    printf "%-15s : %s\n" "$key" "$value"
}
