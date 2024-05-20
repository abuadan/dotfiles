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
ln -sf "$DOTFILES"/config/.config/zsh/.p10k.zsh "$HOME"/.p10k.zsh

echo "Sourcing zshrc file"
source "$HOME"/.zshrc

echo "clone tmux plugin manager TPM"
git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME"/tmux/plugins/tpm
