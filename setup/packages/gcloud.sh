#!/bin/env bash

set +ex

SCRIPT=$(realpath "$0")
DIR=$(dirname "$SCRIPT")

. "$DIR/../../setup/utils/pretty_echo.sh" --source-only
. "$DIR/../../setup/utils/dotfiles_home.sh" --source-only

# download_gcloud() {

# }

if [[ "$(uname)" == "Darwin" ]]; then
	info "Downloading and install gcloud cli."
	if [[ -d "${XDG_DATA_HOME:-$HOME/.local/share}"/gcloud_installation ]]; then
		mkdir "${XDG_DATA_HOME:-$HOME/.local/share}"/gcloud_installation
		touch "${XDG_DATA_HOME:-$HOME/.local/share}"/gcloud_installation/install.sh
	fi
	curl https://sdk.cloud.google.com >"${XDG_DATA_HOME:-$HOME/.local/share}"/gcloud_installation/install.sh
	bash "${XDG_DATA_HOME:-$HOME/.local/share}"/gcloud_installation/install.sh --disable-prompts --install-dir="${XDG_DATA_HOME:-$HOME/.local/share}"
fi

echo -e
success "Done."
