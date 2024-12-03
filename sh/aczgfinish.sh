#!/bin/bash

case $# in
    0)
        echo "Starting..."
        ;;
    *)
        echo "Usage: $0"
        exit 1
        ;;

esac

(
    # Check if the current directory is a git repository
    git status
    if [ $? -ne 0 ]; then
        exit 2
    fi

    # Check if the current branch is a feature branch
    CURRENT_BRANCH=$(git branch --show-current)
    echo "$CURRENT_BRANCH" | grep -q '^feat-' || {
        exit 3
    }

    # Merge the feature branch into master or main
    git checkout master
    if [ $? -ne 0 ]; then
        git checkout main
        if [ $? -ne 0 ]; then
            exit 4
        fi
    fi

    git merge "$CURRENT_BRANCH"

    # Delete the feature branch
    git branch -d "$CURRENT_BRANCH"
    if [ $? -ne 0 ]; then
        exit 5
    fi

    git push origin --delete "$CURRENT_BRANCH"
    if [ $? -ne 0 ]; then
        exit 6
    fi

) > /dev/null 2>&1


case $? in
    0)
        echo "Finished."
        exit 0
        ;;
    2)
        echo "Error: Not a git repository."
        exit 2
        ;;
    3)
        echo "Error: Not on a feature branch."
        exit 3
        ;;
    4)
        echo "Error: Failed to checkout master or main branch."
        exit 4
        ;;
    5)  
        echo "Error: Failed to delete local branch."
        exit 5
        ;;
    6)
        echo "Trying to delete remote branch..."
        echo "Remote branch deletion failed."
        echo "Remote branch probably does not exist."
        exit 0
        ;;
esac