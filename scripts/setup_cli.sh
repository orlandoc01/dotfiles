#!/usr/bin/env bash
# Usage: curl -fsSL https://raw.githubusercontent.com/orlandoc01/dotfiles/macOS/scripts/setup_cli.sh | bash
set -e

DOTFILES_REPO="https://github.com/orlandoc01/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"
RAW_BASE="https://raw.githubusercontent.com/orlandoc01/dotfiles/macOS"

# -- 1. Xcode Command Line Tools ----------------------------------------------
echo "==> Installing Xcode Command Line Tools..."
xcode-select --install 2>/dev/null || true
if ! xcode-select -p &>/dev/null; then
  read -rp "    Press enter once Xcode CLI Tools installation is complete..." < /dev/tty
fi

# -- 2. Homebrew --------------------------------------------------------------
echo "==> Installing Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# -- 3. CLI packages via Brewfile ---------------------------------------------
echo "==> Installing CLI packages..."
curl -fsSL "$RAW_BASE/.config/Brewfile" -o /tmp/Brewfile
brew bundle --file /tmp/Brewfile

# -- 4. Clone dotfiles --------------------------------------------------------
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "==> Cloning dotfiles..."
  git clone -b macOS --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

dotfiles() {
  git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

echo "==> Checking out macOS branch..."
dotfiles checkout macOS 2>&1 || {
  echo "    Backing up pre-existing config files..."
  dotfiles checkout macOS 2>&1 | grep '^\s' | awk '{print $1}' | xargs -I{} sh -c 'mkdir -p "$HOME/.dotfiles-backup/$(dirname {})" && mv "$HOME/{}" "$HOME/.dotfiles-backup/{}"'
  dotfiles checkout macOS
}

echo "==> Initializing submodules (pure prompt, TPM)..."
dotfiles submodule update --init --recursive

# -- 5. Tmux plugins via TPM --------------------------------------------------
echo "==> Installing tmux plugins..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

# -- 6. Default shell ---------------------------------------------------------
echo "==> Setting zsh as default shell..."
sudo chsh -s "$(brew --prefix)/bin/zsh" "$(whoami)"

echo ""
echo "Done! Log out and back in (or start a new session) to load zsh."
