#!/bin/bash
#SBATCH --job-name=f_directory
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30g
#SBATCH --time=10:00:00
#SBATCH --output=/gpfs01/home/styab21/error/%x.out
#SBATCH --error=/gpfs01/home/styab21/error/%x.err

# Base directory paths
base_directory="/gpfs01/home/styab21/prokka_gff_files/tests"
output_directories=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K")

# Iterate over output directories
for ((i=0; i<${#output_directories[@]}; i++)); do
    output_directory="${base_directory}/${output_directories[i]}"
    mkdir -p "$output_directory"

    # Copy files from directories 1 to i+1
    for ((j=1; j<=i+1; j++)); do
        source_directory="${base_directory}/directory_$j"
        cp -r "$source_directory"/* "$output_directory"
    done

    echo "Combined directories 1 to $((i+1)) into $output_directory"
done
