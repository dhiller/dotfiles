#!/bin/bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT="$( cd "$DIR"; cd ..; pwd )"

# install dotfiles from main directory
for dotfile in $(find "$PARENT" -maxdepth 1 -type f -name "\.*" -print); do
    target_file="$HOME/$(basename $dotfile)"
    if [ -f "$target_file" ]; then
        echo "File $target_file exists."
        ls -l "$target_file"
    else
        ln -sv "$dotfile" $HOME
    fi
done

# .config
for config_dir in $(find "$PARENT/.config" -mindepth 1 -maxdepth 1 -type d -print); do
    target_file="$HOME$( echo "$config_dir" | sed 's/^'"$(echo $PARENT | sed 's/\//\\\//g')"'//')"
    if [ -d "$target_file" ]; then
        echo "File $target_file exists."
        ls -l "$target_file"
    else
        ln -sv "$config_dir" "$HOME/.config"
    fi
done

# ssh config
ln -sv "$PARENT/.ssh/config" ~/.ssh/config
