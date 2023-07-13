import pandas as pd

# Import file and convert to numpy array
file = "merged_Final.xls"
df = pd.read_excel(file)
data = df.to_numpy()
print(data[0])

# New data array
newData = []

# Temp variables
Name = ""
Crisp = 0
Cas = 0

# Main loop
for row in data:
    # if new results row found
    if row[0].startswith("Res"):
        if Crisp > 1:
            Crisp = 1
        if Cas > 1:
            Cas = 1
        # append to new data array
        newData.append([Name, Crisp, Cas])
        # reset temp variables
        Name = row[0]
        Crisp = 0
        Cas = 0
    # add values
    elif row[0].startswith("NZ"):
        Crisp += row[2]
        if isinstance(row[5], str) and row[5].isdigit():
            Cas += int(row[5])

# calculate last results cluster
newData.append([Name, Crisp, Cas])

# Export as csv
newFile = "traits.csv"
pd.DataFrame(newData).to_csv(newFile, index=False)
