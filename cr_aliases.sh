#!/bin/bash

ALIAS_NAME="crep"
SCRIPT_PATH="$(pwd)/sh/create_repository.sh"
SHELL_RC="$HOME/.bashrc"

if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Error: Script not found at $SCRIPT_PATH"
    exit 1
fi

chmod +x "$SCRIPT_PATH"
if grep -q "alias $ALIAS_NAME=" "$SHELL_RC"; then
    echo "Alias '$ALIAS_NAME' already exists in $SHELL_RC"
    source "$SHELL_RC"
    exit 1
else
    echo "alias $ALIAS_NAME='$SCRIPT_PATH'" >> "$SHELL_RC"
    echo "Alias '$ALIAS_NAME' added to $SHELL_RC"
fi

source "$SHELL_RC"

if alias "$ALIAS_NAME" &>/dev/null; then
    echo "Alias '$ALIAS_NAME' is now available in the current shell."
else
    echo "Warning: Alias '$ALIAS_NAME' could not be loaded. Try opening a new terminal."
fi