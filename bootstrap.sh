#!/bin/bash
set -eu  # Exit on error, undefined vars

# Source shared library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

init_workspace() {
    if ! confirm "Initializing workspace directory"; then
        log_info "Workspace initialization cancelled"
        return 0
    fi

    local workspace_dir="${HOME}/workspace"

    if [[ -d "$workspace_dir" ]]; then
        log_info "Workspace directory already exists at $workspace_dir"
        return 0
    fi

    log "Creating workspace directory at $workspace_dir"
    if mkdir -pv "$workspace_dir"; then
        log "Workspace directory created successfully"
    else
        log_error "Failed to create workspace directory"
        return 1
    fi
}

init_symlinks() {
    if ! confirm "Initializing symlinks"; then
        log_info "Symlinking cancelled"
        return 0
    fi

    log "Creating configuration directories..."
    mkdir -pv "${HOME}/.config"
    mkdir -pv "${HOME}/.config/fish"

    local files=(
        ".config/fish/config.fish"
        ".config/fish/alias.fish"
        ".config/fish/local.fish"
        ".config/fish/export.fish"
        ".config/fish/jenv.fish"
        ".config/starship.toml"
    )

    log "Creating symlinks..."
    for file in "${files[@]}"; do
        local source="$PWD/$file"
        local target="$HOME/$file"

        if [[ ! -f "$source" ]]; then
            log_warning "Source file $source does not exist, skipping..."
            continue
        fi

        if ln -svf "$source" "$target"; then
            log "Successfully linked $file"
        else
            log_error "Failed to link $file"
            return 1
        fi
    done

    log "Symlinking complete"
}

install_homebrew() {
    if ! is_macos; then
        log_info "Skipping Homebrew installation - macOS not detected"
        return 0
    fi

    if command -v brew &> /dev/null; then
        log_info "Homebrew already installed, skipping..."
        return 0
    fi

    if ! confirm "Installing Homebrew"; then
        log_info "Homebrew installation cancelled"
        return 0
    fi

    log "Installing Homebrew..."
    if [[ -f "brew-install.sh" ]]; then
        if sh brew-install.sh; then
            log "Homebrew installation completed successfully"
        else
            log_error "Homebrew installation failed"
            return 1
        fi
    else
        log_error "brew-install.sh script not found"
        return 1
    fi
}

install_tools() {
    if ! is_macos; then
        log_info "Skipping Homebrew tools - macOS not detected"
        return 0
    fi

    if ! confirm "Installing tools found in Brewfile"; then
        log_info "Tools installation cancelled"
        return 0
    fi

    if ! command -v brew &> /dev/null; then
        log_error "Homebrew not found. Please install Homebrew first."
        return 1
    fi

    log "Installing tools using brew. This may take a while..."
    if brew update && brew upgrade && brew bundle; then
        log "Tools installation completed successfully"
    else
        log_error "Tools installation failed"
        return 1
    fi
}

install_jenv() {
    if ! is_macos; then
        log_info "Skipping jenv installation - macOS not detected"
        return 0
    fi

    if ! confirm "Installing jenv (requires a fish session)"; then
        log_info "jenv installation cancelled"
        return 0
    fi

    log "Installing jenv..."
    if [[ -f "jenv-install.sh" ]]; then
        if sh jenv-install.sh; then
            log "jenv installation completed successfully"
        else
            log_error "jenv installation failed"
            return 1
        fi
    else
        log_error "jenv-install.sh script not found"
        return 1
    fi
}

ensure_brew_environment_working() {
    if is_macos; then
        log "Ensuring that Homebrew environment is working for this session"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
}

main() {
    echo "${PURPLE}===========================================${NC}"
    echo "${PURPLE}         Starting Dotfiles Setup         ${NC}"
    echo "${PURPLE}===========================================${NC}"

    init_workspace || exit 1
    init_symlinks || exit 1
    install_homebrew || exit 1
    ensure_brew_environment_working
    install_tools || exit 1
    install_jenv || exit 1

    echo "${GREEN}===========================================${NC}"
    echo "${GREEN}       Dotfiles Setup Completed!         ${NC}"
    echo "${GREEN}===========================================${NC}"
}

main "$@"
