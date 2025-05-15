
#
#    ███████╗███████╗██╗  ██╗██████╗  ██████╗
#    ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#      ███╔╝ ███████╗███████║██████╔╝██║
#     ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ██╗███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#

# unccoment line to help profile slow startup time
# keep at the top of .zshrc file

# Profile ---------------------------------------------------------------------
function_profile=false
command_profile=false


if [[ $function_profile == true ]]; then
    zmodload zsh/zprof
fi

if [[ $command_profile == true ]]; then
    zmodload zsh/datetime
    setopt promptsubst
    PS4='+$EPOCHREALTIME %N:%i> '
    exec 3>&2 2> startlog.$$
    setopt xtrace prompt_subst
fi

# Completion ------------------------------------------------------------------
if [[ ! -d  "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]]; then
	mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
fi
export ZSH_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
export ZSH_COMPDUMP="${ZSH_CAC:-${XDG_CACHE_HOME:-$HOME/.cache}/zsh}/zcompdump"

zstyle ':zim:completion' dumpfile $ZSH_CACHE/zsh_dumpfile
zstyle ':completion::complete:*' cache-path $ZSH_COMPDUMP

# export PROMPT="oh-my-posh"
export PROMPT="starship"

###################### ZIM zsh plugin manager ######################

export ZIM_CONFIG_FILE="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"/.zimrc
export ZIM_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME/.config}}/zsh/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh


export GPG_TTY="$(tty)"

#You may need to manually set your language environment
export LANG=en_US.UTF-8

# Load shared shell -----------------------------------------------------------
if [ -d $HOME/.config/shell/sh ]; then
    for rc in $HOME/.config/shell/sh/*.sh; do
        source $rc
    done
fi

# Update FPATH
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"


# Source zsh specific configuration
if [[ -d $HOME/.config/shell/zsh ]]; then
    for rc in $HOME/.config/shell/zsh/*.zsh; do
        source $rc
    done
fi


# Source zsh specific configuration
# Need to resource zsh config for them to take effect.
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/sh/004-aliases.sh"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Source local profiles -------------------------------------------------------
[[ -f $HOME/.local/share/zsh/zshrc ]] && . $HOME/.local/share/zsh/zshrc

# Post profile ----------------------------------------------------------------
if [[ $function_profile == true ]]; then
    zprof > startup-functions.log
fi

if [[ $command_profile == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

