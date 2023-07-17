import pandas as pd
from fuzzywuzzy import fuzz

# Load the CSV files into dataframes
traits_df = pd.read_csv('traits2.csv')
output_df = pd.read_csv('output.csv')

# Create a mapping dictionary using fuzzy matching
output_dict = {}
for traits_file in traits_df.iloc[:, 0]:
    match_score = -1  # Initialize match score
    match_filename = None  # Initialize matched filename
    for output_file in output_df['File name']:
        score = fuzz.ratio(traits_file[:13], output_file[:13])  # Calculate match score
        if score > match_score:
            match_score = score
            match_filename = output_file
    if match_filename is not None:
        # Check if there are duplicate matches
        if match_filename in output_dict.values():
            # Append a suffix to make it unique
            suffix = 1
            while f'{match_filename}_{suffix}' in output_dict.values():
                suffix += 1
            match_filename = f'{match_filename}_{suffix}'
        output_dict[traits_file] = output_df.loc[output_df['File name'] == match_filename, 'Species name'].iloc[0]

# Replace the values in the first column of the traits dataframe using the mapping dictionary
traits_df.iloc[:, 0] = traits_df.iloc[:, 0].map(output_dict).fillna(traits_df.iloc[:, 0])

# Save the updated dataframe back to 'traits2.csv'
traits_df.to_csv('traits2.csv', index=False)
