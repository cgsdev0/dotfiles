# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ -f "$HOME/.jira_token" ] ; then
    eval "$(jira --completion-script-zsh)"
    export JIRA_API_TOKEN=`cat $HOME/.jira_token`
fi

if [ -f "$HOME/.nickname" ] ; then
    export NICKNAME=`cat $HOME/.nickname`
fi

export DIRENV_LOG_FORMAT=

# eval "$(hub alias -s)"
#xset r rate 250 40
#setxkbmap -option caps:escape
