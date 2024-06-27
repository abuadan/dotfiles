#!/usr/bin/env bash

if test ! "$(command -v poetry)"; then
	echo "poetry not installed, installing poetry;"
	sh -c "$(curl -sSL https://install.python-poetry.org | python3 -)"
fi
echo "Installed Poetry"
