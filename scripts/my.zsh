#!/usr/bin/env zsh

function my() {
    source $SETUP/scripts/helpers/util.zsh

    if [ "$#" -eq 0 ];
    then
        show_help
        return 1
    fi

    local command="$1"
    shift

    case "$command" in
        dotfiles)
            source $SETUP/scripts/helpers/dotfiles.zsh

            local has_option=false

            while [ "$#" -gt 0 ];
            do
                case "$1" in
                    --git)
                        dotfiles_git
                        has_option=true
                        ;;
                    --misc)
                        dotfiles_misc
                        has_option=true
                        ;;
                    --zsh)
                        dotfiles_zsh
                        has_option=true
                        ;;
                    --all)
                        dotfiles_git
                        dotfiles_misc
                        dotfiles_zsh
                        has_option=true
                        ;;
                    *)
                        msg_error "Unknown option: $1"
                        show_help
                        return 1
                        ;;
                esac
                shift
            done

            if [ "$has_option" = false ];
            then
                dotfiles_git
                dotfiles_misc
                dotfiles_zsh
            fi
            ;;
        backup)
            source $SETUP/scripts/helpers/backup.zsh

            local has_option=false

            while [ "$#" -gt 0 ];
            do
                case "$1" in
                    --brew)
                        backup_brew
                        has_option=true
                        ;;
                    --vsc)
                        backup_vsc
                        has_option=true
                        ;;
                    --all)
                        backup_brew
                        backup_vsc
                        has_option=true
                        ;;
                    *)
                        msg_error "Unknown option: $1"
                        show_help
                        return 1
                        ;;
                esac
                shift
            done

            if [ "$has_option" = false ];
            then
                backup_brew
                backup_vsc
            fi
            ;;
        install)
            source $SETUP/scripts/helpers/install.zsh

            local has_option=false

            while [ "$#" -gt 0 ];
            do
                case "$1" in
                    --brew)
                        install_brew
                        has_option=true
                        ;;
                    --vsc)
                        install_vsc
                        has_option=true
                        ;;
                    --all)
                        install_brew
                        install_vsc
                        has_option=true
                        ;;
                    *)
                        msg_error "Unknown option: $1"
                        show_help
                        return 1
                        ;;
                esac
                shift
            done

            if [ "$has_option" = false ];
            then
                install_brew
                install_vsc
            fi
            ;;
        help)
            show_help
            ;;
        *)
            msg_error "Unknown command: $command"
            show_help
            return 1
            ;;
    esac
}
