#!/usr/bin/env bash

set +e


############ Source files to help provide   ############
############ better echo and path to config ############
############ files repo                     ############

DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P || exit )"

. "$DIR/utils/pretty_echo.sh" --source-only
. "$DIR/utils/dotfiles_home.sh" --source-only

title "Configuring terminfo"

info "adding tmux.terminfo"
tic -x "$DOTFILES/resources/tmux.terminfo"

info "adding xterm-256color-italic.terminfo"
tic -x "$DOTFILES/resources/xterm-256color-italic.terminfo"
