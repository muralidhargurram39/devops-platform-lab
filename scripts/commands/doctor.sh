#!/usr/bin/env bash

platform_doctor() {

    platform_validate

    echo

    ui_header "DevOps Lab Platform Diagnostics"

    ui_section "Platform"

    doctor_platform

}
