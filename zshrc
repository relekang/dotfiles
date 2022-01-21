export ZSH=$HOME/.oh-my-zsh
export DOT=$HOME/.files

ZSH_CUSTOM=$HOME/.zsh-custom

ZSH_THEME=rl
CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

export STARSHIP_CONFIG=$DOT/starship.toml
export PROJECTS=~/dev
export EDITOR='vim'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8 2>/dev/null)
export PHANTOMJS_BIN=/usr/local/bin/phantomjs
export GOPATH=$HOME/.gocode/

plugins=()

source $ZSH/oh-my-zsh.sh

PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:.bin"
PATH=$DOT/bin:$PATH
PATH=$PATH:/Library/Frameworks/Mono.framework/Versions/Current/bin/
PATH=$PATH:/usr/local/lib/ruby/gems/2.5.0/bin/
PATH=$GOPATH/bin:$PATH
PATH=~/.local/bin:$PATH
PATH=~/bin:$PATH
PATH=/Users/rolf/Library/Python/2.7/bin:/Users/rolf/Library/Python/3.7/bin:$PATH
PATH=~/.poetry/bin:$PATH
PATH=/opt/homebrew/bin:$PATH
export PATH

export VIM_BACKGROUND=dark

PYTHON=$(which python3)
export VIRTUALENVWRAPPER_PYTHON=$PYTHON

. $DOT/aliases
if [ -f "$DOT/secret-aliases" ]; then
  . $DOT/secret-aliases
fi
source $DOT/chruby
source $DOT/functions

eval "$(/opt/homebrew/bin/brew shellenv)"

# fnm
PATH="$HOME/.fnm:$PATH"
if which fnm > /dev/null; then
  eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"
fi

if [[ "$(uname)" == "Darwin" ]]; then
  if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
else
  if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
fi

PATH=~/.local/bin:$PATH
PATH=~/.node-bin/node_modules/.bin:$PATH
PATH=~/bin:$PATH
PATH=~/.bin:$PATH
PATH=./node_modules/.bin:$PATH
export PATH

. /Users/rolf/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

if [[ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc ]]; then
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
  eval `ssh-agent -t 1d`
fi

true

export PATH="$HOME/.poetry/bin:$PATH"

eval "$(starship init zsh)"
