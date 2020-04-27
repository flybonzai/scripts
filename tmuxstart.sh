#!/bin/sh
# setup a work space called `work` with two windows
# first window has 3 panes. 
# The first pane set at 65%, split horizontally, set to api root and running vim
# pane 2 is split at 25% and running redis-server 
# pane 3 is set to api root and bash prompt.
# note: `api` aliased to `cd ~/path/to/work`

session="main"

# set up tmux
tmux start-server

# create a new tmux session, starting vim from a saved session in the new window
tmux new-session -d -s $session

# Split pane 1 horizontal by 50%
tmux splitw -h -p 50

# Select pane 2 
tmux selectp -t 2
# Split pane 2 vertically by 50%
tmux splitw -v -p 50

# create a new window called adhoc
tmux new-window -t $session:1 -n adhoc

# create a new window called k8s
tmux new-window -t $session:2 -n k8s

# create a new window called repos
tmux new-window -t $session:3 -n repos
tmux send-keys "repos" C-m

# create a new window called vim
tmux new-window -t $session:4 -n vim

# create a new window called pi
tmux new-window -t $session:5 -n pi
tmux send-keys "sshpi" C-m 

# return to main vim window
tmux select-window -t $session:0

# Finished setup, attach to the tmux session!
tmux attach-session -t $session
