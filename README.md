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

- Run on Tomoko using the command: 

nohup ./prokka.sh & 

disown

### Breaking down prokka.sh 
-	--outdir specifies the output directory for Prokka results as $dir/prokka, where $dir is the directory extracted from the file path.
	
-	--prefix sets the prefix for Prokka output files to the $genome_name, which represents the name of the current genome.
	
-	--force forces Prokka to overwrite existing output files if they already exist.
	
-	--addgenes includes additional gene finding during the annotation process.
	
-	--locustag sets the locus tag to the $genome_name, which helps identify the genes in the annotation output.

-	$file represents the input genome file to be processed by Prokka.

## Running BUSCO 

- Download using: mamba install -c bioconda -c conda-forge busco=5.4.7

- Run on Tomoko using the command: 

nohup ./busco_new.sh

disown

### Breaking down BUSCO 
- 


