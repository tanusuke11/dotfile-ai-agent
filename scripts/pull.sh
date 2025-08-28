#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/dependency.sh"

echo "📥 Pulling latest changes..."
git submodule update --init --recursive
git submodule foreach git fetch origin
git submodule foreach git merge origin/main || true

echo "📋 Copying files from manifest to project root..."
MANIFEST_FILE="$DIR/../manifest.json"
PROJECT_ROOT="$(cd "$DIR/../../" && pwd)"

if [ -f "$MANIFEST_FILE" ]; then
  jq -r '.files[]' "$MANIFEST_FILE" | sed 's|/\*\*$||' | while read -r file; do
    source_path="$DIR/../$file"
    target_path="$PROJECT_ROOT/$file"
    
    if [ -e "$source_path" ]; then
      echo "  Copying $file..."
      mkdir -p "$(dirname "$target_path")"
      cp -r "$source_path" "$target_path"
    else
      echo "  Warning: $source_path not found, skipping..."
    fi
  done
else
  echo "  Warning: manifest.json not found at $MANIFEST_FILE"
fi