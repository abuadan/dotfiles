#!/usr/bin/env bash

# Hardcoded ANSI codes avoid 10 slow subshell forks
export CL_RED="\u001b[31m"
export CL_GREEN="\u001b[32m"
export CL_YELLOW="\u001b[33m"
export CL_BLUE="\u001b[34m"
export CL_MAGENTA="\u001b[35m"
export CL_CYAN="\u001b[36m"
export CL_WHITE="\u001b[37m"
export CL_BLACK="\u001b[38m"
export CL_BOLD="\u001b[1m"
export CL_RESET="\033[m"

function esc_color() {
	echo "\[$1\]"
}
