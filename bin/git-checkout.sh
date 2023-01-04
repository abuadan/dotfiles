#!/bin/env bash

git checkout "$(git branch --list --all | fzf | tr -d '[:space:]')"

