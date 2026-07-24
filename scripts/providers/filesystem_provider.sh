fs_create_dir() {

    local directory="$1"

    mkdir -p "$directory"
}

fs_copy() {

    local source="$1"
    local destination="$2"

    cp "$source" "$destination"
}

fs_copy_recursive() {

    local source="$1"
    local destination="$2"

    cp -R "$source" "$destination"
}

fs_copy_recursive() {

    local source="$1"
    local destination="$2"

    cp -R "$source" "$destination"
}

fs_write_file() {

    local file="$1"

    local content="$2"

    printf "%s\n" "$content" > "$file"
}

fs_symlink() {

    local target="$1"
    local link="$2"

    ln -sfn "$target" "$link"
}

fs_create_dirs() {

    local root="$1"

    mkdir -p \
        "${root}/volumes" \
        "${root}/databases" \
        "${root}/manifests" \
        "${root}/terraform" \
        "${root}/logs"
}
fs_archive() {

    local source="$1"
    local archive="$2"

    tar -czf "$archive" -C "$(dirname "$source")" "$(basename "$source")"
}

fs_directory_exists() {

    local directory="$1"

    [[ -d "$directory" ]]
}

fs_file_exists() {

    local file="$1"

    [[ -f "$file" ]]
}

fs_remove_recursive() {

    local directory="$1"

    rm -rf "$directory"
}

fs_copy_contents() {

    local source="$1"
    local destination="$2"

    cp -R "${source}/." "$destination"
}

fs_remove_recursive() {

    local directory="$1"

    rm -rf "$directory"
}

fs_copy_contents() {

    local source="$1"
    local destination="$2"

    cp -R "${source}/." "$destination"
}


