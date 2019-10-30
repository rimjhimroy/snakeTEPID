rule mergemapped:
    message: """
             --- Merges tepid map results from different lanes into a single file for {wildcards.individual}
             """
    input:
        bamin = lambda wildcards: expand("output/align/{samples}/{samples}.bam",samples=args['LANEDICT'][wildcards.individual]),
        splitin = lambda wildcards: expand("output/align/{samples}/{samples}.split.bam",samples=args['LANEDICT'][wildcards.individual])
    output:
        bamout= "output/merged/{individual}/{individual}.bam",
        splitout= "output/merged/{individual}/{individual}.split.bam"
    log:  
        "output/logs/mergemapped/{individual}.log"
    benchmark:
        "benchmarks/mergemapped/{individual}.json"
    conda:
        "envs/tepid.yaml"
    params:
        bampam = lambda wildcards, input: " -I ".join(input.bamin),
        splitpam = lambda wildcards, input: " -I ".join(input.splitin)
    shell:"""
    echo {params.bampam}
    echo {params.splitpam}
    samtools merge {output.bamout} {input.bamin}
    samtools merge {output.splitout} {input.splitin}
    """
