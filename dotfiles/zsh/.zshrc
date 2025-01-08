#!/usr/bin/env zsh

# Clear the screen on terminal startup for a clean slate.
clear

# Set locale settings to ensure consistent language and character encoding.
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Location of the history file.
HISTFILE="$HOME/.zsh_history"

# Number of commands stored in memory during the session.
HISTSIZE=1000

# Number of commands to save to the history file.
SAVEHIST=10000

# Append commands to the history file, rather than overwriting it.
setopt appendhistory

# Save each command to history immediately after execution.
setopt inc_append_history

# Share the command history between all active terminal sessions.
setopt share_history

# Prevent duplicate commands from being saved to the history file.
setopt hist_save_no_dups

# Remove all duplicate entries from the history.
setopt hist_ignore_all_dups

# Ignore duplicate commands in the history.
setopt hist_ignore_dups

# Ignore commands that begin with a space.
setopt hist_ignore_space

# Remove unnecessary blanks from history entries.
setopt hist_reduce_blanks

# Show the expanded command in the editor before execution.
setopt hist_verify

# Save timestamp and duration for each command in the history.
setopt extended_history

# Enable automatic directory changes by typing just the directory name.
setopt auto_cd

# Make path matching case-sensitive.
CASE_SENSITIVE="true"

# Disable the terminal beep sound for a quieter experience.
setopt nobeep

# Default editor for general use.
export EDITOR="nano"

# Editor for visual tasks.
export VISUAL="nano"

# Editor for Git commit messages.
export GIT_EDITOR="nano"

# Set the GPG TTY (required for proper GPG functionality in terminal sessions).
export GPG_TTY=$(tty)

# Initialize Homebrew environment variables for macOS package management.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Setup path for additional scripts and configurations.
SETUP="$HOME/.setup"

# Load personal Zsh script.
[ -f "$SETUP/scripts/my.zsh" ] && source "$SETUP/scripts/my.zsh"

# Load Antidote plugin manager.
[ -f "$HOME/.zsh_antidote" ] && source "$HOME/.zsh_antidote"

# Load custom aliases.
[ -f "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"

# Load local configuration if it exists (for user-specific settings).
[ -f "$HOME/.zsh_local" ] && source "$HOME/.zsh_local"

# Initialize Starship prompt for a dynamic and customizable shell prompt.
eval "$(starship init zsh)"

# Initialize fnm (Fast Node Manager) and set it to use `.nvmrc` files when switching directories.
eval "$(fnm env --use-on-cd)"
