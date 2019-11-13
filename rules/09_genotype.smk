rule tepid_genotype:
    input:
        refin     = "output/merged/refined_insertions.bed",
        refdel    = "output/merged/refined_deletions.bed",
        ambin     = "output/merged/ambiguous_insertion.bed",
        ambdel    = "output/merged/ambiguous_deletion.bed"
    output:
        genoin  = "output/merged/genotyped_insertions.bed",
        genodel = "output/merged/genotyped_deletions.bed"
    params:
        scripts = args['SCRIPTS'],
        individuals = args['IND'],
        refline = args['REFLINE']
    conda:
        "envs/tepid.yaml"
    shell:"""
        python {params.scripts}/genotype.py \
        -d  \
        -a {input.ambdel} \
        -m {input.refdel} \
        -s <(echo {params.individuals} | tr ' ' '\n') \
        -r {params.refline} > {output.genodel}
        python {params.scripts}/genotype.py \
        -i  \
        -a {input.ambin} \
        -m {input.refin} \
        -s <(echo {params.individuals} | tr ' ' '\n') \
        -r {params.refline} > {output.genoin}
        """