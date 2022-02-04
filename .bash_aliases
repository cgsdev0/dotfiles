# Bitwarden CLI
bw_unlock() { export BW_SESSION=$(bw unlock | head -n4 | tail -n1 | cut -d'=' -f2- | tr -d '"'); }

# Make nvr work
alias vim="nvim"

# Git
alias g="git"
alias gl="git l"
alias gA="git add -A; git s"
alias gr="grh"
alias gR="git reset -q; git s"
alias gs="git s"
alias gc="git commit"

# Clear shortcut
alias c="clear && tmux clear-history"

# Timezones
alias tz-atlanta="sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime"
alias tz-detroit="sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime"
alias tz-sanfrancisco="sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime"

# Weather
alias weather="curl v2d.wttr.in"

# Program
alias ll="ls -lhA"
export TODOTXT_DEFAULT_ACTION=ls
alias t="todo.sh -ct"
alias kde="/usr/lib/x86_64-linux-gnu/libexec/kdeconnectd"
alias sp="baton my saved tracks"

# Wifi Management
alias wifi="nmcli d wifi list"

# Random
alias copy="xclip -selection c"
alias copy-last="fc -ln -1 | xclip -selection c"
alias adb-proxy="adb devices -l | tail -n +2 | head -n -1 | awk '{print \$1}' | xargs -L1 -I {} adb -s {} reverse tcp:8081 tcp:8081"
alias rr="adb shell input keyevent 82"
alias network="sudo service network-manager restart"
alias pass="cat /usr/share/dict/words | grep -v \"[']\" | shuf -n 6 | tr '[:upper:]' '[:lower:]' | xargs | tr ' ' '-'"

# Terminal colors
alias c0="cat ~/.cache/wal/sequences"
alias c1="cat ~/themes/override/monokai"
alias c2="cat ~/themes/override/vscode"
alias c3="cat ~/themes/override/gruvbox"
alias c4="cat ~/themes/override/gruvbox-light"

alias sc0="wal -i ~/.config/wall.png && theme"
alias sc1="wal --theme sexy-monokai && theme"
alias sc2="wal --theme vscode && theme"
alias sc3="wal --theme base16-gruvbox-medium && theme"
alias sc4="wal --theme base16-gruvbox-medium -l && theme"

# Configurations
alias vimrc="vim ~/.config/nvim/init.vim"
alias i3rc="vim ~/.config/i3/config && i3-msg reload"
alias rangerrc="vim ~/.config/ranger/rc.conf"
alias grc="git config --edit --global"
alias ba="vim ~/.bash_aliases && . ~/.bash_aliases"
alias zshrc="vim ~/.zshrc && . ~/.zshrc"
alias tmuxrc="vim ~/.tmux.conf && tmux source-file ~/.tmux.conf"

#### Jira management
alias pr="jira-tools pull-request"
alias start="jira-tools start"
alias ticket="jira-tools create-ticket"
# =============

# Mac specials
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias vim="nvim"
fi

# Twitch things
alias tw_chat="clear; sleep 2; watch-and-reload twitch-chat badcop_"
alias tw_chanpoints="clear; watch-and-reload channel-points"
alias tw_follower="clear; watch-and-reload latest-follower"

# =============== STUPID stuff ===============

# mimic python -m SimpleHTTPServer
serve () { rm /tmp/tunnel; mkfifo /tmp/tunnel; echo "Serving $(pwd) on 127.0.0.1:8000..."; while true; do (printf "HTTP/1.0 200 OK\n"; (reqreader() { while IFS= read line;  do [[ $line = $'\r' ]] && break; echo "$line"; done; exit 0; }; var=$(</tmp/tunnel | reqreader); var=$(echo "$var" | grep ^GET | sed 's/GET \(.*\) HTTP\/1\.1.*/\1/'); var=$(echo "$var" | sed 's/^\(.*\)@$/\1/' | sed 's/^\(.*\)\*/\1/'); var=$(echo "<!doctype html><html><head><title>$(pwd)</title></head><body>"; (cat "./$var" 2> /dev/null || (ls -F "./$var" 2> /dev/null | sed 's/\(.*\)/<a href="\1">\1<\/a><br \/>/')); echo "</body></html>"); printf "Content-Length: "; echo "$var" | wc -c; printf "\r\n\r\n"; echo $var)) | nc -l 8000 | >/tmp/tunnel; done }

# =========== End STUPID stuff ===============

