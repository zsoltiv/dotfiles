#!/bin/bash

CONFIG_HOME="$HOME/.config"
CONFIG_PATHS=(
    "$HOME/.config"
    "/etc"
)
DOTFILES_DIR="$(pwd)"

paths=$(find . -not -path '\./.*' -not -path '\.' -not -executable -type f | sed "s/^\.\///")
valid_config_paths=()
for config_path in ${CONFIG_PATHS[@]}; do
    if [[ -d $config_path ]]; then
        valid_config_paths+=( $config_path )
    fi
done

echo ${valid_config_paths[@]}

# TODO: avoid copying the file from two different valid_config_paths
for path in $paths; do
    for config_path in ${valid_config_paths[@]}; do
        cp "$config_path/$path" "./$path" &> /dev/null &&
            echo "copying $config_path/$path to ./$path" &&
            break
    done
done

git add .
git commit
