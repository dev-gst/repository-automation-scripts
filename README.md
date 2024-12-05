# Branch Management and Automation Scripts

This project provides a set of scripts to manage Git branches, automate Gradle tests, and set up project environments. The scripts include creating new project directories, initializing Git repositories, setting up aliases, and scheduling Gradle tests.

## Files

- `setup.sh`: This script sets up the environment by copying necessary files and creating aliases.
- `aczginit.sh`: This script creates a new feature branch in a Git repository.
- `aczgfinish.sh`: This script merges a feature branch into the master or main branch and optionally deletes the remote branch.
- `cr_repo.sh`: This script creates a new project directory, initializes a Git repository, and creates a README file.
- `gradle_test.sh`: This script runs Gradle tests and logs the output.
- `gradlelogs.sh`: This script displays the Gradle test logs.
- `schedule_gradle_test.sh`: This script schedules the `gradle_test.sh` script to run at specified times using cron.

## Usage

### Setting Up the Environment

1. Ensure `setup.sh` is executable:

    ```shell
    chmod u+x setup.sh
    ```

2. Run `setup.sh` to set up the environment and create aliases:

    ```shell
    ./setup.sh
    ```

3. Open a new terminal to use the aliases.

### Creating a New Feature Branch

1. Use the `aczginit` alias to create a new feature branch:

    ```shell
    aczginit <feature-name>
    ```

    - `<feature-name>`: The name of the new feature branch.

### Finishing a Feature Branch

1. Use the `aczgfinish` alias to merge the feature branch into the master or main branch:

    ```shell
    aczgfinish [-d]
    ```

    - `-d`: (Optional) Delete the remote branch after merging.

### Creating a New Repository

1. Use the `crep` alias to create a new project directory and initialize a Git repository:

    ```shell
    crep [project_path] <project_name>
    ```

    - `[project_path]`: (Optional) The path where the project directory will be created. If not provided, the project will be created in the user's home directory.
    - `<project_name>`: The name of the project directory to be created.

### Running Gradle Tests

1. Use the `gradletest` alias to run Gradle tests and log the output:

    ```shell
    gradletest
    ```

### Viewing Gradle Test Logs

1. Use the `gradlelogs` alias to display the Gradle test logs:

    ```shell
    gradlelogs
    ```

### Scheduling Gradle Tests

1. Use the `schedule_gradle_test` alias to schedule the gradle_test.sh script to run at specified times using cron:

    ```shell
    schedule_gradle_test [time]
    ```

    - `[time]`: (Optional) The cron time format to schedule the script. If not provided, the default time `0 1 * * *` will be used.

## Scripts

### setup.sh

This script sets up the environment by copying necessary files and creating aliases.

#### Functionality

- Copies the dev_automation folder to the user's home directory.
- Creates aliases for the scripts in the `bin` directory.
- Adds the aliases to the user's shell configuration file (e.g., `~/.bashrc`).

### aczginit.sh

This script creates a new feature branch in a Git repository.

#### Functionality

- Accepts one argument: `<feature-name>`.
- Creates and checks out a new branch with the name `feat-<feature-name>`.
- Lists all branches in the repository.

### aczgfinish.sh

This script merges a feature branch into the master or main branch and optionally deletes the remote branch.

#### Functionality

- Accepts one optional argument: `-d`.
- Merges the current feature branch into the master or main branch.
- Deletes the local feature branch.
- Deletes the remote feature branch if the `-d` option is provided.

### cr_repo.sh

This script creates a new project directory, initializes a Git repository, and creates a README file.

#### Functionality

- Accepts one or two arguments: `[project_path] <project_name>`.
- Creates the project directory.
- Initializes a Git repository in the project directory.
- Creates a README.md file with an initial message.
- Commits the initial setup to the Git repository.

### gradle_test.sh

This script runs Gradle tests and logs the output.

#### Functionality

- Sources environment variables from a `.env` file.
- Runs the `gradlew clean test` command.
- Logs the output to `gradle_test.log`.

### gradlelogs.sh

This script displays the Gradle test logs.

#### Functionality

- Sources environment variables from a `.env` file.
- Displays the contents of `gradle_test.log` using `less`.

### schedule_gradle_test.sh

This script schedules the `gradle_test.sh` script to run at specified times using cron.

#### Functionality

- Accepts one optional argument: `[time]`.
- Validates the cron time format.
- Schedules the `gradle_test.sh` script to run at the specified time.
- Removes duplicate cron jobs for the script.
- Adds the new cron job to the user's crontab.