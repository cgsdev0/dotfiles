# Setup fzf
# ---------
if [[ ! "$PATH" == */home/sarah/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/sarah/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/sarah/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/sarah/.fzf/shell/key-bindings.bash"
