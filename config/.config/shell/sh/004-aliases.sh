#!/usr/bin/env bash

# directories
# alias cd='z'
alias ..='cd ..'
alias cd..='cd ..'
alias ~="cd ~"

# quick shortcuts
alias c=cargo
alias e='$EDITOR'
alias g=git
alias j=just
alias m=make
alias t=tm
alias v=vim

# alias cb='cargo b'
# alias cc='cargo c'
# alias ccp='cargo +nightly clippy -- -D warnings'
# alias cf='cargo +nightly fmt --all'
# alias cl="cargo clean"
# alias cr='cargo r'
# alias ct='cargo t'
# alias cm=cmake

alias psake='powershell -c Invoke-Psake'

# default command flags
alias ca=cat
[[ -n "$(command -v bat)" ]] && alias cat=bat
alias df="df -Tha --total"
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias pgrep='pgrep -l'

# git shortcuts
alias ga="git add"
alias gc="git commit --verbose"
alias gs="git status -s"

# source rc file for your shell
[[ $SHELL =~ /bash$ ]] && alias src='source $HOME/.bashrc'
[[ $SHELL =~ /zsh$ ]] && alias src='source $HOME/.config/zsh/.zshrc'

# if eza is installed use that for ls
if test "$(command -v eza)"; then
	alias l="eza --group-directories-first --icons --color=auto --git -an"
	alias ls="eza --group-directories-first --icons --color=always --git -lan --header"
	alias ll="eza --group-directories-first --icons --color=auto --git -lan"
	alias lll="eza --group-directories-first --icons --color=auto --git -ln"
else
	# have to check if we are on a bsd system (cough, cough... mac) as
	# it does not have color mode because of course...
	[[ -n "$(command ls --color=auto)" ]] && ls_color='--color=always --group-directories-first'
	alias l='ls -ahCF $ls_color'
	alias ls='ls -hCFG $ls_color'
	alias ll='ls -alh $ls_color'
	alias lll='ls -lh $ls_color'
	unset ls_color
fi

if test "$(command -v lazydocker)"; then
	alias lzd='lazydocker'
fi

if test "$(command -v lazygit)"; then
	alias lzg='lazygit'
fi

[[ -x "$(command -v pacman)" ]] && {
	alias mirror='sudo reflector --protocol https --latest 50 --number 20 --sort rate --save /etc/pacman.d/mirrorlist'
	alias pacman="sudo pacman --color auto"
	alias paclist="comm -23 <(pacman -Qqett | sort) <(pacman -Qqg -g base-devel | sort | uniq)"
}

########################## FZF ALIAS ##########################
alias fzfs="fzf --preview 'bat --style numbers,changes --color=always {} | head -500'"

if test "$(command -v rg)"; then
	alias rgf="rg --files --hidden | fzf --preview 'bat --style numbers,changes --color=always {} | head -500'"
fi

########################## TMUX ALIAS ##########################
alias tmux="tmux -u"
alias tls="tmux ls"
alias ta="tmux attach-session -t"

unalias z 2>/dev/null
