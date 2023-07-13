#!/bin/bash

# Define the input files
TRAITS_FILE="traits5.csv"
COLUMN_FILE="column_15_names.txt"

# Define a temporary output file
TEMP_FILE="temp2.csv"

# Make sure the temp file is empty
cat /dev/null > "$TEMP_FILE"

# Read the COLUMN_FILE line by line
while IFS= read -r column_line; do
  # Extract the GCF name and the first 9 digits after GCF_
  gcf_name=$(echo "$column_line")
  gcf_id=$(echo "$column_line" | cut -d'_' -f2 | cut -d'.' -f1 | cut -c1-9)

  # Read the TRAITS_FILE line by line
  while IFS= read -r traits_line; do
    # Extract the Result_GCF name and the first 9 digits after Result_GCF_
    result_gcf_name=$(echo "$traits_line" | cut -d',' -f1)
    result_gcf_id=$(echo "$result_gcf_name" | cut -d'_' -f3 | cut -c1-9)

    # If the first 9 digits match, replace the Result_GCF name in the traits.csv with the GCF name
    if [ "$gcf_id" = "$result_gcf_id" ]; then
      traits_line=${traits_line/$result_gcf_name/$gcf_name}
    fi

    # Write the (possibly modified) traits_line to the TEMP_FILE
    echo "$traits_line" >> "$TEMP_FILE"

  done < "$TRAITS_FILE"

  # Move the TEMP_FILE to the TRAITS_FILE for the next iteration
  mv "$TEMP_FILE" "$TRAITS_FILE"
  cat /dev/null > "$TEMP_FILE"

done < "$COLUMN_FILE"

# Clean up: remove the TEMP_FILE
rm "$TEMP_FILE"
