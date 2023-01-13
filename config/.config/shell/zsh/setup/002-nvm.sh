#!/usr/bin/env bash

export ZDOTDIR="$HOME/.config/zsh"

if test ! "$(command -v nvm)"; then
	echo "nvm not installed, running installation"
	sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)"
fi

# Export nvm completion settings for zsh-nvm plugin
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim' 'nvim')
