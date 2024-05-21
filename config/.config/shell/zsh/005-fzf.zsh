#!/usr/bin/env bash

# export FZF_BASE="/opt/homebrew/bin/fzf"

# Setup fzf
# ---------
[ -f ~/.fzf.zsh ] && eval "$(fzf --zsh)"

if [[ -x $(command -v fzf) ]]; then
		eval "$(fzf --zsh)"
		source $(brew --prefix)/opt/fzf/shell/completion.zsh
		source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
		export FZF_BASE="$(brew --prefix)"/bin/fzf

fi


# FZF Git
if [[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/fzf/fzf-git.sh" ]]; then
	source "${XDG_DATA_HOME:-$HOME/.local/share}/fzf/fzf-git.sh"
fi

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

# remove -L of fzf default command
# export FZF_DEFAULT_COMMAND="find . -mindepth 1 -path '*/\.*\' -prune -o -type f -print -o -type l -print 2> /dev/null | cut -b3-"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}"/fzf/fzf-git.sh ] && source "${XDG_DATA_HOME:-$HOME/.local/share}"/fzf/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --icons --color=always --git -a {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --icons --tree --color=always --git -a {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
		cd)           fzf --preview 'eza --icons --tree --color=always --git -a {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/functions.sh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/functions.sh

# vim ft=sh
