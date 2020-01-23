# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes snap if it exists
if [ -d "/snap/bin" ] ; then
    PATH="/snap/bin:$PATH"
fi

# set PATH so it includes user's private go bin if it exists
if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi

# set PATH so it includes go bin if it exists
if [ -d "/usr/local/go/bin" ] ; then
    PATH="/usr/local/go/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export DIRENV_LOG_FORMAT=

if [ ! -z "$SSH_TTY" ]; then
    if [ -f "$HOME/.nickname" ] ; then
        export NICKNAME=`cat $HOME/.nickname`
    fi
else
    eval $(ssh-agent)
fi

export SSH_AUTH_SOCK=/tmp/.devbox_agent.sock
