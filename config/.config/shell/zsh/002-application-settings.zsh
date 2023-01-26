# if repo is installed then soure the work script
[[ -x "$(command -v repo)" ]] && {
    [ -x "$(command -v fzf)" ] && eval "$(repo init zsh --fzf)" || eval "$(repo init zsh)"
}

# if zoxide is installed then source helper scripts
[[ -x "$(command -v zoxide)" ]] && {
    eval "$(zoxide init zsh)"
}

# [[ -x "$(command -v fuck)" ]] & {
# 	eval "$(thefuck --alias)"
# }

[[ -x "$(command -v pyenv)" ]] && {
	export PATH="$PYENV_ROOT/bin:$PATH"
    	eval "$(pyenv init - && pyenv virtualenv-init -)"
}

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
