#!/usr/bin/env bash


SCRIPT=$(realpath -s "$0")
DOTFILES=$(dirname "$SCRIPT")

# Another approch to getting dotfiles dir
# DOTFILES="$(cd -- "$(dirname "$0")" || exit >/dev/null 2>&1 ; pwd -P)"

echo "Dotfiles directory; $DOTFILES"
