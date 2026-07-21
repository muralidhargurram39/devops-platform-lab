metadata_read() {

    local snapshot="$1"

    local snapshot_dir

    snapshot_dir="$(snapshot_path "$snapshot")"

    cat "${snapshot_dir}/metadata.json"

}
