if [ -f /home/sarah/.bashrc ]; then source /home/sarah/.bashrc; fi
source ~/.profile

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

if [ -e /home/sarah/.nix-profile/etc/profile.d/nix.sh ]; then . /home/sarah/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
