# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf.git/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.fzf.git/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf.git/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.fzf.git/shell/key-bindings.zsh"
