docker_is_installed() {
    command -v docker >/dev/null 2>&1
}

docker_is_running() {
    docker info >/dev/null 2>&1
}
