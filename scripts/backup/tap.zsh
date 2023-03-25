#!/usr/bin/env zsh

local BACKUP=$HOME/Setup/backup
local BACKUP_FILE=$BACKUP/tap.list

if [ ! -d $BACKUP ]; then
  mkdir -p $BACKUP
fi

if command -v brew &> /dev/null && brew tap &> /dev/null; then
  brew tap > $BACKUP_FILE
fi

echo -e "\e[1;32m✓\e[0m \e[1mHomebrew taps:\e[0m \e[37msaved in $BACKUP_FILE\e[0m"
