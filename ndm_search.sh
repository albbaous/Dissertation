#!/bin/bash

# Input FASTA file
input_file="/home/styab21/scratch/nucleotide_fasta_protein_homolog_model.fasta"

# Output file for NDM sequences
output_file="/home/styab21/scratch/fasta_files/ndm_all.fasta"

# Pattern to match for NDM sequences
pattern="NDM"

# Initialize the output file
> "$output_file"

# Read the input FASTA file
while IFS= read -r line; do
    # Check if the line starts with '>'
    if [[ $line =~ ^\> ]]; then
        # Check if the description contains 'NDM'
        if [[ $line =~ $pattern ]]; then
            # Write the description line to the output file
            echo "$line" >> "$output_file"
            
            # Read the sequence lines until the next description line
            while IFS= read -r sequence_line && ! [[ $sequence_line =~ ^\> ]]; do
                echo "$sequence_line" >> "$output_file"
            done
        fi
    fi
done < "$input_file"
