#!/usr/bin/env bash

# if sccache is installed add that as a rustc wrapper
[[ -x "$(command -v sccache)" ]] && {
    # export RUSTC_WRAPPER="sccache"
    export SCCACHE_DIR="$HOME/.cache/sccache"
}

# if zoxide is insatlled then source helper scripts
[[ -x "$(command -v zoxide)" ]] && {
    export _ZO_DATA="$HOME/.cache/zoxide/data"
    mkdir -p "$HOME/.cache/zoxide"
}

# if git-delta is installed then use this as the git pager
[[ -n "$(command -v delta)" ]] && {
    export GIT_PAGER="delta --dark"
} || {
    export GIT_PAGER="less"
}

[[ -x "$(command -v wt)" ]] && eval "$(wt source)"

[[ -n "$(command fuck)" ]] &&  eval "$(thefuck --alias)"

[[ -x "$(command -v nvm)" ]] && {
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

[[ -x "$(command -v pyenv)" ]] && {
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
}
