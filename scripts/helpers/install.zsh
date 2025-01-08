#!/usr/bin/env zsh

BACKUP_DIR="$SETUP/backup"

function ensure_backup_file() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        msg_error "Backup file $file not found. Skipping."
        return 1
    fi

    return 0
}

function install_brew() {
    local TAPS_FILE="$BACKUP_DIR/brew_taps.bak"
    local FORMULAE_FILE="$BACKUP_DIR/brew_formulae.bak"
    local CASKS_FILE="$BACKUP_DIR/brew_casks.bak"

    if ! command -v brew >/dev/null 2>&1; then
        echo
        msg_warning "Homebrew not found. Installing Homebrew..."

        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
            msg_error "Failed to install Homebrew. Exiting."
            return 1
        }

        msg_success "Homebrew installed successfully."
    fi

    if ensure_backup_file "$TAPS_FILE"; then
        echo
        msg_info "Installing Homebrew taps from $TAPS_FILE..."

        while IFS= read -r tap; do
            if brew tap "$tap" >/dev/null 2>&1; then
                msg_success "Tap $tap restored successfully."
            else
                msg_error "Failed to tap $tap"
            fi
        done < "$TAPS_FILE"
    fi

    if ensure_backup_file "$FORMULAE_FILE"; then
        echo
        msg_info "Installing Homebrew formulae from $FORMULAE_FILE..."

        while IFS= read -r formula; do
            if brew install "$formula" >/dev/null 2>&1; then
                msg_success "Formula $formula installed successfully."
            else
                msg_error "Failed to install formula $formula"
            fi
        done < "$FORMULAE_FILE"
    fi

    if ensure_backup_file "$CASKS_FILE"; then
        echo
        msg_info "Installing Homebrew casks from $CASKS_FILE..."

        while IFS= read -r cask; do
            if brew install --cask "$cask" >/dev/null 2>&1; then
                msg_success "Cask $cask installed successfully."
            else
                msg_error "Failed to install cask $cask"
            fi
        done < "$CASKS_FILE"
    fi
}

function install_vsc() {
    local VSC_FILE="$BACKUP_DIR/vscode_extensions.bak"

    if ! command -v code >/dev/null 2>&1; then
        echo
        msg_error "VS Code CLI not found. Please install Visual Studio Code and ensure the CLI is available."
        return 1
    fi

    if ensure_backup_file "$VSC_FILE"; then
        echo
        msg_info "Installing VS Code extensions from $VSC_FILE..."

        while IFS= read -r extension; do
            if code --install-extension "$extension" >/dev/null 2>&1; then
                msg_success "Extension $extension installed successfully."
            else
                msg_error "Failed to install extension $extension"
            fi
        done < "$VSC_FILE"
    fi
}
