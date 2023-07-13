import csv

csv_file = "gene_presence_absence.csv"
txt_file = "column_14_names.txt"

# Read the CSV file
with open(csv_file, "r") as file:
    csv_reader = csv.reader(file)
    first_row = next(csv_reader)  # Get the first row

    # Extract names from column 15
    column_14_names = first_row[13:]

# Write names to a new text file
with open(txt_file, "w") as file:
    file.write("\n".join(column_14_names))
