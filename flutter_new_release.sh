#!/bin/bash

# Script to create a new Flutter release branch from the main branch.

# Enhanced print_message function to accept color codes
print_message() {
    local color=$1
    local message=$2
    echo "$(tput setaf $color)$message$(tput sgr0)"
}

error_exit() {
    print_message 1 "$1" # Red message for errors
    exit 1
}

# Check if git is installed
if ! command -v git &> /dev/null
then
    error_exit "git could not be found. Please install git."
fi

# Fetch the latest main branch and all remote branches
git fetch --all

# Check for release name argument
if [ $# -eq 0 ]
  then
    error_exit "No release name supplied. Usage: ./flutter_new_release.sh <release_name>"
fi

RELEASE_NAME=$1
RELEASE_BRANCH="release/$RELEASE_NAME"

# Check if the release branch already exists locally
if git branch --list $RELEASE_BRANCH | grep -q $RELEASE_BRANCH; then
    error_exit "The release branch '$RELEASE_BRANCH' already exists locally. Choose a different name or delete the existing branch if it's no longer needed."
fi

# Check if the release branch already exists on remote
if git ls-remote --heads origin $RELEASE_BRANCH | grep -q $RELEASE_BRANCH; then
    error_exit "The release branch '$RELEASE_BRANCH' already exists on remote. Choose a different name or delete the existing branch if it's no longer needed."
fi

# Create a new release branch from the main
git checkout -b $RELEASE_BRANCH main

if [ $? -ne 0 ]; then
    error_exit "Failed to create a new release branch. Make sure the branch name doesn't conflict with existing branches."
fi

print_message 2 "A new release branch '$RELEASE_BRANCH' has been created successfully from the main branch."

# Push the new release branch to remote
git push -u origin $RELEASE_BRANCH

if [ $? -ne 0 ]; then
    error_exit "Failed to push the new release branch to the remote repository."
fi

print_message 2 "The release branch '$RELEASE_BRANCH' has been pushed to the remote repository successfully."
