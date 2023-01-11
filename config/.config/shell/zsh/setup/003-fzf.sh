#!/usr/bin/env bash 

# setup fzf 
[[ -x "$(command -v fzf)" ]] && {
    $(brew --prefix)/opt/fzf/install
}