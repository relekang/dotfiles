
function _current_dir() {
  local _max_pwd_length="65"
  if [[ $(echo -n $PWD | wc -c) -gt ${_max_pwd_length} ]]; then
    echo "%-2~ ... %3~"
  else
    echo "%~"
  fi
}

_purple="%{$FG[093]%}"
_gray="%{$FG[240]%}"
_lightgray="%{$FG[242]%}"

ZSH_THEME_GIT_PROMPT_PREFIX=" $_gray("
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$_purple*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$_gray)%{$reset_color%}"

PROMPT='
%{$FG[093]%}$(_current_dir)$(git_prompt_info)%{$reset_color%} $AWS_PROFILE
%(?.%{$fg[green]%}.%{$fg[red]%})➤%{$reset_color%} '

RPROMPT='$_lightgray$(hostname)%{$reset_color%}'
