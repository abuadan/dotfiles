
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

[ -n "$(command -v starship)" ] && {
    eval "$(starship init zsh)"
}

