#!/bin/bash
SCRIPT_DIR=$( cd ${0%/*} && pwd -P )
cat directories | xargs -L1 sudo mkdir -p
cat files | xargs -L1 -I {} ln -sf $SCRIPT_DIR/{} /home/$USER/{}
