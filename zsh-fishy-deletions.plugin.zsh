# zsh-fishy-deletions
# https://github.com/OneNoted/zsh-fishy-deletions
# License: MIT

# --- Configuration ---

# Characters excluded from path-component deletion (Ctrl+W).
# Matches Fish's backward-kill-path-component: stops at / = { } , ' " : @ | ; < > &
: ${ZSH_FISHY_PATH_CHARS_EXCLUDE:="\/=&;{}<>"}

# --- Path Component Deletion (Ctrl+W / Alt+Backspace) ---
# Fish's backward-kill-path-component: removes back to the previous path
# separator. Treats foo-bar.txt as one unit, but stops at /.

_fishy_backward_kill_path() {
    emulate -L zsh
    local WORDCHARS=${WORDCHARS//[$ZSH_FISHY_PATH_CHARS_EXCLUDE]/}
    zle backward-kill-word
}
zle -N _fishy_backward_kill_path

# --- Word Deletion (Alt+D / Alt+Delete) ---
# Fish's kill-word: uses alphanumeric word boundaries.

_fishy_kill_word() {
    emulate -L zsh
    local WORDCHARS=
    zle kill-word
}
zle -N _fishy_kill_word

# --- Word Movement (Alt+F / Alt+B) ---
# Fish's forward-word / backward-word: same alphanumeric boundaries.

_fishy_forward_word() {
    emulate -L zsh
    local WORDCHARS=
    zle forward-word
}
zle -N _fishy_forward_word

_fishy_backward_word() {
    emulate -L zsh
    local WORDCHARS=
    zle backward-word
}
zle -N _fishy_backward_word

# --- Directory Navigation ---

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

# --- Alt+Left / Alt+Right (dual behavior) ---
# Fish's prevd-or-backward-word / nextd-or-forward-word:
# word movement when the line has content, directory navigation when empty.

_fishy_prevd_or_backward_word() {
    if [[ -z "$BUFFER" ]]; then
        prevd
        zle reset-prompt
    else
        local WORDCHARS=
        zle backward-word
    fi
}
zle -N _fishy_prevd_or_backward_word

_fishy_nextd_or_forward_word() {
    if [[ -z "$BUFFER" ]]; then
        nextd
        zle reset-prompt
    else
        local WORDCHARS=
        zle forward-word
    fi
}
zle -N _fishy_nextd_or_forward_word

# --- Key Bindings ---

if [[ -z "$ZSH_FISHY_NO_BINDINGS" ]]; then
    # Path-component deletion
    bindkey '^W'       _fishy_backward_kill_path        # Ctrl+W
    bindkey '^[^?'     _fishy_backward_kill_path        # Alt+Backspace

    # Word deletion
    bindkey '^[d'      _fishy_kill_word                 # Alt+D
    bindkey '^[[3;3~'  _fishy_kill_word                 # Alt+Delete

    # Word movement
    bindkey '^[f'      _fishy_forward_word              # Alt+F
    bindkey '^[b'      _fishy_backward_word             # Alt+B

    # Directory navigation / word movement (context-sensitive)
    bindkey '^[[1;3D'  _fishy_prevd_or_backward_word    # Alt+Left
    bindkey '^[[1;3C'  _fishy_nextd_or_forward_word     # Alt+Right
    bindkey '^[^[[D'   _fishy_prevd_or_backward_word    # Alt+Left  (alternate)
    bindkey '^[^[[C'   _fishy_nextd_or_forward_word     # Alt+Right (alternate)
fi
