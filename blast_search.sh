#!/bin/bash

# Set the BLASTDB environment variable
BLASTDB=/home/styab21/scratch/fasta_files/blast_db

# Run BLAST search and output results
blastn -db combined -query ndm_all.fasta -out results.txt -outfmt 6
