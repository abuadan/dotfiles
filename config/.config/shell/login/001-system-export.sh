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
# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
# LDFLAGS+="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
# LDFLAGS+="-I/opt/homebrew/opt/openssl/include"
# LDFLAGS+="-L/opt/homebrew/opt/openssl/lib"
# LDFLAGS+="-L$(/opt/homebrew/bin/brew --prefix openssl)/lib -L$(/opt/homebrew/bin/brew --prefix re2)/lib"
# CPPFLAGS+="-I$(/opt/homebrew/bin/brew --prefix openssl)/include -I$(/opt/homebrew/bin/brew --prefix re2)/include"
# export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
# Some system exports requrie gcc-11 from homebrew which lives at /opt/homebrew/bin/gcc-11
# whilst other require gcc-12
export CFLAGS="-I$(/opt/homebrew/bin/brew --prefix openssl)/include"
export LDFLAGS="-L$(/opt/homebrew/bin/brew --prefix openssl)/lib"
# export CC=gcc
# export ARCHFLAGS="-arch arm64"
export CXX=llvm-g++

export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
export GRPC_BUILD_WITH_BORING_SSL_ASM=""
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1
