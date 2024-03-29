# Flutter Shell Utilities

Welcome to `flutter_sh_utils`! This repository is a collection of shell scripts designed to streamline and automate various tasks for Flutter developers. Whether you're setting up a new project, managing dependencies, or preparing your app for release, my scripts are here to help you.

## Getting Started

These instructions will guide you on how to utilize the scripts effectively for development and testing purposes.

### Prerequisites

Before you start using the scripts, make sure you have the following installed:

- Flutter: Is required for some scripts. [Install Flutter](https://flutter.dev/docs/get-started/install) if you haven't already.
- Git: Git is required for some scripts. [Install Git from](https://git-scm.com/) if you haven't already.
- Bash: The scripts are written for Bash shell. Most Unix-like systems have this installed by default.

### Important Note

**All scripts are designed to be run from a specific location within your Flutter project (e.g., `developer/flutter/packages/`). Please ensure you navigate to the appropriate directory within your project before executing any script.**

### Installation

#### Method 1: Clone & Make Executable

1. **Clone the repository to a known location outside your project:**

    ```bash
    git clone https://github.com/amadejzr/flutter_sh_utils.git
    ```

2. **Make the scripts executable:**

    Navigate to the `flutter_sh_utils` directory and for each script you intend to use, make it executable:

    ```bash
    chmod +x script_name.sh
    ```

#### Method 2: Download and Execute Directly

If you prefer not to clone the entire repository, you can directly download and execute a specific script from within your desired project directory:

1. **Download a script using `curl` or `wget` and execute immediately:**

    ```bash
    curl -O https://raw.githubusercontent.com/amadejzr/flutter_sh_utils/main/script_name.sh && chmod +x script_name.sh && ./script_name.sh arguments
    # OR
    wget https://raw.githubusercontent.com/amadejzr/flutter_sh_utils/main/script_name.sh && chmod +x script_name.sh && ./script_name.sh arguments
    ```

    Replace `script_name.sh` with the actual script and `arguments` with any required inputs.

#### Method 3: Install Globally

For frequent use, consider adding the scripts to a directory in your `PATH`:

1. **Clone the repository and navigate into it as described in Method 1.**

2. **Copy the scripts to a directory in your `PATH`, like `/usr/local/bin`:**

    ```bash
    sudo cp script_name.sh /usr/local/bin
    ```

3. **Now you can run the script from your project's specific directory without the `./`:**

    ```bash
    script_name.sh arguments
    ```

## Usage

Before using any script, navigate to the specific directory within your Flutter project where the script is intended to be run (e.g., `developer/flutter/packages/`).

### Local Execution

If you've cloned the repository or downloaded the script directly:

1. **Navigate to your project's specific directory:**

    ```bash
    cd path/to/developer/flutter/packages
    ```

2. **Run the script:**

    ```bash
    path/to/flutter_sh_utils/script_name.sh arguments
    ```

### Global Execution

If you've installed the script globally:

1. **Navigate to your project's specific directory:**

    ```bash
    cd path/to/developer/flutter/packages
    ```

2. **Run the script from anywhere:**

    ```bash
    script_name.sh arguments
    ```

**Note:** Ensure you have the necessary permissions to execute the script, and it's marked as executable (`chmod +x script_name.sh`).


### Available Scripts

1. **flutter_create_package**: 

   Create a new Flutter package
   This script automates the process of creating a new Flutter package within the specified directory in your project. It sets up essential directories like 'screenshots', and files like 'README.md' and 'CHANGELOG.md'. The script ensures the package name is unique and adds the package dependency to the example's 'pubspec.yaml'. It also provides robust error handling to roll back changes if the process fails at any point. **Ensure you are in the correct directory within your Flutter project before running this script.**

   **Usage**: `./flutter_create_package.sh package_name`
   
   **Arguments**:
    - `package_name`: The desired name for your Flutter package. Provide a unique name for the script to create a new Flutter package in the current directory.
---
2. **git_new_release**: 

   Create a new release branch
   This script automates the process of creating a new release branch from your project's main branch. It ensures you are working with the latest main branch, creates a new release branch with a name you provide, and then pushes this new branch to your remote repository. The script includes enhanced messaging to inform you of the progress and robust error handling to manage any issues that might arise during the process.
   
   **Ensure you are in the correct directory within your project and have the necessary permissions for the repository before running this script.**

   **Usage**: `./git_new_release.sh release_name`
   
   **Arguments**:
    - `release_name`: The desired name for your release branch. Provide a unique name for the script to create a new release branch from the main branch in your repository.
---
3. **delete_local_branches**:

   Delete local branches not present on the remote
   This script automates the process of deleting local branches that do not have a corresponding remote branch on the origin. It fetches the latest branches from the origin, checks each local branch, and offers an interactive prompt to delete branches individually or all at once. The script includes enhanced messaging to inform you of the progress and robust error handling to manage any issues that might arise during the process.

   **Ensure you have committed any important changes and are in the correct directory of your Git repository before running this script. It is recommended to perform a backup of important branches.**

   **Usage**: `./delete_local_branches.sh`
   
   **Interactive Options**:
    - `y`: Confirm the deletion of the current branch.
    - `n`: Skip the deletion of the current branch.
    - `All`: Delete all remaining branches without further confirmation.

<!-- Additional script details can be added here -->

---

Thank you for using `flutter_sh_utils`! I hope these scripts make your Flutter development smoother and more enjoyable.
