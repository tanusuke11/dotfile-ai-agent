#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/dependency.sh"

echo "📋 Copying files from project root to .dotfile-ai-agent..."
MANIFEST_FILE="$DIR/../manifest.json"
PROJECT_ROOT="$(cd "$DIR/../../" && pwd)"

if [ -f "$MANIFEST_FILE" ]; then
  jq -r '.files[]' "$MANIFEST_FILE" | sed 's|/\*\*$||' | while read -r file; do
    source_path="$PROJECT_ROOT/$file"
    target_path="$DIR/../$file"
    
    if [ -e "$source_path" ]; then
      echo "  Copying $file..."
        if [ -d "$source_path" ]; then
          mkdir -p "$target_path"
          cp -r "$source_path"/* "$target_path"/
        elif [ -f "$source_path" ]; then
          mkdir -p "$(dirname "$target_path")"
          cp "$source_path" "$target_path"
        fi
    else
      echo "  Warning: $source_path not found, skipping..."
    fi
  done
else
  echo "  Warning: manifest.json not found at $MANIFEST_FILE"
fi

echo "📤 Pushing submodule changes..."
git submodule foreach 'git add -A && git commit -m "Update submodule" || true'
git submodule foreach git push origin main