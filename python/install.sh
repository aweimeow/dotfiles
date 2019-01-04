#! /usr/bin/env bash
set -e

LOCALDIR="$HOME/.local";
SOURCEDIR="$LOCALDIR/src";
BINDIR="$LOCALDIR/bin";

function prompt() {
    time="$(date +'%Y-%m-%d_%H-%M-%S')";
    title="$1";
    content="$2";
    echo -e -n "\033[32m$time\033[0m \033[34m[$title]\033[0m \033[97m$content\033[0m\n";
}

if ! [ -x "$(command -v git)" ]; then
    prompt precheck "Installing git ...";
    sudo apt install git -y;
fi

if ! [ -x "$(command -v python)" && "$(command -v pip)" ]; then
    prompt precheck "Installing python & pip ...";
    sudo apt install python python-pip -y;
fi

if ! [ -d "$SOURCEDIR" && -d "$BINDIR" ]; then
    prompt precheck "Creating $SOURCEDIR or $BINDIR for binary files.";
    mkdir -p $SOURCEDIR;
    mkdir -p $BINDIR;
fi

if ! [ -x "$(command -v pyenv)" ]; then
    prompt precheck "Installing pyenv ...";
    git clone https://github.com/pyenv/pyenv.git $SOURCEDIR/pyenv;
    cp $(dirname "$0")/pyenv $BINDIR/pyenv;
fi

if ! [ -x "$(command -v pipenv)" ]; then
    prompt precheck "Installing pipenv ...";
    pip install --user pipenv;
fi
