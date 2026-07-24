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
