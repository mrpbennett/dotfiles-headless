
case $- in
*i*) ;;
*) return ;;
esac

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

source "$HOME/.config/shell/all.sh"

if [[ -z $TMUX ]]; then
  t
fi
