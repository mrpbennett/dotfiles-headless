# sdots

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
