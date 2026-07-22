#!/usr/bin/env bash

case $- in
  *i*) ;;
  *) return ;;
esac

DOTFILES_SHELL_DIR="$HOME/.config/shell"

source "$DOTFILES_SHELL_DIR/rc.sh"

export EDITOR=nvim
export SUDO_EDITOR=nvim
