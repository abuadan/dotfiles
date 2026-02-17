#
#    ██████╗ ██████╗  ██████╗ ███████╗██╗██╗     ███████╗
#    ██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║██║     ██╔════╝
#    ██████╔╝██████╔╝██║   ██║█████╗  ██║██║     █████╗
#    ██╔═══╝ ██╔══██╗██║   ██║██╔══╝  ██║██║     ██╔══╝
# ██╗██║     ██║  ██║╚██████╔╝██║     ██║███████╗███████╗
# ╚═╝╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝
#

[[ -d $HOME/.config/shell/login ]] && {
	for rc in "$HOME"/.config/shell/login/*.sh; do
		source $rc
	done
}

[[ -f $HOME/.local/share/bash/profile ]] && . "$HOME"/.local/share/bash/profile

[[ -f "$HOME"/.local/share/cargo/env ]] && . "$HOME"/.local/share/cargo/env
