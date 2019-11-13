rule mergefastqs:
    message: """
             --- Merges fastq files from different lanes into a single file for {wildcards.individual}
             """
    input:        
        fq1 = lambda wildcards: expand("input/raw/{samples}_R1_001.fastq.gz",samples=args['LANEDICT'][wildcards.individual]),
        fq2 = lambda wildcards: expand("input/raw/{samples}_R2_001.fastq.gz",samples=args['LANEDICT'][wildcards.individual])

    output:
        fqout1= "input/samples/{individual}_R1_001.fastq.gz",
        fqout2= "input/samples/{individual}_R2_001.fastq.gz"
    benchmark:
        "benchmarks/mergedfastq/{individual}.json"
    conda:
        "envs/tepid.yaml"
    shell:"""
    cat {input.fq1} > {output.fqout1}
    cat {input.fq2} > {output.fqout2}
    """
