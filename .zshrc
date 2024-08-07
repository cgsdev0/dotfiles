if [[ -d ~/completions ]]; then
  fpath=(~/completions $fpath)
fi

print() {
  [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ] || builtin print "$@";
}

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# hoard all the commands ever
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

DEFAULT_USER=`whoami`

# configure tmux plugin
if [ ! -z "$SSH_TTY" ]; then
  ZSH_TMUX_AUTOSTART=true
  ZSH_TMUX_AUTOCONNECT=true
  ZSH_TMUX_AUTOQUIT=false
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git yarn tmux zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting forgit)

source $ZSH/oh-my-zsh.sh

if [[ -d $HOME/.zsh/pure ]]; then
  fpath+=$HOME/.zsh/pure
fi

autoload -U promptinit; promptinit
prompt pure

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
. ~/.bash_aliases

export FORGIT_FZF_DEFAULT_OPTS=" --border --cycle --ansi --reverse --height '80%' --preview-window right:66%"

export EDITOR=vim

if [ -f "$HOME/.jira_token" ] ; then
    eval "$(jira --completion-script-zsh)"
    export JIRA_API_TOKEN=`cat $HOME/.jira_token`
fi

if [ -f "$HOME/.github_token" ] ; then
    export GITHUB_API_TOKEN=`cat $HOME/.github_token`
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"

# maven
[ -f "/etc/profile.d/maven.sh" ] && . "/etc/profile.d/maven.sh"

# make pasting fast
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if [ -e /home/sarah/.nix-profile/etc/profile.d/nix.sh ]; then . /home/sarah/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# emacs is a way of life, so it's best to always be inside emacs
# (also unrelated, this makes pure prompt not fuck with the title)
# export INSIDE_EMACS=true
printf '\033]2;%s\033\\' "$(hostname)"

if [[ -d "$HOME/.fly" ]]; then
  export FLYCTL_INSTALL="$HOME/.fly"
  export PATH="$FLYCTL_INSTALL/bin:$PATH"
fi

ssh() {
  if [[ ! -z "$TMUX" ]]; then
    if [[ "$1" == "rcdb" ]]; then
      if which hotdog &> /dev/null; then
        HOTDOGGED=true
        hotdog pane
      fi
    fi
    config=$(command ssh "$@" -G)
    host=$(echo "$config" | grep -E "^hostname " | head -n1 | cut -d' ' -f2)
    port=$(echo "$config" | grep -E "^port " | head -n1 | cut -d' ' -f2)
    if [[ "$port" != "22" ]]; then
      host="${host}:${port}"
    fi
    printf '\033]2;%s\033\\' "$host"
    command ssh "$@"
    printf '\033]2;%s\033\\' "$(hostname)"
    if [[ ! -z "$HOTDOGGED" ]]; then
      hotdog reset
    fi
  else
    command ssh "$@"
  fi
}

if which run &> /dev/null && which fzf &> /dev/null; then
  run() {
    if [[ $# -eq 0 ]]; then
      local TASK="$(command run -list \
        | grep '^  [^ ]' \
        | tr -d ' ' \
        | fzf -0 --ansi)"
      command run "$TASK"
    else
      command run "$@"
    fi
  }
fi
# # The next line enables shell command completion for gcloud.
# if [ -f '/home/sarah/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/sarah/tools/google-cloud-sdk/completion.zsh.inc'; fiA
#
source ~/.zsh/autocomplete/*
