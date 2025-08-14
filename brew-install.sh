#!/bin/bash
set -eu

# Source shared library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

# Install homebrew if it is not installed
if ! command -v brew &> /dev/null; then
    log "Homebrew not installed. Attempting to install Homebrew"
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        log "Homebrew installed successfully"

        # Set up Homebrew environment for current session
        if is_macos; then
            log_info "Setting up Homebrew environment"
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        log_error "Homebrew installation failed"
        exit 1
    fi
else
    log_info "Homebrew is already installed"
fi
