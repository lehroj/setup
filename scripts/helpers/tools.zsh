#!/bin/zsh

function msg_error() {
    local NC='\033[0m'
    local RED='\033[0;31m'

    echo -e "${RED}⨯ $1${NC}"
}

function msg_success() {
    local NC='\033[0m'
    local GREEN='\033[0;32m'

    echo -e "${GREEN}✓ $1${NC}"
}

function msg_info() {
    local NC='\033[0m'
    local CYAN='\033[0;36m'

    echo -e "${CYAN}➔ $1${NC}"
}

function show_help() {
    echo
    msg_info "Usage:"
    echo "  my <command> [options]"
    echo
    msg_info "Commands:"
    echo "  backup              Backup various configurations"
    echo "  config              Symlink various configurations"
    echo "  install             Install various tools and applications"
    echo "  help                Show this help message"
    echo
    msg_info "Options for backup:"
    echo "  --brew              Backup Brew taps, formulae, and casks"
    echo "  --vscode            Backup VSCode extensions"
    echo "  --all               Backup everything"
    msg_info "Options for config:"
    echo "  --zsh               Symlink Zsh configuration"
    echo "  --git               Symlink Git configuration"
    echo "  --term              Symlink terminal configuration"
    echo "  --vscode            Symlink VSCode configuration"
    echo "  --all               Symlink everything"
    echo
    msg_info "Options for install:"
    echo "  --brew              Install Brew formulae and casks"
    echo "  --vscode            Install VSCode extensions"
    echo "  --all               Install everything"
}
