#!/usr/bin/env bash
# Usage: ./scripts/new-feature.sh 2026-11-comp-reopen-handling
set -euo pipefail
slug="${1:?usage: new-feature.sh <yyyy-mm-slug>}"
dir="features/$slug"
[ -e "$dir" ] && { echo "$dir already exists"; exit 1; }
mkdir -p "$dir/diagrams"
cp templates/brief.md templates/prd.md templates/rfc.md "$dir/"
echo "Created $dir — start with brief.md"
