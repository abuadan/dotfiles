
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
if [ $PROMPT=="starship" ]; then
	[ -x"$(command -v starship)" ] && {
	    eval "$(starship init zsh)"
	}
fi

export ZSH_THEME="powerlevel10k/powerlevel10k"

