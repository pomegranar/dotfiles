# Dotfiles — Cross-platform (macOS + Linux)

Personal dev environment configs. The repo layout mirrors `$HOME` exactly,
so installation is just symlinks.

## Layout

```
dotfiles/
├── .zshrc            → ~/.zshrc
├── .zshenv           → ~/.zshenv
├── .tmux.conf        → ~/.tmux.conf
├── .vimrc            → ~/.vimrc
└── .config/
    ├── starship.toml → ~/.config/starship.toml
    ├── ghostty/      → ~/.config/ghostty/
    ├── helix/        → ~/.config/helix/
    ├── nvim/         → ~/.config/nvim/      (AstroNvim v6)
    └── pi/           → ~/.config/pi/
```

Editing `~/.zshrc` opens the file in this repo (because it's a symlink),
so changes show up in `git status`.

## Install

```bash
git clone git@github.com:pomegranar/dotfiles.git anar-dotfiles
cd anar-dotfiles
python3 setup.py
```

`setup.py` is a single stdlib-only Python script. It:

1. Walks the repo and discovers each "app" (top-level entry, or one level
   under `.config/`). Add a new folder like `.config/emacs/` and it shows
   up automatically.
2. Shows an interactive list — `space` to toggle install/skip, `enter` to
   continue.
3. Asks whether to back up existing files first (default location:
   `~/dotfiles-backup-<timestamp>/`).
4. Symlinks each selected app from the repo into `$HOME`.

Existing symlinks are always replaced. Existing **real** files/dirs are
only touched if backups are enabled; otherwise they're skipped with a
warning, so you can't lose data by mashing enter.

## Post-install

- Run `nvim` once to bootstrap AstroNvim plugins.
- Install tmux TPM: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- Run `uv setup --shell zsh` for uv shell integration.

## Platform notes

**macOS** — Homebrew paths are auto-detected in zsh plugins. vimtex uses
`skim` as the LaTeX viewer.

**Linux (Fedora / Ubuntu)** — zsh plugins use `/usr/share/zsh/...`. Change
`vimtex_view_method` to `zathura`.

## Sensitive info

Removed from public configs — add locally:

- API keys (`LLAMA_CLOUD_API_KEY`, etc.)
- SSH IPs and private network addresses
- VPN configuration references
- Personal project paths and aliases
- `.config/pi/agent/auth.json` — your own tokens
