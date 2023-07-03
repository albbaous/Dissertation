#!/bin/bash
#SBATCH --job-name=H_K
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30g
#SBATCH --time=168:00:00
#SBATCH --output=/gpfs01/home/styab21/OandE/%x.out
#SBATCH --error=/gpfs01/home/styab21/OandE/%x.err

# Source directories
source_dir1="/gpfs01/home/styab21/prokka_gff_files/tests/H"
source_dir2="/gpfs01/home/styab21/prokka_gff_files/tests/directory_11"

# Destination directory
dest_dir="/gpfs01/home/styab21/prokka_gff_files/tests/H_K"

# Create the destination directory if it doesn't exist
mkdir -p "$dest_dir"

# Copy GFF files from the first source directory
cp "$source_dir1"/*.gff "$dest_dir"

# Copy GFF files from the second source directory
cp "$source_dir2"/*.gff "$dest_dir"

echo "GFF files copied successfully to $dest_dir"
