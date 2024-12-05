#!/bin/bash

show_usage() {
    echo "Usage: command [arg]" >&2
    echo "Options:" >&2
    echo "-d: delete remote branch" >&2
    exit 1
}

show_current_branch() {
    echo "Now on branch:"
    git branch --show-current 2> /dev/null
}

case $# in
    0)
        DELETE_REMOTE=false
        ;;
    1)
        if [ "$1" == "-d" ]; then
            DELETE_REMOTE=true
        else 
            show_usage
        fi
        ;;
    *)
        show_usage
        ;;
esac

git status > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Not a git repository." >&2
    exit 2
fi

CURRENT_BRANCH=$(git branch --show-current)
echo "$CURRENT_BRANCH" | grep -q '^feat-' || {
    echo "Error: Not on a feature branch." >&2
    exit 3
}

git checkout master >/dev/null 2>&1
if [ $? -ne 0 ]; then
    git checkout main >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Error: Failed to find master or main branch." >&2
        exit 4
    fi
fi

git merge "$CURRENT_BRANCH" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Failed to merge $CURRENT_BRANCH into master or main." >&2
    exit 5
fi

git branch -d "$CURRENT_BRANCH" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Failed to delete local branch." >&2
    exit 6
fi

echo "Branch $CURRENT_BRANCH merged and deleted locally."

if [ "$DELETE_REMOTE" == "true" ]; then
    echo "Trying to delete remote branch..."
    git push origin --delete "$CURRENT_BRANCH" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Error: Failed to delete remote branch." >&2
        echo "Check if branch $CURRENT_BRANCH exists on remote or if you have permission to delete it." >&2
        show_current_branch
        exit 7
    fi
    
    echo "Branch $CURRENT_BRANCH deleted remotely."
fi

show_current_branch

exit 0