#!/usr/bin/env bash
# Usage: curl -fsSL https://raw.githubusercontent.com/orlandoc01/dotfiles/ubuntu/scripts/setup_cli.sh | bash
set -e

DOTFILES_REPO="https://github.com/orlandoc01/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"
RAW_BASE="https://raw.githubusercontent.com/orlandoc01/dotfiles/ubuntu/scripts"

# -- 1. Apt packages ----------------------------------------------------------
echo "==> Updating apt..."
sudo apt-get update -qq

echo "==> Installing apt packages..."
curl -fsSL "$RAW_BASE/Aptfile" \
  | grep -v '^\s*#' \
  | grep -v '^\s*$' \
  | xargs sudo apt-get install -y

# -- 2. GitHub CLI (needs official apt repo) ----------------------------------
echo "==> Installing GitHub CLI..."
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update -qq && sudo apt-get install -y gh

# -- 3. pyenv -----------------------------------------------------------------
echo "==> Installing pyenv..."
if [ ! -d "$HOME/.pyenv" ]; then
  curl https://pyenv.run | bash
fi

# -- 4. Neovim (snap for latest stable; apt version is often outdated) --------
echo "==> Installing Neovim..."
sudo snap install nvim --classic
sudo snap alias nvim editor

# -- 5. Nerd Font -------------------------------------------------------------
echo "==> Skipping MesloLGMDZ Nerd Font (headless install)..."
echo "    On a desktop machine run setup_gui.sh to install the font."

# -- 6. Clone dotfiles --------------------------------------------------------
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "==> Cloning dotfiles..."
  git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

dotfiles() {
  git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

echo "==> Checking out ubuntu branch..."
dotfiles checkout ubuntu 2>&1 || {
  echo "    Backing up pre-existing config files..."
  dotfiles checkout ubuntu 2>&1 | grep '^\s' | awk '{print $1}' | xargs -I{} sh -c 'mkdir -p "$HOME/.dotfiles-backup/$(dirname {})" && mv "$HOME/{}" "$HOME/.dotfiles-backup/{}"'
  dotfiles checkout ubuntu
}

echo "==> Initializing submodules (pure prompt, TPM)..."
dotfiles submodule update --init --recursive

echo "==> Configuring dotfiles repo..."
dotfiles config --local status.showUntrackedFiles no

# -- 7. Docker ----------------------------------------------------------------
echo "==> Installing Docker..."
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker "$USER"
echo "    NOTE: Log out and back in for Docker group membership to take effect."

# -- 8. Tmux plugins via TPM --------------------------------------------------
echo "==> Installing tmux plugins..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

# -- 9. Default shell ---------------------------------------------------------
echo "==> Setting zsh as default shell..."
chsh -s "$(which zsh)"

echo ""
echo "Done! Log out and back in (or start a new session) to load zsh."
