#!/bin/bash

case $# in
    1)
        NEWFEATURE=$1
        ;;
    *)
        echo "Usage: $0 <feature-name>"
        exit 1
        ;;
esac

if [ -z "$NEWFEATURE" ]; then
    echo "Error: Feature name cannot be empty."
    exit 1
fi

BRANCH_NAME="feat-$NEWFEATURE"
(
    git checkout -b "$BRANCH_NAME"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create branch $BRANCH_NAME."
        exit 1
    fi

    echo "List of branches:"
    git branch -a
)