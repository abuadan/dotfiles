#
#    ███████╗██████╗ ██████╗  ██████╗ ███████╗██╗██╗     ███████╗
#    ╚══███╔╝██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║██║     ██╔════╝
#      ███╔╝ ██████╔╝██████╔╝██║   ██║█████╗  ██║██║     █████╗
#     ███╔╝  ██╔═══╝ ██╔══██╗██║   ██║██╔══╝  ██║██║     ██╔══╝
# ██╗███████╗██║     ██║  ██║╚██████╔╝██║     ██║███████╗███████╗
# ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝


# loading all files from login.d
if [ -d $HOME/.config/shell/login ]; then
    for rc in $HOME/.config/shell/login/*.sh; do
        emulate bash -c ". $rc"
    done
fi

[[ -f $HOME/.local/share/zsh/zprofile ]] && . $HOME/.local/share/zsh/zprofile
