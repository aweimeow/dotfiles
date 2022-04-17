#! /bin/bash

# Change directory to the directory of this script
cd $(dirname $0)

if ! command -v brew &> /dev/null; then
    echo "\033[0;31m[ERROR] brew is not installed, stop.\033[0m"
fi

while read package; do
    brew install $package;
    echo "[brew] $package installed."
done <package.list