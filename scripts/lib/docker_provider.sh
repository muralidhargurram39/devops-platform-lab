###############################################################################
# Docker Provider
###############################################################################

docker_list_platform_volumes() {

    docker volume ls \
        --filter "name=${DEFAULT_COMPOSE_PROJECT_NAME}_" \
        --format '{{.Name}}'
}

docker_export_volume() {

    local volume="$1"
    local destination="$2"

    docker run --rm \
        -v "${volume}:/source:ro" \
        -v "${destination}:/backup" \
        alpine:latest \
        sh -c "tar -czf /backup/${volume}.tar.gz -C /source ." \
        >/dev/null
}
