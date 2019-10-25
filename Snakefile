import os
import json

args = {}
sbatch_args = {}

configfile: "config/config.json"

if config["__default__"]["running_locally"]=="True":
    # print ("Running Locally")
    args["running_locally"] = True


else:
    print ("Running on cluster")



args['SAMPLES'] = glob_wildcards(config['project']['inputpath']+"/test/{S}_R1_001.fastq.gz").S
args['REFERENCE'] = config['ref']
args['TEDB'] = config['tedb']
args['SCRIPTS'] = config['tepid']['scripts']
args['REFLINE'] = config['refline']
# bash safe mode
shell.executable("/bin/bash")
shell.prefix("set -euo pipefail; ")

rule all:
    input:
        expand('output/align/{sample}/{sample}.bam', zip, sample=args['SAMPLES']),
        expand('output/align/{sample}/{sample}.bam.bai', zip, sample=args['SAMPLES']),
        expand('output/align/{sample}/{sample}.split.bam', zip, sample=args['SAMPLES']),
        expand('output/align/{sample}/{sample}.umap.fastq', zip, sample=args['SAMPLES'])

##### setup singularity #####

# this container defines the underlying OS for each job when using the workflow
# with --use-conda --use-singularity
singularity: "docker://continuumio/miniconda2"

##### setup report #####

report: "report/workflow.rst"


##### load rules #####    
include: "rules/01_tepid_map.smk"

