#!/bin/bash

echo "workspace initialised."

# Copy settings.json to settings.local.json at session start
cp .claude/settings.json .claude/settings.local.json