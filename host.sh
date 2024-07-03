#!/bin/bash

# Set up Termux storage access
termux-setup-storage

# Wait for user confirmation to continue
read -rp "Press Enter once storage access has been set up..."

# Set the target directory
TARGET_DIR="$HOME/storage/shared/#Coding"

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "Directory not found: $TARGET_DIR"
  exit 1
fi

# Change to the target directory
cd "$TARGET_DIR" || exit

# List the directories within the target directory
echo "Contents of $TARGET_DIR:"
dirs=()
index=1
for dir in */; do
  if [ -d "$dir" ]; then
    echo "$index) $dir"
    dirs+=("$dir")
    ((index++))
  fi
done

# Add option to create a new folder
echo "$index) Create a new folder"

# Prompt the user to choose a directory or create a new one
read -rp "Enter the number of the directory you want to navigate to (or $index to create a new folder): " choice

if [[ "$choice" -ge 1 && "$choice" -le "${#dirs[@]}" ]]; then
  selected_dir="${dirs[$((choice-1))]}"
  echo "Navigating to: $selected_dir"
  cd "$selected_dir" || exit
elif [[ "$choice" -eq "$index" ]]; then
  read -rp "Enter the name of the new folder: " new_folder
  mkdir "$new_folder"
  cd "$new_folder" || exit
  echo "Created and navigating to: $new_folder"
else
  echo "Invalid choice"
  exit 1
fi

# Ask the user if they want to host a site using Firebase
read -rp "Do you want to host a site here? (yes/no): " host_site

if [[ "$host_site" == "yes" || "$host_site" == "y" ]]; then
  # Run the Firebase deploy command
  firebase deploy --only hosting
else
  echo "Firebase hosting deployment skipped."
fi
