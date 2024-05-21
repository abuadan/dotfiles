#!/usr/bin/env bash

# repo config path defineds
export REPO_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/repo"
export REPO_LOCAL_PATH="${XDG_DATA_HOME:-$HOME/.config}/share/repo"

# Move vim into $HOME/.config/vim
# export VIMINIT='let $MYVIMRC="${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc" | source $MYVIMRC'
# export VIMDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/vim"

# make yadm conform to $XDG_* paths
export YADM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/yadm"

export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship.toml"

export PYENV_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/pyenv"

export POETRY_HOME="${XDG_DATA_HOME:-$HOME/.config}/poetry"
export POETRY_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/pypoetry"
export POETRY_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/pypoetry"
export POETRY_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/pypoetry"

# GO config
export GOROOT=/usr/local/go
export GOPATH="$(brew --prefix)/bin/go"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/.ripgreprc"

# Javascript nonsense
# export NVM_DIR="$([ -z "${{XDG_CONFIG_HOME:-$HOME/.config}:-$HOME/.config/}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvm"
export VOLTA_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Rust Cargo
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo/"
