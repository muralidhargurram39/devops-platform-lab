restore_platform() {

    local backup_name="${1:-latest}"
    local backup_dir="${BACKUP_ROOT}/${backup_name}"

    ui_header "DevOps Lab Platform Restore"

    ui_key_value "Selected Backup" "$backup_name"

    info "Validating backup..."

    if ! fs_directory_exists "$backup_dir"
    then
      die "Backup not found: ${backup_name}"
   fi

    success "Backup found."

    info "Validating backup contents..."

    fs_directory_exists "${backup_dir}/config" \
       || die "Missing config directory."

    fs_file_exists "${backup_dir}/docker-compose.yml" \
       || die "Missing docker-compose.yml."

    fs_file_exists "${backup_dir}/metadata.conf" \
       || die "Missing metadata.conf."

    success "Backup validated."

    source "${backup_dir}/metadata.conf"

    echo

    ui_key_value "Environment" "$environment"
    ui_key_value "Created" "$created"
    ui_key_value "Version" "$version"
    ui_key_value "Type" "$backup_type"

    echo

    ui_key_value "Actual Backup" "$backup_name"

    echo

    echo
    read -r -p "This will overwrite the current configuration. Continue? [y/N]: " answer

    case "$answer" in
      [Yy]|[Yy][Ee][Ss])
         ;;
      *)
        info "Restore cancelled."
        return 0
        ;;
  esac


  info "Stopping platform..."
  
  platform_stop
  
  success "Platform stopped."

   info "Restoring configuration..."
 
   fs_remove_recursive "${CONFIG_DIR}"
   
   fs_create_dir "${CONFIG_DIR}"

  fs_copy_contents \
    "${backup_dir}/config" \
    "${CONFIG_DIR}"

 success "Configuration restored."

 info "Restoring docker-compose.yml..."

 fs_copy \
    "${backup_dir}/docker-compose.yml" \
    "${PROJECT_ROOT}/docker-compose.yml"

 success "docker-compose.yml restored."

 info "Starting platform..."

 platform_start

 info "Waiting for services to initialize..."

 for entry in "${SERVICES[@]}"
 do
    IFS='|' read -r name docker_service url http_enabled <<< "$entry"

    if [[ "$http_enabled" == "true" ]]; then
        info "Waiting for ${name}..."

        if wait_for_http "$url" 120; then
            success "${name} is ready."
        else
            warning "${name} did not become ready within the timeout."
        fi
    fi
 done

 info "Running diagnostics..."

 platform_doctor

 success "Diagnostics completed."

 echo

 success "Restore completed successfully."

 ui_key_value "Backup" "$backup_name"
 ui_key_value "Environment" "$environment"
 ui_key_value "Restored At" "$(date '+%Y-%m-%d %H:%M:%S')"

}
