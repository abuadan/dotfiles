#!/usr/bin/env bash

export ZDOTDIR="$HOME/.config/zsh"

if test ! "$(command -v nvm)"; then
	echo "nvm not installed, running installation"
	sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)"
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh --no-use" ] && \. "$NVM_DIR/nvm.sh --no-use" # This loads nvm
