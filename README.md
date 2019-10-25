# SnakeTEPID

TEPID is generally frustrating to install and there are several bugs that needs to be addressed. This snakemake workflow of TEPID takes care of the installations
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

## Clone this repository

git clone https://github.com/rimjhimroy/snakeTEPID.git

## Prepare Data

1. Copy or symlink your raw data (*.fastq.gz files) into the 'input/samples/' folder.

2. Make sure the data in samples folder has the following format: [SAMPLE_INCLUDING_LANE]_R1_001.fastq.gz and [SAMPLE_INCLUDING_LANE]_R2_001.fastq.gz

3. Download the latest genome FASTA file in 'input/ref/' and TE annotation in 'input/teann' for your organism

4. Convert TE annotation GFF to bed file with family identification in the following format:

    ```bash
    chromosome start stop strand TE_name TE_family TE_superfamily
    ```

5. Build index of reference:

6. Edit the config/cluster.json file to suit your particular cluster (i.e. partition name, memory, cpu, time etc.)

7. Edit the config/config.json file for your experimental setup

    ```bash
    Base input foldername: "project.inputpath"
    Tepid installation basepath: "tepid.basepath"
    Tepid installation scriptpath: "tepid.scripts"
    Path to TE annotation: "tedb"
    Path to reference genome: "ref"
    Refline name: "refline"
    ```

8. Edit the snakemake.sh submission script to reflect your cluster configuration. Right now, the command works only for SLURM systems

## Run snakTEPID workflow

```bash
# dry-run
snakemake -s TEPID_paired --use-conda --cluster-config config/cluster.json -np
# execute
sbatch snakemake.sh
```

NOTE: If you are using SLURM, you must create the output/slurm_out directory prior to running snakemake, otherwise your jobs will instantly fail with no error message. This can be circumvented by installing a SLURM-specific snakemake profile and adjusting the submit script accordingly.

That's it! Snakemake will automagically run tepid-map, tepid-discover, and tepid-refine steps for all of the FASTQ files provided in the input/samples folder.
