#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/dependency.sh"

echo "📤 Pushing submodule changes..."
git submodule foreach 'git add -A && git commit -m "Update submodule" || true'
git submodule foreach git push origin main