# Setup fzf
# ---------
if [[ ! "$PATH" == */home/sarah/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/sarah/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/sarah/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/sarah/.fzf/shell/key-bindings.zsh"
