#!/usr/bin/env zsh

function msg_error() {
    local NC='\033[0m'
    local RED='\033[0;31m'

    echo -e "${RED}⨯ $1${NC}"
}

function msg_info() {
    local NC='\033[0m'
    local CYAN='\033[0;36m'

    echo -e "${CYAN}➔ $1${NC}"
}

function msg_success() {
    local NC='\033[0m'
    local GREEN='\033[0;32m'

    echo -e "${GREEN}✓ $1${NC}"
}

function msg_warning() {
    local NC='\033[0m'
    local YELLOW='\033[0;33m'

    echo -e "${YELLOW}⚠ $1${NC}"
}

function show_help() {
    echo
    msg_info "Usage:"
    echo "  my <command> [options]"
    echo
    msg_info "Commands:"
    echo "  dotfiles            Symlink all configurations"
    echo "  backup              Backup all configurations"
    echo "  install             Install all tools and applications"
    echo "  help                Show this help message"
    echo
    msg_info "Options for dotfiles:"
    echo "  --git               Symlink Git configuration"
    echo "  --misc              Symlink misc configuration"
    echo "  --zsh               Symlink Zsh configuration"
    echo "  --all               Symlink everything"
    echo
    msg_info "Options for backup:"
    echo "  --brew              Backup Brew taps, formulae, and casks"
    echo "  --vsc               Backup VSCode extensions"
    echo "  --all               Backup everything"
    echo
    msg_info "Options for install:"
    echo "  --brew              Install Brew formulae and casks"
    echo "  --vsc               Install VSCode extensions"
    echo "  --all               Install everything"
}
