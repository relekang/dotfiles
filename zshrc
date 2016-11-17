export ZSH=$HOME/.oh-my-zsh
export DOT=$HOME/.dotfiles

ZSH_THEME="af-magic"
CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

export PROJECTS=~/dev
export EDITOR='vim'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
export PHANTOMJS_BIN=/usr/local/bin/phantomjs

plugins=(git npm pip)

source $ZSH/oh-my-zsh.sh

# User configuration

PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
PATH=./node_modules/.bin:$PATH
PATH=$DOT/bin:$PATH
PATH=~/.local/bin:$PATH
PATH=~/bin:$PATH
export PATH

. $DOT/aliases
source $DOT/chruby
source $DOT/functions
source $DOT/python/virtualenvwrapper

export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH=~/.rbenv/shims:$PATH

export NVM_DIR="${HOME}/.nvm"
NVM_SH="/usr/local/opt/nvm/nvm.sh"
[ -s "$NVM_SH" ] && . "$NVM_SH"  # This loads nvm

# added by travis gem
[ -f /Users/rolf/.travis/travis.sh ] && source /Users/rolf/.travis/travis.sh
