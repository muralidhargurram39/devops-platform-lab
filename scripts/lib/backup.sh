#!/usr/bin/env bash

backup_platform() {

    local timestamp

    timestamp=$(date +"%Y%m%d-%H%M%S")

    local backup_root="backups"

    local backup_dir="${backup_root}/${timestamp}"

    ui_header "DevOps Lab Platform Backup"

    ui_key_value "Backup Name" "$timestamp"
    
    ui_key_value "Environment" "$ACTIVE_ENV"

    info "Creating backup directory..."

    fs_create_dir "$backup_dir"

    success "Backup directory created."

    info "Backing up configuration..."

    fs_copy_recursive "config" "${backup_dir}/"

    success "Configuration backed up."

    info "Backing up docker-compose.yml..."

    fs_copy "docker-compose.yml" "${backup_dir}/"

    success "docker-compose.yml backed up."

    info "Generating backup metadata..."

    local metadata

    metadata=$(cat <<EOF
    version=1.0.0
    created=$(date +"%Y-%m-%dT%H:%M:%S")
    environment=${ACTIVE_ENV}
    backup_name=${timestamp}
    backup_type=configuration
EOF
)

    fs_write_file "${backup_dir}/metadata.conf" "$metadata"

    success "Metadata generated."

    info "Updating latest backup link..."

    fs_symlink "$timestamp" "${backup_root}/latest"

    success "Latest backup link updated."

    echo

   success "Backup completed successfully."

   echo

   ui_key_value "Location" "$backup_dir"
}
