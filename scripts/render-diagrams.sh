#!/usr/bin/env bash
# Renders every ```mermaid block in domains/ and features/ to SVG under build/
# and writes a copy of each markdown file with the blocks replaced by <img>.
# Use the build/ folder as the input of the wiki publish job.
# Needs: npm i -g @mermaid-js/mermaid-cli   (or use npx)
set -euo pipefail
MMDC="${MMDC:-$(command -v mmdc || echo 'npx -y @mermaid-js/mermaid-cli')}"
rm -rf build && mkdir -p build
find domains features -name '*.md' | while read -r md; do
  out="build/$md"
  mkdir -p "$(dirname "$out")"
  $MMDC -q -i "$md" -o "$out" -e svg ${PUPPETEER_CFG:+-p "$PUPPETEER_CFG"}
done
echo "Rendered to build/"
