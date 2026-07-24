#!/usr/bin/env bash

platform_help() {

cat <<EOF
${PROJECT_NAME}

Usage:

    ${CLI_NAME} <command>

Workspace Commands
    setup
    wake
    sleep

Service Commands
    start   [service|all]
    stop    [service|all]
    restart [service|all]

Operations
    status

Utility Commands
    version
    help
        
EOF

}
