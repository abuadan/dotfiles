#!/usr/bin/env bash

# Setup all zsh dependencies to ensure that can run it

DOTFILES="$(cd -- "$(dirname "$0")/../../.." && pwd -P)"

echo "Dotfiles directory; $DOTFILES"

. "$DOTFILES/setup/utils/backup.sh" --source-only

echo "Linking profile files"
for f in .bash_profile .bashrc .profile .zshenv; do
	backup "$HOME/$f"
	ln -sf "$DOTFILES/config/$f" "$HOME/$f"
done

echo "Linking zsh files"
for f in .zlogin .zlogout .zprofile .zshrc; do
	backup "$HOME/$f"
	ln -sf "$DOTFILES/config/.config/zsh/$f" "$HOME/$f"
done

# Load shared shell -----------------------------------------------------------
if [[ -d "${XDG_CONFIG_HOME:-$HOME/.config}/shell/sh" ]]; then
	for rc in "${XDG_CONFIG_HOME:-$HOME/.config}"/shell/sh/*.sh; do
		source "$rc"
	done
fi

echo "Settings up TPM for TMUX"
if ! [[ -d "${XDG_CONFIG_HOME:-$HOME/.config}"/tmux/plugins/tpm ]]; then
	mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"/tmux/plugins/tpm
	echo "Cloning tpm"
	git clone https://github.com/tmux-plugins/tpm "${XDG_CONFIG_HOME:-$HOME/.config}"/tmux/plugins/tpm
else
	echo "TPM already installed"
fi
