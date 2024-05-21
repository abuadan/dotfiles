HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/history"
mkdir -p $(dirname "$HISTFILE")

# https://www.commandlinux.com/man-page/man1/zshoptions.1.html
setopt   HIST_FCNTL_LOCK        # Better file lock call with histfile
setopt   HIST_IGNORE_DUPS       # Ignore command if duplicate of prev event
setopt   HIST_IGNORE_SPACE      # Ignore command if starts with a space
setopt   HIST_IGNORE_ALL_DUPS    # Ignore all duplicates
setopt   HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first
setopt   SHARE_HISTORY          # Share history between zsh sessions
setopt   HIST_SAVE_NO_DUPS
unsetopt EXTENDED_HISTORY       # Make sure no timestamps in histfile

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# Ignore case completion for zsh
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

