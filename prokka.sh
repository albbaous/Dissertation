#!/bin/bash

# Directory where genomes are 
ref_dir="/home/styab21/scratch/ncbi_dataset/data"

# Find all .fna files in the reference genomes directory and its subdirectories
fasta_files=$(find $ref_dir -name "*.fna")

# Loop through each FASTA file
for file in $fasta_files; do
    # Get the directory and filename of the .fna file
    dir=$(dirname $file)
    filename=$(basename $file)
    genome_name=${filename%.*}

    # Run Prokka on the genome
    prokka --outdir $dir/prokka \
           --prefix $genome_name \
           --force \
           --addgenes \
           --locustag $genome_name \
           $file
done
