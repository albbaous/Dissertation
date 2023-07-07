#!/bin/bash

# Path to the directory containing FASTA files
fasta_dir="/home/styab21/scratch/fasta_files"

# Path to the output directory for the combined FASTA file and BLAST database
output_dir="/home/styab21/scratch/fasta_files/blast_db"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Combine all FASTA files into a single file
combined_fasta="$output_dir/combined.fasta"

# Concatenate all FASTA files into the combined FASTA file
cat "$fasta_dir"/*.fasta > "$combined_fasta"

# Create the BLAST database from the combined FASTA file
blast_db_path="$output_dir/$database_name"

makeblastdb -in "$combined_fasta" -dbtype nucl -parse_seqids -title combined -out "$blast_db_path"
