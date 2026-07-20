#!/usr/bin/env bash
#
# =============================================================================
# DevOps Lab Platform
# File    : colors.sh
# Purpose : ANSI color definitions used throughout the CLI.
# =============================================================================

# Reset
readonly COLOR_RESET='\033[0m'

# Regular Colors
readonly COLOR_BLACK='\033[0;30m'
readonly COLOR_RED='\033[0;31m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[0;33m'
readonly COLOR_BLUE='\033[0;34m'
readonly COLOR_PURPLE='\033[0;35m'
readonly COLOR_CYAN='\033[0;36m'
readonly COLOR_WHITE='\033[0;37m'

# Bold Colors
readonly COLOR_BOLD='\033[1m'
readonly COLOR_BOLD_RED='\033[1;31m'
readonly COLOR_BOLD_GREEN='\033[1;32m'
readonly COLOR_BOLD_YELLOW='\033[1;33m'
readonly COLOR_BOLD_BLUE='\033[1;34m'

# Status Colors
readonly COLOR_SUCCESS="${COLOR_GREEN}"
readonly COLOR_ERROR="${COLOR_RED}"
readonly COLOR_WARNING="${COLOR_YELLOW}"
readonly COLOR_INFO="${COLOR_BLUE}"
