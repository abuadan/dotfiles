#!/usr/bin/env bash

# Setup all zsh dependencies to ensure that can run it

DOTFILES="$(
	cd -- "$(dirname "$2")" || exit >/dev/null 2>&1
	pwd -P
)"

echo "Dotfiles directory; $DOTFILES"

echo "Linking profile files"
ln -sf "$DOTFILES"/config/.bash_profile "$HOME"/.bash_profile
ln -sf "$DOTFILES"/config/.bashrc "$HOME"/.bashrc
ln -sf "$DOTFILES"/config/.profile "$HOME"/.profile
ln -sf "$DOTFILES"/config/.zshenv "$HOME"/.zshenv

echo "Linking zsh files"
ln -sf "$DOTFILES"/config/.config/zsh/.zlogin "$HOME"/.zlogin
ln -sf "$DOTFILES"/config/.config/zsh/.zlogout "$HOME"/.zlogout
ln -sf "$DOTFILES"/config/.config/zsh/.zprofile "$HOME"/.zprofile
ln -sf "$DOTFILES"/config/.config/zsh/.zshrc "$HOME"/.zshrc

# TODO: Remove mentions to pk10
# ln -sf "$DOTFILES"/config/.config/zsh/.p10k.zsh "$HOME"/.p10k.zsh

# Load shared shell -----------------------------------------------------------
if [[ -d "${XGD_CONFIG_DATA:-$HOME/.config}/shell/sh" ]]; then
	for rc in "${XGD_CONFIG_DATA:-$HOME/.config}"/shell/sh/*.sh; do
		source $rc
	done
fi

echo "Settings up TPM for TMUX"
# TODO: Wrap this around a guard
if ! [[ -d "$XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins/tpm" ]]; then
	echo "Cloning tpm"
	git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME:-$HOME/.config}"/tmux/tmux/plugins/tpm
else
	echo "TPM already installed"
fi
