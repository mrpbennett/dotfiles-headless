#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$HOME/.local/share/dotfiles-headless"

DOTFILES_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$REPO_DIR}")" 2>/dev/null && pwd || true)
if [[ ! -d $DOTFILES_DIR/.git ]]; then
  DOTFILES_DIR=$REPO_DIR
  [[ -d $DOTFILES_DIR/.git ]] || git clone --depth 1 https://github.com/mrpbennett/dotfiles-headless.git "$DOTFILES_DIR"
fi

sudo apt-get update

echo "✓ Installing apt packages, including Docker & Nginx..."
sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential curl git stow docker.io docker-compose-v2 nginx

sudo systemctl enable --now docker nginx
sudo groupadd -f docker
sudo usermod -aG docker "$(id -un)"

echo "✓ Installing atuin..."
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh -s -- --non-interactive

echo "✓ Installing mise package manager..."
MISE_BIN=$(command -v mise || true)
if [[ -z $MISE_BIN ]]; then
  curl -fsSL https://mise.run | sh
  MISE_BIN="$HOME/.local/bin/mise"
fi

echo "✓ Running Stow for symlinks..."
stow --no-folding --restow --dir "$DOTFILES_DIR" --target "$HOME" .
ln -snf "$HOME/.config/shell/inputrc.sh" "$HOME/.inputrc"

echo "✓ Installing packages via mise..."
"$MISE_BIN" trust -y "$HOME/.config/mise/config.toml"
"$MISE_BIN" install -y
GOBIN="$HOME/.local/bin" "$MISE_BIN" exec -- go install github.com/joshmedeski/sesh/v2@latest

echo "✓ Installing TPM..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
[[ -d $TPM_DIR ]] || git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
"$MISE_BIN" exec -- "$TPM_DIR/bin/install_plugins"

echo "✓ Installing TailScale..."
curl -fsSL https://tailscale.com/install.sh | sh
sudo systemctl enable --now tailscaled

echo "Done. Log out and back in before using Docker without sudo."
source ~/.bashrc
