import csv

# Path to the input FASTA file
fasta_file = "combined.fasta"

# Path to the BLAST results file
blast_results_file = "results.txt"

# Path to the output CSV file
output_file = "output.csv"

# Read the genome names from the FASTA file
genome_names = []
with open(fasta_file, "r") as file:
    for line in file:
        if line.startswith(">"):
            genome_names.append(line.strip()[1:])

# Determine gene presence from the BLAST results
gene_presence = {}
with open(blast_results_file, "r") as file:
    for line in file:
        genome = line.strip().split(",")[0]
        gene_presence[genome] = 1

# Create the output CSV file
with open(output_file, "w", newline="") as file:
    writer = csv.writer(file)
    writer.writerow(["Genome", "oxa_presence"])
    for genome in genome_names:
        presence = gene_presence.get(genome, 0)
        writer.writerow([genome, presence])
