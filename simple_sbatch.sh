#!/bin/bash

#SBATCH --mem=16G             # ask for 16gb of ram
#SBATCH --gres=gpu:a40:1      # ask for 1 a40 GPU
#SBATCH --time 8:00:00        # ask for 8 hours
#SBATCH -c 16                 # numper of cpu cores
#SBATCH --qos=normal          # could be "normal", "m1, "m2", "m3", etc... 
#SBATCH --output=slurm-%j.log # where logs will be directed
#SBATCH --open-mode=append    # append to the end of the log file, don't overwrite previous logs

# submit
srun python main.py 
