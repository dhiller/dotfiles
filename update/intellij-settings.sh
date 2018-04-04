#!/bin/bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT="$( cd "$DIR"; cd ..; pwd )"

function usage {
    cat <<HERE
Usage: $0 <source-dir>
Example: $0 ~/Library/Preferences/IntelliJIdea2018.1
HERE
}

if [ "$#" -lt 1 ]; then
    usage
    exit 1
fi

if [ ! -d "$1" ]; then
    usage
    exit 1
fi
source_dir="$1"; shift

rsync -av "$source_dir/" "$PARENT/idea/settings"
