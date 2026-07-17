#!/usr/bin/env bash

if test ! "$(command -v cargo)"; then
	echo "rust not installed, installing rust;"
	sh -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)"
fi
echo "Rust 🦀 installed"
