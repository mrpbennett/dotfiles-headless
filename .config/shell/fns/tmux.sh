# Create a Tmux Dev Layout with editor, ai, and terminal
# Usage: tdl <c|cx|codex|other_ai> [<second_ai>]
tdl() {
  [[ -z ${1:-} ]] && {
    echo "Usage: tdl <c|cx|codex|other_ai> [<second_ai>]"
    return 1
  }
  [[ -z ${TMUX:-} || -z ${TMUX_PANE:-} ]] && {
    echo "You must start tmux to use tdl."
    return 1
  }

  local current_dir="${PWD}"
  local editor_pane ai_pane ai2_pane
  local ai="${1:-}"
  local ai2="${2:-}"
  local editor="${EDITOR:-nvim}"

  # Use TMUX_PANE for the pane we're running in (stable even if active window changes)
  editor_pane="${TMUX_PANE:-}"

  # Name the current window after the base directory name
  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"

  # Split window vertically - top 85%, bottom 15% (target editor pane explicitly)
  tmux split-window -v -p 15 -t "$editor_pane" -c "$current_dir"

  # Split editor pane horizontally - AI on right 30% (capture new pane ID directly)
  ai_pane=$(tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

  # If second AI provided, split the AI pane vertically
  if [[ -n $ai2 ]]; then
    ai2_pane=$(tmux split-window -v -t "$ai_pane" -c "$current_dir" -P -F '#{pane_id}')
    tmux send-keys -t "$ai2_pane" -l -- "$ai2"
    tmux send-keys -t "$ai2_pane" C-m
  fi

  # Run ai in the right pane
  tmux send-keys -t "$ai_pane" -l -- "$ai"
  tmux send-keys -t "$ai_pane" C-m

  # Run nvim in the left pane
  tmux send-keys -t "$editor_pane" -l -- "$editor"
  tmux send-keys -t "$editor_pane" -l -- " ."
  tmux send-keys -t "$editor_pane" C-m

  # Select the nvim pane for focus
  tmux select-pane -t "$editor_pane"
}

# Create multiple tdl windows with one per subdirectory in the current directory
# Usage: tdlm <c|cx|codex|other_ai> [<second_ai>]
tdlm() {
  [[ -z ${1:-} ]] && {
    echo "Usage: tdlm <c|cx|codex|other_ai> [<second_ai>]"
    return 1
  }
  [[ -z ${TMUX:-} || -z ${TMUX_PANE:-} ]] && {
    echo "You must start tmux to use tdlm."
    return 1
  }

  local ai="${1:-}"
  local ai2="${2:-}"
  local base_dir="$PWD"
  local first=true
  local pane_id value

  # Rename the session to the current directory name (replace dots/colons which tmux disallows)
  tmux rename-session "$(basename "$base_dir" | tr '.:' '--')"

  for dir in "$base_dir"/*/; do
    [[ -d $dir ]] || continue
    local dirpath="${dir%/}"

    if $first; then
      # Reuse the current window for the first project
      pane_id="${TMUX_PANE:-}"
      tmux send-keys -t "$pane_id" -l -- "cd -- "
      printf -v value '%q' "$dirpath"
      tmux send-keys -t "$pane_id" -l -- "$value"
      tmux send-keys -t "$pane_id" C-m
      first=false
    else
      pane_id=$(tmux new-window -c "$dirpath" -P -F '#{pane_id}')
    fi

    tmux send-keys -t "$pane_id" -l -- "tdl "
    printf -v value '%q' "$ai"
    tmux send-keys -t "$pane_id" -l -- "$value"
    if [[ -n $ai2 ]]; then
      tmux send-keys -t "$pane_id" -l -- " "
      printf -v value '%q' "$ai2"
      tmux send-keys -t "$pane_id" -l -- "$value"
    fi
    tmux send-keys -t "$pane_id" C-m
  done
}

# Create a multi-pane swarm layout with the same command started in each pane (great for AI)
# Usage: tsl <pane_count> <command>
tsl() {
  [[ -z ${1:-} || -z ${2:-} ]] && {
    echo "Usage: tsl <pane_count> <command>"
    return 1
  }
  [[ -z ${TMUX:-} || -z ${TMUX_PANE:-} ]] && {
    echo "You must start tmux to use tsl."
    return 1
  }

  local count="${1:-}"
  local cmd="${2:-}"
  local current_dir="${PWD}"
  local current_pane="${TMUX_PANE:-}"
  local -a panes

  tmux rename-window -t "$current_pane" "$(basename "$current_dir")"

  panes+=("$current_pane")

  while ((${#panes[@]} < count)); do
    local new_pane
    local split_target="${panes[-1]}"
    new_pane=$(tmux split-window -h -t "$split_target" -c "$current_dir" -P -F '#{pane_id}')
    panes+=("$new_pane")
    tmux select-layout -t "${panes[0]}" tiled
  done

  for pane in "${panes[@]}"; do
    tmux send-keys -t "$pane" -l -- "$cmd"
    tmux send-keys -t "$pane" C-m
  done

  tmux select-pane -t "${panes[0]}"
}

ts() {
  local session
  session=$(sesh list --icons | fzf-tmux -p 80%,70% \
    --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
    --header '  ^a all ^t tmux ^g configs ^x zoxide ^f find' \
    --bind 'tab:down,btab:up' \
    --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
    --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
    --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
    --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
    --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
    --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
    --preview-window 'right:55%' \
    --preview 'sesh preview {}' 2>/dev/null) ||
    session=$(sesh list | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
  [[ -z "$session" ]] && return
  sesh connect "$session"
}
