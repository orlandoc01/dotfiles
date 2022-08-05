#! /bin/bash
xcode-select --install
read -p "Please follow the instructions to install Xcode Tools and press enter once its finished"

#install brew + setup applications
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
curl https://raw.githubusercontent.com/orlandoc01/dotfiles/macOS/.Brewfile --output $HOME/.config/Brewfile
brew bundle --file $HOME/.config/Brewfile

# setup dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone -b macOS --bare https://github.com/orlandoc01/dotfiles $HOME/.dotfiles
cd $HOME && dotfiles checkout && dotfiles submodule update --init --recursive
chmod +x $HOME/.config/yabai/yabairc

#setup zsh with oh-my-zsh
sudo chsh -s /usr/local/bin/zsh $(whoami)

#install tpm for tmux
$HOME/.tmux/plugins/tpm/tpm
$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
