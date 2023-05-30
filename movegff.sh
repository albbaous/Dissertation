#!/bin/bash

source_dir="/home/styab21/scratch/prokka_results"
target_dir="/home/styab21/scratch/prokka_gff_files"

# Create the target directory if it doesn't exist
mkdir -p "$target_dir"

# Find all GFF files in the subdirectories and move them to the target directory
find "$source_dir" -type f -name "*.gff" -exec mv -t "$target_dir" {} +

echo "GFF files moved to $target_dir"
