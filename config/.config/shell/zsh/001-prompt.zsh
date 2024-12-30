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
if [[ $PROMPT = "ohmyposh" ]]; then
	export OHMYPOSH_CONFIG=${XGD_CONFIG_HOME:-$HOME/.config}/ohmyposh/config.toml
	[[ -x "$(command -v ohmyposh)" ]] && {
		eval "$(ohmyposh init zsh)"
	}
fi
