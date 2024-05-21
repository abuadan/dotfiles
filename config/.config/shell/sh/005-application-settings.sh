#!/usr/bin/env bash

if test "$(command -v sscache)"; then
	export RUSTC_WRAPPER="sccache"
	export SCCACHE_DIR="$HOME/.cache/sccache"
fi

if test "$(command -v zoxide)"; then
	export _ZO_DATA="$HOME/.cache/zoxide/data"
	mkdir -p "$HOME/.cache/zoxide"
fi

if test "$(command -v delta)"; then
	export GIT_PAGER="delta --dark"
else
	export GIT_PAGER="less"
fi

if test "$(command -v wt)"; then
	eval "$(wt source)"
fi
