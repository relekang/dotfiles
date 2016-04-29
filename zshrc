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

export PATH="./node_modules/.bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/MacGPG2/bin:/usr/texbin"
export PATH=~/.local/bin:$PATH
export PATH=~/bin:$PATH

. $DOT/aliases
source $DOT/chruby
source $DOT/functions
source $DOT/python/virtualenvwrapper

export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
