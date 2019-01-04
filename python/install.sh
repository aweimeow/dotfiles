#! /usr/bin/env bash
set -e

LOCALDIR="$HOME/.local";
SOURCEDIR="$LOCALDIR/src";
BINDIR="$LOCALDIR/bin";
SHELLCONFIG="$HOME/.bashrc";

function prompt() {
    time="$(date +'%Y-%m-%d %H:%M:%S')";
    title="$1";
    content="$2";
    echo -e -n "\033[32m$time\033[0m \033[34m[$title]\033[0m \033[97m$content\033[0m\n";
}

if ! [ -x "$(command -v git)" ]; then
    prompt precheck "Installing git ...";
    sudo apt install git -y;
fi

if ! [ -x "$(command -v python)" ] || ! [ -x "$(command -v pip)" ]; then
    prompt precheck "Installing python & pip ...";
    sudo apt install python python-pip -y;
fi

if ! [ -d "$SOURCEDIR" ] || ! [ -d "$BINDIR" ]; then
    prompt precheck "Creating $SOURCEDIR or $BINDIR for binary files.";
    mkdir -p $SOURCEDIR;
    mkdir -p $BINDIR;
fi

if ! [ $(printenv | grep -E "^PATH.*$BINDIR") ]; then
    prompt configure "Write $BINDIR into $SHELLCONFIG";
    echo "export PATH=$BINDIR:$PATH" >> $SHELLCONFIG;
    source $SHELLCONFIG;
fi

if ! [ -z "${PIPENV_VENV_IN_PROJECT}" ]; then
    prompt configure "Write PIPENV_VENV_IN_PROJECT variable into $SHELLCONFIG";
    echo "export PIPENV_VENV_IN_PROJECT=1" >> $SHELLCONFIG;
    source $SHELLCONFIG;
fi

if ! [ -x "$(command -v pyenv)" ]; then
    prompt precheck "Installing pyenv ...";
    if ! [ -d "$SOURCEDIR/pyenv" ]; then
        git clone https://github.com/pyenv/pyenv.git $SOURCEDIR/pyenv;
    fi
    curl -fLo $BINDIR/pyenv https://aweimeow.tw/python/pyenv;
    chmod +x $BINDIR/pyenv;
fi

if ! [ -x "$(command -v pipenv)" ]; then
    prompt precheck "Installing pipenv ...";
    pip install --user pipenv;
fi

prompt success "Your Python Environment is ready! You may need to restart shell to take effect.";
prompt info "Each python versions have its own isolated pipenv virtual environment."
prompt info "Use pyenv install <python version> to install a desired version.";
prompt info "And then you are able to use pyenv change <python version> to switch version.";
