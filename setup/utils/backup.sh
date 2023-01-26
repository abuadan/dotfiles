#!/usr/bin/env bash

set -e
# Util to back up files or directories that already exist
# before initial setup

. "./dotfiles_home.sh" --source-only

# steps are
## check if file or directory exists
## confirm that directory exists and that it will be moved
## move directory or file
## if directory ask if they want to archive it

backup() {
	# back up objects
	info "Backing up; $local_object"
}
