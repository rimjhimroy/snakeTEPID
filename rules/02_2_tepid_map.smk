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
        bam   = 'output/merged/{sample}/{sample}.bam',
        bai   = 'output/merged/{sample}/{sample}.bam.bai',
        split = 'output/merged/{sample}/{sample}.split.bam',
        umap  = 'output/merged/{sample}/{sample}.umap.fastq'
    params:
        ref=args['REFERENCE'],
        base=args['REFERENCE'].rsplit('.', 1)[0],
        scriptpath=args['SCRIPTS'],
        basepath=args['BASEPATH']
    benchmark:
        "benchmarks/map/{sample}.json"
    conda:
        "envs/tepid.yaml"
    threads: int(CLUSTER['tepid_map']['cpu'])
    shell:"""
        {params.basepath}/tepid-map -x {params.base} -y {params.base}.X11_01_02000S -p {threads} -s 200 -n {wildcards.sample} -1 {input.r1} -2 {input.r2}
        mv {wildcards.sample}.bam {output.bam}
        mv {wildcards.sample}.bam.bai {output.bai}
        mv {wildcards.sample}.split.bam {output.split}
        mv {wildcards.sample}.umap.fastq {output.umap}
        """
