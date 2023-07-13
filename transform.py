import pandas as pd

# Load your CSV file
df = pd.read_csv('traits.csv')

# Perform any cleaning or transformations...

# Save it back to a CSV
df.to_csv('traits2.csv', index=False)
