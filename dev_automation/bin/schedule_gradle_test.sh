#!/bin/bash

GRADLE_TEST_SCRIPT_NAME="gradle_test.sh"
DEFAULT_TIME="0 1 * * *"
GRADLE_TEST_SCRIPT_PATH="$(dirname "${BASH_SOURCE[0]}")/$GRADLE_TEST_SCRIPT_NAME"

remove_duplicates() {
    local script_path="$1"

    crontab -l | awk -v deletion_pattern="$script_path" '$0 !~ deletion_pattern' | crontab - >/dev/null 2>&1
}

save_time_format() {
    local time="$1"
    local script_path="$2"

    local original_crontab=$(crontab -l 2>/dev/null)
    (
        echo "$time $script_path"
        echo "$original_crontab"
    ) | crontab - >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    else
        echo "$original_crontab" | crontab - >/dev/null 2>&1
        return 1
    fi
}

echo "Please, ensure you have java and cron service installed and running on your system"
echo "Please, make sure you export JAVA_HOME in the script $GRADLE_TEST_SCRIPT_PATH"
echo "Please, make sure you have the correct path to the gradle project in the script $GRADLE_TEST_SCRIPT_PATH"
echo "This script will schedule the execution of $GRADLE_TEST_SCRIPT_PATH"
case $# in
    0)
        TIME=$DEFAULT_TIME
        echo "No time specified. Using default time: $DEFAULT_TIME"
        ;;
    1)
        TIME=$1
        ;;
    *)
        echo "Usage: command [time]"
        exit 1
        ;;
esac

if [ ! -f $GRADLE_TEST_SCRIPT_PATH ]; then
    echo "Error: Script not found at $GRADLE_TEST_SCRIPT_PATH"
    exit 2
fi

chmod u+x $GRADLE_TEST_SCRIPT_PATH
if [ $? -ne 0 ]; then
    echo "Error: Failed to make $GRADLE_TEST_SCRIPT_PATH executable" >&2
    exit 3
fi

remove_duplicates "$GRADLE_TEST_SCRIPT_PATH"
save_time_format "$TIME" "$GRADLE_TEST_SCRIPT_PATH"
if [ $? -eq 1 ]; then
    echo "Error: Invalid time format"
    exit 4
else
    echo "Script $GRADLE_TEST_SCRIPT_PATH scheduled to run at $TIME"
    echo "Current crontab:"
    crontab -l
fi

exit 0
