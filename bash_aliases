alias readmail='cat /var/mail/rolf'

alias jeeves='cd ~/dev/jeeves/ && venv/bin/python manage.py'
alias jeeves-remote='ssh 80.212.215.123 ~/dev/jeeves/venv/bin/python ~/dev/jeeves/manage.py'

alias ls='ls -l'

#
# git
alias gl='git log --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gc='git commit'
alias gd='git diff'
alias gch='git checkout'
alias gb='git branch'
alias gs='git status'
alias gr='git rebase'
alias gf='git fetch'
alias gp='git pull'
alias gpp='git push'

#
# ssh
alias :severus='ssh severus.mocco.no'
alias :neville='ssh neville.mocco.no'

alias :itdagene='ssh itdagene.no'

alias :cass='ssh rolferl@login.samfundet.no'
alias :fendrel='ssh 80.212.215.123'
alias 'cirkus-tunnel'='ssh -L 5432:cirkus:5432 rolferl@login.samfundet.no'
alias 'jeeves-tunnel'='ssh -L 9000:127.0.0.1:9000 80.212.215.123'

alias :ntnu='ssh rolferl@caracal.stud.ntnu.no'

alias :fs='ssh filtersystem@s8.wservices.ch'

#
# mosh
alias irc='mosh neville.mocco.no -- screen -rdU irc'
alias ::neville='mosh neville.mocco.no'
alias ::severus='mosh severus.mocco.no'
alias ::lkng='mosh q.lkng.me'
alias ::ntnu='mosh rolferl@caracal.stud.ntnu.no'
