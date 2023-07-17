import pandas as pd

# Read the CSV file
df = pd.read_csv('output.csv')

# Remove duplicate rows
df = df.drop_duplicates()

# Save the unique rows back to the CSV file
df.to_csv('output.csv', index=False)
