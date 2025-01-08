#!/usr/bin/env zsh

DOTFILES_DIR="$SETUP/dotfiles"

# Git mapping
GIT_SOURCES=(
    "${DOTFILES_DIR}/git/.gitconfig"
    "${DOTFILES_DIR}/git/.git_aliases"
    "${DOTFILES_DIR}/git/.git_ignore"
    "${DOTFILES_DIR}/git/.git_local"
    "${DOTFILES_DIR}/git/.git_perso"
    "${DOTFILES_DIR}/git/.git_work"
)

GIT_TARGETS=(
    "${HOME}/.gitconfig"
    "${HOME}/.git_aliases"
    "${HOME}/.git_ignore"
    "${HOME}/.git_local"
    "${HOME}/.git_perso"
    "${HOME}/.git_work"
)

# Misc mapping
MISC_SOURCES=(
    "$DOTFILES_DIR/misc/ghostty-config"
    "$DOTFILES_DIR/misc/gpg-agent.conf"
    "$DOTFILES_DIR/misc/starship.toml"
    "$DOTFILES_DIR/misc/vscode-settings.json"
)

MISC_TARGETS=(
    "$HOME/.config/ghostty/config"
    "$HOME/.gnupg/gpg-agent.conf"
    "$HOME/.config/starship.toml"
    "$HOME/Library/Application Support/Code/User/settings.json"
)

# Zsh mapping
ZSH_SOURCES=(
    "$DOTFILES_DIR/zsh/.zshrc"
    "$DOTFILES_DIR/zsh/.zsh_aliases"
    "$DOTFILES_DIR/zsh/.zsh_antidote"
    "$DOTFILES_DIR/zsh/.zsh_local"
)

ZSH_TARGETS=(
    "$HOME/.zshrc"
    "$HOME/.zsh_aliases"
    "$HOME/.zsh_antidote"
    "$HOME/.zsh_local"
)

function create_symlink() {
    local SOURCE_FILE=$1
    local TARGET_FILE=$2
    local TARGET_DIR=$(dirname "$TARGET_FILE")

    if [[ ! -e "$SOURCE_FILE" ]]; then
        msg_error "Error: Source file '$SOURCE_FILE' is missing. Skipping."
        return
    fi

    if [[ -e "$TARGET_FILE" || -L "$TARGET_FILE" ]]; then
        msg_warning "File '$TARGET_FILE' already exists. Overwrite? [o] to overwrite, any other key to skip."
        read -ks REPLY

        if [[ "$REPLY" == "o" || "$REPLY" == "O" ]]; then
            rm -rf "$TARGET_FILE"
            ln -s "$SOURCE_FILE" "$TARGET_FILE"
            msg_success "Symlink overwritten for '$TARGET_FILE'."
        else
            msg_success "Skipped for '$TARGET_FILE'."
        fi
    else
        [[ ! -d "$TARGET_DIR" ]] && mkdir -p "$TARGET_DIR"
        ln -s "$SOURCE_FILE" "$TARGET_FILE"
        msg_success "Symlink created for '$TARGET_FILE'."
    fi
}

function dotfiles_git() {
    echo
    msg_info "Creating symlinks for Git configuration files..."

    for (( i = 1; i <= ${#GIT_SOURCES[@]}; i++ )); do
        create_symlink "${GIT_SOURCES[$i]}" "${GIT_TARGETS[$i]}"
    done
}

function dotfiles_misc() {
    echo
    msg_info "Creating symlinks for miscellaneous configuration files..."

    for (( i = 1; i <= ${#MISC_SOURCES[@]}; i++ )); do
        create_symlink "${MISC_SOURCES[$i]}" "${MISC_TARGETS[$i]}"
    done
}

function dotfiles_zsh() {
    echo
    msg_info "Creating symlinks for Zsh configuration files..."

    for (( i = 1; i <= ${#ZSH_SOURCES[@]}; i++ )); do
        create_symlink "${ZSH_SOURCES[$i]}" "${ZSH_TARGETS[$i]}"
    done
}
