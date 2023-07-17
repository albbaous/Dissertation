from Bio import Phylo

# Read the Newick tree file
tree = Phylo.read('my_tree.newick', 'newick')

# Get the number of branches
num_branches = len(tree.get_terminals()) - 1

# Print the number of branches
print("Number of branches:", num_branches)
