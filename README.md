# Dissertation
A repository for my dissertation code 

# Basic Code 

Run a batch file:    sbatch file.sh 
##
Read the queue for jobs in SLURM:    squeue 
Open compressed files:    zless file.zip 
Cancel job:    scancel jobnumber  
Check on specific job:  sacct -j jobnumber --format=jobid,jobname,elapsed,state,exitcode 
Make files readable and writable for everyone:  chmod a+rw file.sh 
Make file executable for everyone:  chmod +x file.txt 
Check file permissions for all files in directory:  ls -ltr 
