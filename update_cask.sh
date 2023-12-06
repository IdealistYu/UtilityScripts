#!/bin/bash

# Function to display section headers
print_section_header() {
  echo "=============================================="
  echo "$1"
  echo "=============================================="
}

# Update Homebrew formula
print_section_header "Updating Homebrew Formula"
brew update
echo

# Upgrade all formulae
print_section_header "Upgrading Formulae"
brew upgrade --formula
echo

# List of casks to exclude from the upgrade
excluded_casks=("godot")

# Get outdated casks excluding the ones in the exclusion list
outdated_casks=$(brew outdated --cask --greedy | grep -v -E "$(IFS=\| ; echo "${excluded_casks[*]}")" | awk '{print $1}')

# Display casks that will not be upgraded
print_section_header "Casks not being upgraded"
echo "${excluded_casks[@]}"
echo

# Display casks that will be upgraded
print_section_header "Casks being upgraded"
echo "${outdated_casks[@]}"
echo

# Upgrade only the specified casks
print_section_header "Upgrading Casks"
for cask in $outdated_casks; do
  brew upgrade --cask "$cask"
done
echo

# Cleanup old versions
print_section_header "Cleaning up old versions"
brew cleanup
echo

echo "Script execution completed."
