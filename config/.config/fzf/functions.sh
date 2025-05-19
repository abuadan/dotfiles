#!/usr/bin/env bash

# GIT heart FZF
# -------------

is_in_git_repo() {
	git rev-parse HEAD >/dev/null 2>&1
}

fzf-down() {
	fzf --height 50% "$@" --border
}

_gf() {
	is_in_git_repo || return
	git -c color.status=always status --short --untracked-files=all |
		fzf-down -m --ansi --nth 2..,.. \
			--preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
		cut -c4- | sed 's/.* -> //'
}

_gb() {
	is_in_git_repo || return
	git branch -a --color=always | grep -v '/HEAD\s' | sort |
		fzf-down --ansi --multi --tac --preview-window right:70% \
			--preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
		sed 's/^..//' | cut -d' ' -f1 |
		sed 's#^remotes/##'
}

_gt() {
	is_in_git_repo || return
	git tag --sort -version:refname |
		fzf-down --multi --preview-window right:70% \
			--preview 'git show --color=always {} | head -'$LINES
}

_gh() {
	is_in_git_repo || return
	git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
		fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
			--header 'Press CTRL-S to toggle sort' \
			--preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
		grep -o "[a-f0-9]\{7,\}"
}

_gr() {
	is_in_git_repo || return
	git remote -v | awk '{print $1 "\t" $2}' | uniq |
		fzf-down --tac \
			--preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
		cut -d$'\t' -f1
}

fif() {
	rg \
		--column \
		--line-number \
		--no-column \
		--no-heading \
		--ignore-case \
		--hidden \
		--follow \
		--glob '!.git/*' "$1" |
		awk -F ":" '/1/ {start = $2<20 ? 0 : $2 - 20; end = $2 + 20; print $1 " " $2 " " start ":" end}' |
		fzf --preview 'bat --wrap character --color always {1} --highlight-line {2} --line-range {3}' --preview-window wrap

}

# Man without options will use fzf to select a page
fzf-man() {
	MAN="/usr/bin/man"
	if [ -n "$1" ]; then
		$MAN "$@"
		return $?
	else
		$MAN -k . | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
		return $?
	fi
}

fzf-kill-processes() {
	local pid
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if [ "x$pid" != "x" ]; then
		echo "$pid" | xargs kill "-${1:-9}"
	fi
}

fzf-env-vars() {
	local out
	out=$(env | fzf)
	echo "$(echo "$out" | cut -d= -f2)"
}

fzf-aliases-functions() {
	CMD=$(
		(
			(alias)
			(functions | grep "()" | cut -d ' ' -f1 | grep -v "^_")
		) | fzf | cut -d '=' -f1
	)

	eval "$CMD"
}

# Select a docker image or images to remove
function drmi() {
	docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}

# Select a docker container to remove
function drm() {
	local cid
	cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker rm "$cid"
}

function docker-ps() {
	docker ps | fzf | awk '{print $1}'
}

function docker-logs() {
	docker logs -f "$(docker ps | fzf | awk '{print $1}')"
}
