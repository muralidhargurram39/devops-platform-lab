#!/usr/bin/env bash

platform_help() {

    echo

    ui_header "${PROJECT_NAME}"

    ui_section "Usage"

    echo "  ${CLI_NAME} <command> [options]"
    echo

    ui_section "Workspace"

    printf "  %-24s %s\n" "setup"             "Initialize the platform"
    printf "  %-24s %s\n" "Deploy"             "Create containers (docker compose up -d)"
    printf "  %-24s %s\n" "wake"              "Wake the development workspace"
    printf "  %-24s %s\n" "sleep"             "Put the workspace into sleep mode"
    echo

    ui_section "Platform"

    printf "  %-24s %s\n" "start [service|all]"   "Start services"
    printf "  %-24s %s\n" "stop [service|all]"    "Stop services"
    printf "  %-24s %s\n" "restart [service|all]" "Restart services"
    printf "  %-24s %s\n" "status"                "Show service status"
    printf "  %-24s %s\n" "doctor"                "Run platform diagnostics"
    printf "  %-24s %s\n" "health"                "Check service health"
    echo

    ui_section "Operations"

    printf "  %-24s %s\n" "backup"               "Create a configuration backup"
    printf "  %-24s %s\n" "restore [backup]"     "Restore from a backup"
    printf "  %-24s %s\n" "cleanup"              "Remove temporary resources"
    echo

    ui_section "Utilities"

    printf "  %-24s %s\n" "logs <service>"       "View service logs"
    printf "  %-24s %s\n" "shell <service>"      "Open an interactive shell"
    printf "  %-24s %s\n" "exec <service> <cmd>" "Execute a command"
    printf "  %-24s %s\n" "config"               "Show current configuration"
    printf "  %-24s %s\n" "version"              "Show platform version"
    printf "  %-24s %s\n" "help"                 "Show this help"
    echo

    ui_section "Examples"

    echo "  ${CLI_NAME} start"
    echo "  ${CLI_NAME} stop nexus"
    echo "  ${CLI_NAME} doctor"
    echo "  ${CLI_NAME} backup"
    echo "  ${CLI_NAME} restore latest"
    echo "  ${CLI_NAME} logs jenkins"
    echo "  ${CLI_NAME} shell nexus"
    echo

    ui_section "Documentation"

    echo "  README.md"
    echo
}
