#!/bin/bash
#PBS -q rt_HG
#PBS -N livecodebench
#PBS -l select=1
#PBS -l walltime=1:00:00
#PBS -j oe
#PBS -m n
#PBS -koed
#PBS -V
#PBS -o outputs/

set -e
cd "$PBS_O_WORKDIR/LiveCodeBench"

echo "Nodes allocated to this job:"
cat $PBS_NODEFILE

# environment variables
export TMP="/groups/gag51395/fujii/tmp"
export TMP_DIR="/groups/gag51395/fujii/tmp"
export HF_HOME="/groups/gag51395/fujii/hf_cache"

source .venv/bin/activate

export CUDA_VISIBLE_DEVICES=0
export TOKENIZERS_PARALLELISM=false
python -m lcb_runner.runner.main \
  --model $MODEL \
  --scenario codegeneration \
  --evaluate \
  --release_version release_v6 \
  --dataset-path "/groups/gcg51558/datasets/eval/code_generation_lite" \
  --all_result_csv $RESULT_CSV


