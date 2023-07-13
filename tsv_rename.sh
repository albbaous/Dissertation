#!/bin/bash

parent_directory="/home/styab21/scratch/CRISPRCasFinder-master/results"

for directory in "$parent_directory"/Result_GCF*; do
    if [ -d "$directory" ]; then
        directory_id=$(basename "$directory")
        tsv_directory="$directory/TSV"
        for filename in "$tsv_directory"/*; do
            new_filename=$(basename "$filename" | sed -e "s/REPORT/REPORT_$directory_id/" -e "s/summary/summary_$directory_id/")
            mv "$filename" "$tsv_directory/$new_filename"
        done
    fi
done
