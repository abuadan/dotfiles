#!/usr/bin/env bash
# Util to back up files or directories that already exist before initial setup,
# so install.sh's symlink loop never silently clobbers pre-existing content.

DOTFILES="$(cd -- "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
BACKUP_ROOT="${DOTFILES_BACKUP_ROOT:-$HOME/.dotfiles-backup}"

. "$DOTFILES/setup/utils/pretty_echo.sh" --source-only

# Move $1 to $BACKUP_ROOT/<run-timestamp>/<same-path-relative-to-$HOME>, unless it
# doesn't exist, is already a symlink pointing into this repo (re-running install
# is idempotent by definition here), or is an empty directory (nothing to lose in
# either case).
backup() {
    local target="$1"

    [[ -e "$target" || -L "$target" ]] || return 0

    if [[ -L "$target" ]]; then
        case "$(realpath -- "$target")" in
            "$DOTFILES"/*) return 0 ;;
        esac
    fi

    if [[ -d "$target" && -z "$(ls -A -- "$target" 2>/dev/null)" ]]; then
        rmdir -- "$target"
        return 0
    fi

    : "${DOTFILES_BACKUP_TIMESTAMP:=$(date +%Y%m%d-%H%M%S)}"
    export DOTFILES_BACKUP_TIMESTAMP

    local relative="${target#"$HOME"/}"
    local dest="$BACKUP_ROOT/$DOTFILES_BACKUP_TIMESTAMP/$relative"

    mkdir -p -- "$(dirname -- "$dest")"
    info "Backing up $target -> $dest"
    mv -- "$target" "$dest"
}
