mkdir -p "$HOME/.cache"

# 1. Repo (Auto-cached, checks for FZF)
[[ -x "$(command -v repo)" ]] && {
	REPO_CACHE="$HOME/.cache/repo_init_bash.sh"

	if [[ ! -f "$REPO_CACHE" ]]; then
		if [ -x "$(command -v fzf)" ]; then
			repo init bash --fzf >"$REPO_CACHE"
		else
			repo init bash >"$REPO_CACHE"
		fi
	fi

	# shellcheck disable=SC1090
	source "$REPO_CACHE"
	unset REPO_CACHE
}

# 2. Zoxide (Auto-cached)
[[ -x "$(command -v zoxide)" ]] && {
	export _ZO_DATA_DIR="$HOME/.cache/zoxide"
	[[ -d "$_ZO_DATA_DIR" ]] || mkdir -p "$_ZO_DATA_DIR"

	ZOXIDE_CACHE_BASH="$HOME/.cache/zoxide_init_bash.sh"

	[[ ! -f "$ZOXIDE_CACHE_BASH" ]] && zoxide init --cmd cd bash >"$ZOXIDE_CACHE_BASH"
	# shellcheck disable=SC1090
	source "$ZOXIDE_CACHE_BASH"
	unset ZOXIDE_CACHE_BASH
}

# 3. Atuin (Auto-cached and fixed to 'bash' instead of 'zsh')
[[ -x "$(command -v atuin)" ]] && {
	ATUIN_CACHE_BASH="$HOME/.cache/atuin_init_bash.sh"

	[[ ! -f "$ATUIN_CACHE_BASH" ]] && atuin init bash >"$ATUIN_CACHE_BASH"
	# shellcheck disable=SC1090
	source "$ATUIN_CACHE_BASH"
	unset ATUIN_CACHE_BASH
}
