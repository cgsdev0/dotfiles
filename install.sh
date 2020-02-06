#!/bin/bash
SCRIPT_DIR=$( cd ${0%/*} && pwd -P )
cat directories | xargs -L1 -I {} sudo mkdir -p $HOME/{}
cat files | xargs -L1 -I {} sudo ln -sf $SCRIPT_DIR/{} $HOME/{}

sudo ln -sf $HOME/.profile $HOME/.zprofile
