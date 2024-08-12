#!/bin/zsh

function symlink_file()
{
    local SOURCE_FILE=$1
    local TARGET_FILE=$2

    if [[ -L "$TARGET_FILE" || -f "$TARGET_FILE" ]];
    then
        msg_info "File already exists for $(basename "$TARGET_FILE"). [o]verwrite ? any other key to skip."
        read -ks REPLY

        if [[ "$REPLY" == "o" || "$REPLY" == "O" ]];
        then
            rm -rf "$TARGET_FILE"
            ln -s "$SOURCE_FILE" "$TARGET_FILE"
            msg_success "File overwritten for $(basename "$TARGET_FILE")."
        else
            msg_success "Skipped for $(basename "$TARGET_FILE")."
        fi
    else
        msg_info "File $(basename "$TARGET_FILE") doesn't exist. [c]reate ? any other key to skip."
        read -ks REPLY

        if [[ "$REPLY" == "c" || "$REPLY" == "C" ]];
        then
            ln -s "$SOURCE_FILE" "$TARGET_FILE"
            msg_success "Symlink created for $(basename "$TARGET_FILE")."
        else
            msg_success "Skipped for $(basename "$TARGET_FILE")."
        fi
    fi

    unset REPLY
}

function config_git()
{
    local CONFIG_DIR=$SETUP/dotfiles/git
    local TARGET_DIR=$HOME

    echo
    msg_info "Creating symlinks for Git config files..."

    if [[ ! -d "$CONFIG_DIR" ]];
    then
        msg_error "Git config directory doesn't exist: $CONFIG_DIR"
        return 1
    fi

    if [[ -z $(ls -A "$CONFIG_DIR") ]];
    then
        msg_error "Git config directory is empty: $CONFIG_DIR"
        return 1
    fi

    for FILE in $(ls -A1 $CONFIG_DIR);
    do
        symlink_file "$CONFIG_DIR/$FILE" "$TARGET_DIR/$(basename "$FILE")"
    done
}

function config_term()
{
    local HYPER_CONFIG=$SETUP/dotfiles/term/hyper.js
    local HYPER_TARGET=$HOME/Library/Application\ Support/Hyper/.hyper.js
    local STARSHIP_CONFIG=$SETUP/dotfiles/term/starship.toml
    local STARSHIP_TARGET=$HOME/.config/starship.toml

    echo
    msg_info "Creating symlinks for terminal config files..."

    if [[ ! -f "$HYPER_CONFIG" ]];
    then
        msg_error "Hyper config file doesn't exist: $HYPER_CONFIG"
        return 1
    fi

    symlink_file "$HYPER_CONFIG" "$HYPER_TARGET"

    if [[ ! -f "$STARSHIP_CONFIG" ]];
    then
        msg_error "Starship config file doesn't exist: $STARSHIP_CONFIG"
        return 1
    fi

    symlink_file "$STARSHIP_CONFIG" "$STARSHIP_TARGET"
}

function config_vscode()
{
    local CONFIG_DIR=$SETUP/dotfiles/vscode
    local TARGET_DIR=$HOME/Library/Application\ Support/Code/User

    echo
    msg_info "Creating symlinks for VSCode config files..."

    if [[ ! -d "$CONFIG_DIR" ]];
    then
        msg_error "VSCode config directory doesn't exist: $CONFIG_DIR"
        return 1
    fi

    if [[ -z $(ls -A "$CONFIG_DIR") ]];
    then
        msg_error "VSCode config directory is empty: $CONFIG_DIR"
        return 1
    fi

    for FILE in $(ls -A1 $CONFIG_DIR);
    do
        symlink_file "$CONFIG_DIR/$FILE" "$TARGET_DIR/$(basename "$FILE")"
    done
}

function config_zsh()
{
    local CONFIG_DIR=$SETUP/dotfiles/zsh
    local TARGET_DIR=$HOME

    echo
    msg_info "Creating symlinks for Zsh config files..."

    if [[ ! -d "$CONFIG_DIR" ]];
    then
        msg_error "Zsh config directory doesn't exist: $CONFIG_DIR"
        return 1
    fi

    if [[ -z $(ls -A "$CONFIG_DIR") ]];
    then
        msg_error "Zsh config directory is empty: $CONFIG_DIR"
        return 1
    fi

    for FILE in $(ls -A1 $CONFIG_DIR);
    do
        symlink_file "$CONFIG_DIR/$FILE" "$TARGET_DIR/$(basename "$FILE")"
    done
}
