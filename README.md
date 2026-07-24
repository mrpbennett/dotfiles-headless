```
________  ________  ________  _________  ________
|\   ____\|\   ___ \|\   __  \|\___   ___\\   ____\
\ \  \___|\ \  \_|\ \ \  \|\  \|___ \  \_\ \  \___|_
 \ \_____  \ \  \ \\ \ \  \\\  \   \ \  \ \ \_____  \
  \|____|\  \ \  \_\\ \ \  \\\  \   \ \  \ \|____|\  \
    ____\_\  \ \_______\ \_______\   \ \__\  ____\_\  \
   |\_________\|_______|\|_______|    \|__| |\_________\
   \|_________|                             \|_________|
```

<p align="center">
    <img alt="GNU Stow" src="https://img.shields.io/badge/managed_with-GNU_Stow-4CAF50?style=flat-square&logo=gnu&logoColor=white"/>
    <img alt="Ubuntu" src="https://img.shields.io/badge/platform-ubuntu-000000?style=flat-square&logo=ubuntu&logoColor=white"/>
    <img alt="zsh shell" src="https://img.shields.io/badge/shell-zsh-4FC3F7?style=flat-square"/>
    <img alt="LazyVim" src="https://img.shields.io/badge/editor-LazyVim-7C3AED?style=flat-square"/>
</p>

dotfiles for Ubuntu Server managed with GNU Stow and mise.

## What it sets up

- **Shell**: Zsh with starship prompt, fzf, eza, zoxide, tmux, bat, ripgrep, fd, jq, curlie
- **Editors**: Neovim
- **Agents**: opencode, claude-code
- **Dev tools**: mise, Docker, Docker Compose, nginx, GitHub CLI (`gh`), lazygit, lazydocker, atuin, btop, yazi, Sesh
- **Languages**: Node.js (LTS), Python (latest), Go (latest)

Core system packages (Docker, Docker Compose, nginx, build-essential, git, curl, stow) are installed through apt. The rest is installed through mise after the OS packages are in place.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/mrpbennett/sdots/main/install.sh | bash
```

Log out and back in after installation before using Docker without `sudo`.

## Stow maintenance

All symlinks are managed with `--no-folding` so stow creates real directories and only symlinks individual files. This prevents conflicts when multiple tools share a parent like `~/.config/`.

| Command | Purpose |
| ------- | ------- |
| `stow --no-folding --restow --dir "$DOTFILES_DIR" --target "$HOME" .` | Relink everything (safe to re-run after adding/removing files) |
| `stow --no-folding --simulate --dir "$DOTFILES_DIR" --target "$HOME" .` | Dry run — preview what would change without touching the filesystem |
| `stow --delete --dir "$DOTFILES_DIR" --target "$HOME" .` | Remove all managed symlinks (leaves real files untouched) |

`$DOTFILES_DIR` is wherever you cloned the repo — typically `~/.local/share/sdots`.

## Tmux keybindings

<summary>All custom keybindings — prefix is <code>Ctrl+s</code></summary>

### Config

| Key          | Action                       |
| ------------ | ---------------------------- |
| `prefix + q` | Reload config                |
| `prefix + ?` | Show all keybindings (popup) |

### Pane splits

| Key                   | Action                        |
| --------------------- | ----------------------------- |
| `prefix + \|`         | Split right                   |
| `prefix + -`          | Split down                    |
| `prefix + v`          | Split right                   |
| `prefix + x`          | Kill pane                     |
| `prefix + f`          | Floating shell popup (80×60%) |
| `Alt + Enter`         | Split down (no prefix)        |
| `Alt + Shift + Enter` | Split right (no prefix)       |
| `Alt + Escape`        | Kill pane (no prefix)         |

### Pane navigation

| Key                    | Action                     |
| ---------------------- | -------------------------- |
| `prefix + h/j/k/l`     | Navigate panes (vim-style) |
| `Ctrl + Alt + ←/→/↑/↓` | Navigate panes (no prefix) |

### Pane resize

| Key                            | Action                          |
| ------------------------------ | ------------------------------- |
| `prefix + H/J/K/L`             | Resize pane 5 cells             |
| `Ctrl + Alt + Shift + ←/→/↑/↓` | Resize pane 5 cells (no prefix) |

### Windows

| Key                         | Action        |
| --------------------------- | ------------- |
| `prefix + c` / `prefix + t` | New window    |
| `prefix + r`                | Rename window |
| `prefix + k`                | Kill window   |

### Sessions

| Key          | Action                          |
| ------------ | ------------------------------- |
| `prefix + C` | New session                     |
| `prefix + R` | Rename session                  |
| `prefix + K` | Kill session                    |
| `prefix + T` | Sesh session picker (fzf popup) |

### Copy mode (vi)

| Key          | Action                  |
| ------------ | ----------------------- |
| `prefix + [` | Enter copy mode         |
| `v`          | Begin selection         |
| `y`          | Copy selection and exit |
