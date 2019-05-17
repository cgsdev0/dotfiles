# SQL
alias mysql-dev="mysql -h 127.0.0.1 --port=3307 -uroot -pdev"
alias mycli-dev="mycli -h 127.0.0.1 -P 3307 -uroot -pdev"

# Taskrunner
alias taskl="taskrunner --list | tail -n +3 | fzf | xargs -r taskrunner"
alias taskr="taskrunner"
alias taskt="taskrunner --config mobile/Troy/troy.taskrunner.json"

# Locations
alias gb="cd ~/co/backend"
alias gt="cd ~/co/backend/mobile/Troy"
alias gd="cd ~/co/backend/mobile/SamsaraDriver"

# Programs
alias g="git"
alias top="vtop --theme wal"
alias ll="ls -lhA"
alias kde="/usr/lib/x86_64-linux-gnu/libexec/kdeconnectd"
alias slack="google-chrome --app='https://samsara-net.slack.com/messages'"

# Wifi Management
alias wifi="nmcli d wifi list"

# Random
alias mcdonalds="git commit -a --amend --no-edit && bash -c \"git push mac -f --no-verify && ssh dev@mac \\\"~/fix.sh\\\" \""
alias mac="ssh dev@mac"
alias phone="adb connect pixel:5555"
alias network="sudo service network-manager restart"
#alias yarn="~/bin/yarn-hack"
alias yarl="cat package.json | jq '.scripts | to_entries[] | .key' | tr -d '\" ' | fzf | xargs -r ~/bin/yarn-hack"

# Terminal colors
alias c0="cat ~/.cache/wal/sequences"
alias c1="cat ~/themes/override/monokai"
alias c2="cat ~/themes/override/vscode"

# Configurations
# alias vim="~/Tools/nvim.appimage"
alias vimrc="vim ~/.config/nvim/init.vim"
alias i3rc="vim ~/.config/i3/config"
alias rangerrc="vim ~/.config/ranger/rc.conf"
alias ba="vim ~/.bash_aliases && . ~/.bash_aliases"
