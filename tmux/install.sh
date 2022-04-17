#! /bin/bash

# Change directory to the directory of this script
cd $(dirname $0)

if [ ! -f "$HOME/.tmux.conf" ]; then
    cp .tmux.conf $HOME;
    echo "[tmux] tmux configuration installed."
fi

if [ ! -d "$HOME/.local/share" ]; then
    echo "Create $HOME/.local/share ...";
    mkdir -p $HOME/.local/share/
fi

if [ ! -d "$HOME/.local/share/tmux-powerline" ]; then
    cp -r tmux-powerline $HOME/.local/share/
    echo "[tmux] tmux-powerline installed."
fi