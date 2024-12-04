#!/bin/bash

GRADLE_PROJECT_PATH="/path/to/gradle/project"
GRADLEW_PATH="$GRADLE_PROJECT_PATH/gradlew"

if [ ! -f $GRADLEW_PATH ]; then
    echo "Error: gradlew not found at $GRADLEW_PATH"
    exit 1
fi

(
    cd $GRADLE_PROJECT_PATH
    $GRADLEW_PATH clean test

) 2>&1 | tee $GRADLE_PROJECT_PATH/gradle_test.log