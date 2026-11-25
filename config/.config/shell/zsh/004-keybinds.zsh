
bindkey -s '^f' 'tm\n'
bindkey -s '^b' 'tm -e\n'
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;3C' forward-word # Option-right-arrow
bindkey '^[[1;3D' backward-word # Option-left-arrow

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Use vim key in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# zsh-vi-mode resets keymaps on init, so bind backspace after it has finished.
# (The old `bindkey -v '^?' ...` just selected the viins keymap and bound nothing.)
function zvm_after_init() {
  bindkey -M viins '^?' backward-delete-char
}

# change word selection to exclude slashes
autoload -U select-word-style
select-word-style bash

# Edit line in vim with ctrl-v
autoload -Uz edit-command-line;
zle -N edit-command-line
bindkey '^v' edit-command-line

# Copy pwd to system clipboard by ctrl-y
function copypwd {
  print -rn -- "$PWD" | pbcopy
}
zle -N copypwd
bindkey '^y' copypwd

# Y in visual mode will copy to system clipboard (same in vim)
function vi-yank-systemclipboard {
  zle vi-yank
  echo "$CUTBUFFER" | pbcopy -i
}
zle -N vi-yank-systemclipboard
bindkey -M vicmd 'Y' vi-yank-systemclipboard
