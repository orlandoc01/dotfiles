# ENV variables
USER=$(whoami)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/Users/$USER/Library/Python/2.7/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export LD_LIBRARY_PATH=/usr/local/opt/openssl/lib:"${LD_LIBRARY_PATH}"                    
export CPATH=/usr/local/opt/openssl/include:"${CPATH}"                                    
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig:"${PKG_CONFIG_PATH}"          
export LANG=en_US.UTF-8
export EDITOR='vim'
export GRADLE_USER_HOME="$HOME/.gradle"
#export GRADLE_HOME=/usr/local/Cellar/gradle/5.3
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/Users/$USER/Library/Android/sdk/platform-tools:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$(npm config get prefix)/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
export LDFLAGS=-L/opt/local/lib
export CXXFLAGS=-I/opt/local/include 
export ARCHFLAGS="-arch x86_64"

# Set personal aliases,
alias ack="Ack --after-context=1 --before-context=1"
alias ctags="/usr/local/bin/ctags"
alias sg="solargraph socket"
alias sg_forever="while true; do sg; sleep 1; done"
alias find_ig='find . -type f -not -path "./.git/*" -and -not -path "./tmp/*"'
alias svim='vim -u ~/.SpaceVim/vimrc'
alias rb='eval "$(rbenv init -)"'
alias je='eval "$(jenv init -)"'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Oh My ZSH Settings
DEFAULT_USER="orlandocastillo"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_THEME=""
# CASE_SENSITIVE="true"
# ENABLE_CORRECTION="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
export ZSH="/Users/$USER/.oh-my-zsh"
fpath=( "$HOME/.zfunctions" $fpath )
source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
autoload -U promptinit; promptinit
prompt pure
plugins=(git docker)

# Start TMUX
[[ -z $TMUX ]] && (tmux attach || tmux new)
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

export GOSUMDB=off
export GOPATH="${HOME}/.go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PATH="/Users/$USER/.local/bin:$PATH"
