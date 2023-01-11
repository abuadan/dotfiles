
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

[ -x"$(command -v starship)" ] && {
    eval "$(starship init zsh)"
}

