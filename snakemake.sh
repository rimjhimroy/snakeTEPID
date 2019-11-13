#!/bin/bash
#SBATCH --mem=2G
#SBATCH -o snakemake.out
#SBATCH -e snakemake.err
#SBATCH -n 1
#SBATCH -c 1
<<<<<<< HEAD
#SBATCH --time=2-0
=======
>>>>>>> 514f5a8528124a5e54d992c815d02f64da290294
#SBATCH --mail-type=END

mkdir "output"
mkdir "output/slurm_out"
source ~/.bashrc
conda activate snakemake
echo "Executing paired-end workflow"
<<<<<<< HEAD
snakemake -s TEPID_paired2 -p -j 9999 --latency-wait 120 --use-conda --cluster-config config/cluster.json --cluster "sbatch -c {cluster.cpu} --mem={cluster.mem} -t {cluster.time} -p {cluster.partition} -o {cluster.output} -e {cluster.error} --mail-type=FAIL"
=======
snakemake -s TEPID_paired -p -j 9999 --latency-wait 120 --use-conda --cluster-config config/cluster.json --cluster "sbatch -c {cluster.cpu} --mem={cluster.mem} -t {cluster.time} -p {cluster.partition} -o {cluster.output} -e {cluster.error} --mail-type=FAIL"
>>>>>>> 514f5a8528124a5e54d992c815d02f64da290294
