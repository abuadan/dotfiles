#!/usr/bin/env bash

set +e

############ Source files to help provide   ############
############ better echo and path to config ############
############ files repo                     ############

DIR="$(
	cd -- "$(dirname "$0")" || exit >/dev/null 2>&1
	pwd -P
)"

. "$DIR/../utils/pretty_echo.sh" --source-only
. "$DIR/../utils/dotfiles_home.sh" --source-only

title "Configuring terminfo"
title "$DOTFILES"

info "adding tmux.terminfo"
tic -x "$DOTFILES/config/.config/resources/tmux.terminfo"

info "adding xterm-256color-italic.terminfo"
tic -x "$DOTFILES/config/.config/resources/xterm-256color-italic.terminfo"
