#!/usr/bin/env bash

list_files() {
    cd "${0%/*}"
    git ls-files | grep -v '^_' | grep -v "README.md"
}

list_dirs() {
    cd "${0%/*}"
    git ls-files | grep -v '^_' | xargs -L1 dirname | sort | uniq
}

SCRIPT_DIR=$( cd ${0%/*} && pwd -P )
list_dirs | xargs -I {} sudo mkdir -p "$HOME"/{}
list_files | xargs -I {} sudo ln -sf $SCRIPT_DIR/{} "$HOME"/{}

sudo ln -sf "$HOME"/.profile "$HOME"/.zprofile

find "$HOME"/bin -xtype l -print0 | xargs -0 rm --
