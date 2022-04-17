#! /bin/bash

# Change directory to the directory of this script
cd $(dirname $0)

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "[zsh] oh-my-zsh installed."
fi

if [ ! -f "$HOME/.oh-my-zsh/themes/aweimeow.zsh-thme" ]; then
    cp ./aweimeow.zsh-theme $HOME/.oh-my-zsh/themes/;
    echo "[zsh] oh-my-zsh theme installed."
fi

if [ -f "$HOME/.zshrc" ]; then
    echo "\033[1;33m[WARN] $HOME/.zshrc exists, overwrite.\033[0m"
fi

# Install zsh-syntax-highlighting and zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting/ $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    echo "[zsh] zsh-syntax-highlighting installed."
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    echo "[zsh] zsh-autosuggestions installed."
fi


cp .zshrc $HOME/.zshrc
echo "[zsh] .zshrc installed."