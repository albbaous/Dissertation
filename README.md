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

  
