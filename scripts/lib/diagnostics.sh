###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_DIAGNOSTICS_LOADED:-}" ]] && return 0
readonly DEVOPS_DIAGNOSTICS_LOADED=1

###############################################################################
# Private Helpers
###############################################################################



###############################################################################
# Public API
###############################################################################

diagnostics_print_separator() {

    printf "%s\n" \
        "------------------------------------------------------------"

}

diagnostics_print_summary_line() {

    local label="$1"
    local value="$2"

    printf "%-18s : %s\n" \
        "$label" \
        "$value"

}

diagnostics_summary_status() {

    local warning="$1"
    local error="$2"

    if (( error > 0 )); then

        printf "UNHEALTHY"

    elif (( warning > 0 )); then

        printf "DEGRADED"

    else

        printf "HEALTHY"

    fi

}

