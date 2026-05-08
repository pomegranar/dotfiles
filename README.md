# Dotfiles — Cross-platform (macOS + Linux: Fedora / Ubuntu)

## Overview
Personal development environment configs, cleaned of sensitive information.
Each directory mirrors the standard XDG or dotfile path structure.

## Structure
```
dotfiles/
├── tmux/          → ~/.tmux.conf
├── ghostty/       → ~/.config/ghostty/config
├── helix/         → ~/.config/helix/{config,languages}.toml
├── nvim/          → ~/.config/nvim/ (AstroNvim v6)
├── pi/            → ~/.config/pi/agent/ (Pi agent config)
├── starship.toml  → ~/.config/starship.toml
├── vim/           → ~/.vim/vimrc
└── zsh/           → ~/.zshrc, ~/.zshenv
```

## Installation

### 1. Clone the repo
```bash
git clone <your-repo-url> ~/.config/dotfiles
# or wherever you prefer
```

### 2. Create symlinks (or use a dotfile manager)
```bash
# tmux
ln -sf ~/.config/dotfiles/tmux/tmux.conf ~/.tmux.conf

# ghostty
mkdir -p ~/.config/ghostty
ln -sf ~/.config/dotfiles/ghostty/config ~/.config/ghostty/config

# helix
mkdir -p ~/.config/helix
ln -sf ~/.config/dotfiles/helix/config.toml ~/.config/helix/config.toml
ln -sf ~/.config/dotfiles/helix/languages.toml ~/.config/helix/languages.toml

# nvim (AstroNvim)
ln -sf ~/.config/dotfiles/nvim ~/.config/nvim

# pi
mkdir -p ~/.config/pi/agent
ln -sf ~/.config/dotfiles/pi/agent/settings.json ~/.config/pi/agent/settings.json
ln -sf ~/.config/dotfiles/pi/agent/models.json ~/.config/pi/agent/models.json
# NOTE: auth.json needs your own authentication tokens

# starship
ln -sf ~/.config/dotfiles/starship.toml ~/.config/starship.toml

# vim
ln -sf ~/.config/dotfiles/vim/vimrc ~/.vimrc

# zsh
ln -sf ~/.config/dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/.config/dotfiles/zsh/zshenv ~/.zshenv
```

### 3. Post-install steps
- Run `nvim` to bootstrap AstroNvim plugins
- Install plugins: `~/.tmux/plugins/tpm` (tmux TPM)
- Configure ghostty themes per your distro's package
- Set up conda/mamba paths in `~/.zshrc` for your platform

## Platform Notes

### macOS
- Homebrew paths are detected automatically in zsh plugins
- Ghostty theme: use `~/.config/ghostty/auto/theme.ghostty` for custom themes
- vimtex uses `skim` as the LaTeX viewer

### Linux (Fedora / Ubuntu)
- zsh plugins: use system package paths (`/usr/share/zsh/...`)
- Ghostty themes: install via ` paru -S ghostty-git` (AUR) or build from source
- vimtex: change `vimtex_view_method` to `zathura` for Linux

## Sensitive Info Removed
The following were removed from public configs — add them locally:
- API keys (LLAMA_CLOUD_API_KEY, etc.)
- SSH IPs and private network addresses
- VPN configuration references
- Personal project paths
- Personal aliases (chatdku, etc.)
