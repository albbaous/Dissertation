#!/bin/bash

# Run BLAST search and output results
blastn -db combined -query per_all.fasta -out results.txt -outfmt 6
