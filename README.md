# Create Repository Script

This project provides a set of scripts to create a new project directory, initialize a Git repository, and set up an alias for easy execution.

## Files

- `cr_aliases.sh`: This script sets up an alias for the `create_repository.sh` script.
- `create_repository.sh`: This script creates a new project directory, initializes a Git repository, and creates a README file.

## Usage

### Setting Up the Alias

1. Ensure `cr_aliases.sh` is executable:
    
    ```shell
    cd /path/to/cr_aliases.sh
    chmod u+x cr_aliases.sh
    ```

2. Run cr_aliases.sh to set up the alias:
    
    ```shell
    ./cr_aliases.sh
    ```

3. Creating a New Repository

    Once the alias is set up, you can create a new repository using the crep alias.

    **Example**:

    Create a project in the home directory:
    
    ```shell
    crep my_project
    ```

    Create a project in a specified directory:
    
    ```shell
    crep /path/to/directory my_project
    ```