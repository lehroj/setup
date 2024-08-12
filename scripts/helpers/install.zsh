#!/bin/zsh

function install_brew()
{
    local BACKUP_TAPS=$SETUP/backup/brew_taps.save
    local BACKUP_FORMULAE=$SETUP/backup/brew_formulae.save
    local BACKUP_CASKS=$SETUP/backup/brew_casks.save

    echo
    msg_info "Installing brew formulae & casks..."

    if [[ ! -f $BACKUP_TAPS ]];
    then
        msg_error "$BACKUP_TAPS doesn't exist, skipped."
    fi

    if [[ ! -s $BACKUP_TAPS ]];
    then
        msg_error "$BACKUP_TAPS is empty, skipped."
    fi

    while read TAP;
    do
        if [[ "$(brew tap -- | grep -E "(^|\s)$TAP($|\s)")" ]];
        then
            msg_info "Homebrew tap - $TAP already done..."
        else
            brew tap $TAP &> /dev/null

            if [[ "$(brew tap -- | grep -E "(^|\s)$TAP($|\s)")" ]];
            then
                msg_success "Homebrew tap - $TAP ok!"
            else
                msg_error "Homebrew tap - $TAP failed!"
            fi
        fi
    done < $BACKUP_TAPS

    if [[ ! -f $BACKUP_FORMULAE ]];
    then
        msg_error "$BACKUP_FORMULAE doesn't exist, skipped."
    fi

    if [[ ! -s $BACKUP_FORMULAE ]];
    then
        msg_error "$BACKUP_FORMULAE is empty, skipped."
    fi

    while read FORMULA;
    do
        if [[ "$(brew list --formula | grep -E "(^|\s)$FORMULA($|\s)")" ]];
        then
            msg_info "Homebrew formula - $FORMULA already done..."
        else
            brew install $FORMULA &> /dev/null

            if [[ "$(brew list --formula | grep -E "(^|\s)$FORMULA($|\s)")" ]];
            then
                msg_success "Homebrew formula - $FORMULA ok!"
            else
                msg_error "Homebrew formula - $FORMULA failed!"
            fi
        fi
    done < $BACKUP_FORMULAE

    if [[ ! -f $BACKUP_CASKS ]];
    then
        msg_error "$BACKUP_CASKS doesn't exist, skipped."
    fi

    if [[ ! -s $BACKUP_CASKS ]];
    then
        msg_error "$BACKUP_CASKS is empty, skipped."
    fi

    while read CASK;
    do
        if [[ "$(brew list --cask | grep -E "(^|\s)$CASK($|\s)")" ]];
        then
            msg_info "Homebrew cask - $CASK already done..."
        else
            brew install --cask $CASK &> /dev/null

            if [[ "$(brew list --cask | grep -E "(^|\s)$CASK($|\s)")" ]];
            then
                msg_success "Homebrew cask - $CASK ok!"
            else
                msg_error "Homebrew cask - $CASK failed!"
            fi
        fi
    done < $BACKUP_CASKS
}

function install_vscode()
{
    local BACKUP_VSCODE=$SETUP/backup/vscode-extensions.save

    echo
    msg_info "Installing VSCode extensions..."

    if [[ ! -f $BACKUP_VSCODE ]];
    then
        msg_error "$BACKUP_VSCODE doesn't exist, skipped."
    fi

    if [[ ! -s $BACKUP_VSCODE ]];
    then
        msg_error "$BACKUP_VSCODE is empty, skipped."
    fi

    while read EXTENSION;
    do
        if [[ "$(code --list-extensions | grep -E "(^|\s)$EXTENSION($|\s)")" ]];
        then
            msg_info "VSCode extension - $EXTENSION already done..."
        else
            code --install-extension $EXTENSION &> /dev/null

            if [[ "$(code --list-extensions | grep -E "(^|\s)$EXTENSION($|\s)")" ]];
            then
                msg_success "VSCode extension - $EXTENSION ok!"
            else
                msg_error "VSCode extension - $EXTENSION failed!"
            fi
        fi
    done < $BACKUP_VSCODE
}
