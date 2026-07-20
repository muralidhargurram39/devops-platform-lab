#!/usr/bin/env bash
#
# =============================================================================
# DevOps Lab Platform
# File    : constants.sh
# Purpose : Global constants used by the platform.
# =============================================================================

###############################################################################
# CLI Information
###############################################################################

readonly CLI_NAME="DevOps Lab Platform"
readonly CLI_VERSION="1.0.0"

###############################################################################
# Project
###############################################################################

readonly PROJECT_NAME="devops-lab-platform"

###############################################################################
# Docker Compose
###############################################################################

readonly COMPOSE_FILE="docker-compose.yml"

###############################################################################
# Docker Network
###############################################################################

readonly PLATFORM_NETWORK="devops-platform"

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
