#!/usr/bin/env bash

set +e


############ Source files to help provide   ############
############ better echo and path to config ############
############ files repo                     ############

DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P || exit )"

. "$DIR/../utils/pretty_echo.sh" --source-only

title "Running brew setup"
info "checking if brew binary is present."

if test ! "$(command -v brew)"; then
	warning "brew binary not found, installing brew;"
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
fi

info "brew installed, setting up packages and casks"
brew bundle --file "$DIR/utils/Brewfile"

# install fzf
echo -e
info "Installing fzf"
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

info "Successfully setup brew"
