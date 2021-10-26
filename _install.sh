#!/bin/bash

list_files() {
    cd "${0%/*}"
    git ls-files | grep -v '^_'
}

list_dirs() {
    cd "${0%/*}"
    git ls-files | grep -v '^_' | xargs -L1 dirname | sort | uniq
}

SCRIPT_DIR=$( cd ${0%/*} && pwd -P )
list_dirs | xargs -L1 -I {} sudo mkdir -p $HOME/{}
list_files | xargs -L1 -I {} sudo ln -sf $SCRIPT_DIR/{} $HOME/{}

sudo ln -sf $HOME/.profile $HOME/.zprofile
