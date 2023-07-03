#!/bin/bash
#SBATCH --job-name=Roary_HK
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=100g
#SBATCH --time=168:00:00
#SBATCH --output=/gpfs01/home/styab21/error/%x.out
#SBATCH --error=/gpfs01/home/styab21/error/%x.err

# Activate Conda
source $HOME/.bash_profile
conda activate /gpfs01/home/styab21/miniconda3/envs/roary3_env

# Run Roary
roary -f roary_results -e -v --mafft -p 40 -i 30 -s -g 400000 -iv 1.2 *.gff
