# zsh-fishy-deletions

**Make Zsh feel like Fish.**

The Fish shell is great, though, sometimes the lack of POSIX compliance is kinda annoying. I couldn't find any plugins out there that added fish's intuitive line-editing, so I just threw this together. It's super simple and probably suboptimal, but uhh good enough!!

The plugin adds a few features from fish that I really missed: **granular word deletion** and **directory history navigation**. *(that's probably what they're called? Right? Maybe?)*

Combining this with the amazing `zsh-autosuggestions` and `zsh-syntax-highlighting` gets me close enough to what I'm used to to use zsh without having to change my ways.

## Features

### 1. Fish-like Word Deletion (`Ctrl+W` / `Alt+Del`)

In standard Zsh, `Ctrl+W` often deletes entire paths like `~/.config/fish/config.fish`.
**zsh-fishy-deletions** changes this to match Fish's behavior:

* Stops deletion at directory separators (`/`).
* Stops at shell syntax characters (`=`, `&`, `;`, `|`).
* **Preserves** dots (`.`) and hyphens (`-`), so filenames like `my-script.sh` aren't preserved or something.

### 2. Directory Navigation (`Alt+Left` / `Alt+Right`)

Navigate your directory history quicker.

* **`prevd` (Alt+Left):** Go back to the previous directory you were in.
* **`nextd` (Alt+Right):** Go forward again.
* **`dirh`:** View your session's directory history.

## Installation

### [Zinit](https://github.com/zdharma-continuum/zinit)

```zsh
zinit load OneNoted/zsh-fishy-deletions
```

## Configuration

You can customize the behavior by setting these variables **before** loading the plugin.

### Disable Keybindings

If you prefer to map the keys yourself:

```zsh
export ZSH_FISHY_NO_BINDINGS=1
```

### Custom Word Separators

Change which characters stop the deletion cursor.
Default: `\/=&;!#%^(){}<>`

```zsh
export ZSH_FISHY_WORD_CHARS_EXCLUDE="\/=&;" 
```

## Some other fish plugins

1. **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)** (Grey ghost text)
2. **[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)** (Colors as you type)
3. **[zsh-abbr](https://github.com/olets/zsh-abbr)** (Fish-style abbreviations)
4. **[zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)** / **[atuin](https://github.com/atuinsh/atuin)** (Up arrow filters history)

## License

MIT
