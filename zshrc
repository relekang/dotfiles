export ZSH=$HOME/.oh-my-zsh
export DOT=$HOME/.dotfiles

ZSH_THEME="af-magic"
CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

export PROJECTS=~/dev
export EDITOR='vim'
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

plugins=(git npm pip redis-cli bower rbates)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/home/rolf/apache-storm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/MacGPG2/bin:/usr/texbin"
export PATH=~/.local/bin:$PATH

. $DOT/aliases
source $DOT/chruby
source $DOT/functions
source $DOT/python/virtualenvwrapper
