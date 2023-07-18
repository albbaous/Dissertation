# Dissertation Repo
A repository containing code for the dissertation titled "" by Alexandra Baousi 

## Basic Code 
- Run a batch file on Augusta:    ``sbatch file.sh``

- Run a batch file on Tomoko: ``nohup ./script.sh &``

- Run a python script on Tomoko: ``python3 script.py``

- Read the queue for jobs in SLURM:    ``squeue -u username``
  
- Open compressed files:    ``zless file.zip``
  
- Cancel job:   ``scancel jobnumber``  
  
- Check on job progress:  ``sacct`` 
  
- Make file executable:  ``chmod +x file.sh``
  
- Check file permissions for all files in directory:  ``ls -ltr`` 

- Command to transfer files from remote to local: ``scp username@hpc.address:/path/on/hpc /path/on/local/machine``

- Command to transfer files from local to remote: ``scp /path/to/local/file username@hpc.address:/path/on/hpc``

## Requirements: 
This is to download the required software: 

1. Anaconda or Miniconda. If not installed on your system, you can download Anaconda [here](https://www.anaconda.com/products/distribution) or Miniconda [here](https://docs.conda.io/en/latest/miniconda.html).

- If running on Tomoko, activate Conda environment and run script

- If running on Augusta, incorporate the Conda activation command in script (as demonstrated in the code on this repository)

2. Mamba (a faster version of Conda). Make sure you are in the base environment. If not, you can activate it:
```
conda activate base
```

Install Mamba from the conda-forge channel:
```
conda install -c conda-forge mamba
```

## Downloading genomes 

- Download from NCBI (https://www.ncbi.nlm.nih.gov/data-hub/genome/) (accessed May 12, 2023). 
  
- Use filters "Reference genomes", “Annotated by NCBI RefSeq”, “complete” (asssembly level), “2021-2023”
  
- May need to retrieve dataset from ``bin`` if using MacOS operating system. 
  
- Unzip files in ``ncbi_dataset/data`` directory and transfer to remote, using scp command or FileZilla (https://filezilla-project.org)

## Running Prokka 

- Download using:
```
mamba install -c bioconda -c conda-forge prokka=1.14.6
```

-  !!! When running bash shell scripts on Tomoko make sure the conda env is activated prior to running them !!!

-  Prior to running this activate Prokka environment !!!! 

- Run on Tomoko using the command: 

```
nohup ./prokka.sh &
```

### Breaking down ``prokka.sh``
-	``--outdir`` specifies the output directory for Prokka results as $dir/prokka, where ``$dir`` is the directory extracted from the file path.
	
-	``--prefix`` sets the prefix for Prokka output files to the $genome_name, which represents the name of the current genome.
	
-	``--force`` forces Prokka to overwrite existing output files if they already exist.
	
-	``--addgenes`` includes additional gene finding during the annotation process.
	
-	``--locustag`` sets the locus tag to the $genome_name, which helps identify the genes in the annotation output.

-	``$file`` represents the input genome file to be processed by Prokka.

## Running and understanding ``movefna.sh`` (for BUSCO analysis) and ``movegff.sh`` (for Roary) on Tomoko 

- These create new directories which include only the files necessary for BUSCO (fna) and Roary (gff) analyses. 

## Running BUSCO 

- Download using:
```
mamba install -c bioconda -c conda-forge busco=5.4.7
```

- Activate BUSCO environment prior to running!! (keep activated during)

- Run on Tomoko using the command: 

```
nohup ./busco_new.sh &
```

### Breaking down BUSCO 
- ``-i`` the input file to analyse which is the ``.fna`` files in ``/prokka_fna_files``

- ``-l`` or ``--lineage_dataset`` which is ``gammaproteobacteria_odb10`` 

!! it is important to have the latest version of BUSCO (v 5.4.7) as earlier ones do not have the gammaproteobacteria dataset !!

- ``-m`` or ``--mode`` sets the assessment MODE: ``genome`` in this case

- ``-o`` defines the folder that will contain all results, logs, and intermediate data

### Creating BUSCO graphs 

- This can be run in the command line

- Run this to move all short_summary* files in one directory:

```
find . -type f -name 'short_summary*' -exec cp {} /path/to/short_summaries \;
```

- Start R and run the following:

(answer yes to install the package to your personal library)

```
install.packages("ggplot2")

q(save="no")
```

- Move to the directory where busco is saved and then into the bin. For example I would do:

``cd /home/styab21/miniconda3/envs/busco2_env/bin``

- Run script for graphs:

```
python3 generate_plot.py --working_directory /path/to/short_summaries
```

!!  These graphs are very low quality and messy due to high genome no. they represent so the alternative is to create a graph in Excel using the ``batch_summary.txt`` file created by Busco !!!


## Installing Roary 

- Download using:

```
mamba install -c bioconda conda-forge roary=1.13.0
```

### Prior to running Roary !!!! Understanding the need to split it up into smaller directories 

- Roary could not exactly handle the 258 genomes (as filted after the BUSCO analysis) 

- It failed on the large dataset after many tries, whilst it worked on smaller subsets of data

- Therefore: 
  
#### Divide and Conquer 

- Genomes were split into 11 subdirectories, 10 of which contained 25 genomes and 1 of which had 8. This was done using the script ``directory.sh``

- ``directory.sh`` created 11 directories labelled ``directory_1``, ``directory_2`` and so on

#### Next, ``fibonacci_directories.sh``:

- Not quite like the fibonacci sequence, but name is memorable

- Copied the contents of ``directory_1`` to a new directory called ``A``.

- Copied the contents of ``directories_1`` and ``directory_2`` to a new directory called ``B``.

- Copied the contents of directories_1,_2, and_3 to a new directory called ``C``.

- Overall, this script creates a series of output directories and populates them with the cumulative contents of the corresponding source directories (created by ``directory.sh``)

- This means that Roary could be run in parallel in each directory (``A``-``K``), to spot which files were failing it

- There were a lot of questions raised like "is it the number of files?" or "is it 1 bad file failing it?" or "is it a group of files??"

- This is what splitting them up helped to clarify.

- Directories ``A``-``H`` were successful in producing roary outputs but ``I``,``J``,``K`` were not so what was problematic about them?

#### Using ``problem_directories.sh`` to combine directory_9, 10 and 11 which contain the files roary failed on: 

- This assesses whether there is was an issue with specific files or whether it was the volume of files that troubled roary since ``I``,``J``,``K`` contained more files than previous directories.

- Running roary on the resultant directory showed no issues so the files were all fine. 

#### Combining directory H with directory_11
- This was done using the script ``H_K.sh``

- This was a last attempt at getting roary to run on as many files as possible

## Running Roary 

- Run on Augusta using the command:

```
sbatch roary.sh
```

### Breaking down Roary 
- ``-f`` Specifies the output directory for Roary results

- ``-e`` createS a multiFASTA alignment of core genes using PRANK

- ``-v`` enables verbose output

- ``--mafft`` runs multiple sequence alignment using MAFFT

- ``-p`` specifies the number of CPUs to be used (40 in this case)

- ``-i`` Sets the minimum percentage identity for BLASTp comparisons (30 in this case)

- ``-s`` ensures paralogs are not split

- ``-g`` sets maximum number of clusters (400000 in this case)

- ``-iv`` sets the MCL inflation value for clustering (1.2 in this case)

- ``*.gff`` specifies the input GFF files for Roary.

### Creating Roary plots 

- Download FastTree (to a conda environment):

```
 mamba install -c bioconda fasttree
```

- Run this to generate newick tree:
  
```
FastTree -nt -gtr core_gene_alignment.aln > my_tree.newick
```

- Get the ``roary_plots.py`` script from https://github.com/sanger-pathogens/Roary/tree/master/contrib/roary_plots

- Then run this:

```
python roary_plots.py my_tree.newick gene_presence_absence.csv
```

This code creates ``pangenome_matrix.png``, ``pangenome_frequency.png`` , ``pangenome_pie.png``

## Brief venture into panaroo (``panaroo3.sh``) as alternative (did not work out) 

- Download using:

```
mamba install -c bioconda conda-forge panaroo=1.3.3
```

### Running and understanding panaroo 

- Run on Augusta using:

```
sbatch panaroo3.sh
```

- ``-i`` Input directory

- ``-o`` Output directory or file prefix for Panaroo results.

- ``-clean-mode`` The stringency mode at which to run panaroo set to ``sensitive``

- ``-c`` Sequence identity threshold (default=0.98) set to``0.4`` 

- ``-a`` Output alignments of core genes or all genes. Here it is set to ``core``
  
- ``-aligner`` Sets the ``clustal`` aligner for multiple sequence alignment.

- ``-core_threshold`` Minimum nucleotide identity threshold for core gene identification set to ``0.98``

- ``-t`` Number of threads (CPU cores) to use for parallel processing. Here it is ``40``

## Preparing files for Scoary

- Scoary takes ``gene_presence_absence.csv`` from Roary and a ``traits.csv`` made by the user

- `` gene_presence_absence.csv`` not found here as file is too big

### This step requires a Python environment with Pandas and Numpy installed as many of this scripts use that

This is how to do that: 

- Requirements

1. Python 3.6 or newer. If your operating system does not provide a Python interpreter, you can go to python.org to download an installer.

- In your terminal or command prompt, run:

```
conda create --name myenv python=3.7
```

- Activate:

```
conda activate myenv
```

- Package installation:

```
conda install pandas numpy
```

### 1) CARD (did not work out) 
### Making a blastable database of genome fasta files using ``blast_db.sh``
- Run the following scripts for this on Tomoko - not many resources required for these

Using the makeblast db command: 

- ``-in`` Defines the input fasta files

- ``-dbtype`` Sets the type of database to be made. Here it is ``nucl`` for "nucleotide"
  
- ``-title`` Defines the title of the database. Here it is ``combined``

- ``-out`` Sets the output directory 

### Making a query database from all NDM sequences using ``gene_copy.sh``

- Download necessary CARD (Comprehensive Antibiotic Resistance Database) data here:

https://card.mcmaster.ca/download

- Run the ``gene_copy.sh`` script to compile all sequences of gene of interest (i.e. NDM), as stated on the ``nucleotide_fasta_protein_homolog_model.fasta``  from the downloaded CARD info, in one query fasta

- Change ``line 10`` in the script to set the ``pattern`` to the name of the gene as found on CARD.

- Change ``line 7`` in the script to rename the output fasta to match the gene you are looking for

### Running blastn using ``blast_run.sh``

- Download BLAST using:

```
mamba install -c bioconda conda-forge blast=2.14
```

``blastn`` was used since gene sequences are in nucleotide format

- ``-db`` Sets the name of the BLAST database used. Here it is ``combined``

- ``-query`` Sets the name of the query fasta created. Here it is ``ndm_all.fasta`` but this can be changed according to gene being sought out. 

- ``-out`` Defines the output file ``results.txt``

- ``-outfmt`` Sets the format results are to be printed in. Here it is ``6`` to achieve a similar format to a ``.csv`` file

### Use this to check no. of hits without needing to move to next step 

```
grep -oP '^\S+\t(GCF_[[:alnum:]_]+)' results.txt | cut -f 2 | sort -u | wc -l
```

### Using ``oxa.py`` to convert ``results.txt`` to ``traits.csv``

- Run this python script to format results for input into scoary:

```
python3 oxa.sh
```

- This script labels traits as ``oxa_presence`` - this can be altered in line 29 to give the right gene name

- The script ``final.py`` makes sure that the top left corner is empty as Scoary requires  

### 2) Lack of CARD traits significance so moving onto Crisprcasfinder instead 

- Download all CRISPRCasFinder associated files: 

https://github.com/dcouvin/CRISPRCasFinder

- Download crisprcasfinder using Conda :

```
conda env create -f ccf.environment.yml -n crisprcasfinder
conda activate crisprcasfinder
mamba init
mamba activate
mamba install -c bioconda macsyfinder=2.0
macsydata install -u CASFinder==3.1.0
```

### Run ``running_crisp.sh``

- This runs crisprcasfinder on the dataset using ``CRISPRCasFinder.pl``  

### Run ``tsv_rename.sh`` 

- This renames all relevant crisprcas files to include their original genome ID (from RefSeq download) 

### Run ``merge.sh`` 

- This merges all ``CRISPR-Cas_summary_*.xls`` files into one big file, seperating them with genome IDs

- Creates ``merged_Final.xls`` which is the wrong format so needs to be converted in Microsoft Excel to ``Excel 97-2004 Workbook (.xls)``

### Run ``traits3.py`` 

- This creates the traits file but it doesn't print the first line for some reason so this was added manually.

  !! Top 2 rows have to be edited manually with this script!!

- This is the genome name that needs to be added manually (also remove the ``Name`` label in the top left corner):

```
Result_GCF_000696345_1689247595
```

- 6 other genomes from the 208 were also not printed due to a mislabelling error from ``tsv_rename.sh``

- These are the 6 genomes:

```
Result_GCF_018394375_1689251354,1,0 
Result_GCF_017329545_1689249925,1,0
Result_GCF_024582835_1689259432,1,1 
Result_GCF_024362845_1689259303,1,0 
Result_GCF_027286365_1689260472,1,1
Result_GCF_025758125_1689260065,1,0
```

- Run this to print all the crisprcasfinder directory titles into a txt file (``directory_titles.txt``):

```
find -type d -name "Result_GCF*" -printf "%f\n" > directory_titles.txt
```

### Run ``match.py``

- This generated ``unmatched_rows.txt`` to show which genomes did not make it to the ``traits.csv``

- Manually add these to the ``traits.csv``


### Run ``column.py`` to get the names of genomes as written in the ``gene_presence_abscence.csv``

- This takes all the names from column 15 onwards in the first row of the ``gene_presence_abscence.csv``

- This lists all the original names of genomes

- Creates ``column_15_names.txt``

### Run ``traits5.sh`` to replace the names given to genomes by crisprcasfinder with original names 

- This matches genomes in ``traits.csv`` to genomes in the ``column_15_names.txt``

- Matches the first 9 digits after ``Result_GCF_`` in ``traits.csv`` to the first 9 digits after ``GCF_`` in ``column_15_names.txt``

- If the first 9 digits match, it replaces the ``Result_GCF`` name in the ``traits.csv`` with the GCF name

- One of the genomes (``Result_GCF_914590485_1689261328``) does not match the genomes from column_15_names.txt so it can be renamed manually to ``GCF_914590485.1_CEDIAZO_illumina_assembly_genomic``

### Run ``transform.py``

- This makes sure ``traits.csv`` is written in the correct csv format since there was a lot of manual editing

!! Remove the top left corner value that it adds as that should remain empty !!

- ``traits2.csv`` found here is the traits file used in the final scoary run
  
## Running Scoary 

- Download using:

```
mamba install -c bioconda conda-forge scoary=1.6.16
```
### Understanding Scoary 

Use default parameters:

- ``-g`` Set to ``gene_presence_absence.csv``
  
- ``-t`` Set to ``traits.csv`` 

## Constructing Interactive Tree of Life (iTOL) Trees

Access iTOL here: 

https://itol.embl.de

#### Create iTOL Conda environment:

- You will need Biopython, pandas, fuzzywuzzy and ete3 for the iTOL related scripts

- To get these create a Conda environment dedicated to iTOL (refer to Requirements for guidance on this):

- Biopython
```
mamba install biopython
````

- Pandas
```
mamba install pandas
```

- Ete3 
```
pip install ete3
```

- Fuzzywuzzy
```
pip install fuzzywuzzy
```

## Preparing Newick tree for iTOL 
### Running ``tree_rename.py`` 
- This creates an ``output.csv`` where the first column contains the NCBI file names of gammaproteobacteria (begin with ``GCF_``) and the second one contains the corresponding scientific name for each genome. 

### Running ``duplicates.py``
- This removed any duplicate genome names in the ``output.csv`` (some genomes would have multiple sequences so there would be duplicates)

- This helped check that the ``output.csv`` had the desired no. of genomes (273 which is the number of genomes originally downloaded)

### Running ``tree.py`` 
- This renamed the branches in the Newick tree generated by Fasttree in the Roary step

- It replaces the RefSeq names with their corresponding scientific name in each branch.

- This code does not read words in brackets [] 

- This means that [Pantoea] beijingensis had to be manually taken out of its brackets in the ``output.csv``

### Running ``tree_vis.py`` 
- This just visualises the Newick tree on the terminal. Helped during the branch labelling stage

### Running ``rename_traits.py`` 
- This renamed the ``traits2.csv`` genomes with their scientific name. This also uses ``output.csv`` and matches genomes in this to those found in the ``traits2.csv``

- This is needed for the ``dataset_binary_template.txt`` from iTOL

## Upload relevant files to iTOL 



