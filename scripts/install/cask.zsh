#!/usr/bin/env zsh

local BACKUP_FILE=$HOME/Setup/backup/cask.list

if [ ! -f $BACKUP_FILE ]; then
  echo -e "\e[1;31m✗\e[0m \e[1mHomebrew casks:\e[0m \e[37mfile $BACKUP_FILE doesn't exist, aborting...\e[0m"

  return
fi

if [ ! -s $BACKUP_FILE ]; then
  echo -e "\e[1;31m✗\e[0m \e[1mHomebrew casks:\e[0m \e[37mfile $BACKUP_FILE is empty, aborting...\e[0m"

  return
fi

while read CASK; do
  if [ "$(brew list --casks | grep -E "(^|\s)$CASK($|\s)")" ]; then
    echo -e "\e[1;32m✓\e[0m \e[1mHomebrew cask - $CASK\e[0m \e[37malready done...\e[0m"
  else
    brew install --cask $CASK &> /dev/null

    if [ "$(brew list --casks | grep -E "(^|\s)$CASK($|\s)")" ]; then
      echo -e "\e[1;32m✓\e[0m \e[1mHomebrew cask - $CASK\e[0m \e[37minstalled!\e[0m"
    else
      echo -e "\e[1;31m✗\e[0m \e[1mHomebrew cask - $CASK\e[0m \e[37mfailed!\e[0m"
    fi
  fi
done < $BACKUP_FILE
