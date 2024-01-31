#!/bin/bash

#SBATCH --mem=16G
#SBATCH --gres=gpu:a40:1
#SBATCH --time 8:00:00
#SBATCH -c 16 
#SBATCH --qos=normal
#SBATCH --output=slurm-%j.log
#SBATCH --open-mode=append

# send this batch script a SIGUSR1 60 seconds
# before we hit our time limit
#SBATCH --signal=B:USR1@60

# exporting environment variables for the program 
export TQDM_MININTERVAL=30
export EXP_DIR=$(realpath experiments/$SLURM_JOB_ID)
export CKPT_DIR=/checkpoint/$USER/$SLURM_JOB_ID
export WANDB_RUN_ID=$SLURM_JOB_ID

# Symbolic link to checkpoint directory
# so it is easier to find them
ln -s $CKPT_DIR $EXP_DIR

# Log environment (will appear in log file not console)
echo "EXP_DIR: $EXP_DIR"
echo "CKPT_DIR: $CKPT_DIR"

# Handle pre-emption or timeout! slurm will send SIGUSR1 
# 60 seconds before a timeout or preemption. In response, 
# we should resubmit this job by using scontrol. The actual 
# logic of resuming the experiment will be handled by our 
# python program.
resubmit() {
    echo "Resubmitting job"
    scontrol requeue $SLURM_JOB_ID
    exit 0
}
trap resubmit SIGUSR1

# submit actual program:
# the program itself should support resuming from the 
# checkpoints that will be stored in $CKPT_DIR
srun python train.py --allow_resume=True

