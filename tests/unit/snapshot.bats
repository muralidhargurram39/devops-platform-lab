@test "snapshot_metadata creates metadata.json" {

    local snapshot

    snapshot="$(_snapshot_directory)"

    snapshot_create "$snapshot"

    snapshot_metadata "$snapshot"

    [ -f "${snapshot}/metadata.json" ]
}

@test "snapshot_copy_compose copies compose file" {
    # Create snapshot
    # Copy compose
    # Assert docker-compose.yml exists
}

@test "snapshot_copy_env copies env file when present" {
    # Create temporary .env
    # Copy it
    # Assert file exists in snapshot
}
