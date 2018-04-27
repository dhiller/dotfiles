#!/bin/bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT="$( cd "$DIR"; cd ..; pwd )"

# link config directories
function link_dirs {
    for config_dir in $(find "$PARENT" -mindepth 1 -maxdepth 1 -type d -name "\.*" -and -not -name "\.git" -and -not -name "\.ssh" -print); do
        target_file="$HOME$( echo "$config_dir" | sed 's/^'"$(echo $PARENT | sed 's/\//\\\//g')"'//')"
        if [ -h "$target_file" ]; then
            echo "Link from $target_file exists."
            ls -l "$target_file"
        else
            if [ -d "$target_file" ]; then
                echo "Directory $target_file exists."
                ls -l "$target_file"
            else
                ln -sv "$config_dir" "$target_file"
            fi
        fi
    done
}

function link_file {
    local dotfile
    source_file="$1"
    local target_file
    target_file="$HOME$( echo "$source_file" | sed 's/^'"$(echo $PARENT | sed 's/\//\\\//g')"'//')"
    if [ -h "$target_file" ]; then
        echo "Link from $target_file exists."
        ls -l "$target_file"
    else
        if [ -f "$target_file" ]; then
            echo "File $target_file exists."
            ls -l "$target_file"
        else
            ln -sv "$source_file" "$target_file"
        fi
    fi
}

# install dotfiles from main directory
function link_dotfiles {
    for dotfile in $(find "$PARENT" -maxdepth 1 -type f -name "\.*" -print); do
        link_file "$dotfile"
    done
}

link_dotfiles
link_dirs
link_file "$PARENT/.ssh/config"
for config_file in $(find "$PARENT" -type f -path "**/Library/Preferences/*"); do
    link_file "$config_file"
done
