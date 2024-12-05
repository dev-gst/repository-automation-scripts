#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
else
    echo "Error: .env file not found in $SCRIPT_DIR" >&2
    exit 1
fi

export JAVA_HOME
export PATH=$JAVA_HOME/bin:$PATH

GRADLEW_PATH="$GRADLE_PROJECT_PATH/gradlew"

if [ ! -f $GRADLEW_PATH ]; then
    echo "Error: gradlew not found at $GRADLEW_PATH" >&2
    exit 2
fi

(
    cd $GRADLE_PROJECT_PATH
    $GRADLEW_PATH clean test

) 2>&1 | tee $GRADLE_PROJECT_PATH/gradle_test.log

printf "\nLog saved to %s\n" "$GRADLE_PROJECT_PATH/gradle_test.log"