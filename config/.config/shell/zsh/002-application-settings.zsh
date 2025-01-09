# if zoxide is installed then source helper scripts
[[ -x "$(command -v zoxide)" ]] && {
		eval "$(zoxide init --cmd cd zsh)"
}

[[ -x "$(command -v fuck)" ]] && {
	eval "$(thefuck --alias)"
}

[[ -x "$(command -v pyenv)" ]] && {
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init - && pyenv virtualenv-init -)"
}

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# [[ -x "$(command -v atuin)" ]] && {
# 		eval "$(atuin init zsh)"
# }


if [[ -d "$(brew --prefix)"/share/google-cloud-sdk ]]; then
	source "$(brew --prefix)"/share/google-cloud-sdk/completion.zsh.inc
	source "$(brew --prefix)"/share/google-cloud-sdk/path.zsh.inc
fi

