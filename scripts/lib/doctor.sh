doctor_platform() {

    if docker_is_installed
    then
        ui_health_row "Docker Installed" "Healthy"
    else
        ui_health_row "Docker Installed" "Failed"
    fi

    if docker_is_running
    then
        ui_health_row "Docker Running" "Healthy"
    else
        ui_health_row "Docker Running" "Failed"
    fi

    if compose_is_available
    then
        ui_health_row "Docker Compose" "Healthy"
    else
        ui_health_row "Docker Compose" "Failed"
    fi

   ui_section "Services"

   for entry in "${SERVICES[@]}"
   do

     IFS='|' read -r name docker_service url http_enabled <<< "$entry"

       if docker_container_running "$docker_service"
         then
         ui_health_row "$name" "Running"
      else
        ui_health_row "$name" "Stopped"
     fi
 done

  ui_section "HTTP"

  for entry in "${SERVICES[@]}"
  do

    IFS='|' read -r name docker_service url http_enabled <<< "$entry"

    if [[ "$http_enabled" == "true" ]]
    then

        if http_check "$url"
        then
            ui_health_row "$name" "Reachable"
        else
            ui_health_row "$name" "Unreachable"
        fi

    fi

 done
}
