rule individual_bed_merge2:
    input:
        expand("output/merged/{individual}/refined_insertions_{individual}.bed",individual=args['IND']),
        expand("output/merged/{individual}/refined_deletions_{individual}.bed",individual=args['IND']),
        expand("output/merged/{individual}/ambiguous_insertion_{individual}.bed",individual=args['IND']),
        expand("output/merged/{individual}/ambiguous_deletion_{individual}.bed",individual=args['IND'])
    output:
        refin     = "output/merged/refined_insertions.bed",
        refinpoly = "output/merged/refined_insertions_poly_te.bed",
        refdel    = "output/merged/refined_deletions.bed",
        ambin     = "output/merged/ambiguous_insertion.bed",
        ambdel    = "output/merged/ambiguous_deletion.bed"
    params:
        scripts = args['SCRIPTS']
    conda:
        "envs/tepid.yaml"
    shell:"""
          cd output/merged/
          python {params.scripts}/merge_insertions.py -f refined_insertions
          python {params.scripts}/merge_deletions.py -f refined_deletions
          python {params.scripts}/merge_insertions.py -f ambiguous_insertion
          python {params.scripts}/merge_deletions.py -f ambiguous_deletion
          cd ../../
          """