
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

if [[ $PROMPT = "starship" ]]; then
	[ -x "$(command -v starship)" ] && {
	    eval "$(starship init zsh)"
	}
else
	# set theme to p10k
	export ZSH_THEME="powerlevel10k/powerlevel10k"
	# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
	[[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh" ]] || source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh"
fi
