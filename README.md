# SnakeTEPID

## REQUIRED:

Python 3
Snakemake
Conda
Singularity (system-wide installation, not with conda) (at the moment singularity is not working)

## TARGET PLATFORM:

(Required) Singularity >= 2.4 (does not require sudo access) or Docker (requires sudo access)
(Optional) Sun Grid Compute Engine
(Optional) Ubuntu 16.04 (Xenial)

## Create snakemake environment

```bash
conda create -c bioconda -c conda-forge -n snakemake snakemake
```

## Load snakemake environment

```bash
conda activate snakemake
```

## Run snakTEPID workflow

```bash
snakemake --use-conda --use-singularity --cluster-config config/cluster.json -np
```

## Clone this repository

git clone https://github.com/rimjhimroy/snakeTEPID.git

## Prepare Data

1. Copy or symlink your raw data (*.fastq.gz files) into the input/samples/ folder.

2. Download the latest genome FASTA file and TE annotation for your organism

3. Convert TE annotation GFF to bed file with family identification in the following format:

4. Build index of reference:

5. Edit the config/cluster.json file to suit your particular cluster (i.e. partition name, memory, etc.)

6. Edit the config/config.json file for your experimental setup

7. Edit the snakemake.sh submission script to reflect your cluster configuration. Right now, the command works for SLURM systems

8. Run the snakemake.sh script as a batch script using your cluster's scheduler. For SLURM, this would be:
sbatch snakemake.sh
NOTE: If you are using SLURM, you must create the output/slurm_out directory prior to running snakemake, otherwise your jobs will instantly fail with no error message. This can be circumvented by installing a SLURM-specific snakemake profile and adjusting the submit script accordingly.

That's it! Snakemake will automagically run tepid-map, tepid-discover, and tepid-refine steps for all of the FASTQ files provided in the input/samples folder.
