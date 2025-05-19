
bindkey -e
bindkey -s '^f' 'tm\n'
bindkey -s '^b' 'tm -e\n'
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey 'ƒ' forward-word  # Option-f
bindkey '∫' backward-word # Option-b

# Use vim key in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# change word selection to exclude slashes
autoload -U select-word-style
select-word-style bash

# Edit line in vim with ctrl-v
autoload -Uz edit-command-line;
zle -N edit-command-line
bindkey '^v' edit-command-line

# Copy pwd to system clipboard by ctrl-y
function copypwd {
  echo $(pwd) | pbcopy
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

