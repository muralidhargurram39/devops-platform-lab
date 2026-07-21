###############################################################################
# Archive Library
###############################################################################

archive_create() {

    local source="$1"
    local archive="$2"

    tar -czf "$archive" \
        -C "$source" .

}

archive_extract() {

    local archive="$1"
    local destination="$2"

    mkdir -p "$destination"

    tar -xzf "$archive" \
        -C "$destination"

}

archive_verify() {

    local archive="$1"

    tar -tzf "$archive" >/dev/null

}

archive_list() {

    local archive="$1"

    tar -tzf "$archive"

}
