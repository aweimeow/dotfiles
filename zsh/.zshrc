# aweimeow.zshrc Configuration

# System Path
export PATH=$HOME/.local/bin/python_bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/X11/bin
export TERM="xterm-256color"
export LANG="C.UTF-8"
export LC_CTYPE="C.UTF-8"
export HIST_STAMPS="yyyy-mm-dd"

# ZSH configuration
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="aweimeow"
export ZSH_DISABLE_COMPFIX="true"
export DISABLE_AUTO_UPDATE="true"
export DISABLE_AUTO_TITLE="true"

plugins=(zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# iTerm2 Shortcut
function title() {
    echo -e "\033];$*\007\a"sss
}

# FZF configuration

export FZF_DEFAULT_OPTS="--color fg:188,bg:0,hl:228,fg+:214,bg+:235,hl+:202,info:241,prompt:196,spinner:253,pointer:196,marker:82"
export FZF_CTRL_R_OPTS='--sort --exact'
source $HOME/.local/config/fzf/*

alias cat="ccat"

# Development Environment

# Python / PIP related setting
export PIP_REQUIRE_VIRTUALENV=true

# Fix zsh home & end key working
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line

echo -e "\033]6;1;bg;red;brightness;40\a" > /dev/null
echo -e "\033]6;1;bg;green;brightness;44\a" > /dev/null
echo -e "\033]6;1;bg;blue;brightness;52\a" > /dev/null

function watch() {
    while :;
    do
    clear
    $*
    sleep 5
    done
}
