#!/usr/bin/env bash

if command -v sccache >/dev/null 2>&1; then
	export RUSTC_WRAPPER="sccache"
	export SCCACHE_DIR="$HOME/.cache/sccache"
fi

if command -v delta >/dev/null 2>&1; then
	export GIT_PAGER="delta --dark"
else
	export GIT_PAGER="less"
fi

if command -v wt >/dev/null 2>&1; then
	# Cached per shell; regenerated when the wt binary is newer than the cache.
	_wt_shell="${ZSH_VERSION:+zsh}"
	_wt_cache="$HOME/.cache/wt_source.${_wt_shell:-sh}"
	if [ ! -f "$_wt_cache" ] || [ "$(command -v wt)" -nt "$_wt_cache" ]; then
		wt source >"$_wt_cache"
	fi
	# shellcheck disable=SC1090
	. "$_wt_cache"
	unset _wt_shell _wt_cache
fi
