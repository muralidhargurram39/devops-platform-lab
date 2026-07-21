#!/usr/bin/env bash
#
# =============================================================================
# DevOps Lab Platform
# File    : constants.sh
# Purpose : Global constants used by the platform.
# =============================================================================

###############################################################################
# Source Guard
###############################################################################

[[ -n "${DEVOPS_CONSTANTS_LOADED:-}" ]] && return 0
readonly DEVOPS_CONSTANTS_LOADED=1

###############################################################################
# Project
###############################################################################

readonly PROJECT_NAME="devops-lab-platform"

###############################################################################
# Service Names
###############################################################################

readonly SERVICE_JENKINS="jenkins"
readonly SERVICE_SONARQUBE="sonarqube"
readonly SERVICE_POSTGRES="sonar-postgres"
readonly SERVICE_NEXUS="nexus"
readonly SERVICE_TOMCAT="tomcat"

###############################################################################
# Default Ports
###############################################################################

readonly PORT_JENKINS=8080
readonly PORT_SONARQUBE=9000
readonly PORT_NEXUS=8081
readonly PORT_TOMCAT=8082

###############################################################################
# Status
###############################################################################

readonly STATUS_RUNNING="Running"
readonly STATUS_STOPPED="Stopped"

###############################################################################
# Lifecycle Actions
###############################################################################

readonly ACTION_STARTING="Starting"
readonly ACTION_STOPPING="Stopping"
readonly ACTION_RESTARTING="Restarting"
