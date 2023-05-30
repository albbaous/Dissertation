#!/bin/bash
#SBATCH --job-name=Roary
#SBATCH --partition=defq
#SBATCH --nodes=24
#SBATCH --ntasks-per-node=1
#SBATCH --mem=30g
#SBATCH --time=120:00:00
#SBATCH --output=/gpfs01/home/styab21/OandE/%x.out
#SBATCH --error=/gpfs01/home/styab21/OandE/%x.err


#Activate Conda
source $HOME/.bash_profile
conda activate /gpfs01/home/styab21/miniconda3/envs/roary_env

# Run Roary
roary -f roary_results -e -v --mafft -p 8 *.gff
