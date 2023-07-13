#!/bin/bash

# Define the source and destination paths
SOURCE_DIR="/home/styab21/scratch/CRISPRCasFinder-master/results"
DEST_FILE="/home/styab21/scratch/CRISPRCasFinder-master/results/merged_Final.xls"

# Create an empty merged file
cat /dev/null > "$DEST_FILE"

# Loop through all the directories starting with "Result_GCF"
for dir in "$SOURCE_DIR"/Result_GCF_*; do
  echo "Inspecting directory: $dir"

  if [ -d "$dir" ]; then
    echo "Directory $dir exists."
    if [ -d "$dir/TSV" ]; then
      echo "Directory $dir/TSV exists."

      # Extract the unique ID from the directory name
      unique_id=$(basename "$dir")
      echo "Unique ID is: $unique_id"

      # Build the file path
      file="$dir/TSV/CRISPR-Cas_summary_$unique_id.xls"
      echo "Expected file path is: $file"

      # Check if the file exists and cat its contents to the merged file
      if [ -f "$file" ]; then
        echo "File $file exists."
        # Add the ID number as a line in the merged .xls file
        echo "$unique_id" >> "$DEST_FILE"

        # Concatenate the file contents to the merged .xls file
        cat "$file" >> "$DEST_FILE"
      else
        echo "File $file does not exist."
      fi
    else
      echo "Directory $dir/TSV does not exist."
    fi
  else
    echo "Directory $dir does not exist."
  fi
done

echo "Merging completed successfully!"
