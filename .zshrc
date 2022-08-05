# ENV variables
USER=$(whoami)
HOMEBREW_PATH="/opt/homebrew" # Apple Silicon
# HOMEBREW_PATH="/usr/local" # Apple Intel
export PATH="$HOMEBREW_PATH/sbin:$HOMEBREW_PATH/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOMEBREW_PATH/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOMEBREW_PATH/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/Users/$USER/Library/Python/2.7/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
export LANG=en_US.UTF-8
export EDITOR='nvim'
export GRADLE_USER_HOME="$HOME/.gradle"
export PATH="$HOMEBREW_PATH/opt/llvm/bin:$PATH"
export PATH="/Users/$USER/Library/Android/sdk/platform-tools:$PATH"
export PATH="$HOMEBREW_PATH/opt/python/libexec/bin:$PATH"

# Set personal aliases,
alias ack="Ack --after-context=1 --before-context=1"
alias find_ig='find . -type f -not -path "./.git/*" -and -not -path "./tmp/*"'
alias rb='eval "$(rbenv init -)"'
alias je='eval "$(jenv init -)"'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vim='nvim'

# ZSH prompt
source $HOMEBREW_PATH/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
autoload -U promptinit; promptinit
prompt pure

# Start TMUX
[[ -z $TMUX ]] && (tmux attach || tmux new)
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

export GOSUMDB=off
export GOPATH="${HOME}/.go"
export GOROOT="$HOMEBREW_PATH/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PATH="/Users/$USER/.local/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
