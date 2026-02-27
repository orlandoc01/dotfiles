#!/usr/bin/env bash
# Usage: curl -fsSL https://raw.githubusercontent.com/orlandoc01/dotfiles/macOS/scripts/setup_gui.sh | bash
# Note: Run setup_cli.sh first before running this script.
set -e

RAW_BASE="https://raw.githubusercontent.com/orlandoc01/dotfiles/macOS"

# Ensure Homebrew is available
eval "$(/opt/homebrew/bin/brew shellenv)"

# -- 1. GUI packages via Brewfile.gui -----------------------------------------
echo "==> Installing GUI packages..."
curl -fsSL "$RAW_BASE/.config/Brewfile.gui" -o /tmp/Brewfile.gui
brew bundle --file /tmp/Brewfile.gui

# -- 2. Start macOS window management services --------------------------------
echo "==> Starting yabai and skhd..."
yabai --start-service
skhd --start-service
chmod +x "$HOME/.config/yabai/yabairc"

echo ""
echo "Done!"
