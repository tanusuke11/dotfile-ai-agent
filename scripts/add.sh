#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/dependency.sh"

if [ -z "$1" ]; then
  echo "Usage: $0 <path>"
  exit 1
fi

path="$1"
manifest="$DIR/../manifest.json"

echo "➕ Adding $path to manifest.json"

tmp=$(mktemp)
jq --arg path "$path" '.files += [$path]' "$manifest" > "$tmp" && mv "$tmp" "$manifest"