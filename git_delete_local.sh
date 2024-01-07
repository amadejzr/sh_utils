#!/bin/bash

# Script to delete all local branches not present on the remote (origin)

# Function to print messages with color
print_message() {
    local color=$1
    local message=$2
    echo "$(tput setaf $color)$message$(tput sgr0)"
}

# Function to handle errors
error_exit() {
    print_message 1 "$1" # Red message for errors
    exit 1
}

# Check if git is installed
if ! command -v git &> /dev/null
then
    error_exit "git could not be found. Please install git."
fi

# Fetch the latest branches from the origin
git fetch origin

# Get a list of local branches
local_branches=$(git branch | sed 's/*//g' | tr -d ' ')
delete_all=false

# Loop through each local branch and check if it exists on the remote
for branch in $local_branches; do
    # Skip the main and master branches or any other branch you want to preserve.
    if [[ "$branch" == "main" || "$branch" == "master" ]]; then
        continue
    fi
    
    # Check if the branch exists on the remote
    if ! git show-ref --verify --quiet refs/remotes/origin/$branch; then
        if [ "$delete_all" == false ]; then
            print_message 3 "Local branch '$branch' does not exist on the remote. Delete? [y/n/All]"
            read -r input
            if [ "$input" == "All" ]; then
                delete_all=true
            elif [ "$input" != "y" ]; then
                print_message 2 "Skipping '$branch'."
                continue
            fi
        fi
        # If the branch doesn't exist on the remote, delete it locally
        print_message 3 "Deleting local branch: $branch"
        git branch -D $branch
    else
        print_message 2 "Keeping local branch: $branch"
    fi
done

print_message 2 "Cleanup complete."
