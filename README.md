# zsh-fishy-deletions

A Zsh plugin that replicates Fish shell's word deletion, word movement, and directory navigation — matching Fish's per-operation boundary rules.

> **Note:** The word deletion part of this plugin can be approximated by setting `WORDCHARS` globally in your `.zshrc`. However, Fish actually uses *different* word boundaries for different operations (path-component deletion vs. alphanumeric word movement), and this plugin replicates that distinction. It also bundles directory navigation and the dual-behavior `Alt+Left`/`Alt+Right`.

## Features

### Path Component Deletion (`Ctrl+W` / `Alt+Backspace`)

Matches Fish's `backward-kill-path-component`. Removes back to the previous path separator, treating filenames like `foo-bar.txt` as a single unit:

- Stops at path separators (`/`) and shell syntax characters (`=`, `&`, `;`, `{`, `}`, `<`, `>`)
- Preserves dots (`.`), hyphens (`-`), and other filename characters

### Word Deletion (`Alt+D` / `Alt+Delete`)

Matches Fish's `kill-word`. Uses strict alphanumeric word boundaries — stops at `-`, `.`, `/`, and all other non-alphanumeric characters.

### Word Movement (`Alt+F` / `Alt+B`)

Matches Fish's `forward-word` / `backward-word`. Same alphanumeric boundaries as word deletion.

### Directory Navigation / Word Movement (`Alt+Left` / `Alt+Right`)

Matches Fish's `prevd-or-backward-word` / `nextd-or-forward-word` — context-sensitive:

- **Line has content:** moves cursor by word (alphanumeric boundaries)
- **Line is empty:** navigates directory history

| Command | Description |
|---------|-------------|
| `prevd` | Go to the previous directory |
| `nextd` | Go to the next directory |
| `dirh` | Print directory history |

## Installation

### [Zinit](https://github.com/zdharma-continuum/zinit)

```zsh
zinit load OneNoted/zsh-fishy-deletions
```

### Manual

Source the plugin file in your `.zshrc`:

```zsh
source /path/to/zsh-fishy-deletions.plugin.zsh
```

## Configuration

Set these variables **before** loading the plugin.

### Disable Default Keybindings

```zsh
export ZSH_FISHY_NO_BINDINGS=1
```

Then bind the widgets yourself:

```zsh
# Path-component deletion
bindkey '^W'       _fishy_backward_kill_path
bindkey '^[^?'     _fishy_backward_kill_path

# Word deletion
bindkey '^[d'      _fishy_kill_word
bindkey '^[[3;3~'  _fishy_kill_word

# Word movement
bindkey '^[f'      _fishy_forward_word
bindkey '^[b'      _fishy_backward_word

# Directory navigation / word movement
bindkey '^[[1;3D'  _fishy_prevd_or_backward_word
bindkey '^[[1;3C'  _fishy_nextd_or_forward_word
```

### Custom Path Separators

Override which characters stop path-component deletion (default: `\/=&;{}<>`):

```zsh
export ZSH_FISHY_PATH_CHARS_EXCLUDE="\/=&;"
```

## Related Plugins

Other plugins that bring Fish-like behavior to Zsh:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) — ghost text suggestions
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) — syntax coloring as you type
- [zsh-abbr](https://github.com/olets/zsh-abbr) — Fish-style abbreviations
- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) / [atuin](https://github.com/atuinsh/atuin) — history substring search

## License

MIT
