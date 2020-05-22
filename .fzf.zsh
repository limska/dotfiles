# Setup fzf
# ---------
if [[ ! "$PATH" == */u/cd8rit/.fzf.git/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/u/cd8rit/.fzf.git/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/u/cd8rit/.fzf.git/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/u/cd8rit/.fzf.git/shell/key-bindings.zsh"
