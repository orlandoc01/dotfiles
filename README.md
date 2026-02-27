# dotfiles

My macOS configuration files.

<img width="1470" alt="Screen Shot 2022-08-05 at 12 16 26 AM" src="https://user-images.githubusercontent.com/14842987/183023293-9fc2fa85-86d2-498d-ba86-098e662bc554.png">

## Setup

```bash
# CLI tools (also suitable for SSH/headless):
curl -fsSL https://raw.githubusercontent.com/orlandoc01/dotfiles/macOS/scripts/setup_cli.sh | bash

# Desktop environment (run after CLI):
curl -fsSL https://raw.githubusercontent.com/orlandoc01/dotfiles/macOS/scripts/setup_gui.sh | bash
```

`setup_cli.sh` installs Xcode CLI tools, Homebrew, all CLI packages, clones this repo, and sets zsh as the default shell. `setup_gui.sh` installs GUI apps, fonts, and starts the macOS window management services.

Packages are declared in `.config/Brewfile` (CLI) and `.config/Brewfile.gui` (GUI/desktop).

## Stack

| Tool | Role |
|------|------|
| [Neovim](https://neovim.io) | Editor |
| [Alacritty](https://alacritty.org) | Terminal |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| [zsh](https://www.zsh.org) + [pure](https://github.com/sindresorhus/pure) | Shell + prompt |
| [yabai](https://github.com/koekeishiya/yabai) | Tiling window manager |
| [skhd](https://github.com/koekeishiya/skhd) | Hotkey daemon |
| [sketchybar](https://github.com/FelixKratz/SketchyBar) | Status bar |

## Neovim

Configured with [lazy.nvim](https://github.com/folke/lazy.nvim). LSP servers managed via [Mason](https://github.com/williamboman/mason.nvim) (`gopls`, `ts_ls`, `rust_analyzer`, `clangd`, `lua_ls`).

| Key | Action |
|-----|--------|
| `<C-p>` | Find files (Telescope) |
| `<C-j>` / `<C-k>` | Navigate results in Telescope |
| `gd` | Go to definition |
| `K` | Hover docs |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `gr` | References |
| `<leader>e` | Line diagnostics |
| `[d` / `]d` | Prev/next diagnostic |
| `<leader>lf` | Format buffer |

## Window Management (yabai + skhd)

yabai runs in BSP tiling mode. skhd uses a **modal hotkey system** — enter `switcher` mode from anywhere with `ctrl-f`, then press `s`/`t`/`space` to enter sub-modes. `return` exits back to default from any mode.

## Shell

`.zshrc` auto-attaches to an existing tmux session or starts a new one on launch. The pure prompt is installed as a git submodule at `.config/zsh/pure`.
