#!/usr/bin/env zsh

local BACKUP=$HOME/Setup/backup
local BACKUP_FILE=$BACKUP/brew.list

if [ ! -d $BACKUP ]; then
  mkdir -p $BACKUP
fi

if command -v brew &> /dev/null && brew list &> /dev/null; then
  brew list --formulae > $BACKUP_FILE
fi

echo -e "\e[1;32m✓\e[0m \e[1mHomebrew formulae:\e[0m \e[37msaved in $BACKUP_FILE\e[0m"
