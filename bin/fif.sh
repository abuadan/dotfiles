#!/bin/env bash

rg  \
	--column \
	--line-number \
	--no-column \
	--no-heading \
	--ignore-case \
	--hidden \
	--follow \
	--glob '!.git/*' "$1" \
	| awk -F  ":" '/1/ {start = $2<20 ? 0 : $2 - 20; end = $2 + 20; print $1 " " $2 " " start ":" end}' \
	| fzf --preview 'bat --wrap character --color always {1} --highlight-line {2} --line-range {3}' --preview-window wrap
