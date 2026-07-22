#!/usr/bin/env bash
export PATH="$HOME/.local/bin:$PATH"

case $- in
*i*) ;;
*) return ;;
esac

export OSH="$HOME/.oh-my-bash"

completions=(
  git
  composer
  ssh
)
aliases=(
  general
)
plugins=(
  git
  bashmarks
)

OSH_THEME=""
[[ -f "$OSH/oh-my-bash.sh" ]] && source "$OSH/oh-my-bash.sh"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
  export SUDO_EDITOR=nvim
else
  export EDITOR="nvim"
  export SUDO_EDITOR=nvim
fi

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml" # Starship Prompt

DOTFILES_SHELL_DIR="$HOME/.config/shell"
source "$DOTFILES_SHELL_DIR/rc.sh"
