#!/usr/bin/env bash

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# shellcheck disable=SC2155
# export HOMEBREW_PREFIX="$(brew --prefix)"
# shellcheck disable=SC2155
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

################## JAVA ###################
# export JAVA_HOME="/opt/homebrew/opt/openjdk"
# shellcheck disable=SC2155
export JAVA_HOME="$(/usr/libexec/java_home -v 21)"
export JAVA_OPTS="-server -Xms8192m -Xmx12288m -XX:ReservedCodeCacheSize=512m -XX:+UseG1GC -XX:SoftRefLRUPolicyMSPerMB=50 -ea -Dsun.io.useCanonCaches=false -Djava.net.preferIPv4Stack=true -XX:-OmitStackTraceInFastThrow"

################## GO ###################
# export GOROOT='/usr/local/go'
# export GOPTAH="${XDG_CONFIG_HOME:-$HOME/.config}"/go
# export GOCACHE="${XDG_CACHE_HOME:-$HOME/.cache}"/go-build
# export GOMODCACHE="${XDG_CACHE_HOME:-$HOME/.cache}"/go/pkg/mod
# export GOENV="${XDG_DATA_HOME:-$HOME/.local}"/go/env
# export GOBIN="${HOMEBREW_PREFIX:-/opt/homebrew/}"/bin/go
######################## FLAGS ########################
# Compilation flags
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
LDFLAGS+="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
LDFLAGS+="-I/opt/homebrew/opt/openssl/include"
LDFLAGS+="-L/opt/homebrew/opt/openssl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
# Some system exports requrie gcc-11 from homebrew which lives at /opt/homebrew/bin/gcc-11
# whilst other require gcc-12
export CC=gcc
export ARCHFLAGS="-arch arm64"
export CXX=clang
export GRPC_PYTHON_BUILD_SYSTEM_RE2=true
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=true
export GRPC_BUILD_WITH_BORING_SSL_ASM="" pip

# Docker related stuff
if [ "$(uname -s)" == "Darwin" ]; then
	export DOCKER_DEFAULT_PLATFORM=linux/arm64
fi

export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8
