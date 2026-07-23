export EDITOR="nvim"
# ~/.atuin/bin must be explicit: stow owns ~/.zshrc so atuin's installer can't reliably add it
export PATH="$PATH:$HOME/.local/bin:$HOME/.atuin/bin"
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi
export MANROFFOPT="-c"
export ZSH="$HOME/.oh-my-zsh"
