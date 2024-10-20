#!/usr/bin/env zsh

# Clear screen on start
clear

# Locale settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# History settings
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory
setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt extended_history

# Enable automatic changing of directory
setopt auto_cd

# Case sensitive
CASE_SENSITIVE="true"

# No beep
setopt nobeep

# Editor settings
export EDITOR='nano'
export VISUAL='nano'
export GIT_EDITOR='nano'

# GPG settings
export GPG_TTY=$(tty)

# Setup
SETUP=$HOME/.setup

source $SETUP/scripts/my.zsh
source $HOME/.zsh_antidote
source $HOME/.zsh_aliases

if [[ -f $HOME/.zsh_local ]]; then
    source $HOME/.zsh_local
fi

eval "$(starship init zsh)"

# FNM
eval "$(fnm env --use-on-cd)"
