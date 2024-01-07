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

# Fetch the latest main branch
git checkout main && git pull origin main

# Check for release name argument
if [ $# -eq 0 ]
  then
    error_exit "No release name supplied. Usage: ./flutter_new_release.sh <release_name>"
fi

RELEASE_NAME=$1

# Create a new release branch from the main
git checkout -b release/$RELEASE_NAME main

if [ $? -ne 0 ]; then
    error_exit "Failed to create a new release branch. Make sure the branch name doesn't conflict with existing branches."
fi

print_message 2 "A new release branch 'release/$RELEASE_NAME' has been created successfully from the main branch."

# Push the new release branch to remote
git push -u origin release/$RELEASE_NAME

if [ $? -ne 0 ]; then
    error_exit "Failed to push the new release branch to the remote repository."
fi

print_message 2 "The release branch 'release/$RELEASE_NAME' has been pushed to the remote repository successfully."
