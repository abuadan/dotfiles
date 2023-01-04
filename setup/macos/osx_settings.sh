#!/usr/bin/env bash

set +e

DIR="$(dirname "$0")"
. "$DIR/../utils/pretty_echo.sh" --source-only

title "Configuring macOS"
if [[ "$(uname)" == "Darwin" ]]; then

	info "Finder: show all filename extensions"
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	info "show hidden files by default"
	defaults write com.apple.Finder AppleShowAllFiles -bool false

	info "only use UTF-8 in Terminal.app"
	defaults write com.apple.terminal StringEncodings -array 4

	info "expand save dialog by default"
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

	info "show the ~/Library folder in Finder"
	chflags nohidden ~/Library

	info "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
	defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

	info "Enable subpixel font rendering on non-Apple LCDs"
	defaults write NSGlobalDomain AppleFontSmoothing -int 2

	info "Use current directory as default search scope in Finder"
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

	info "Show Path bar in Finder"
	defaults write com.apple.finder ShowPathbar -bool true

	info "Show Status bar in Finder"
	defaults write com.apple.finder ShowStatusBar -bool true

	info "Disable press-and-hold for keys in favor of key repeat"
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

	info "Set a blazingly fast keyboard repeat rate"
	defaults write NSGlobalDomain KeyRepeat -int 1

	info "Set a shorter Delay until key repeat"
	defaults write NSGlobalDomain InitialKeyRepeat -int 15

	info "Enable tap to click (Trackpad)"
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

	info "Enable Safari’s debug menu"
	defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

	info "Kill affected applications"

	for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done
else
	warning "macOS not detected. Skipping."
fi
