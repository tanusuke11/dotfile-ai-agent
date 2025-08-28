#!/usr/bin/env bash
set -e

check_dependency() {
  local cmd=$1
  local url=$2
  if ! command -v "$cmd" &> /dev/null; then
    echo "⚠️  Missing dependency: $cmd"
    echo "   Please install it manually:"
    echo "   $url"
    exit 1
  fi
}

check_dependency jq "https://stedolan.github.io/jq/download/"
check_dependency rsync "https://rsync.samba.org/download.html"