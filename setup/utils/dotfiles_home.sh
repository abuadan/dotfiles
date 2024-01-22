#!/usr/bin/env bash

DOTFILES="$(
	cd -- "$(dirname "$2")" || exit >/dev/null 2>&1
	pwd -P
)"

echo "Dotfiles directory; $DOTFILES"
