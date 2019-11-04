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

plugins=()

source $ZSH/oh-my-zsh.sh

PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
PATH=$DOT/bin:$PATH
PATH=$PATH:/Library/Frameworks/Mono.framework/Versions/Current/bin/
PATH=$PATH:/usr/local/lib/ruby/gems/2.5.0/bin/
PATH=$GOPATH/bin:$PATH
PATH=~/.local/bin:$PATH
PATH=~/bin:$PATH
PATH=/Users/rolf/Library/Python/2.7/bin:/Users/rolf/Library/Python/3.7/bin:$PATH
PATH=~/.poetry/bin:$PATH
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
source $DOT/python/virtualenvwrapper

# fnm
eval "$(fnm env --multi)"

if [[ "$(uname)" == "Darwin" ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

PATH=~/.local/bin:$PATH
PATH=~/.node-bin/node_modules/.bin:$PATH
PATH=~/bin:$PATH
PATH=./node_modules/.bin:$PATH
export PATH

. /Users/rolf/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/rolf/dev/rl.com/lambdas/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/rolf/dev/rl.com/lambdas/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/rolf/dev/rl.com/lambdas/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/rolf/dev/rl.com/lambdas/node_modules/tabtab/.completions/sls.zsh
