#!/usr/bin/env zsh

BACKUP_DIR="$SETUP/backup"

function ensure_backup_dir()
{
    if [[ ! -d "$BACKUP_DIR" ]];
    then
        mkdir -p "$BACKUP_DIR"
    fi
}

function backup_brew() {
    ensure_backup_dir

    local CASKS_FILE="$BACKUP_DIR/brew_casks.bak"
    local FORMULAE_FILE="$BACKUP_DIR/brew_formulae.bak"
    local TAPS_FILE="$BACKUP_DIR/brew_taps.bak"

    echo

    if ! command -v brew >/dev/null 2>&1; then
        msg_error "Homebrew not found. Skipping Homebrew backup."
        return
    fi

    msg_info "Backing up Homebrew casks to $CASKS_FILE..."
    brew list --cask > "$CASKS_FILE"
    msg_success "Homebrew casks backed up successfully."

    echo

    msg_info "Backing up Homebrew formulae to $FORMULAE_FILE..."
    brew list --formula > "$FORMULAE_FILE"
    msg_success "Homebrew formulae backed up successfully."

    echo

    msg_info "Backing up Homebrew taps to $TAPS_FILE..."
    brew tap > "$TAPS_FILE"
    msg_success "Homebrew taps backed up successfully."
}

function backup_vsc() {
    ensure_backup_dir

    local VSC_FILE="$BACKUP_DIR/vscode_extensions.bak"

    echo

    if ! command -v code >/dev/null 2>&1; then
        msg_error "VS Code CLI not found. Skipping VS Code extensions backup."
        return
    fi

    msg_info "Backing up VS Code extensions to $VSC_FILE..."
    code --list-extensions > "$VSC_FILE"
    msg_success "VS Code extensions backed up successfully."
}
