#!/usr/bin/env bash

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

export GPG_TTY="$(tty)"

# editor and vim
[[ -n "$(command -v nvim)" ]] && [[ "$OSTYPE" != 'msys' || -n $IS_ALACRITTY ]] && {
    export EDITOR='nvim'
    export VISUAL='nvim'
} || {
    export EDITOR="vim"
    export VISUAL="vim"
}

# filename (if known), line number if known, falling back to percent if known,
# falling back to byte offset, falling back to dash
export LESSPROMPT='?f%f .?ltLine %lt:?pt%pt\%:?btByte %bt:-...'

# i = case-insensitive searches, unless uppercase characters in search string
# F = exit immediately if output fits on one screen
# M = verbose prompt
# R = ANSI color support
# S = chop long lines (rather than wrap them onto next line)
# X = suppress alternate screen
export LESS=iFMRSX

# Color man pages.
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;208m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;111m'

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

######################## FLAGS ########################
# Compilation flags
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export CC=gcc
export ARCHFLAGS="-arch arm64"
export CXX=clang

