#!/usr/bin/env bash

###############################################################################
# Interactive Menu Helpers
###############################################################################

menu_select() {

    local __resultvar="$1"
    shift

    local title="$1"
    shift

    local -a options=("$@")
    local choice
    local index

    [[ ${#options[@]} -gt 0 ]] || {
        print_error "No options available."
        return 1
    }

    echo
    print_header "$title"

    for ((index=0; index<${#options[@]}; index++)); do
        printf " %2d) %s\n" "$((index + 1))" "${options[index]}"
    done

    echo

    while true; do

        read -r -p "Select option [1-${#options[@]}] (q to cancel): " choice

        case "$choice" in
            q|Q)
                return 1
                ;;
        esac

        if [[ "$choice" =~ ^[0-9]+$ ]] &&
           (( choice >= 1 && choice <= ${#options[@]} )); then

            printf -v "$__resultvar" '%s' "${options[$((choice-1))]}"
            return 0
        fi

        print_warning "Invalid selection."

    done
}

###############################################################################

menu_confirm() {

    local message="${1:-Continue?}"
    local answer

    while true; do

        read -r -p "${message} [y/N]: " answer

        case "$answer" in
            y|Y|yes|YES)
                return 0
                ;;
            n|N|no|NO|"")
                return 1
                ;;
        esac

        print_warning "Please enter y or n."

    done
}
