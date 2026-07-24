docker_is_installed() {
    command -v docker >/dev/null 2>&1
}

docker_is_running() {
    docker info >/dev/null 2>&1
}

docker_engine_health() {

    if docker info >/dev/null 2>&1; then
        echo "Running"
    else
        echo "Stopped"
    fi

}

docker_compose_health() {

    if docker compose version >/dev/null 2>&1; then
        echo "Available"
    else
        echo "Unavailable"
    fi

}

health_is_ok() {

    local status="$1"

    case "$status" in
        Healthy|Reachable)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

####################################################
# Logs
####################################################

compose_logs() {

    docker compose logs \
        --tail=50
}

compose_service_logs() {

    local service="$1"

    docker compose logs \
        --tail=50 \
        "$service"
}

compose_follow_logs() {

    local service="$1"

    docker compose logs \
        --follow \
        "$service"
}

####################################################
# Cleanup
####################################################

docker_cleanup_containers() {

    docker container prune --force
}

docker_cleanup_images() {

    docker image prune --force
}

docker_cleanup_networks() {

    docker network prune --force
}

docker_cleanup_builder() {

    docker builder prune --force
}

####################################################
# Shell
####################################################

compose_shell() {

    local service="$1"

    if docker compose exec "$service" bash -c "exit" >/dev/null 2>&1
    then
        docker compose exec "$service" bash
    else
        docker compose exec "$service" sh
    fi
}

###########################################################
# Execute command inside container
###########################################################

compose_exec() {

    local service="$1"
    shift

    docker compose exec "$service" "$@"
}

docker_check_daemon() {

    docker info >/dev/null 2>&1
}

docker_container_running() {

    local service="$1"

    docker compose ps --status running "$service" \
        | grep -q "$service"
}

docker_container_exists() {

    local service="$1"

    docker compose ps "$service" \
        | grep -q "$service"
}
