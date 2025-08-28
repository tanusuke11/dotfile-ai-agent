#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/dependency.sh"

echo "🔄 Syncing submodules..."
git submodule foreach '
  git fetch origin &&
  git merge --no-edit origin/main || {
    echo "⚠️  Merge conflict detected in $name"
  }
'