#!/usr/bin/env python3
"""
Dotfiles setup — symlinks files from this repo into $HOME.

Layout convention: every path in this repo mirrors its destination relative
to $HOME. The script descends one level into `.config/` (so each app there
is a separate symlink); everything else at the repo root is one app.

Drop a new folder in (e.g. `.config/emacs/` or `.gnupg/`) and it shows up
automatically next time you run this.
"""

from __future__ import annotations

import datetime
import os
import shutil
import sys
import termios
import tty
from pathlib import Path

DEPENDENCIES = {
    "gols": "a colorful `ls` alternative — https://github.com/Tigermen0710/gols",
}

REPO = Path(__file__).resolve().parent
HOME = Path.home()

# Directories whose children are each their own app (rather than the dir itself).
SPLIT_DIRS = {".config"}

# Repo-internal files that are not dotfiles.
IGNORE = {".git", ".gitignore", "setup.py", "README.md", ".DS_Store", "__pycache__"}


# --- Discovery ---------------------------------------------------------------

def discover_apps() -> list[tuple[Path, Path]]:
    """Return [(src_in_repo, dst_in_home)] pairs."""
    apps: list[tuple[Path, Path]] = []
    for entry in sorted(REPO.iterdir()):
        if entry.name in IGNORE:
            continue
        if entry.is_dir() and entry.name in SPLIT_DIRS:
            for child in sorted(entry.iterdir()):
                if child.name in IGNORE:
                    continue
                apps.append((child, HOME / child.relative_to(REPO)))
        else:
            apps.append((entry, HOME / entry.relative_to(REPO)))
    return apps


# --- Tiny TUI ----------------------------------------------------------------

CSI = "\x1b["

def _read_key() -> str:
    fd = sys.stdin.fileno()
    old = termios.tcgetattr(fd)
    try:
        tty.setraw(fd)
        ch = sys.stdin.read(1)
        if ch == "\x1b":
            ch += sys.stdin.read(2)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old)
    return ch


def pick(apps: list[tuple[Path, Path]]) -> list[bool]:
    sel = [True] * len(apps)
    cursor = 0
    sys.stdout.write(CSI + "?25l")  # hide cursor
    try:
        while True:
            sys.stdout.write(CSI + "H" + CSI + "2J")
            print("Dotfiles setup")
            print("  ↑/↓ or j/k: move   space: toggle   a: all   n: none   enter: continue   q: quit\n")
            for i, (_src, dst) in enumerate(apps):
                mark = "●" if sel[i] else "○"
                state = "install" if sel[i] else "skip   "
                rel = dst.relative_to(HOME)
                line = f"  {mark} {state}  ~/{rel}"
                if i == cursor:
                    line = CSI + "7m" + line + CSI + "0m"
                print(line)
            sys.stdout.flush()
            k = _read_key()
            if k in ("q", "\x03"):
                sys.exit(0)
            if k in ("\r", "\n"):
                return sel
            if k == " ":
                sel[cursor] = not sel[cursor]
            elif k in ("j", CSI + "B"):
                cursor = (cursor + 1) % len(apps)
            elif k in ("k", CSI + "A"):
                cursor = (cursor - 1) % len(apps)
            elif k == "a":
                sel = [True] * len(apps)
            elif k == "n":
                sel = [False] * len(apps)
    finally:
        sys.stdout.write(CSI + "?25h")


def confirm(prompt: str, default: bool = True) -> bool:
    suffix = " [Y/n] " if default else " [y/N] "
    ans = input(prompt + suffix).strip().lower()
    return default if not ans else ans.startswith("y")


def ask(prompt: str, default: str) -> str:
    return input(f"{prompt} [{default}] ").strip() or default


# --- Linking -----------------------------------------------------------------

def link_one(src: Path, dst: Path, backup_root: Path | None) -> str:
    rel = f"~/{dst.relative_to(HOME)}"

    if dst.is_symlink():
        if Path(os.readlink(dst)) == src:
            return f"  = {rel} (already linked)"
        dst.unlink()
    elif dst.exists():
        if backup_root is None:
            return f"  ! {rel} exists and is not a symlink — skipped (enable backup or remove it)"
        backup_dst = backup_root / dst.relative_to(HOME)
        backup_dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(str(dst), str(backup_dst))

    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.symlink_to(src)
    return f"  + {rel} → {src}"


def check_dependencies() -> None:
    missing = [(b, d) for b, d in DEPENDENCIES.items() if shutil.which(b) is None]
    if not missing:
        return
    print("Warning: missing optional dependencies:")
    for binary, desc in missing:
        print(f"  - {binary}: {desc}")
    print()


def main() -> None:
    check_dependencies()
    apps = discover_apps()
    if not apps:
        print("No dotfiles found in repo.")
        return

    flags = pick(apps)
    chosen = [a for a, s in zip(apps, flags) if s]
    if not chosen:
        print("\nNothing selected.")
        return

    print("\nWill install:")
    for _src, dst in chosen:
        print(f"  ~/{dst.relative_to(HOME)}")
    print()

    backup_root: Path | None = None
    if confirm("Back up any existing files that would be replaced?"):
        ts = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
        default_loc = str(HOME / f"dotfiles-backup-{ts}")
        loc = ask("Backup location:", default_loc)
        backup_root = Path(os.path.expanduser(loc)).resolve()
        backup_root.mkdir(parents=True, exist_ok=True)
        print(f"Backups → {backup_root}")

    print()
    for src, dst in chosen:
        try:
            print(link_one(src, dst, backup_root))
        except OSError as e:
            print(f"  ! ~/{dst.relative_to(HOME)}: {e}")

    print("\nDone.")


if __name__ == "__main__":
    main()
