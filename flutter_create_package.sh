#!/bin/bash

# Assign the first argument to the variable 'name'.
name=$1

# Save the current directory to return back in case of failure.
current_dir=$(pwd)

# Function to handle errors and rollback changes.
handle_error() {
    echo "An error occurred. Rolling back changes..."
    # Navigate back to the original directory.
    cd "$current_dir"
    # Remove the created package directory if it exists.
    if [ -d "$name" ]; then
        rm -rf "$name"
    fi
    exit 1
}

# Check if the package name is provided.
if [ -z "$name" ]; then
  echo "Please provide a package name."
  echo "Usage: $0 package_name"
  exit 1
fi

# Create the Flutter package and check for errors.
flutter create --template=package "$name" || handle_error

# Navigate into the package directory.
cd "$name" || handle_error

echo "$(tput setaf 3)Creating dir screenshots and files README and CHANGELOG$(tput sgr0)"

# Create README.md with the specified content.
echo "TODO: UPDATE READ ME" > README.md || handle_error

# Create CHANGELOG.md with the specified content.
echo "TODO: UPDATE CHANGE LOG" > CHANGELOG.md || handle_error

# Create the 'screenshots' directory.
mkdir screenshots || handle_error


echo "$(tput setaf 3)Creating a new Flutter project inside the 'example' directory...$(tput sgr0)"

# Create the 'example' directory and navigate into it.
mkdir example && cd example || handle_error

# Create a new Flutter project inside the 'example' directory.
flutter create . > /dev/null 2>&1 || handle_error

# Navigate back to the main package directory.
cd .. || handle_error

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
" example/pubspec.yaml || handle_error

# Print completion message.
echo "$(tput setaf 2)Flutter package '$name' has been created successfully with all specified files and configurations.$(tput sgr0)"

