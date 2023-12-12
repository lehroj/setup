#!/usr/bin/env zsh

clear

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

export GPG_TTY=$(tty)

setopt NO_BEEP

DISABLE_AUTO_UPDATE="true"

CASE_SENSITIVE="true"

HISTFILE=$HOME/.zsh_history
HISTSIZE="10000"
SAVEHIST="10000"

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY

. $HOME/Setup/scripts/my.zsh

. $HOME/.zsh_plugins
. $HOME/.zsh_aliases
. $HOME/.zsh_utils
