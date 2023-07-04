#!/bin/bash
#SBATCH --job-name=extract_fasta
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30g
#SBATCH --time=120:00:00
#SBATCH --output=/gpfs01/home/styab21/OandE/%x.out
#SBATCH --error=/gpfs01/home/styab21/OandE/%x.err

# Source directory containing GFF files
source_dir="/gpfs01/home/styab21/prokka_gff_files/tests/H_K"

# Destination directory for new FASTA files
dest_dir="/gpfs01/home/styab21/prokka_gff_files/tests/H_K/fasta_files"

# Create the destination directory if it doesn't exist
mkdir -p "$dest_dir"

# Iterate over each GFF file in the source directory
for gff_file in "$source_dir"/*.gff; do
    # Extract the filename (without extension) from the GFF file
    filename=$(basename "$gff_file" .gff)

    # Create a new FASTA file for the current GFF file
    fasta_file="$dest_dir/$filename.fasta"
    touch "$fasta_file"

    # Extract the FASTA sections from the GFF file
    awk '/^##FASTA/{flag=1;next}/^##/{flag=0}flag' "$gff_file" >> "$fasta_file"

    echo "Created $fasta_file"
done

echo "New FASTA files created successfully in $dest_dir"
