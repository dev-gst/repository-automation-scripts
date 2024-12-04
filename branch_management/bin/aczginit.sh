#!/bin/bash

case $# in
    1)
        NEWFEATURE=$1
        ;;
    *)
        echo "Usage: $0 <feature-name>" >&2
        exit 1
        ;;
esac

if [ -z "$NEWFEATURE" ]; then
    echo "Error: Feature name cannot be empty." >&2
    exit 2
fi

BRANCH_NAME="feat-$NEWFEATURE"
git checkout -b "$BRANCH_NAME" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Failed to create branch $BRANCH_NAME." >&2
    exit 3
fi

echo "List of branches:"
git branch -a 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Error: Failed to list branches." >&2
    exit 4
fi

exit 0
