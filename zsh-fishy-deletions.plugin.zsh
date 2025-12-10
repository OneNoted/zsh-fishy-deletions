# zsh-fishy-deletions
# https://github.com/OneNoted/zsh-fishy-deletions
# License: MIT

# Configuration


: ${ZSH_FISHY_WORD_CHARS_EXCLUDE:="\/=&;!#%^(){}<>"}


# Fish-like Word Deletion


_fishy_backward_kill_word() {
    emulate -L zsh
    # Remove specified chars from WORDCHARS to stop deletion at them
    local WORDCHARS=${WORDCHARS//[$ZSH_FISHY_WORD_CHARS_EXCLUDE]/}
    zle backward-kill-word
}
zle -N _fishy_backward_kill_word

_fishy_kill_word() {
    emulate -L zsh
    local WORDCHARS=${WORDCHARS//[$ZSH_FISHY_WORD_CHARS_EXCLUDE]/}
    zle kill-word
}
zle -N _fishy_kill_word


# Fish-like Directory Navigation


setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME


prevd() {
    emulate -L zsh
    if [[ ${#dirstack} -gt 0 ]]; then
        pushd -q +1
    else
        echo "No previous directory"
    fi
}


nextd() {
    emulate -L zsh
    if [[ ${#dirstack} -gt 0 ]]; then
        pushd -q -0
    else
        echo "No next directory"
    fi
}


dirh() {
    dirs -v
}


# Key Bindings


if [[ -z "$ZSH_FISHY_NO_BINDINGS" ]]; then


    bindkey '^W'       _fishy_backward_kill_word    # Ctrl+W
    bindkey '^[^?'     _fishy_backward_kill_word    # Alt+Backspace
    bindkey '^[d'      _fishy_kill_word             # Alt+D
    bindkey '^[[3;3~'  _fishy_kill_word             # Alt+Delete


 
    bindkey '^[[1;3D' prevd  # Alt+Left
    bindkey '^[[1;3C' nextd  # Alt+Right

  
    bindkey '^[^[[D'  prevd  # Alt+Left
    bindkey '^[^[[C'  nextd  # Alt+Right
fi
