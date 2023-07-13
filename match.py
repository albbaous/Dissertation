directory_titles_file = "directory_titles.txt"
traits_file = "traits.txt"
matched_output_file = "matched_rows.txt"
unmatched_output_file = "unmatched_rows.txt"

# Read directory titles and traits into lists
directory_titles = []
with open(directory_titles_file, "r") as file:
    for line in file:
        directory_titles.append(line.strip())

traits = []
with open(traits_file, "r") as file:
    for line in file:
        traits.append(line.strip())

# Matched and unmatched rows lists
matched_rows = []
unmatched_rows = []

# Match rows based on the last 10 digits
for title in directory_titles:
    title_last_digits = title[-10:]
    found_match = False
    for trait in traits:
        trait_last_digits = trait[-10:]
        if title_last_digits == trait_last_digits:
            matched_rows.append((title, trait))
            found_match = True
            break
    if not found_match:
        unmatched_rows.append(title)

# Write matched rows to the matched output file
with open(matched_output_file, "w") as file:
    for title, trait in matched_rows:
        file.write(f"{title}\t{trait}\n")

# Write unmatched rows to the unmatched output file
with open(unmatched_output_file, "w") as file:
    for row in unmatched_rows:
        file.write(f"{row}\n")
