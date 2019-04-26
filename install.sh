#!/bin/bash
cd "${0%/*}"
mkdir -p "/home/$USER/bin"
z=1; ln -sf "bin/dotify" "/home/$USER/bin/dotify"
z=1; ln -sf "bin/term-launch" "/home/$USER/bin/term-launch"
