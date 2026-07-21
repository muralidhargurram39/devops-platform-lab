@test "snapshot_metadata creates metadata.json" {

    local snapshot

    snapshot="$(_snapshot_directory)"

    snapshot_create "$snapshot"

    snapshot_metadata "$snapshot"

    [ -f "${snapshot}/metadata.json" ]
}
