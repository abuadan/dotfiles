
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

if [[ $PROMPT = "starship" ]]; then
	[ -x "$(command -v starship)" ] && {
	    eval "$(starship init zsh)"
	}
else
	export ZSH_THEME="powerlevel10k/powerlevel10k"

	(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"
	# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
	# Initialization code that may require console input (password prompts, [y/n]
	# confirmations, etc.) must go above this block; everything else may go below.
	if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
	fi

	(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"
fi
