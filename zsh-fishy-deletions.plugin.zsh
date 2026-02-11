# zsh-fishy-deletions
# https://github.com/OneNoted/zsh-fishy-deletions
# License: MIT

# --- Configuration ---

: ${ZSH_FISHY_WORD_CHARS_EXCLUDE:="\/=&;!#%^(){}<>"}

# --- Fish-like Word Deletion ---

_fishy_backward_kill_word() {
    emulate -L zsh
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

# --- Fish-like Directory Navigation ---

setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT PUSHD_TO_HOME

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

dirh() { dirs -v; }

_fishy_prevd() {
    prevd
    zle reset-prompt
}
zle -N _fishy_prevd

_fishy_nextd() {
    nextd
    zle reset-prompt
}
zle -N _fishy_nextd

# --- Key Bindings ---

if [[ -z "$ZSH_FISHY_NO_BINDINGS" ]]; then
    # Word deletion
    bindkey '^W'       _fishy_backward_kill_word  # Ctrl+W
    bindkey '^[^?'     _fishy_backward_kill_word  # Alt+Backspace
    bindkey '^[d'      _fishy_kill_word           # Alt+D
    bindkey '^[[3;3~'  _fishy_kill_word           # Alt+Delete

    # Directory navigation
    bindkey '^[[1;3D'  _fishy_prevd               # Alt+Left
    bindkey '^[[1;3C'  _fishy_nextd               # Alt+Right
    bindkey '^[^[[D'   _fishy_prevd               # Alt+Left  (alternate)
    bindkey '^[^[[C'   _fishy_nextd               # Alt+Right (alternate)
fi
