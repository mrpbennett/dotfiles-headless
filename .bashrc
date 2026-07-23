#!/usr/bin/env bash
export PATH="$HOME/.local/bin:$PATH"

case $- in
*i*) ;;
*) return ;;
esac

if [[ -z $TMUX ]]; then
  t
fi

DOTFILES_SHELL_DIR="$HOME/.config/shell"
source "$DOTFILES_SHELL_DIR/all.sh"
