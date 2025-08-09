#!/bin/bash
#PBS -q rt_HF
#PBS -N livecodebench
#PBS -l select=1
#PBS -l walltime=3:00:00
#PBS -j oe
#PBS -m n
#PBS -koed
#PBS -V
#PBS -o outputs/

set -e
cd $PBS_O_WORKDIR

echo "Nodes allocated to this job:"
cat $PBS_NODEFILE

# environment variables
export TMP="/groups/gag51395/fujii/tmp"
export TMP_DIR="/groups/gag51395/fujii/tmp"
export HF_HOME="/groups/gag51395/fujii/hf_cache"

source .venv/bin/activate

MODEL_NAME="meta-llama/Llama-3.3-70B-Instruct"

export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
export TOKENIZERS_PARALLELISM=false
python -m lcb_runner.runner.main \
  --model $MODEL_NAME \
  --scenario codegeneration \
  --evaluate \
  --release_version release_v6 \
  --tensor_parallel_size 8
