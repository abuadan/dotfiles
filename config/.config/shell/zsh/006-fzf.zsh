export FZF_BASE="/opt/homebrew/bin/fzf"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use fd (https://github.com/sharkdp/fd) instead of the default find

# remove -L of fzf default command
# export FZF_DEFAULT_COMMAND="find . -mindepth 1 -path '*/\.*\' -prune -o -type f -print -o -type l -print 2> /dev/null | cut -b3-"
export FZF_DEFAULT_COMMAND='fd --type f'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
