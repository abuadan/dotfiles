#!/usr/bin/env bash

function contains_path() {
	# https://stackoverflow.com/a/1397020
	[[ ":$PATH:" == *":$1:"* ]] && return 0 || return 1
}

function append_path() {
	contains_path "$1" || {
		[[ -z $PATH ]] && PATH="$1" || PATH="$PATH:$1"
	}
}

function prepend_path() {
	contains_path "$1" || {
		[[ -z $PATH ]] && PATH="$1" || PATH="$1:$PATH"
	}
}

function main() {
	# save default path and clear path variable
	local system_path="$PATH"
	PATH=

	# if local_bin is defined then add all folders to path
	[[ -d $LOCAL_BIN ]] && {
		for dir in "$LOCAL_BIN/*" "$LOCAL_BIN"; do
			[[ -d "$dir" ]] && prepend_path "$dir"
		done
	}

	append_path "$XDG_CONFIG_HOME/git/bin"
	append_path "$XDG_CONFIG_HOME/fzf/bin"
	append_path "$XDG_DATA_HOME/sbin"
	append_path "$XDG_DATA_HOME/cargo/bin"
	append_path "$XDG_DATA_HOME/.cargo/bin"
	append_path "$XDG_DATA_HOME/poetry/bin"
	# this is a bit annoying since brew is not in the path yet
	# so we need to use full path
	append_path "/opt/homebrew/bin"
	append_path "/opt/homebrew/sbin"
	append_path "/opt/homebrew/opt/llvm/bin"
	append_path "/opt/homebrew/opt/openjdk/bin"
	append_path "/opt/homebrew/opt/ruby/bin"
	append_path "/opt/homebrew/lib/ruby/gems/3.3.0/bin"

	# adding system path back
	# Ending solution from https://stackoverflow.com/a/15988793
	while [ "$system_path" ]; do
		iter=${system_path%%:*}
		append_path "$iter"
		# If one element is left then set system_path to empty else delete the first element and loop again
		[ "$system_path" = "$iter" ] && system_path='' || system_path="${system_path#*:}"
	done

	export PATH=$PATH
}

main

unset contains_path
unset prepend_path
unset append_path
unset main
