# ☕️ Dotfiles ☕️

Heavily inspired by the wonderful [nyx](https://github.com/EdenEast/nyx.git) repo, please check it out.

## Installation

There are several bash scripts used for Installation, the structure of the project means that most of the heavy lifting is done
via symlinking. Each `config/.config/*` entry is symlinked into `~/.config/` individually (not the whole folder at once), so
apps that write their own cache/state into `~/.config/<app>` don't end up writing into this repo's working tree. Anything
already on disk that would be replaced by a symlink is backed up first (see `setup/utils/backup.sh`), not overwritten blindly.

### Settings

Settings are mainly mac based and can be mostly found at;

```shell
	 setup
	├──  macos
	│  ├──  brew
	│  ├──  settings
	│  └──  utils
	│     ├──  Brewfile
	│     └──  Brewfile.lock.json
	├──  packages
	│  ├──  fzf-git.sh
	│  ├──  gcloud.sh
	│  ├──  go.sh
	│  └──  rust.sh
	├──  terminal
	│  ├──  shell.sh
	│  ├──  terminfo.sh
	│  └──  zsh
	└──  utils
	   ├──  backup.sh
	   ├──  dotfiles_home.sh
	   └──  pretty_echo.sh
```
