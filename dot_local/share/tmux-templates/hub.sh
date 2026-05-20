tmux send-keys 'mise r lint:pyright --watch' C-m

tmux split-window -h
tmux send-keys 'lv' C-m

tmux select-pane -L

tmux split-window -v
tmux send-keys 'claude' C-m

tmux split-window -v
tmux send-keys 'jjui' C-m

tmux split-window -v
tmux send-keys 'exec $SHELL' C-m

tmux select-pane -R
tmux resize-pane -x 40

tmux new-window -n app

tmux send-keys 'mise r app:server' C-m
tmux split-window -h
tmux send-keys 'mise r app:ui' C-m

tmux select-window -t workspace
