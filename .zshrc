#!/usr/bin/env bash
export PATH="$HOME/.local/bin:$PATH"

case $- in
*i*) ;;
*) return ;;
esac

# PATH TO YOUR OH MY ZSH INSTALLATION.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# VI MODE START ---
bindkey -v
KEYTIMEOUT=1

zle-keymap-select() {
  local cursor=$( [[ $KEYMAP == vicmd ]] && echo '\e[1 q' || echo '\e[5 q' )
  echo -ne "$cursor"
}

zle-line-init() { echo -ne '\e[5 q'; }  # beam cursor on new prompt (insert mode)

zle -N zle-keymap-select
zle -N zle-line-init
# VIM MODE END ---

if [[ -z $TMUX ]]; then
  t
fi

source "$HOME/.config/shell/all.sh"
