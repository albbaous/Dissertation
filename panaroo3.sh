#!/bin/bash
#SBATCH --job-name=Panaroo3
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=100g
#SBATCH --time=168:00:00
#SBATCH --output=/gpfs01/home/styab21/OandE/%x.out
#SBATCH --error=/gpfs01/home/styab21/OandE/%x.err

# Activate Conda
source $HOME/.bash_profile
conda activate /gpfs01/home/styab21/miniconda3/envs/panaroo

# running panaroo
mkdir results3
panaroo -i *.gff -o results3 --clean-mode sensitive -c 0.4 -a core --aligner clustal --core_threshold 0.98 -t 40
