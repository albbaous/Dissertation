#!/bin/bash

# Source directory
source_dir="/home/styab21/scratch/ncbi_dataset/data"

# Destination directory
destination_dir="/home/styab21/scratch/prokka_results"

# Create the destination directory if it doesn't exist
mkdir -p "$destination_dir"

# Iterate over each subdirectory under the source directory
for subdir in "$source_dir"/*/; do
  if [ -d "$subdir" ]; then
    # Extract the name of the subdirectory
    subdir_name=$(basename "$subdir")
    
    # Check if the 'prokka' subdirectory exists
    if [ -d "$subdir/prokka" ]; then
      # Rename and move the 'prokka' subdirectory
      mv "$subdir/prokka" "$destination_dir/$subdir_name"
      echo "Moved $subdir/prokka to $destination_dir/$subdir_name"
    else
      echo "No 'prokka' subdirectory found in $subdir"
    fi
  fi
done
