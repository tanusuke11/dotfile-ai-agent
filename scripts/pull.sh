#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/dependency.sh"

echo "📥 Pulling latest changes..."
git submodule update --init --recursive
git submodule foreach git fetch origin
git submodule foreach git merge origin/main || true