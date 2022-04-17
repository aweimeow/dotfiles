#! /bin/bash

# Change directory to the directory of this script
cd $(dirname $0)

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 2>&1 /dev/null
    echo "[vim] vim-plug installed."
fi

if [ -f "$HOME/.vimrc" ]; then
    echo "\033[0;31m[ERROR] $HOME/.vimrc exists, stop.\033[0m"
else
    cp .vimrc $HOME/.vimrc
    echo "[vim] .vimrc installed, please run `:PlugInstall` when first time of starting vim."
fi
