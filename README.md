# SnakeTEPID

[![Snakemake](https://img.shields.io/badge/snakemake-≥5.7.1-brightgreen.svg)](https://snakemake.readthedocs.io)
[![Snakemake-Report](https://img.shields.io/badge/snakemake-report-green.svg)](https://cdn.rawgit.com/snakemake-workflows/dna-seq-gatk-variant-calling/master/.test/report.html)

TEPID is generally frustrating to install and there are several bugs that still needs to be addressed. This snakemake workflow for TEPID seamlessly takes care of the installations and runs the full pipeline from tepid-map to genotype.py. All you have to do is prepare your data according to the instructions and run it.

## REQUIRED:

Python 3
Snakemake (Tested with 5.7.4) [if problem with activation of tepid env from snakemake, follow the "Check your '.bashrc' file" instructions]  
Conda  
Singularity (system-wide installation, not with conda) (at the moment singularity is not working)  

## TARGET PLATFORM:

(Required) Singularity >= 2.4 (does not require sudo access) or Docker (requires sudo access)  
(Optional) SLURM  
(Optional) Ubuntu 16.04 (Xenial)  

## Create snakemake environment

```bash
conda create -c bioconda -c conda-forge -n snakemake snakemake
```

## Load snakemake environment

```bash
conda activate snakemake
```

## Check your '.bashrc' file

The following conda initiallize block should be moved to the end in thre file:

```bash
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/[user]]/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/[user]/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/[user]/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/[user]/miniconda3/bin:$PATH"
    fi
fi

unset __conda_setup
# <<< conda initialize <<<
```

## Clone this repository

git clone https://github.com/rimjhimroy/snakeTEPID.git

## Prepare Data

1. Copy or symlink your raw data (*.fastq.gz files) into the 'input/samples/' folder.

2. Make sure the data in samples folder has the following format: [SAMPLE_INCLUDING_LANE]_R1_001.fastq.gz and [SAMPLE_INCLUDING_LANE]_R2_001.fastq.gz. Lane information should be in 3 digit format like: '_L00X', eg. '_L001'. Example file name: 'BOR_01_L003_R1_001.fastq' and 'BOR_01_L003_R2_001.fastq'.

3. Download the latest genome FASTA file in 'input/ref/' and TE annotation in 'input/teann' for your organism

4. Convert TE annotation GFF to bed file with family identification in the following format:

    ```bash
    chromosome start stop strand TE_name TE_family TE_superfamily
    ```

5. Edit the config/cluster.json file to suit your particular cluster (i.e. partition name, memory, cpu, time etc.)

6. Edit the config/config.json file for your experimental setup

    ```bash
    Base input foldername: "project.inputpath"
    Tepid installation basepath: "tepid.basepath"
    Tepid installation scriptpath: "tepid.scripts"
    Path to TE annotation: "tedb"
    Path to reference genome: "ref"
    Refline name: "refline"
    ```

7. Edit the snakemake.sh submission script to reflect your cluster configuration. Right now, the command works only for SLURM systems

## Run snakTEPID workflow

```bash
# dry-run
snakemake -s TEPID_paired --use-conda --cluster-config config/cluster.json -np
# execute
sbatch snakemake.sh
```

NOTE: See the [Snakemake documentation](https://snakemake.readthedocs.io/en/stable/executable.html) for further details.

That's it! Snakemake will automagically run tepid-map, tepid-discover, and tepid-refine steps for all of the FASTQ files provided in the input/samples folder.
