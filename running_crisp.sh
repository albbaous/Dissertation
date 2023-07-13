#!/bin/bash

directory="/home/styab21/scratch/CRISPRCasFinder-master"
for file in "$directory"/*.fasta; do
        perl CRISPRCasFinder.pl -in "$file" -cas
done

