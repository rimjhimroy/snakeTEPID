rule tepid_map:
    input:
        r1 = 'input/samples/{sample}_R1_001.fastq.gz',
        r2 = 'input/samples/{sample}_R2_001.fastq.gz'
    output:
        bam   = 'output/align/{sample}/{sample}.bam',
        bai   = 'output/align/{sample}/{sample}.bam.bai',
        split = 'output/align/{sample}/{sample}.split.bam',
        umap  = 'output/align/{sample}/{sample}.umap.fastq'
    params:
        ref=args['REFERENCE']
    conda:
        "envs/tepid.yaml"
    shell:
          "tepid-map -x {params.ref} -y {params.ref}.X15_01_65525S -p 12 -s 200 -n {wildcards.sample} -1 {input.r1} -2 {input.r2} &&"
          " mv {wildcards.sample}.bam {output.bam} &&"
          " mv {wildcards.sample}.bam.bai {output.bai} &&"
          " mv {wildcards.sample}.split.bam {output.split} &&"
          " mv {wildcards.sample}.umap.fastq {output.umap}"