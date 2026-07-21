#!/usr/bin/env bash

###############################################################################
# Test Framework
###############################################################################

PASS=0
FAIL=0

pass() {
    printf "✔ %s\n" "$1"
    ((++PASS))
}

fail() {
    printf "✖ %s\n" "$1"
    ((++FAIL))
}

assert_equals() {

    local expected="$1"
    local actual="$2"
    local message="$3"

    if [[ "$expected" == "$actual" ]]; then
        pass "$message"
    else
        fail "$message"
        printf "    Expected : %s\n" "$expected"
        printf "    Actual   : %s\n" "$actual"
    fi

}

assert_true() {

    local rc="$1"
    local message="$2"

    if [[ "$rc" -eq 0 ]]; then
        pass "$message"
    else
        fail "$message"
    fi

}

print_summary() {

    printf "\n"
    printf "=========================================\n"
    printf "Passed : %d\n" "$PASS"
    printf "Failed : %d\n" "$FAIL"
    printf "=========================================\n"

    [[ "$FAIL" -eq 0 ]]

}
