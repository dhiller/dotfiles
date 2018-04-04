#!/bin/bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT="$( cd "$DIR"; cd ..; pwd )"

apm list --installed --bare > "$PARENT/packages/atom.txt"
