#!/usr/bin/env bash

set +e


############ Source files to help provide   ############
############ better echo and path to config ############
############        files repo              ############

DIR="$( cd -- "$(dirname "$0")" || exit >/dev/null 2>&1 ; pwd -P )"

. "$DIR/../utils/pretty_echo.sh" --source-only
. "$DIR/../utils/dotfiles_home.sh" --source-only
