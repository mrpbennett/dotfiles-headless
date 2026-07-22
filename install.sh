#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

sudo apt-get update

echo "✓ Installing apt packages, including Docker & Nginx..."
sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential curl git stow docker.io docker-compose-v2 nginx

sudo systemctl enable --now docker nginx
sudo groupadd -f docker
sudo usermod -aG docker "$(id -un)"

echo "✓ Installing mise package manager..."
MISE_BIN=$(command -v mise || true)
if [[ -z $MISE_BIN ]]; then
  curl -fsSL https://mise.run | sh
  MISE_BIN="$HOME/.local/bin/mise"
fi

if [[ -f $HOME/.bashrc && ! -L $HOME/.bashrc ]]; then
  [[ ! -e $HOME/.bashrc.bak ]] || {
    echo "$HOME/.bashrc.bak already exists" >&2
    exit 1
  }
  mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
fi

echo "✓ Running Stow for symlinks..."
stow --no-folding --restow --dir "$DOTFILES_DIR" --target "$HOME" .

echo "✓ Installing packages via mise..."
"$MISE_BIN" trust -y "$HOME/.config/mise/config.toml"
"$MISE_BIN" install -y
GOBIN="$HOME/.local/bin" "$MISE_BIN" exec -- go install github.com/joshmedeski/sesh/v2@latest

echo "✓ Installing TPM..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
[[ -d $TPM_DIR ]] || git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
"$MISE_BIN" exec -- "$TPM_DIR/bin/install_plugins"

echo "Done. Log out and back in before using Docker without sudo."
