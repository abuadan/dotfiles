# Setup prompt to use

if [[ $PROMPT = "starship" ]]; then
	export STARSHIP_CONFIG=${XGD_CONFIG_HOME:-$HOME/.config}/starship/starship.toml
	if [[ ! -d  "${XDG_CACHE_HOME:-$HOME/.cache}/.starship" ]]; then
		mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/.starship"
	fi
	export STARSHIP_CACHE=${XDG_CACHE_HOME:-$HOME/.cache}/.starship/cache
	[[ -x "$(command -v starship)" ]] && {
	    eval "$(starship init zsh)"
	}
fi
if [[ $PROMPT = "oh-my-posh" ]]; then
	export OHMYPOSH_CONFIG=${XGD_CONFIG_HOME:-$HOME/.config}/oh-my-posh/powerlevel10k_rainbow.toml
	[[ -x "$(command -v oh-my-posh)" ]] && {
		eval "$(oh-my-posh init zsh --config $OHMYPOSH_CONFIG)"
	}
fi
