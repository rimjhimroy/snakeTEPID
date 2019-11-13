rule individual_bed_merge:
    message: """
             --- merge insertions and deletions
             """
    input:
        expand("output/merged/{individual}/insertions_{individual}.bed",individual=args['IND']),
        expand("output/merged/{individual}/deletions_{individual}.bed",individual=args['IND'])
    output:
        inbed  = "output/merged/insertions.bed",
        inpoly = "output/merged/insertions_poly_te.bed",
        delbed  = "output/merged/deletions.bed"
    params:
        scripts = args['SCRIPTS']
    conda:
        "envs/tepid.yaml"
    shell:"""
        cd output/merged/
        python {params.scripts}/merge_insertions.py -f insertions
        python {params.scripts}/merge_deletions.py -f deletions
        cd ../../
        """
