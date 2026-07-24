<div align="center">
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
</div>

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

## Tmux keybindings

Leader key: `C-s` (replaces default `C-b`)

| Key                        | Context      | Action                               |
| -------------------------- | ------------ | ------------------------------------ |
| `C-s`                      | prefix       | Send prefix (type literal `C-s`)     |
| `R`                        | prefix       | Reload tmux config                   |
| `?`                        | prefix       | Show keybinding help popup           |
| `T`                        | prefix       | Launch sesh (fzf session picker)     |
| **Pane navigation**        |              |                                      |
| `h` / `j` / `k` / `l`      | prefix       | Select pane left / down / up / right |
| `H` / `J` / `K` / `L`      | prefix       | Resize pane 5 cells (repeatable)     |
| `x`                        | prefix       | Kill pane                            |
| `\|` / `v`                 | prefix       | Split window horizontally            |
| `-`                        | prefix       | Split window vertically              |
| `f`                        | prefix       | Floating popup pane                  |
| **Pane ops (no prefix)**   |              |                                      |
| `M-Enter`                  | none         | Split vertical (`-v`)                |
| `M-S-Enter`                | none         | Split horizontal (`-h`)              |
| `M-Escape`                 | none         | Kill pane                            |
| `C-M-arrows`               | none         | Select pane in direction             |
| `C-M-S-arrows`             | none         | Resize pane 5 cells                  |
| **Windows**                |              |                                      |
| `c` / `t`                  | prefix       | New window (cwd)                     |
| `r`                        | prefix       | Rename window                        |
| **Window nav (no prefix)** |              |                                      |
| `M-1`–`M-9`                | none         | Select window 1–9                    |
| `M-Left` / `M-Right`       | none         | Previous / next window               |
| `M-S-Left` / `M-S-Right`   | none         | Swap window left / right             |
| **Sessions**               |              |                                      |
| `C`                        | prefix       | New session (cwd)                    |
| `S`                        | prefix       | Rename session                       |
| `q`                        | prefix       | Kill session                         |
| `P` / `N`                  | prefix       | Previous / next session              |
| `M-Up` / `M-Down`          | none         | Previous / next session              |
| **Copy mode (vi)**         |              |                                      |
| `v`                        | copy-mode-vi | Begin selection                      |
| `C-v`                      | copy-mode-vi | Rectangle toggle                     |
| `y`                        | copy-mode-vi | Copy selection & cancel              |
