#!/bin/bash

case $# in
    1)
        PROJECT_PATH=$HOME
        PROJECT_NAME=$1
        ;;
    2)
        PROJECT_PATH=$1
        PROJECT_NAME=$2
        ;;
    *)
        echo "Usage: $0 [project_path] <project_name>"
        exit 1
        ;;
esac

PROJECT_PATH=${PROJECT_PATH%/}
PROJECT_NAME=${PROJECT_NAME%/}
FULL_PATH=$PROJECT_PATH/$PROJECT_NAME

mkdir -p $FULL_PATH
if [ $? -ne 0 ]; then
    echo "Failed to create directory"
    exit 1
fi

touch $FULL_PATH/README.md
if [ $? -ne 0 ]; then
    echo "Failed to create file"
    exit 1
fi

(
    cd $FULL_PATH
    echo "projeto $PROJECT_NAME inicializado...." >> ./README.md
    git init
    git add $FULL_PATH/README.md
    git commit -m "first commit - repositório configurado"
) > /dev/null 2>&1

echo "Repository created at $FULL_PATH"

exit 0