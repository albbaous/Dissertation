#!/bin/bash

# Path to the output directory for the combined FASTA file and BLAST database
output_dir="/home/styab21/scratch/fasta_files/fasta_files/combined"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Create the BLAST database from the combined FASTA file
blast_db_path="$output_dir/$database_name"

makeblastdb -in combined.fasta -dbtype nucl -title combined -out "$blast_db_path" 
