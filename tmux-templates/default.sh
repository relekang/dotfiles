tmux send-keys 'pi' C-m

tmux split-window -h
tmux send-keys 'lv' C-m

tmux select-pane -L
tmux split-window -v
tmux send-keys 'jjui' C-m

tmux select-pane -U
