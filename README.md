# SnakeTEPID

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
