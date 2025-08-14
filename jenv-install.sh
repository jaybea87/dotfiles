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
    local jdks=(
        "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home"
        "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home"
        "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home"
    )

    log "Adding JDKs to jenv..."
    for jdk in "${jdks[@]}"; do
        add_jdk "$jdk"
    done

    # Set global version - could be made configurable
    local global_version="21"
    log "Setting global Java version to $global_version"
    if jenv global "$global_version" 2>/dev/null; then
        log "Global Java version set to $global_version"
    else
        log_warning "Could not set global version to $global_version, using available version"
        # Try to set any available version
        local available_version
        available_version=$(jenv versions --bare | head -n1)
        if [[ -n "$available_version" ]]; then
            jenv global "$available_version"
            log "Set global Java version to $available_version"
        fi
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
