export ZSH=$HOME/.oh-my-zsh
export DOT=$HOME/.dotfiles

ZSH_THEME="af-magic"
CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

export PROJECTS=~/dev
export EDITOR='vim'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8 2>/dev/null)
export PHANTOMJS_BIN=/usr/local/bin/phantomjs
export GOPATH=$HOME/gocode/
export RAINBOW=true

plugins=(git npm pip)

source $ZSH/oh-my-zsh.sh

# User configuration


PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
PATH=$DOT/bin:$PATH
PATH=$PATH:/Library/Frameworks/Mono.framework/Versions/Current/bin/
PATH=$GOPATH/bin:$PATH
PATH=~/.local/bin:$PATH
PATH=~/bin:$PATH
PATH=/Users/rolf/Library/Python/2.7/bin:/Users/rolf/Library/Python/3.7/bin:$PATH
export PATH

export VIM_BACKGROUND=dark

PYTHON=$(which python3)
export VIRTUALENVWRAPPER_PYTHON=$PYTHON

. $DOT/aliases
. $DOT/secret-aliases
source $DOT/chruby
source $DOT/functions
source $DOT/python/virtualenvwrapper

export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH=~/.rbenv/shims:$PATH

export NVM_DIR="${HOME}/.nvm"
NVM_SH="/usr/local/opt/nvm/nvm.sh"
[ -s "$NVM_SH" ] && . "$NVM_SH"  # This loads nvm

if [[ "$(uname)" == "Darwin" ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# added by travis gem
[ -f /Users/rolf/.travis/travis.sh ] && source /Users/rolf/.travis/travis.sh

if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

PATH=~/.local/bin:$PATH
PATH=~/bin:$PATH
PATH=./node_modules/.bin:$PATH
export PATH

. /Users/rolf/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/rolf/.nvm/versions/node/v8.11.2/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/rolf/.nvm/versions/node/v8.11.2/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/rolf/.nvm/versions/node/v8.11.2/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/rolf/.nvm/versions/node/v8.11.2/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh