import csv

# Path to the output CSV file
output_file = "/home/styab21/scratch/fasta_files/fasta_files/combined/output.csv"

# Path to the BLAST results file
blast_results_file = "/home/styab21/scratch/fasta_files/fasta_files/combined/results.txt"

# Create a set to store the gene presence information
gene_presence = set()

# Read the genome names from the BLAST results file
with open(blast_results_file, "r") as file:
    reader = csv.reader(file, delimiter='\t')
    for row in reader:
        if len(row) >= 2:
            gene_presence.add(row[1])

# Update the output CSV file with gene presence information
updated_rows = []
with open(output_file, "r") as file:
    reader = csv.reader(file)
    for i, row in enumerate(reader):
        if i == 0:
            updated_rows.append(row)  # Append the header row as is
        else:
            genome = row[0]
            presence = int(genome in gene_presence)
            row[1] = presence
            updated_rows.append(row)

# Write the updated rows to a new output CSV file
new_output_file = "/home/styab21/scratch/fasta_files/fasta_files/combined/updated_output.csv"
with open(new_output_file, "w", newline="") as file:
    writer = csv.writer(file)
    writer.writerows(updated_rows)



