#!/bin/bash
cd "${0%/*}"
mkdir -p "/home/$USER"
mkdir -p "/home/$USER/bin"
mkdir -p "/home/$USER/.config/autorandr/docked"
mkdir -p "/home/$USER/.config/autorandr/home"
mkdir -p "/home/$USER/.config/autorandr/mobile"
mkdir -p "/home/$USER/.config/cava"
mkdir -p "/home/$USER/.config/Dharkael"
mkdir -p "/home/$USER/.config/dunst"
mkdir -p "/home/$USER/.config/i3"
mkdir -p "/home/$USER/.config/nvim"
mkdir -p "/home/$USER/.config/polybar"
mkdir -p "/home/$USER/.config/ranger"
z=1; ln -sf ".bash_aliases" "/home/$USER/.bash_aliases"
z=1; ln -sf ".bash_profile" "/home/$USER/.bash_profile"
z=1; ln -sf ".bashrc" "/home/$USER/.bashrc"
z=1; ln -sf "bin/battery" "/home/$USER/bin/battery"
z=1; ln -sf "bin/cava-colors" "/home/$USER/bin/cava-colors"
z=1; ln -sf "bin/color" "/home/$USER/bin/color"
z=1; ln -sf "bin/dotify" "/home/$USER/bin/dotify"
z=1; ln -sf "bin/i3-get-window-criteria" "/home/$USER/bin/i3-get-window-criteria"
z=1; ln -sf "bin/location" "/home/$USER/bin/location"
z=1; ln -sf "bin/monitor" "/home/$USER/bin/monitor"
z=1; ln -sf "bin/set_title" "/home/$USER/bin/set_title"
z=1; ln -sf "bin/term-launch" "/home/$USER/bin/term-launch"
z=1; ln -sf "bin/theme" "/home/$USER/bin/theme"
z=1; ln -sf "bin/volume" "/home/$USER/bin/volume"
z=1; ln -sf "bin/wal-edit" "/home/$USER/bin/wal-edit"
z=1; ln -sf "bin/weather" "/home/$USER/bin/weather"
z=1; ln -sf "bin/weather_widget" "/home/$USER/bin/weather_widget"
z=1; ln -sf ".config/autorandr/docked/config" "/home/$USER/.config/autorandr/docked/config"
z=1; ln -sf ".config/autorandr/docked/postswitch" "/home/$USER/.config/autorandr/docked/postswitch"
z=1; ln -sf ".config/autorandr/home/config" "/home/$USER/.config/autorandr/home/config"
z=1; ln -sf ".config/autorandr/mobile/config" "/home/$USER/.config/autorandr/mobile/config"
z=1; ln -sf ".config/autorandr/mobile/postswitch" "/home/$USER/.config/autorandr/mobile/postswitch"
z=1; ln -sf ".config/cava/config" "/home/$USER/.config/cava/config"
z=1; ln -sf ".config/Dharkael/flameshot.ini" "/home/$USER/.config/Dharkael/flameshot.ini"
z=1; ln -sf ".config/dunst/dunstrc" "/home/$USER/.config/dunst/dunstrc"
z=1; ln -sf ".config/i3/config" "/home/$USER/.config/i3/config"
z=1; ln -sf ".config/nvim/init.vim" "/home/$USER/.config/nvim/init.vim"
z=1; ln -sf ".config/polybar/config" "/home/$USER/.config/polybar/config"
z=1; ln -sf ".config/polybar/launch.sh" "/home/$USER/.config/polybar/launch.sh"
z=1; ln -sf ".config/ranger/rc.conf" "/home/$USER/.config/ranger/rc.conf"
z=1; ln -sf ".gitconfig" "/home/$USER/.gitconfig"
z=1; ln -sf ".profile" "/home/$USER/.profile"
z=1; ln -sf ".zshrc" "/home/$USER/.zshrc"
