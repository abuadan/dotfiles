#!/usr/bin/env bash

# repo config path defineds
export REPO_CONFIG_PATH="$XDG_CONFIG_HOME/repo"
export REPO_LOCAL_PATH="$XDG_DATA_HOME/share/repo"

# Move vim into $HOME/.config/vim
# export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# export VIMDOTDIR="$XDG_CONFIG_HOME/vim"

# make yadm conform to $XDG_* paths
export YADM_DIR="$XDG_CONFIG_HOME/yadm"

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

export POETRY_HOME="$XDG_DATA_HOME/poetry"
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"

