# Keybindings

A reference for every custom keybinding configured in this repo, across zsh, tmux, and
neovim. Generated from the live, current config (not just the source files) — tmux bindings
in particular were pulled from a running `tmux list-keys` dump, since plugins register some
of these at runtime.

---

## Shell (zsh)

Config: `config/.config/shell/zsh/004-keybinds.zsh`, `005-fzf.zsh`.

| Key | Action |
|---|---|
| `Ctrl-F` | Launch `tm` (tmux session manager) |
| `Ctrl-B` | Launch `tm -e` |
| `Ctrl-P` | History search backward |
| `Ctrl-N` | History search forward |
| `Option-→` | `forward-word` (accept suggestion word-by-word) |
| `Option-←` | `backward-word` |
| `Ctrl-V` | Edit current command line in `$EDITOR` |
| `Ctrl-Y` | Copy `$PWD` to system clipboard (`copypwd`) |
| `Ctrl-?` (backspace) | `backward-delete-char` |
| `k` / `j` (vicmd, normal mode) | History-substring-search up/down |
| `h`/`j`/`k`/`l` (menu-select, tab-complete) | Vi-style navigation through completion menu |
| `Y` (vicmd, visual mode) | Yank to system clipboard (same as vim's `y` + clipboard) |

zsh-vi-mode provides standard vi modal editing on top of this (`Esc` → normal mode, `i`/`a`/`v`
→ insert/visual, `hjkl` motions, etc.) — not enumerated here since it mirrors vim itself.

### fzf shell integration

| Key | Action |
|---|---|
| `Ctrl-T` | Fuzzy-find a file/dir and insert its path at the cursor |
| `Ctrl-R` | Fuzzy-find shell history |
| `Option-C` | Fuzzy-find a directory and `cd` into it |
| `Ctrl-G` | Unbound (was `list-expand`) — freed so `fzf-git.sh`'s two-key `Ctrl-G` sequences below work |

### fzf-git.sh (`Ctrl-G` + second key)

| Key | Fuzzy-finds |
|---|---|
| `Ctrl-G Ctrl-F` | Files |
| `Ctrl-G Ctrl-B` | Branches |
| `Ctrl-G Ctrl-T` | Tags |
| `Ctrl-G Ctrl-R` | Remotes |
| `Ctrl-G Ctrl-H` | Commit hashes |
| `Ctrl-G Ctrl-S` | Stashes |
| `Ctrl-G Ctrl-L` | Reflogs |
| `Ctrl-G Ctrl-E` | Each ref |
| `Ctrl-G Ctrl-W` | Worktrees |

Selection is inserted at the cursor in the current command line (e.g. `git checkout <Ctrl-G Ctrl-B>`).

---

## tmux

Config: `config/.config/tmux/tmux.conf` (oh-my-tmux base) + `tmux.conf.local` (overrides).
**Prefix key is `Ctrl-A`**, not tmux's default `Ctrl-B`.

### No-prefix (root table) — work immediately, no prefix needed

| Key | Action |
|---|---|
| `Ctrl-H` / `Ctrl-J` / `Ctrl-K` / `Ctrl-L` | Move to pane left/down/up/right — passes through to Vim or fzf if either is running in the target pane, otherwise moves panes |
| `Ctrl-\` | Move to last-used pane (same Vim/fzf passthrough) |
| `Ctrl-M-H` / `Ctrl-M-J` / `Ctrl-M-K` / `Ctrl-M-L` | Swap pane with the one to the left/below/above/right |
| `Option-H` / `Option-J` / `Option-K` / `Option-L` | Resize pane left/down/up/right by 1 cell (passes through to Vim) |
| `Option-F` | Start tmux-fingers (normal mode — pick a visible token to copy) |
| `Option-G` | Start tmux-fingers in jump mode (moved off `Option-F`, which was double-bound; `Option-J` collides with the built-in pane-resize bindings below) |

### Prefix table (`Ctrl-A` then...)

**Windows**
| Key | Action |
|---|---|
| `c` | New window |
| `,` | Rename window |
| `.` | Move window |
| `f` | Find window |
| `n` / `Ctrl-N` | Next window |
| `p` / `Ctrl-P` | Previous window |
| `Ctrl-H` / `Ctrl-L` | Previous/next window (repeatable) |
| `Option-N` / `Option-P` | Next/previous window (including hidden) |
| `Tab` / `a` | Last window |
| `0`–`9` | Jump to window by index |
| `w` | Interactive window tree (`choose-tree`) |
| `&` | Kill window (confirm) |
| `Ctrl-S-H` / `Ctrl-S-L` | Swap window left/right and follow it |

**Panes**
| Key | Action |
|---|---|
| `"` / `-` | Split pane horizontally/vertically (down/right), preserving cwd |
| `%` / `_` | Split pane vertically/horizontally (right/down), preserving cwd |
| `h`/`j`/`k`/`l` or arrow keys | Move pane left/down/up/right (repeatable) |
| `H`/`J`/`K`/`L` (shift) | Resize pane by 2 cells (repeatable) |
| `Option-Up/Down/Left/Right` | Resize pane by 5 cells (repeatable) |
| `Ctrl-Up/Down/Left/Right` | Resize pane by 1 cell (repeatable) |
| `o` | Cycle to next pane |
| `;` | Last-used pane |
| `M` | Marked-pane select |
| `<` / `>` / `{` / `}` | Swap pane up/down |
| `z` | Zoom/unzoom pane |
| `!` | Break pane into its own window |
| `x` | Kill pane (confirm) |
| `q` | Show pane numbers |

**Layout / session**
| Key | Action |
|---|---|
| `Space` | Next layout |
| `Option-1`–`Option-7` | Switch to a specific layout (even-horizontal, tiled, etc.) |
| `E` | Spread current layout across all panes |
| `$` | Rename session |
| `s` | Interactive session tree |
| `(` / `)` | Switch to previous/next session |
| `Ctrl-F` | Find session (prompt) |
| `d` | Detach client |
| `Ctrl-C` | New session |
| `Ctrl-Z` | Suspend client |
| `m` | Toggle mouse mode |
| `t` | Clock mode |
| `T` | Session wizard (fuzzy session/dir picker popup) — needs a genuinely fresh tmux server to register, not just a config reload |

**Copy / paste / clipboard**
| Key | Action |
|---|---|
| `Enter` / `[` / `Esc` | Enter copy mode |
| `]` / `p` | Paste buffer |
| `y` | Copy current line to system clipboard (tmux-yank) |
| `Y` | Copy current pane's pwd to system clipboard (tmux-yank) |
| `=` / `b` / `P` | Buffer list / choose-buffer |

**Fuzzy-picker (tmux-fingers)**
| Key | Action |
|---|---|
| `Ctrl-Y` | Start tmux-fingers (prefixed, moved off `Ctrl-F` which clashed with `find-session`) |
| `J` | Start tmux-fingers in jump mode (the plugin's own default prefix binding — separate from the `Option-F`/`Option-G` root-table bindings above) |

**Utilities**
| Key | Action |
|---|---|
| `F` | Open FPP (Facebook PathPicker) on the current pane's output — an oh-my-tmux built-in, not tmux-fingers |

**Plugin management (TPM)**
| Key | Action |
|---|---|
| `I` | Install plugins |
| `u` | Update plugins |
| `Option-U` | Clean/remove unused plugins |

**Config**
| Key | Action |
|---|---|
| `r` | Reload tmux config |
| `R` | Reload config with a confirmation message |
| `e` | Edit `tmux.conf.local` in `$EDITOR`, then reload |
| `?` | List all keybindings |
| `/` | Look up a specific key's binding |
| `~` | Show tmux messages |
| `C` | Customize-mode (interactive option editor) |
| `D` | Choose-client |

### Copy mode (`copy-mode-vi`) — vi-style, entered via `Enter`/`[`/`Esc`

Standard vim motions apply (`hjkl`, `w`/`b`/`e`, `0`/`$`, `gg`/`G`, `f`/`t`/`F`/`T`, `/`/`?`,
`Ctrl-D`/`Ctrl-U` half-page, `Ctrl-F`/`Ctrl-B` full-page). Notable non-default bindings:

| Key | Action |
|---|---|
| `v` / `Space` | Begin selection |
| `V` | Select line |
| `Ctrl-V` | Toggle rectangle/block selection |
| `y` / `Enter` | Copy selection to system clipboard and exit copy mode (tmux-yank) |
| `Y` | Copy selection and also paste it into the tmux buffer |
| `Ctrl-H`/`Ctrl-J`/`Ctrl-K`/`Ctrl-L` | Move between panes without leaving copy mode |
| `q` / `Esc` | Cancel / exit copy mode |

---

## Neovim

Neovim's own keymap system is extensive (LazyVim defaults + many plugins) — the best live
reference is `:WhichKey` or `:Telescope keymaps` inside nvim itself, not a static doc.
Custom bindings on top of LazyVim's defaults, from `lua/config/keymaps.lua`:

| Key | Action |
|---|---|
| `-` (normal mode) | Open Oil (file explorer) |
| `Tab` (normal mode) | Toggle Oil / close it if already open |

tmux.nvim's own default pane-navigation bindings are explicitly disabled
(`@tmux-nvim-navigation false`) since they duplicated and raced against the tmux
`Ctrl-hjkl` bindings above — use those instead when navigating between nvim splits and
tmux panes.
