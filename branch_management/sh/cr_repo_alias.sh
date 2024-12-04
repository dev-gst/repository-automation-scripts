#!/bin/bash

CREATE_REPOSITORY_ALIAS="crep"
SCRIPT_PATH="$(pwd)/cr_repo.sh"
SHELL_RC="$HOME/.bashrc"

if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Error: Script not found at $SCRIPT_PATH"
    exit 1
fi

chmod +x "$SCRIPT_PATH"
if grep -q "alias $CREATE_REPOSITORY_ALIAS=" "$SHELL_RC"; then
    echo "Alias '$CREATE_REPOSITORY_ALIAS' already exists in $SHELL_RC"
    source "$SHELL_RC"
    exit 2
else
    echo "alias $CREATE_REPOSITORY_ALIAS='$SCRIPT_PATH'" >> "$SHELL_RC"
    echo "Alias '$CREATE_REPOSITORY_ALIAS' added to $SHELL_RC"
fi

source "$SHELL_RC"

if alias "$CREATE_REPOSITORY_ALIAS" &>/dev/null; then
    echo "Alias '$CREATE_REPOSITORY_ALIAS' is now available in the current shell."
else
    echo "Warning: Alias '$CREATE_REPOSITORY_ALIAS' could not be loaded. Try opening a new terminal."
fi