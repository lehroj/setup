#!/usr/bin/env zsh

local BACKUP=$HOME/Setup/backup
local BACKUP_FILE=$BACKUP/vsc.list

if [ ! -d $BACKUP ]; then
  mkdir -p $BACKUP
fi

if command -v code &> /dev/null && code --list-extensions &> /dev/null; then
  code --list-extensions > $BACKUP_FILE
fi

echo -e "\e[1;32m✓\e[0m \e[1mVisual Studio Code extensions:\e[0m \e[37msaved in $BACKUP_FILE\e[0m"
