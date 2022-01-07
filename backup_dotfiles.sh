#!/bin/bash

CONFIG_HOME="$HOME/.config"
DOTFILES_DIR="$(pwd)"

paths=$(find . -not -path '\./.*' -not -path '\.' -type f | sed 's/^\.\///')

for path in $paths; do
    cp "$CONFIG_HOME/$path" "./$path"
done
