#!/usr/bin/env zsh

local DOTFILES_ZSH=$HOME/Setup/dotfiles/zsh

for FILE in $(ls -A1 $DOTFILES_ZSH); do
  SRC=$DOTFILES_ZSH/$FILE
  DST=$HOME/$FILE

  if [ -L $DST ] ||  [ -f $DST ]; then
    echo -e "\e[1;36m?\e[0m \e[1mSymlink|file already exists for $FILE.\e[0m \e[37m[o]verwrite ? any other key to skip.\e[0m"
    read -ks REPLY

    if [ $REPLY == "o" || $REPLY == "O" ]; then
      rm -rf $DST
      ln -s $SRC $DST

      echo -e "\e[1;32m✓\e[0m \e[1mSymlink overwritten for $FILE\e[0m"
    else
      echo -e "\e[1;32m✓\e[0m \e[1mSkipped for $FILE\e[0m"
    fi
  else
    echo -e "\e[1;36m?\e[0m \e[1m$FILE doesn't exists for $FILE.\e[0m \e[37m[c]reate ? any other key to skip.\e[0m"
    read -ks REPLY

    if [ $REPLY == "c" || $REPLY == "C" ]; then
      ln -s $SRC $DST

      echo -e "\e[1;32m✓\e[0m \e[1mSymlink created for $FILE\e[0m"
    else
      echo -e "\e[1;32m✓\e[0m \e[1mSkipped for $FILE\e[0m"
    fi
  fi
done
