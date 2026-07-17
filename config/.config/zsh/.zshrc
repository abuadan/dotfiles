
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


if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

# rest of .zshrc script

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

if [[ ! -d  "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_sessions" ]]; then
	mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_sessions"
fi

export ZSH_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_sessions"
export ZSH_COMPDUMP="${ZSH_CACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh}/zcompdump"

# export PROMPT="oh-my-posh"
export PROMPT="starship"

###################### ZSH Settings ###############################
export ZDOTDIR="$HOME/.config/zsh"

###################### ZIM zsh plugin manager ######################

zstyle ':zim:completion' dumpfile $ZSH_CACHE/zsh_dumpfile
zstyle ':completion::complete:\*' cache-path $ZSH_COMPDUMP

export ZIM_CONFIG_FILE="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"/.zimrc
export ZIM_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"/.zim

# [MOVED] Update FPATH *BEFORE* Zim initializes to ensure all completions are cached correctly
# Also hardcoded to avoid the massive startup penalty of `brew --prefix`
export FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME/.config}}/zsh/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# zsh-vi-mode defaults to deferring its own init to the first precmd (queuing
# zvm_init via precmd_functions) unless ZVM_INIT_MODE=sourcing is set *before* the
# module loads below. Left unset, zvm_init runs after every shell/zsh/*.zsh file has
# already made its own bindkey calls, then resets the keymap out from under them.
# Setting it here (not in shell/zsh/*.zsh, which loads too late to matter) makes
# zvm_init run synchronously and immediately, in the correct order.
export ZVM_INIT_MODE=sourcing

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

# Source zsh specific configuration
if [[ -d $HOME/.config/shell/zsh ]]; then
    for rc in $HOME/.config/shell/zsh/*.zsh; do
        source $rc
    done
fi


# Source zsh specific configuration
# Need to resource zsh config for them to take effect.
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/sh/004-aliases.sh"

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

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
