#!/bin/bash
SCRIPT_DIR=$( cd ${0%/*} && pwd -P )
cat directories | xargs -L1 -I {} sudo mkdir -p /home/$USER/{}
cat files | xargs -L1 -I {} sudo ln -sf $SCRIPT_DIR/{} /home/$USER/{}

sudo ln -sf /home/$USER/.profile /home/$USER/.zprofile
