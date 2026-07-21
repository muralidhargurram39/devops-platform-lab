#!/usr/bin/env bash

set -e

echo "========================================"
echo "Running Unit Tests"
echo "========================================"

for test in tests/unit/*.sh
do
    echo
    echo "Running $test"
    bash "$test"
done

echo
echo "========================================"
echo "Running Integration Tests"
echo "========================================"

if [[ -d tests/integration ]]; then

    for test in tests/integration/*.sh; do

        [[ -f "$test" ]] || continue

        echo
        echo "Running $test"

        bash "$test"

    done

fi
