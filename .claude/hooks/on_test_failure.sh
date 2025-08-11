#!/bin/bash

# on_test_failure.sh - Get quick advice from Gemini CLI when tests fail
# Usage: on_test_failure.sh <tool_output> <file_paths>

TOOL_OUTPUT="$1"
FILE_PATHS="$2"

# Check if Gemini CLI is installed
if ! command -v gemini &> /dev/null; then
    echo "⚠️  Gemini CLI not found. Please install gemini-cli first."
    exit 0
fi

# Check if test failure is detected
if ! echo "$TOOL_OUTPUT" | grep -qi "fail\|Fail\|FAIL\|error\|Error\|ERROR\|exception\|Exception\|EXCEPTION\|test.*failed\|Test.*Failed\|TEST.*FAILED\|❌\|✗"; then
    exit 0
fi

echo "🚨 Test failure detected. Getting quick fix advice..."

# Get concise advice from Gemini CLI
echo "Analyze this test failure and provide 3 specific fix suggestions:

Test Output:
$TOOL_OUTPUT

Affected Files: $FILE_PATHS" | gemini 2>/dev/null | head -n 15

exit 0