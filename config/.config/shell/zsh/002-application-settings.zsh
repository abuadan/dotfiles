if command -v zoxide >/dev/null 2>&1; then
    export _ZO_DATA_DIR="$HOME/.cache/zoxide"
    [[ -d "$_ZO_DATA_DIR" ]] || mkdir -p "$_ZO_DATA_DIR"
    # `zoxide init` itself is sourced at the very end of .zshrc (it must come last).
fi

# Cache the generated alias; `thefuck --alias` starts a Python interpreter (~100ms+).
# Regenerated automatically when the thefuck binary is newer than the cache.
if command -v thefuck >/dev/null 2>&1; then
    THEFUCK_CACHE="$HOME/.cache/thefuck_alias.zsh"
    if [[ ! -f "$THEFUCK_CACHE" || "$(command -v thefuck)" -nt "$THEFUCK_CACHE" ]]; then
        thefuck --alias > "$THEFUCK_CACHE"
    fi
    source "$THEFUCK_CACHE"
    unset THEFUCK_CACHE
fi
