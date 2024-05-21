HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache/zsh}/history"
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

zstyle ':fzf-tab:*' popup-min-size 50 30
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# Ignore case completion for zsh
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

