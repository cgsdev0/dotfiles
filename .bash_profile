if [ -f /home/sarah/.bashrc ]; then source /home/sarah/.bashrc; fi
source ~/.profile

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
