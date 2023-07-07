# Dissertation Repo
A repository containing code for the dissertation titled "" by Alexandra Baousi 

## Basic Code 
- Run a batch file:    ``sbatch file.sh`` 

- Read the queue for jobs in SLURM:    ``squeue -u username``
  
- Open compressed files:    ``zless file.zip``
  
- Cancel job:   ``scancel jobnumber``  
  
- Check on job progress:  ``sacct`` 
  
- Make file executable:  ``chmod +x file.sh``
  
- Check file permissions for all files in directory:  ``ls -ltr`` 

- Command to transfer files from remote to local: 

- Command to transfer files from local to remote: 

- Command to transfer files from Tomoko to Augusta: 

## Downloading genomes 

- Download from NCBI (https://www.ncbi.nlm.nih.gov/data-hub/genome/) (accessed May 12, 2023). 
  
- Use filters "Reference genomes", “Annotated by NCBI RefSeq”, “complete” (asssembly level), “2021-2023”
  
- May need to retrieve dataset from ``bin`` if using MacOS operating system. 
  
- Unzip files in ``ncbi_dataset/data`` directory and transfer to remote, using scp command or FileZilla (https://filezilla-project.org)

## Running Prokka 

- Download using: ``mamba install -c bioconda -c conda-forge prokka=1.14.6``

-  !!! When running bash shell scripts on Tomoko make sure the conda env is activated prior to running them !!!

-  Prior to running this activate Prokka environment !!!! 

- Run on Tomoko using the command: 

``nohup ./prokka.sh & ``

### Breaking down ``prokka.sh``
-	``--outdir`` specifies the output directory for Prokka results as $dir/prokka, where ``$dir`` is the directory extracted from the file path.
	
-	``--prefix`` sets the prefix for Prokka output files to the $genome_name, which represents the name of the current genome.
	
-	``--force`` forces Prokka to overwrite existing output files if they already exist.
	
-	``--addgenes`` includes additional gene finding during the annotation process.
	
-	``--locustag`` sets the locus tag to the $genome_name, which helps identify the genes in the annotation output.

-	``$file`` represents the input genome file to be processed by Prokka.

## Running and understanding ``movefna.sh`` (for BUSCO analysis) and ``movegff.sh`` (for Roary) on Tomoko 

- These create new directories which include only the files necessary for BUSCO and Roary analyses. They have similar features: 

- ``mkdir -p`` ensures that the target directory is created only if it doesn't already exist

- find command searches for all files (-type f) in the ``$source_dir`` directory and its subdirectories that have the right extension (-name "*.fna" or "*.gff")

- ``-exec mv`` executes the mv command to move files to the ``$target_dir``

- {} placeholder represents the found file

- plus sign (+) symbol at the end of the command ensures that multiple files can be moved in a single invocation of mv

## Running BUSCO 

- Download using: ``mamba install -c bioconda -c conda-forge busco=5.4.7``

- Activate BUSCO environment prior to running!! (keep activated during)

- Run on Tomoko using the command: 

``nohup ./busco_new.sh &``

### Breaking down BUSCO 
- ``-i`` the input file to analyse which is the ``.fna`` files in ``/prokka_fna_files``

- ``-l`` or ``--lineage_dataset`` which is ``gammaproteobacteria_odb10`` 

!! it is important to have the latest version of BUSCO (v 5.4.7) as earlier ones do not have the gammaproteobacteria dataset !!

- ``-m`` or ``--mode`` sets the assessment MODE: ``genome`` in this case

- ``-o`` defines the folder that will contain all results, logs, and intermediate data

### Creating BUSCO graphs 

- This can be run in the command line

- Run this to move all short_summary* files in one directory: ``find . -type f -name 'short_summary*' -exec cp {} /home/styab21/scratch/busco_results/short_summaries \;``

- Start R and run the following:

(answer yes to install the package to your personal library)

``install.packages("ggplot2")``

``q(save="no") ``

- Move to the directory where busco is saved and then into the bin. For example I would do:

``cd /home/styab21/miniconda3/envs/busco2_env/bin``

- Run script for graphs:

``python3 generate_plot.py --working_directory /home/styab21/scratch/busco_results/short_summaries``

!!  These graphs are very low quality and messy due to high genome no. they represent so the alternative is to create a graph in Excel using the ``batch_summary.txt`` file created by Busco !!!


## Installing Roary 

- Download using: ``mamba install -c bioconda conda-forge roary=1.13.0``

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

- Copied the contents of directories_1,_2, and_3 to a new directory called C.

- Overall, this script creates a series of output directories and populates them with the cumulative contents of the corresponding source directories (created by ``directory.sh``)

- This means that Roary could be run in parallel in each directory (A-K), to spot which files were failing it

- There were a lot of questions raised like "is it the number of files?" or "is it 1 bad file failing it?" or "is it a group of files??"

- This is what splitting them up helped to clarify.

- Directories A-H were successful in producing roary outputs but I,J,K were not so what was problematic about them?

#### Using ``problem_directories.sh`` to combine directory_9, 10 and 11 which contain the files roary failed on: 

- This assesses whether there is was an issue with specific files or whether it was the volume of files that troubled roary since I,J,K contained more files than previous directories.

- Running roary on the resultant directory showed no issues so the files were all fine. 

#### Combining directory H with directory_11
- This was done using the script ``H_K.sh``

- This was a last attempt at getting roary to run on as many files as possible

## Running Roary 

- Run on Augusta using the command: sbatch ``roary.sh``

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

- Download FastTree (to a conda environment):  ``mamba install -c bioconda fasttree``

- Run this to generate newick tree: ``FastTree -nt -gtr core_gene_alignment.aln > my_tree.newick``

- Then run this: ``python roary_plots.py my_tree.newick gene_presence_absence.csv``

## Preparing files for Scoary

- Scoary takes ``gene_presence_absence.csv`` from Roary and a ``traits.csv`` made by the user

### Making a blastable database of genome fasta files using ``blast.sh``



