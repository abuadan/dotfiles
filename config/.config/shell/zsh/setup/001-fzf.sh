#!/usr/bin/env bash

[[ -x "$(command -v brew)" ]] && {
	# setup fzf
	[[ -x "$(command -v fzf)" ]] && {
		"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
	}
}
