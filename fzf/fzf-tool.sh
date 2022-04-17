#! /usr/bin/env bash

function fhelp() {
    cat -C never << EOF
FZF scripts to easy your life:

search   - Search files with highlight syntax preview window
esearch  - Edit searched file by fzf
fd       - fzf-directory to switch into nested directory
fda      - fzf-directory with all hidden directories
git lg   - fzf-git-log browsing git log with fzf
fkill    - Search process and kill by root privilege
EOF
}

# Search files with highlight syntax preview window
function search() {
    fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
                   echo {} is a binary file ||
                   (highlight -O xterm256 --style camo -j 3 -l {} || cat {}) 2> /dev/null' \
        --preview-window=right:65%
}

function esearch() {
    local file
    file=$(search)
    [ -n "$file" ] && vim $file
}

function csearch() {
    local file
    file=$(search)
    [ -n "$file" ] && cat $file
}

# fd - fzf-directory to switch into nested directory
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - fd including hidden directories
function fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fzf-git-log - Browsing git log with fzf
function fzf-git-log() {
  local out q sha
  while out=$(
      git log --graph --color=always \
          --format="%C(green)%h%Creset %C(cyan)%<(20)%an%$Creset %C(yellow)%d%Creset %s %C(black)%C(bold)%cr" |
      fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}

# fkill - Use sudo privilege to search and kill target process
fkill() {
  local pid
  pid=$(sudo ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs sudo kill -${1:-9}
  fi
}
