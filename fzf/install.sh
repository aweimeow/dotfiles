#! /bin/bash

# Change directory to the directory of this script
cd $(dirname $0)

if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    bash $HOME/.fzf/install --key-bindings --completion --update-rc
    echo "[fzf] fzf installed."
fi

if [ ! -d "$HOME/.local/config/fzf" ]; then
    mkdir -p $HOME/.local/config/fzf
    echo "[fzf] fzf config directory created."
fi

for f in "fzf-tool.sh"; do
    if [ ! -f "$HOME/.local/config/fzf/$f" ]; then
        cp $f $HOME/.local/config/fzf
        echo "[fzf] fzf config $f created."
    fi
done

echo "[fzf] instllation completed."
