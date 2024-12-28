#!/bin/zsh

function symlink_file()
{
    local SOURCE_FILE=$1
    local TARGET_FILE=$2
    local TARGET_DIR=$(dirname "$TARGET_FILE")

    if [[ -L "$TARGET_FILE" || -f "$TARGET_FILE" ]];
    then
        msg_info "File already exists for '$TARGET_FILE'. [o]verwrite? any other key to skip."
        read -ks REPLY

        if [[ "$REPLY" == "o" || "$REPLY" == "O" ]];
        then
            rm -rf "$TARGET_FILE"
            ln -s "$SOURCE_FILE" "$TARGET_FILE"
            msg_success "File overwritten for '$TARGET_FILE'."
        else
            msg_success "Skipped for '$TARGET_FILE'."
        fi
    else
        msg_info "File '$TARGET_FILE' doesn't exist. [c]reate? any other key to skip."
        read -ks REPLY

        if [[ "$REPLY" == "c" || "$REPLY" == "C" ]];
        then
            if [[ ! -d "$TARGET_DIR" ]]; then
                mkdir -p "$TARGET_DIR"
            fi

            ln -s "$SOURCE_FILE" "$TARGET_FILE"
            msg_success "Symlink created for '$TARGET_FILE'."
        else
            msg_success "Skipped for '$TARGET_FILE'."
        fi
    fi

    unset REPLY
}

function config_git()
{
    local CONFIG_DIR=$SETUP/dotfiles/git
    local TARGET_DIR=$HOME

    echo

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
    local GHOSTTY_CONFIG=$SETUP/dotfiles/term/ghostty.conf
    local GHOSTTY_TARGET=$HOME/.config/ghostty/config
    local STARSHIP_CONFIG=$SETUP/dotfiles/term/starship.toml
    local STARSHIP_TARGET=$HOME/.config/starship.toml

    echo

    if [[ ! -f "$GHOSTTY_CONFIG" ]];
    then
        msg_error "Ghostty config file doesn't exist: $GHOSTTY_CONFIG"
        return 1
    fi

    symlink_file "$GHOSTTY_CONFIG" "$GHOSTTY_TARGET"

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
