#!/usr/bin/env bash

set +e


DIR="$(dirname "$0")"

. "$DIR/utils/pretty_echo.sh" --source-only
. "$DIR/utils/dotfiles_home.sh" --source-only

find -H "$DOTFILES" -maxdepth 3 -name '*.symlink'
