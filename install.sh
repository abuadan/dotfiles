#!/usr/bin/env bash

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
	config/.config/zsh/setup.sh

	# info "Installing OH my zsh and setting up p10k"
	# TODO: Need to install different zsh zimrc and starship prompt and ohmyposh
	# config/.config/shell/zsh/setup/
	# config/.config/shell/zsh/setup/

	info "setting up darwin settings"
	setup/macos/settings
	setup/macos/brew

	info "Install Additional packages outside brew"
	setup/packages/rust.sh

	info "Update terminal settings"
	setup/terminal/terminfo.sh

	info "Initial setup of zsh"
	config/.config/zsh/setup.sh

	info "Link all folders/files assoisated with .config folder"
	ln -sf "$DIR"/config/.config "$HOME"/.config

	info "Link bin folder to $XDG_DATA_HOME"
	ln -sf "$DIR"/bin "$XDG_DATA_HOME"/sbin

	info "Sourcing zshrc file"
	source "$HOME"/.zshrc

}

common_setup
if [[ "$(uname)" == "Darwin" ]]; then
	darwin_setup
fi

echo -e
success "Done."
