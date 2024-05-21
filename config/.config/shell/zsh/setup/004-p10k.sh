#!/usr/bin/env bash

# Check for p10k theme
if ! [[ -f ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/themes/powerlevel10k ]]; then
	echo "Powerlevel 10k not installed installing PK10"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
fi
