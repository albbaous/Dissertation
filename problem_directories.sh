#!/bin/bash
#SBATCH --job-name=IJK
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30g
#SBATCH --time=10:00:00
#SBATCH --output=/gpfs01/home/styab21/error/%x.out
#SBATCH --error=/gpfs01/home/styab21/error/%x.err

# Source directories
source_directory1="/gpfs01/home/styab21/prokka_gff_files/tests/directory_9"
source_directory2="/gpfs01/home/styab21/prokka_gff_files/tests/directory_10"
source_directory3="/gpfs01/home/styab21/prokka_gff_files/tests/directory_11"

# Destination directory
destination_directory="/gpfs01/home/styab21/prokka_gff_files/tests/IJK"

# Copy files from source directories to destination directory
cp "$source_directory1"/* "$destination_directory"
cp "$source_directory2"/* "$destination_directory"
cp "$source_directory3"/* "$destination_directory"

echo "All files copied to $destination_directory"

