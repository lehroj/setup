#!/bin/zsh

function ensure_backup_dir()
{
    local BACKUP_DIR=$SETUP/backup

    if [[ ! -d "$BACKUP_DIR" ]];
    then
        mkdir -p "$BACKUP_DIR"
    fi
}

function backup_brew()
{
    local BACKUP_DIR=$SETUP/backup
    local TAPS_FILE=$BACKUP_DIR/brew_taps.save
    local FORMULAE_FILE=$BACKUP_DIR/brew_formulae.save
    local CASKS_FILE=$BACKUP_DIR/brew_casks.save

    ensure_backup_dir

    if command -v "brew" >/dev/null 2>&1;
    then
        echo
        msg_info "Backing up Brew taps..."
        brew tap > "$TAPS_FILE"
        msg_success "Brew taps saved to $TAPS_FILE"

        echo
        msg_info "Backing up Brew formulae..."
        brew list --formula > "$FORMULAE_FILE"
        msg_success "Brew formulae saved to $FORMULAE_FILE"

        echo
        msg_info "Backing up Brew casks..."
        brew list --cask > "$CASKS_FILE"
        msg_success "Brew casks saved to $CASKS_FILE"
    else
        msg_error "Error: Brew is not installed."
    fi
}

function backup_vscode()
{
    local BACKUP_DIR=$SETUP/backup
    local VSC_FILE=$BACKUP_DIR/vscode-extensions.save

    ensure_backup_dir

    if command -v "code" >/dev/null 2>&1;
    then
        echo
        msg_info "Backing up VSCode extensions..."
        code --list-extensions > "$VSC_FILE"
        msg_success "VSCode extensions saved to $VSC_FILE"
    else
        msg_error "Error: VSCode is not installed."
    fi
}
