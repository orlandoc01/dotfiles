# dotfiles

My Ubuntu/Linux configuration files.

## Setup

```bash
# CLI tools (also suitable for SSH/headless):
curl -fsSL https://raw.githubusercontent.com/orlandoc01/dotfiles/ubuntu/scripts/setup_cli.sh | bash

# Desktop environment (run after CLI):
curl -fsSL https://raw.githubusercontent.com/orlandoc01/dotfiles/ubuntu/scripts/setup_gui.sh | bash
```

`setup_cli.sh` installs apt packages, gh CLI, terraform, pyenv, neovim (snap), docker, clones this repo, inits submodules, installs TPM plugins, and sets zsh as the default shell. `setup_gui.sh` installs desktop apps via apt and snap (alacritty, discord, postman, spotify).

Packages are declared in `scripts/Aptfile` (CLI) and `scripts/Aptfile.gui` (GUI/desktop).

### Dependencies

- `xclip` — required for clipboard integration in both tmux and neovim; installed automatically via `Aptfile`
- `MesloLGMDZ Nerd Font` — must be installed manually; download from [nerdfonts.com](https://www.nerdfonts.com) and place `.ttf` files in `~/.local/share/fonts/`, then run `fc-cache -fv`

## Stack

| Tool | Role |
|------|------|
| [Neovim](https://neovim.io) | Editor |
| [Alacritty](https://alacritty.org) | Terminal |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| [zsh](https://www.zsh.org) + [pure](https://github.com/sindresorhus/pure) | Shell + prompt |

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

## Shell

`.zshrc` auto-attaches to an existing tmux session or starts a new one on launch. The pure prompt is installed as a git submodule at `.config/zsh/pure`.
