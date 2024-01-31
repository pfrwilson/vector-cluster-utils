
# functions for starting interactive compute nodes
alias interactive_gpu_session="srun --mem=16G --gres=gpu:a40:1 --time=8:00:00 -c 8 --pty /bin/bash"
alias interactive_cpu_session="srun --mem=32G --time=4-0 -c 32 --partition cpu --pty /bin/bash"

# helpful aliases
export EXACTVU_PCA_DATA_ROOT=/ssd005/projects/exactvu_pca
