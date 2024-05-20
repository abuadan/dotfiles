#!/bin/env bash

set +ex

SCRIPT=$(realpath "$0")
DIR=$(dirname "$SCRIPT")

. "$DIR/setup/utils/pretty_echo.sh" --source-only
. "$DIR/setup/utils/dotfiles_home.sh" --source-only

info "Need to update recurive git submodules"
git submodule update --init --remote --recursive

common_setup() {

	for entry in "$DOTFILES/setup/common"/*; do
		if test -f "$entry"; then
			info "found $entry"
		fi
	done
}

usage() {
	info ""
}

darwin_setup() {

	info "Setup dot files linked to home directory"
	chmod +x config/.config/zsh/setup.sh
	config/.config/zsh/setup.sh

	info "Link all folders/files assoisated with .config folder"
	ln -sf "$DIR"/config/.config "$HOME"/.config

	warning "Installing OH my zsh"
	chmod +x config/.config/shell/zsh/setup/001-install-ohmyzsh
	chmod +x config/.config/shell/zsh/setup/005-p10k.sh

	config/.config/shell/zsh/setup/001-install-ohmyzsh
	config/.config/shell/zsh/setup/005-p10k.sh

	info "setting up darwin settings"
	chmod +x setup/macos/brew
	chmod +x setup/macos/settings

	setup/macos/settings
	setup/macos/brew

	info "Update terminal settings"
	chmod +x setup/terminal/terminfo.sh
	setup/terminal/terminfo.sh

}

common_setup
if [[ "$(uname)" == "Darwin" ]]; then
	darwin_setup
fi

echo -e
success "Done."
