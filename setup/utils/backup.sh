#!/usr/bin/env bash

# Util to back up files or directories that already exist
# before initial setup


. "./dotfiles_home.sh" --source-only

backup(){
	# back up objects
	info "Backing up; $local_object"
}
