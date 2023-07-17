import os
import csv
from Bio import SeqIO

# Specify the directory
directory_path = "ncbi_dataset/data"

# Specify the output file
output_file_path = "output.csv"

# Open the output file
with open(output_file_path, 'w', newline='') as output_file:
    writer = csv.writer(output_file)
    writer.writerow(["File name", "Species name"])  # Write the header
    
    # Loop over subdirectories
    for subdir, dirs, files in os.walk(directory_path):
        for file in files:
            # Check if file is .fna
            if file.endswith('.fna'):
                file_path = os.path.join(subdir, file)

                with open(file_path, 'r') as fna_file:
                    # Loop over the records in the fasta file
                    for record in SeqIO.parse(fna_file, 'fasta'):
                        # Extract the species name after 'NZ_AP' and 8 random numbers
                        species_name = ' '.join(record.description.split()[1:3])  # Now only the first two words are taken
                        # Write the file name and species name to the output file
                        writer.writerow([file, species_name])
