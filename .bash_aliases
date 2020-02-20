# SQL
alias mysql-dev="mysql -h 127.0.0.1 --port=3307 -uroot -pdev"
alias mycli-dev="mycli -h 127.0.0.1 -P 3307 -uroot -pdev"

# Taskrunner
alias taskl="taskrunner --list | tail -n +3 | fzf | xargs -r taskrunner"
alias taskr="export SENTRY_RELEASE_ID=\"troy:dev_no_sentry\"; taskrunner"
alias taskt="taskrunner --config mobile/Troy/troy.taskrunner.json"

# Locations
alias gb="cd ~/co/backend"
alias gt="cd ~/co/backend/mobile/Troy"
alias gd1="cd ~/co/backend/mobile/SamsaraDriver"

# Git
alias g="git"
alias gl="git l"
alias gA="git add -A; git s"
alias gr="grh"
alias gR="git reset -q; git s"
alias gs="git s"
alias gc="git commit"

# Jank control
jankset() { curl https://shaneschulte.com/mob_jank_gauge/set_jank.php -d "jank=$1"; }
jankadd() { curl https://shaneschulte.com/mob_jank_gauge/set_jank.php -d "jank=$1&mode=add"; }
janksubtract() { curl https://shaneschulte.com/mob_jank_gauge/set_jank.php -d "jank=$1&mode=subtract"; }
jankpop() { curl https://shaneschulte.com/mob_jank_gauge/set_jank.php -d "jank=$1&mode=pop"; }

# Timezones
alias tz-atlanta="sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime"
alias tz-detroit="sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime"
alias tz-sanfrancisco="sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime"

# Program
alias top="gotop"
alias ll="ls -lhA"
alias kde="/usr/lib/x86_64-linux-gnu/libexec/kdeconnectd"
alias slack="google-chrome --app='https://samsara-net.slack.com/messages'"
alias j="jira-tui board"
alias sp="baton my saved tracks"

# Wifi Management
alias wifi="nmcli d wifi list"
alias vpn="taskrunner vpn/token && sudo openvpn /home/shane/co/backend/conf/tunnelblick/default.tblk/Contents/Resources/config.ovpn"

# Random
alias mcdonalds="git commit -a --amend --no-edit && bash -c \"git push mac -f --no-verify && ssh dev@mac \\\"~/fix.sh\\\" \""
alias copy="xclip -selection c"
alias copy-last="fc -ln -1 | xclip -selection c"
alias mac="ssh dev@mac"
alias phone="adb connect pixel:5555"
alias adb-proxy="adb devices -l | tail -n +2 | head -n -1 | awk '{print \$1}' | xargs -L1 -I {} adb -s {} reverse tcp:8081 tcp:8081"
alias rr="adb shell input keyevent 82"
alias network="sudo service network-manager restart"
#alias yarn="~/bin/yarn-hack"
alias yarl="cat package.json | jq '.scripts | to_entries[] | .key' | tr -d '\" ' | fzf | xargs -r ~/bin/yarn-hack"
alias buildi="yarn android-proxy && react-native run-android --variant=InternalDebug --no-packager"
alias hack="figlet ACCESS GRANTED | nms && ssh"
alias fixhist="history | sed \"s/[0-9* ]*\(.*\)/\1/\" > ~/.zsh_history"
alias d1="sudo chown -R shane:shane /dev/kvm && bin/d1-run-android"
alias troy="sudo chown -R shane:shane /dev/kvm && bin/troy-run-android"
alias pass="cat /usr/share/dict/words | grep -v \"[']\" | shuf -n 6 | tr '[:upper:]' '[:lower:]' | xargs | tr ' ' '-'"
alias pr="pull-request"

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

# Sentry
alias ds="git apply ~/disable_sentry.patch"
alias es="git checkout -- ~/co/backend/mobile/Troy/index.js"

# Mac specials
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias vim="nvim"
fi
