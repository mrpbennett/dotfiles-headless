SHELL_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

# INIT
source "$SHELL_DIR/init.sh"

# ALIASES
source "$SHELL_DIR/aliases/main.sh"
source "$SHELL_DIR/aliases/docker.sh"

# FUNCTIONS
source "$SHELL_DIR/fns/tmux.sh"
