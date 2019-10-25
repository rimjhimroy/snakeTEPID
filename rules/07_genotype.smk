rule tepid_genotype:
    input:
        refin     = "align/refined_insertions.bed",
        refdel    = "align/refined_deletions.bed",
        ambin     = "align/ambiguous_insertion.bed",
        ambdel    = "align/ambiguous_deletion.bed",
    output:
        genoin  = "genotyped_insertions.bed",
        genodel = "genotyped_deletions.bed"
    params:
        scripts = args['SCRIPTS'],
        samples = args['SAMPLES'],
        refline = args['REFLINE']
    shell:
        "python {params.scripts}/genotype.py "
        " -d  "
        " -a {input.ambdel} "
        " -m {input.refdel} "
        " -s <(echo {params.samples} | tr ' ' '\n') "
        " -r {params.refline} > {output.genodel} &&"
        " python {params.scripts}/genotype.py "
        " -i  "
        " -a {input.ambin} "
        " -m {input.refin} "
        " -s <(echo {params.samples} | tr ' ' '\n') "
        " -r {params.refline} > {output.genoin}" 