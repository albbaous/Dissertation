import pandas as pd
import numpy as np

# Load file
file = "merged_Final.xls"
df = pd.read_excel(file)

# Initialize list to hold new data
newData = []

# Initialize temp variables
Name = ""
Crisp = 0
Cas = 0

# Main loop
for index, row in df.iterrows():
    # Check if the row is a 'Results' row or a 'NZ' row
    if str(row[0]).startswith("Res"):
        # Append data to list and reset counters if a new 'Results' row is found
        newData.append([Name, Crisp, Cas])
        Name = row[0]
        Crisp = 0
        Cas = 0
    elif str(row[0]).startswith("NZ"):
        # If a trait is present, denote it as 1
        Crisp = 1 if np.isfinite(row[2]) and row[2] != 0 else Crisp
        Cas = 1 if str(row[5]).isdigit() and int(row[5]) != 0 else Cas

# Append the last 'Results' row after the loop ends
newData.append([Name, Crisp, Cas])

# Convert the list to a DataFrame and save it as a .csv file
new_df = pd.DataFrame(newData, columns=['Name', 'Crisp', 'Cas'])
new_df.to_csv('traits_3.csv', index=False)
