#!/bin/env bash

set +ex

SCRIPT=$(realpath -s "$0")
DIR=$(dirname "$SCRIPT")

. "$DIR/setup/utils/pretty_echo.sh" --source-only
. "$DIR/setup/utils/dotfiles_home.sh" --source-only

common_setup() {

	for entry in "$DOTFILES/setup/common"/*
	do
		if test -f "$entry"; then
			info "found $entry"
		fi
	done
}

usage() {
	info ""
}


common_setup
# if [[ "$(uname)" == "Darwin" ]]; then
# 	./setup/macos/install.sh
# fi
echo -e
success "Done."
