#!/usr/bin/env bash

# Copy settings.json to settings.local.json at session start
cp .claude/settings.json .claude/settings.local.json
echo "Settings copied to local session file."

# Check if Serena MCP Server is already running
SERENA_PID=$(pgrep -f "serena start-mcp-server")
if [ -n "$SERENA_PID" ]; then
    echo "Serena MCP Server is already running (PID: $SERENA_PID)"
else
    # Start Serena MCP Server in background
    echo "Starting Serena MCP Server..."
    uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project . 
    echo "Serena MCP Server started"
fi