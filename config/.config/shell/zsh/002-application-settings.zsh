if command -v zoxide >/dev/null 2>&1; then
    export _ZO_DATA_DIR="$HOME/.cache/zoxide"
    [[ -d "$_ZO_DATA_DIR" ]] || mkdir -p "$_ZO_DATA_DIR"

    ZOXIDE_CACHE="$HOME/.cache/zoxide_init.zsh"
    [[ -f "$ZOXIDE_CACHE" ]] || zoxide init --cmd cd zsh > "$ZOXIDE_CACHE"
    source "$ZOXIDE_CACHE"
    unset ZOXIDE_CACHE
fi

if command -v thefuck >/dev/null 2>&1; then
    eval "$(thefuck --alias)"
fi
