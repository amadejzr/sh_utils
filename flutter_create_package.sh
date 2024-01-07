#!/bin/bash

# Enhanced script to create a Flutter package with additional files and configurations.

# Function to print messages with color.
print_message() {
    local color=$1
    local message=$2
    echo "$(tput setaf $color)$message$(tput sgr0)"
}

# Function to handle errors and rollback changes.
handle_error() {
    local err_msg="${1:-'Unknown Error'}" # Default to 'Unknown Error' if no error message is provided.
    local err_line="${2:-'Unknown Line'}"  # Default to 'Unknown Line' if no line number is provided.
    print_message 1 "An error occurred on line $err_line: $err_msg. Rolling back changes..."
    # Navigate back to the original directory.
    cd "$current_dir"
    # Remove the created package directory if it exists.
    [[ -d "$name" ]] && rm -rf "$name"
    exit 1
}

# Ensure the script is terminated on any errors and captures the line number.
trap 'handle_error "$?" "$LINENO"' ERR

# Assign the first argument to the variable 'name'.
name="$1"

# Save the current directory to return back in case of failure.
current_dir=$(pwd)

# Check if the package name is provided.
if [[ -z "$name" ]]; then
  handle_error "No package name provided" "$LINENO"
fi

# Check if the directory with the package name already exists.
if [[ -d "$name" ]]; then
  print_message 1 "The directory '$name' already exists. Please choose a different name or remove the existing directory."
  exit 1
fi

# Create the Flutter package and check for errors.
flutter create --template=package "$name"

# Navigate into the package directory.
cd "$name"

print_message 3 "Creating dir screenshots and files README and CHANGELOG"

# Create README.md with the specified content.
echo "TODO: UPDATE READ ME" > README.md

# Create CHANGELOG.md with the specified content.
echo "TODO: UPDATE CHANGE LOG" > CHANGELOG.md

# Create the 'screenshots' directory.
mkdir screenshots

print_message 3 "Creating a new Flutter project inside the 'example' directory..."

# Create the 'example' directory and navigate into it.
mkdir example && cd example

# Create a new Flutter project inside the 'example' directory.
flutter create . > /dev/null 2>&1

# Navigate back to the main package directory.
cd ..

# Add the package dependency to the example's pubspec.yaml.
sed -i '' "/dependencies:/a\\
  flutter:\\
    sdk: flutter\\
  $name:\\
    # When depending on this package from a real application you should use:\\
    #   $name: ^x.y.z\\
    # The example app is bundled with the plugin so we use a path dependency on\\
    # the parent directory to use the current plugin's version.\\
    path: ../
" example/pubspec.yaml

# Print completion message.
print_message 2 "Flutter package '$name' has been created successfully with all specified files and configurations."
