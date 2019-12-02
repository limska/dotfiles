#! /bin/zsh

#==============================================================================
# PROMPT/TITLEBAR/COLORS/MISC
#==============================================================================
export PS1="%F{cyan}%n%F{blue}@%F{cyan}%M %F{yellow}%~ > %f"
export RPROMPT='%(?,%F{green}:%),%F{yellow}%? %F{red}:()%f'

# pwd in titlebar
precmd() {print -Pn "\e]2;[%2~]\a"}

# colors in menu-driven tab completion
eval $(dircolors -b)

# less colors
export LESS_TERMCAP_us=$'\e[32m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'

# editor (needed for git diff etc.)
export EDITOR="vim"

# quiet
setopt no_beep

# extended globbing
setopt extendedglob

# background processes aren't killed on exit of shell
setopt autocontinue

#==============================================================================
# AUTOCOMPLETION
#==============================================================================
autoload -U compinit ; compinit
setopt complete_in_word
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#==============================================================================
# HISTORY OPTIONS
#==============================================================================
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$HOME/.zsh_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt appendhistory
setopt share_history
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

#==============================================================================
# STANDARD KEYS BEHAVIOUR
#==============================================================================
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[2~" quoted-insert
bindkey "\e[3~" delete-char

#==============================================================================
# FZF
#==============================================================================
export FZF_HOME="$HOME/.fzf.git/"
export PATH="$FZF_HOME/bin:$PATH"
source "$FZF_HOME/shell/completion.zsh"
source "$FZF_HOME/shell/key-bindings.zsh"

#==============================================================================
# FASD
#==============================================================================
# Enable everything but zsh-hook
eval "$(fasd --init posix-alias)"

_fasd_preexec() {
    { eval "fasd --proc \$(fasd --sanitize \$2)"; } &|
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _fasd_preexec

cd ()
{
    if [[ $# -eq 0 \
       || -e "$@" \
       || $@ == "-" ]]; then
        builtin cd "$@"
    else
        local dir
        dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && \
        cd "${dir}"
    fi
}

v() {
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && \
    $EDITOR "${file}" || return 1
}

#==============================================================================
# COREUTILS ALIASES
#==============================================================================
alias ..="cd .."
alias ls="ls --color=auto"
alias l="ls -alh"
alias rcp="cp -rv"
alias rrm="rm -rf"
alias grep="grep -iEn --color=auto"
alias ff="find | grep"

#==============================================================================
# GIT ALIASES
#==============================================================================
alias gco="git commit -am"
alias gca="git commit --amend"
alias gcl="git clean -fd"
alias gch="git checkout"
alias glo="git log --stat=200,100"
alias gls="git ls-files"
alias gdi="git difftool"
alias gdn="git diff --name-only"
alias gnd="git -c \"diff.tool=vimnodiff\" difftool"
alias gst="git status"
alias gbr="git branch"
alias grm="git rebase master"

#==============================================================================
# GLOBAL ALIASES
#==============================================================================
alias -g ¬H="head"
alias -g ¬T="tail"
alias -g ¬C="cat"
alias -g ¬G="grep"

#==============================================================================
# APPLICATION ALIASES/FUNCTIONS
#==============================================================================
alias vi="vim -O"
alias vd="vimdiff"
