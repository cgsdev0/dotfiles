# Git
alias g="git"
alias gl="git l"
alias gA="git add -A; git s"
alias gr="grh"
alias gR="git reset -q; git s"
alias gs="git s"
alias gc="git commit"

# Timezones
alias tz-atlanta="sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime"
alias tz-detroit="sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime"
alias tz-sanfrancisco="sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime"

# Program
alias ll="ls -lhA"
alias kde="/usr/lib/x86_64-linux-gnu/libexec/kdeconnectd"
alias sp="baton my saved tracks"

# Wifi Management
alias wifi="nmcli d wifi list"

# Power Management
alias sleep-disable="sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias sleep-enable="sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target"

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

# Configurations
alias vimrc="vim ~/.config/nvim/init.vim"
alias i3rc="vim ~/.config/i3/config && i3-msg reload"
alias rangerrc="vim ~/.config/ranger/rc.conf"
alias grc="git config --edit --global"
alias ba="vim ~/.bash_aliases && . ~/.bash_aliases"
alias zshrc="vim ~/.zshrc && . ~/.zshrc"
alias tmuxrc="vim ~/.tmux.conf && tmux source-file ~/.tmux.conf"

# == Samsara ==
alias unfuck-hooks="[[ \"\$(readlink \$HOME/co/backend/.git/hooks)\" = personal_hooks ]] || (cd \$HOME/co/backend/.git; unlink hooks; mkdir -p personal_hooks; ln -s personal_hooks hooks; echo 'Personal hooks restored.')"
alias d1="sudo chown -R shane:shane /dev/kvm && bin/d1-run-android"
alias troy="sudo chown -R shane:shane /dev/kvm && bin/troy-run-android"
alias slack="google-chrome --app='https://samsara-net.slack.com/messages'"
alias vpn="taskrunner vpn/token && sudo openvpn /home/shane/co/backend/conf/tunnelblick/default.tblk/Contents/Resources/config.ovpn"
#### Taskrunner
alias taskl="taskrunner --list | tail -n +3 | fzf | xargs -r taskrunner"
alias taskr="export SENTRY_RELEASE_ID=\"troy:dev_no_sentry\"; taskrunner"
alias taskt="taskrunner --config mobile/Troy/troy.taskrunner.json"
alias dbox="taskrunner devbox/run"
alias dbox-mac="ssh mac \"/usr/local/bin/tmux send-keys -t monitoring C-C 'DEVBOX_CUSTOM_AUTOSSH_OPTS= taskrunner devbox/run' C-m\""
#### Locations
alias gb="cd ~/co/backend"
alias gt="cd ~/co/backend/mobile/Troy"
alias gd1="cd ~/co/backend/mobile/SamsaraDriver"
#### SQL
alias mysql-dev="mysql -h 127.0.0.1 --port=3307 -uroot -pdev"
alias mycli-dev="mycli -h 127.0.0.1 -P 3307 -uroot -pdev"
#### Jank controls
jankset() { curl https://shaneschulte.com/mob_jank_gauge/set_jank.php -d "jank=$1"; }
jankadd() { curl https://shaneschulte.com/mob_jank_gauge/set_jank.php -d "jank=$1&mode=add"; }
janksubtract() { curl https://shaneschulte.com/mob_jank_gauge/set_jank.php -d "jank=$1&mode=subtract"; }
jankpop() { curl https://shaneschulte.com/mob_jank_gauge/set_jank.php -d "jank=$1&mode=pop"; }
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
# =========== End STUPID stuff ===============
