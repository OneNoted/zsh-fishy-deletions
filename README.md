# zsh-fishy-deletions

A Zsh plugin that brings Fish shell's word deletion and directory navigation to Zsh.

## Features

### Word Deletion (`Ctrl+W` / `Alt+Backspace` / `Alt+D` / `Alt+Delete`)

Standard Zsh treats entire paths as a single word — `Ctrl+W` on `~/.config/fish/config.fish` deletes the whole thing. This plugin makes deletion granular, matching Fish's behavior:

- Stops at directory separators (`/`)
- Stops at shell syntax characters (`=`, `&`, `;`, `!`, `#`, `%`, `^`, `(`, `)`, `{`, `}`, `<`, `>`)
- Preserves dots (`.`) and hyphens (`-`) within filenames

### Directory Navigation (`Alt+Left` / `Alt+Right`)

Navigate your directory history with keybindings:

| Command | Keybinding | Description |
|---------|------------|-------------|
| `prevd` | `Alt+Left` | Go to the previous directory |
| `nextd` | `Alt+Right` | Go to the next directory |
| `dirh` | — | Print directory history |

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
bindkey '^W' _fishy_backward_kill_word
bindkey '^[d' _fishy_kill_word
bindkey '^[[1;3D' _fishy_prevd
bindkey '^[[1;3C' _fishy_nextd
```

### Custom Word Separators

Override which characters act as word boundaries (default: `\/=&;!#%^(){}<>`):

```zsh
export ZSH_FISHY_WORD_CHARS_EXCLUDE="\/=&;"
```

## Related Plugins

Other plugins that bring Fish-like behavior to Zsh:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) — ghost text suggestions
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) — syntax coloring as you type
- [zsh-abbr](https://github.com/olets/zsh-abbr) — Fish-style abbreviations
- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) / [atuin](https://github.com/atuinsh/atuin) — history substring search

## License

MIT
