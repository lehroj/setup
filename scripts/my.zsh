#!/usr/bin/env zsh

function my()
{
    local COMMAND=$1
    local FLAG=$2

    local SCRIPTS=$HOME/Setup/scripts

    local BACKUPS=("tap" "brew" "cask" "vsc")
    local DOTFILES=("git" "zsh" "vsc")

    local es()
    {
      echo "$1" | sed 's/^[[:space:]]*//'
    }

    local help()
    {
      es "
          Usage:

          my <command> <flag>

          Commands:

          backup        make backup
          install       install from backup
          dotfiles      symlink dotfiles
          help          help

          Use -h as <flag> to see availables flags.
      "
    }

    local help_backup()
    {
      es "
          Usage:

          my backup <flag>

          Flags:

          -b      backup formulae from Homebrew
          -c      backup casks from Homebrew
          -t      backup taps from Homebrew
          -v      backup extensions from Visual Studio Code
          -h      help
      "
    }

    local help_install()
    {
      es "
          Usage:

          my install <flag>

          Flags:

          -b      install Homebrew formulae from backup
          -c      install Homebrew casks from backup
          -t      tap Homebrew taps from backup
          -v      install Visual Studio Code extensions from backup
          -h      help
      "
    }

    local help_dotfiles()
    {
      es "
          Usage:

          my dotfiles <flag>

          Flags:

          -g      symlink git config
          -v      symlink Visual Studio Code config
          -z      symlink Zsh config
          -h      help
      "
    }

    case $COMMAND in
        "backup")
          case $FLAG in
            "-t")
              source $SCRIPTS/backup/tap.zsh
            ;;
            "-b")
              source $SCRIPTS/backup/brew.zsh
            ;;
            "-c")
              source $SCRIPTS/backup/cask.zsh
            ;;
            "-v")
              source $SCRIPTS/backup/vsc.zsh
            ;;
            "-h")
              help_backup
            ;;
            "")
              for FILE in ${BACKUPS[@]}; do
                source $SCRIPTS/backup/$FILE.zsh
              done
            ;;
            *)
              help_backup
            ;;
          esac
        ;;
        "install")
          case $FLAG in
            "-t")
              source $SCRIPTS/install/tap.zsh
            ;;
            "-b")
              source $SCRIPTS/install/brew.zsh
            ;;
            "-c")
              source $SCRIPTS/install/cask.zsh
            ;;
            "-v")
              source $SCRIPTS/install/vsc.zsh
            ;;
            "-h")
              help_install
            ;;
            "")
              for FILE in ${BACKUPS[@]}; do
                source $SCRIPTS/install/$FILE.zsh
              done
            ;;
            *)
              help_install
            ;;
          esac
        ;;
        "dotfiles")
          case $FLAG in
            "-g")
              source $SCRIPTS/dotfiles/git.zsh
            ;;
            "-v")
              source $SCRIPTS/dotfiles/vsc.zsh
            ;;
            "-z")
              source $SCRIPTS/dotfiles/zsh.zsh
            ;;
            "-h")
              help_dotfiles
            ;;
            "")
              for FILE in ${DOTFILES[@]}; do
                source $SCRIPTS/dotfiles/$FILE.zsh
              done
            ;;
            *)
              help_dotfiles
            ;;
          esac
        ;;
        *)
          help
        ;;
    esac
}
