#!/usr/bin/env bash

set +e

SCRIPT=$(realpath "$0")
DIR=$(dirname "$SCRIPT")

. "$DIR/setup/utils/pretty_echo.sh" --source-only
. "$DIR/setup/utils/dotfiles_home.sh" --source-only
. "$DIR/setup/utils/backup.sh" --source-only

# Opt-in extras: neither needs credentials to run, but both are unattended
# downloads a fresh install shouldn't be forced to pay for by default.
WITH_GCLOUD=false
WITH_FZF_GIT=false
for arg in "$@"; do
	case "$arg" in
	--with-gcloud) WITH_GCLOUD=true ;;
	--with-fzf-git) WITH_FZF_GIT=true ;;
	--with-extras)
		WITH_GCLOUD=true
		WITH_FZF_GIT=true
		;;
	esac
done

# A failed critical step aborts the install; a failed optional step just warns
# and lets the rest of the install continue.
critical() {
	info "$1"
	shift
	"$@" || error "Failed: $*"
}

optional() {
	info "$1"
	shift
	"$@" || warning "Failed (continuing): $*"
}

info "Need to update recursive git submodules"
git submodule update --init --recursive

# Steps genuinely shared between macOS and Linux: shell setup, per-app config
# symlinking, and package installs that aren't platform-specific package managers.
common_setup() {
	critical "Setup dot files linked to home directory" "$DIR"/config/.config/zsh/setup.sh

	info "Install additional packages outside brew"
	critical "Installing rust" "$DIR"/setup/packages/rust.sh

	info "Update terminal settings"
	critical "Configuring terminfo" "$DIR"/setup/terminal/terminfo.sh

	info "Link each config/.config/* entry individually, not the whole folder"
	mkdir -p "$HOME"/.config
	for entry in "$DIR"/config/.config/*; do
		name="$(basename "$entry")"
		backup "$HOME/.config/$name"
		ln -sf "$entry" "$HOME/.config/$name"
	done

	info "Link bin folder to $XDG_DATA_HOME/sbin"
	backup "$XDG_DATA_HOME/sbin"
	ln -sf "$DIR"/bin "$XDG_DATA_HOME"/sbin

	if $WITH_FZF_GIT; then
		optional "Installing fzf-git.sh" "$DIR"/setup/packages/fzf-git.sh
	else
		info "Skipping fzf-git.sh (pass --with-fzf-git or --with-extras to install)"
	fi

	if $WITH_GCLOUD; then
		optional "Installing gcloud CLI" "$DIR"/setup/packages/gcloud.sh
	else
		info "Skipping gcloud CLI (pass --with-gcloud or --with-extras to install)"
	fi
}

darwin_setup() {
	optional "Setting up darwin settings" "$DIR"/setup/macos/settings
	critical "Setting up brew" "$DIR"/setup/macos/brew
}

linux_setup() {
	warning "Linux package installation isn't wired up yet - common_setup() covers the shell/config/symlink steps, but you'll need to install packages from setup/macos/utils/Brewfile's equivalents manually for now."
}

common_setup
case "$(uname)" in
Darwin) darwin_setup ;;
Linux) linux_setup ;;
esac

echo -e
success "Done. Open a new shell (and restart tmux, if running) to pick up the changes."
