###############################################################################
# Docker Provider
###############################################################################

docker_list_platform_volumes() {

    docker volume ls \
        --filter "name=${DEFAULT_COMPOSE_PROJECT_NAME}_" \
        --format '{{.Name}}'
}
