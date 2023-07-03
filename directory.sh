#!/bin/bash
#SBATCH --job-name=directory
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30g
#SBATCH --time=10:00:00
#SBATCH --output=/gpfs01/home/styab21/prokka_gff_files/%x.out
#SBATCH --error=/gpfs01/home/styab21/prokka_gff_files/%x.err

# Source directory path
source_directory="/gpfs01/home/styab21/prokka_gff_files"

# Destination base directory path
destination_base="/gpfs01/home/styab21/prokka_gff_files/tests"

# Create the destination directories
num_directories=11
files_per_directory=25

# Retrieve GFF files from the source directory
files=("$source_directory"/*.gff)
num_files=${#files[@]}

# Calculate the number of files per subdirectory
files_per_subdirectory=$((num_files / num_directories))

# Shuffle the files randomly
shuffled_files=($(shuf -e "${files[@]}"))

# Distribute the files into subdirectories
counter=0
for ((i=1; i<=num_directories; i++)); do
    # Create destination directory
    destination_directory="$destination_base/directory_$i"
    mkdir -p "$destination_directory"

    # Copy files to the destination directory
    for ((j=counter; j<counter+files_per_directory; j++)); do
        if [ "$j" -ge "$num_files" ]; then
            break
        fi
	file="${shuffled_files[$j]}"
        cp "$file" "$destination_directory"
        echo "Copied $file to $destination_directory"
    done

    counter=$((counter+files_per_directory))
done
