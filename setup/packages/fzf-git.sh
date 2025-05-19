#!/bin/env bash

set +ex

SCRIPT=$(realpath "$0")
DIR=$(dirname "$SCRIPT")

. "$DIR/../../setup/utils/pretty_echo.sh" --source-only
. "$DIR/../../setup/utils/dotfiles_home.sh" --source-only

if test "$(command -v fzf)"; then
	info "fzf installed, checking for fzf-git"
	if ! [ -f "${XDG_DATA_HOME:-$HOME/.local/share}"/fzf/fzf-git.sh ]; then
		info "Cloning fzf git."
		git clone https://github.com/junegunn/fzf-git.sh.git "${XDG_DATA_HOME:-$HOME/.local/share}"/fzf/
	fi
	echo -e
	success "Done."

else
	echo -e
	error "Fzf not installed "
fi
