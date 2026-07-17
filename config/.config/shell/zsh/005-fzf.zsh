BREW_PREFIX="/opt/homebrew"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/fzf/fzf-git.sh" ]]; then
    source "${XDG_DATA_HOME:-$HOME/.local/share}/fzf/fzf-git.sh"
    bindkey -r '^G'
fi

if [[ -x $(command -v fzf) ]]; then
    [[ -d "$HOME/.cache" ]] || mkdir -p "$HOME/.cache"
    FZF_CACHE="$HOME/.cache/fzf_init.zsh"

    [[ ! -f "$FZF_CACHE" ]] && fzf --zsh > "$FZF_CACHE"
    source "$FZF_CACHE"
    unset FZF_CACHE

    source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"
    source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
    export FZF_BASE="$BREW_PREFIX/bin/fzf"
fi

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"'
  --color=fg:#d4d4d4,fg+:#d4d4d4,bg:#1f1f1f,bg+:#222222
  --color=hl:#608b4e,hl+:#C586C0,info:#C586C0,marker:#C586C0
  --color=prompt:#C586C0,spinner:#C586C0,pointer:#C586C0,header:#608b4e
  --color=border:#808080,label:#C586C0,query:#d4d4d4'

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() { fd --hidden --exclude .git . "$1"; }
_fzf_compgen_dir() { fd --type=d --hidden --exclude .git . "$1"; }

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --icons --color=always --git -a {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --icons --tree --color=always --git -a {} | head -200'"

_fzf_comprun() {
    local command=$1
    shift
    case "$command" in
        cd)           fzf --preview 'eza --icons --tree --color=always --git -a {} | head -200' "$@" ;;
        export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
        ssh)          fzf --preview 'dig {}'                   "$@" ;;
        *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
    esac
}

if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/functions.sh" ]]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/functions.sh"
fi
