#!/usr/bin/env bash
export PATH="$HOME/.local/bin:$PATH"
source "$HOME/.config/shell/all.sh"

case $- in
*i*) ;;
*) return ;;
esac

if [[ -z $TMUX ]]; then
  t
fi
