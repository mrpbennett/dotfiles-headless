#!/usr/bin/env bash

command -v mise >/dev/null 2>&1 && eval "$(mise activate bash)"
command -v atuin >/dev/null 2>&1 && eval "$(atuin init bash)"
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"
