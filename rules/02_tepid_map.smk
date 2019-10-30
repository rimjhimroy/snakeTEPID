CLUSTER = json.load(open("config/cluster.json"))
rule tepid_map:
    message: """
             --- Runs tepid map on the sample {wildcards.sample}
             """
    input:
        rules.yaha_bowtie_index.output,
        r1 = 'input/samples/{sample}_R1_001.fastq.gz',
        r2 = 'input/samples/{sample}_R2_001.fastq.gz'
    output:
        bam   = 'output/align/{sample}/{sample}.bam',
        bai   = 'output/align/{sample}/{sample}.bam.bai',
        split = 'output/align/{sample}/{sample}.split.bam',
        umap  = 'output/align/{sample}/{sample}.umap.fastq'
    params:
        ref=args['REFERENCE'],
        base=args['REFERENCE'].rsplit('.', 1)[0],
        scriptpath=args['SCRIPTS'],
        basepath=args['BASEPATH']
    log:  
        "output/logs/map/{sample}.log"
    benchmark:
        "benchmarks/map/{sample}.json"
    conda:
        "envs/tepid.yaml"
    threads: int(CLUSTER['tepid_map']['cpu'])
    shell:"""
        {params.basepath}/tepid-map -x {params.base} -y {params.base}.X15_01_65525S -p {threads} -s 200 -n {wildcards.sample} -1 {input.r1} -2 {input.r2}
        mv {wildcards.sample}.bam {output.bam}
        mv {wildcards.sample}.bam.bai {output.bai}
        mv {wildcards.sample}.split.bam {output.split}
        mv {wildcards.sample}.umap.fastq {output.umap}
        """