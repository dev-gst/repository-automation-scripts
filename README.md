# Branch Management Scripts

This project provides a set of scripts to manage Git branches and repositories, including creating new project directories, initializing Git repositories, and setting up aliases for easy execution.

## Files

- `setup.sh`: This script sets up the environment by copying necessary files and creating aliases.
- `aczginit.sh`: This script creates a new feature branch in a Git repository.
- `aczgfinish.sh`: This script merges a feature branch into the master or main branch and optionally deletes the remote branch.
- `cr_repo.sh`: This script creates a new project directory, initializes a Git repository, and creates a README file.

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

## Scripts

### setup.sh

This script sets up the environment by copying necessary files and creating aliases.

#### Functionality

- Copies the branch_management folder to the user's home directory.
- Creates aliases for the scripts in the bin directory.
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