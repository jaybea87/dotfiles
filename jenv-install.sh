#!/bin/bash
set -eu

# Source shared library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

cleanup_jenv() {
    log "Cleaning up stale jenv lock..."
    rm -f ~/.jenv/shims/.jenv-shim
}

install_jenv() {
    if brew list jenv &>/dev/null; then
        log_info "jenv is already installed"
        return 0
    fi

    log "Installing jenv..."
    if brew install jenv; then
        log "jenv installed successfully"
    else
        log_error "Failed to install jenv"
        return 1
    fi
}

add_jdk() {
    local path="$1"
    local version_name

    if [[ ! -d "$path" ]]; then
        log_warning "JDK path $path does not exist, skipping..."
        return 0
    fi

    # Extract version name from path for better logging
    version_name=$(basename "$path" | sed 's/\.jdk$//')

    if jenv versions --bare | grep -q "$(basename "$path")"; then
        log_info "JDK $version_name already added to jenv"
        return 0
    fi

    log "Adding JDK $version_name to jenv"
    if jenv add "$path"; then
        log "Successfully added JDK $version_name"
    else
        log_error "Failed to add JDK $version_name"
        return 1
    fi
}

configure_jenv() {
    log "Discovering installed JDKs..."

    # Dynamically find all JDK installations in the standard macOS location
    local jdks=()

    if [[ -d "/Library/Java/JavaVirtualMachines" ]]; then
        # Find all .jdk directories and get their Contents/Home paths
        local jdk_path
        for jdk_path in $(find /Library/Java/JavaVirtualMachines -maxdepth 1 -name "*.jdk" -type d | sort); do
            if [[ -d "$jdk_path/Contents/Home" ]]; then
                jdks+=("$jdk_path/Contents/Home")
            fi
        done
    fi

    if [[ ${#jdks[@]} -eq 0 ]]; then
        log_warning "No JDK installations found in /Library/Java/JavaVirtualMachines"
        return 1
    fi

    log_info "Found ${#jdks[@]} JDK installation(s)"

    log "Adding JDKs to jenv..."
    for jdk in "${jdks[@]}"; do
        add_jdk "$jdk"
    done

    # Set global version - prefer LTS versions in order: 25, 21, 17, 11, or latest available
    local global_version=""
    local preferred_versions=("25" "21" "17" "11")

    log "Determining global Java version..."
    for preferred in "${preferred_versions[@]}"; do
        # Match either "26" exactly or "26.x.x" versions
        if jenv versions --bare 2>/dev/null | grep -qE "^${preferred}(\.|\$)"; then
            global_version="$preferred"
            break
        fi
    done

    # If no preferred version found, use the latest available
    if [[ -z "$global_version" ]]; then
        global_version=$(jenv versions --bare 2>/dev/null | tail -n1)
    fi

    if [[ -n "$global_version" ]]; then
        log "Setting global Java version to $global_version"
        if jenv global "$global_version" 2>/dev/null; then
            log "Global Java version set to $global_version"
        else
            log_warning "Could not set global version to $global_version"
        fi
    else
        log_warning "Could not determine a global Java version"
    fi
}

setup_plugins() {
    log "Configuring jenv plugins..."

    # Reset export plugin
    jenv disable-plugin export &>/dev/null || true
    if jenv sh-enable-plugin export; then
        log "Export plugin enabled"
    else
        log_warning "Failed to enable export plugin"
    fi

    # Reset maven plugin
    jenv disable-plugin maven &>/dev/null || true
    if jenv sh-enable-plugin maven; then
        log "Maven plugin enabled"
    else
        log_warning "Failed to enable maven plugin"
    fi
}

finalize_setup() {
    log "Rehashing jenv shims..."
    jenv rehash

    log "Running jenv doctor..."
    jenv doctor

    log_info "Note: 'No JAVA_HOME set' is OK - the export plugin requires a new fish session to take effect"
    log_info "If you see any [ERROR]: Try rerunning this script in a new fish session"
}

main() {
    if ! is_macos; then
        log_info "Skipping jenv setup - macOS not detected"
        exit 0
    fi

    log "Starting jenv setup..."

    cleanup_jenv
    install_jenv || exit 1
    configure_jenv || exit 1
    setup_plugins
    finalize_setup

    log "jenv setup completed successfully"
}

main "$@"
