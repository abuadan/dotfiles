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
	eval "$(wt source)" # If this is slow, cache it like we do in step 3!
fi
