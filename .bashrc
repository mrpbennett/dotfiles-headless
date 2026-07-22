#!/usr/bin/env bash
export PATH="$HOME/.local/bin:$PATH"

case $- in
  *i*) ;;
  *) return ;;
esac


export EDITOR=nvim
export SUDO_EDITOR=nvim
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml" # Starship Prompt

DOTFILES_SHELL_DIR="$HOME/.config/shell"
source "$DOTFILES_SHELL_DIR/rc.sh"
