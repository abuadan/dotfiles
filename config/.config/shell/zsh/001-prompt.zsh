# Setup prompt to use

if [[ $PROMPT = "starship" ]]; then
	export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
	[ -x "$(command -v starship)" ] && {
	    eval "$(starship init zsh)"
	}
else
	export ZSH_THEME="powerlevel10k/powerlevel10k"
fi
