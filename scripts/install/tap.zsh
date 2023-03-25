#!/usr/bin/env zsh

local BACKUP_FILE=$HOME/Setup/backup/tap.list

if [ ! -f $BACKUP_FILE ]; then
  echo -e "\e[1;31m✗\e[0m \e[1mHomebrew taps:\e[0m \e[37mfile $BACKUP_FILE doesn't exist, aborting...\e[0m"

  return
fi

if [ ! -s $BACKUP_FILE ]; then
  echo -e "\e[1;31m✗\e[0m \e[1mHomebrew taps:\e[0m \e[37mfile $BACKUP_FILE is empty, aborting...\e[0m"

  return
fi

while read TAP; do
  if [ "$(brew tap -- | grep -E "(^|\s)$TAP($|\s)")" ]; then
    echo -e "\e[1;32m✓\e[0m \e[1mHomebrew tap - $TAP\e[0m \e[37malready done...\e[0m"
  else
    brew tap $TAP &> /dev/null

    if [ "$(brew tap -- | grep -E "(^|\s)$TAP($|\s)")" ]; then
      echo -e "\e[1;32m✓\e[0m \e[1mHomebrew tap - $TAP\e[0m \e[37mok!\e[0m"
    else
      echo -e "\e[1;31m✗\e[0m \e[1mHomebrew tap - $TAP\e[0m \e[37mfailed!\e[0m"
    fi
  fi
done < $BACKUP_FILE
