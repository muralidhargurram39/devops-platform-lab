###############################################################################
# Restore Command
###############################################################################

command_restore() {

    local snapshot="$1"

    [[ -n "$snapshot" ]] \
        || die "Snapshot name required"

    platform_restore "$snapshot"

}
