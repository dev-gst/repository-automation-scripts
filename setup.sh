#!/bin/bash

SHELL_RC="$HOME/.bashrc"

ROOT_FOLDER="dev_automation"

SOURCE_FOLDER="./$ROOT_FOLDER"
SOURCE_BIN=$SOURCE_FOLDER/bin

TARGET_FOLDER="$HOME/$ROOT_FOLDER"
TARGET_BIN="$TARGET_FOLDER/bin"

if [ ! -d $SOURCE_FOLDER ]; then
    echo "Error: Source folder $SOURCE_FOLDER not found"
    exit 1
fi

if [ -d $TARGET_FOLDER ]; then
    cp -r $TARGET_FOLDER $TARGET_FOLDER.bak
    rm -rf $TARGET_FOLDER
fi

cp -r $SOURCE_FOLDER $HOME
if [ $? -ne 0 ]; then
    echo "Failed to copy files"
    exit 2
fi

declare -A ALIASES

ALIASES["aczginit"]="$TARGET_BIN/aczginit.sh"
ALIASES["aczgfinish"]="$TARGET_BIN/aczgfinish.sh"
ALIASES["crep"]="$TARGET_BIN/cr_repo.sh"
ALIASES["gradletest"]="$TARGET_BIN/schedule_gradle_test.sh"
ALIASES["gradlelogs"]="$TARGET_BIN/gradlelogs.sh"

for ALIAS in "${!ALIASES[@]}"; do
    SCRIPT_PATH="${ALIASES[$ALIAS]}"

    if [ ! -f "$SCRIPT_PATH" ]; then
        echo "Error: Script not found at $SCRIPT_PATH"
        exit 3
    fi

    chmod u+x "$SCRIPT_PATH"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to make $SCRIPT_PATH executable"
        exit 4
    fi
done

for ALIAS in "${!ALIASES[@]}"; do
    SCRIPT_PATH="${ALIASES[$ALIAS]}"

    if grep -q "alias $ALIAS=" "$SHELL_RC"; then
        echo "Alias '$ALIAS' already exists in $SHELL_RC"
    else
        echo "alias $ALIAS='$SCRIPT_PATH'" >> "$SHELL_RC"
        echo "Alias '$ALIAS' added to $SHELL_RC"
        ALIAS_ADDED=true
    fi
done

if [ "$ALIAS_ADDED" = true ]; then
    echo "Setup complete"
    echo "Please open a new terminal to use the aliases"
else
    echo "No changes made to $SHELL_RC"
fi

source "$SHELL_RC"

exit 0
