#!/usr/bin/env bash

if test "$(command -v sscache)"; then
    export RUSTC_WRAPPER="sccache"
    export SCCACHE_DIR="$HOME/.cache/sccache"
fi

if test "$(command -v zoxide)"; then
    export _ZO_DATA="$HOME/.cache/zoxide/data"
    mkdir -p "$HOME/.cache/zoxide"
fi

# if test "$(command -v delta)"; then
#     export GIT_PAGER="delta --dark"
# else
#     export GIT_PAGER="less"
# fi

if test "$(command -v wt)"; then
    eval "$(wt source)"
fi

# if test "$(command -v fuck)"; then
#     eval "$(thefuck --alias)"
# fi

# if test "$(command -v pyenv)"; then
#     eval "$(pyenv init -)"
#     eval "$(pyenv virtualenv-init -)"
# fi

# if test "$(command -v nvm)"; then
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# 	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# fi

# # if sccache is installed add that as a rustc wrapper
# if [ -x "$(command -v sccache)" ]; then
#     # export RUSTC_WRAPPER="sccache"
#     export SCCACHE_DIR="$HOME/.cache/sccache"
# fi

# # if zoxide is insatlled then source helper scripts
# if [ -x "$(command -v zoxide)" ]; then 
#     export _ZO_DATA="$HOME/.cache/zoxide/data"
#     mkdir -p "$HOME/.cache/zoxide"
# fi

# # if git-delta is installed then use this as the git pager
# if [ -n "$(command -v delta)" ]; then 
#     export GIT_PAGER="delta --dark"
# else
#     export GIT_PAGER="less"
# fi

# if [ -x "$(command -v wt)" ]; then 
#     eval "$(wt source)"
# fi 

# if [ -x "$(command fuck)" ]; then 
#  eval "$(thefuck --alias)"
# fi

# if [ -x "$(command -v nvm)" ]; then
# 	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# 	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# fi

# if [ -x "$(command -v pyenv)" ]; then 
#     eval "$(pyenv init -)"
#     eval "$(pyenv virtualenv-init -)"
# fi