#!/bin/bash
cat directories | xargs -L1 sudo mkdir -p
cat files | xargs -L1 -I {} ln -sf /home/$USER/dotfiles/{} /home/$USER/{}
