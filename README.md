# Dissertation Repo
A repository containing code for the dissertation titled "" by Alexandra Baousi 

## Basic Code 
- Run a batch file:    sbatch file.sh 

- Read the queue for jobs in SLURM:    squeue -u username
  
- Open compressed files:    zless file.zip 
  
- Cancel job:    scancel jobnumber  
  
- Check on job progress:  sacct 
  
- Make file executable:  chmod +x file.sh
  
- Check file permissions for all files in directory:  ls -ltr 

- Command to transfer files from remote to local: 

- Command to transfer files from local to remote: 

- Command to transfer files from Tomoko to Augusta: 

## Downloading genomes 

- Download from NCBI (https://www.ncbi.nlm.nih.gov/data-hub/genome/) (accessed May 12, 2023). 
  
- Use filters "Reference genomes", “Annotated by NCBI RefSeq”, “complete” (asssembly level), “2021-2023”
  
- May need to retrieve dataset from "bin" if using MacOS operating system. 
  
- Unzip files in ncbi_dataset/data directory and transfer to remote, using scp command or FileZilla (https://filezilla-project.org)

## Running Prokka 

- Download using: mamba install -c bioconda -c conda-forge prokka=1.14.6

-  !!! When running bash shell scripts on Tomoko make sure the conda env is activated prior to running them !!!

-  Prior to running this activate Prokka environment !!!! 

- Run on Tomoko using the command: 

nohup ./prokka.sh & 

### Breaking down prokka.sh 
-	--outdir specifies the output directory for Prokka results as $dir/prokka, where $dir is the directory extracted from the file path.
	
-	--prefix sets the prefix for Prokka output files to the $genome_name, which represents the name of the current genome.
	
-	--force forces Prokka to overwrite existing output files if they already exist.
	
-	--addgenes includes additional gene finding during the annotation process.
	
-	--locustag sets the locus tag to the $genome_name, which helps identify the genes in the annotation output.

-	$file represents the input genome file to be processed by Prokka.

## Running and understanding movefna.sh (for BUSCO analysis) and movegff.sh (for Roary) on Tomoko 

- These create new directories which include only the files necessary for BUSCO and Roary analyses. They have similar features: 

- mkdir -p ensures that the target directory is created only if it doesn't already exist

- find command searches for all files (-type f) in the $source_dir directory and its subdirectories that have the right extension (-name "*.fna" or "*.gff")

- -exec mv executes the mv command to move files to the $target_dir

- {} placeholder represents the found file

- plus sign (+) symbol at the end of the command ensures that multiple files can be moved in a single invocation of mv

## Running BUSCO 

- Download using: mamba install -c bioconda -c conda-forge busco=5.4.7

- Activate BUSCO environment prior to running!! (keep activated during)

- Run on Tomoko using the command: 

nohup ./busco_new.sh


### Breaking down BUSCO 
- -i the input file to analyse which is the .fna files in /prokka_fna_files

- -l or --lineage_dataset which is gammaproteobacteria_odb10 

!! it is important to have the latest version of BUSCO (v 5.4.7) as earlier ones do not have the gammaproteobacteria dataset !!

- -m or --mode sets the assessment MODE: genome, proteins, transcriptome

- -o defines the folder that will contain all results, logs, and intermediate data

## Running Roary 

- Download using: mamba install -c bioconda conda-forge roary=1.13.0

- Run on Augusta using the command: sbatch roary.sh 

## Breaking down Roary 


