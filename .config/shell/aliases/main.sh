# FILE SYSTEM ---
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff='nvim "$(fzf --preview '\''bat --style=numbers --color=always {}'\'')"'

# DIRS ---
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# HELPERS ---
alias e="exit"  # a swifter exit
alias v="nvim"  # quicker nvim
alias bt="btop" # better activity monitor
alias t="tmux"  # quicker tmux

alias cat="bat"     # a better cat
alias curl="curlie" # a better curl

alias lzg='lazygit'
alias lzd='lazydocker'


function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
