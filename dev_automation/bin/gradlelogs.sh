#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
else
    echo "Error: .env file not found in $SCRIPT_DIR" >&2
    exit 1
fi

less $GRADLE_PROJECT_PATH/gradle_test.log

