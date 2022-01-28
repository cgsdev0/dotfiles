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


# =============== STUPID stuff ===============

# mimic python -m SimpleHTTPServer
serve () { rm /tmp/tunnel; mkfifo /tmp/tunnel; echo "Serving $(pwd) on 127.0.0.1:8000..."; while true; do (printf "HTTP/1.0 200 OK\n"; (reqreader() { while IFS= read line;  do [[ $line = $'\r' ]] && break; echo "$line"; done; exit 0; }; var=$(</tmp/tunnel | reqreader); var=$(echo "$var" | grep ^GET | sed 's/GET \(.*\) HTTP\/1\.1.*/\1/'); var=$(echo "$var" | sed 's/^\(.*\)@$/\1/' | sed 's/^\(.*\)\*/\1/'); var=$(echo "<!doctype html><html><head><title>$(pwd)</title></head><body>"; (cat "./$var" 2> /dev/null || (ls -F "./$var" 2> /dev/null | sed 's/\(.*\)/<a href="\1">\1<\/a><br \/>/')); echo "</body></html>"); printf "Content-Length: "; echo "$var" | wc -c; printf "\r\n\r\n"; echo $var)) | nc -l 8000 | >/tmp/tunnel; done }

# twitch_chat {channel} - opens a websocket for reading chat
twitch_chat () {
rm -f /tmp/twitch_tunnel;
mkfifo /tmp/twitch_tunnel;
clear;

# Example chat msg:
# @badge-info=;badges=;client-nonce=31ab40a7bef7162bfc8eade860eb185a;color=#DAA520;display-name=BuddysPizza;emotes=;first-msg=0;flags=;id=e86038a5-4d49-4868-aa96-b563da8fc689;mod=0;room-id=56931496;subscriber=0;tmi-sent-ts=1643181677955;turbo=0;user-id=42089909;user-type= :buddyspizza!buddyspizza@buddyspizza.tmi.twitch.tv PRIVMSG #badcop_ :!help

colorize() {
    printf "\x1b[38;2;$(( 16#${1:0:2} ));$(( 16#${1:2:2} ));$(( 16#${1:4:2} ))m"
}

parsechat() {
    if [[ "$1" == *" PRIVMSG "* ]]; then
        color=$(echo -n "$1" | grep -oP "color=.*?;" | cut -d'=' -f2- | tr -d '#;\n')
        name=$(echo -n "$1" | grep -oP "display-name=.*?;" | cut -d'=' -f2- | tr -d ';\n')
        msg=$(printf "$1" | grep -oP "PRIVMSG.*$" | cut -d':' -f2-)
        if [[ "${#color}" != "6" ]]; then
            color=${"$(echo "$name" | md5sum)":3:9}
        fi
        if [[ "$1" == *"custom-reward-id=15569ace-d070-4037-986d-967f44196d74;"* ]]; then
            colorize $color
            echo "$name summoned a cow!"
            cowsay "$msg"
        elif [[ "$msg" == "!lolcat "* ]]; then
            colorize $color
            printf "$name"
            printf '\033[0m'
            echo -n ": "
            echo "$msg" | cut -d' ' -f2- | lolcat
        elif [[ "$msg" == $'\x01'"ACTION "* ]]; then
            colorize $color
            echo "$name" $(echo "$msg" | cut -d' ' -f2-)
        else
            colorize $color
            printf "$name"
            printf '\033[0m'
            echo -n ": "
            echo "$msg"
        fi
    fi
}
reqreader() {
  while IFS= read -r line; do
    [[ $line == "PING"* ]] && echo "PONG :tmi.twitch.tv\r";
    parsechat "$line" 1>&2
  done;
  exit 0;
}
(echo "CAP REQ :twitch.tv/tags twitch.tv/commands\r\nPASS SCHMOOPIIE\r\nNICK justinfan21799\r\nJOIN #${1}\r"; \
    </tmp/twitch_tunnel | reqreader) \
    | websocat_linux64 wss://irc-ws.chat.twitch.tv:443 \
    | >/tmp/twitch_tunnel
}
alias mychat="twitch_chat badcop_"
# =========== End STUPID stuff ===============
