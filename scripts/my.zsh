#!/bin/zsh

function my() {
    source $SETUP/scripts/helpers/tools.zsh

    if [ "$#" -eq 0 ];
    then
        show_help
        return 1
    fi

    local command="$1"
    shift

    case "$command" in
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
                    --vscode)
                        backup_vscode
                        has_option=true
                        ;;
                    --all)
                        backup_brew
                        backup_vscode
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
                backup_vscode
            fi
            ;;
        config)
            source $SETUP/scripts/helpers/config.zsh

            local has_option=false

            while [ "$#" -gt 0 ];
            do
                case "$1" in
                    --zsh)
                        config_zsh
                        has_option=true
                        ;;
                    --git)
                        config_git
                        has_option=true
                        ;;
                    --hyper)
                        config_hyper
                        has_option=true
                        ;;
                    --vscode)
                        config_vscode
                        has_option=true
                        ;;
                    --all)
                        config_zsh
                        config_git
                        config_term
                        config_vscode
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
                config_zsh
                config_git
                config_term
                config_vscode
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
                    --vscode)
                        install_vscode
                        has_option=true
                        ;;
                    --all)
                        install_brew
                        install_vscode
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
                install_vscode
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
