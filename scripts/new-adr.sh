#!/usr/bin/env bash
# Usage: ./scripts/new-adr.sh compensation "Recalculations append, never overwrite"
set -euo pipefail
domain="${1:?usage: new-adr.sh <domain> \"<title>\"}"
title="${2:?missing title}"
dir="domains/$domain/adr"
mkdir -p "$dir"
# ADR numbers are global across domains so they never collide
last=$(find domains -path '*/adr/*.md' -printf '%f\n' | grep -oE '^[0-9]{4}' | sort -n | tail -1)
num=$(printf '%04d' $(( 10#${last:-0} + 1 )))
slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-|-$//g')
file="$dir/$num-$slug.md"
sed "s/ADR-NNNN: <decision in one sentence, present tense>/ADR-$num: $title/; s/<yyyy-mm-dd>/$(date +%F)/" templates/adr.md > "$file"
echo "Created $file — also add a line under Decisions in domains/$domain/context.md"
