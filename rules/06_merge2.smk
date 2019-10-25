rule sample_bed_merge2:
    input:
        expand("align/{sample}/refined_insertions_{sample}.bed",sample=SAMPLES),
        expand("align/{sample}/refined_deletions_{sample}.bed",sample=SAMPLES),
        expand("align/{sample}/ambiguous_insertion_{sample}.bed",sample=SAMPLES),
        expand("align/{sample}/ambiguous_deletion_{sample}.bed",sample=SAMPLES)
    output:
        refin     = "align/refined_insertions.bed",
        refinpoly = "align/refined_insertions_poly_te.bed",
        refdel    = "align/refined_deletions.bed",
        ambin     = "align/ambiguous_insertion.bed",
        ambdel    = "align/ambiguous_deletion.bed",
    params:
        scripts = SCRIPTS
    shell:
          "cd align && "
          "python {params.scripts}/merge_insertions.py -f refined_insertions && "
          "python {params.scripts}/merge_deletions.py -f refined_deletions && "
          "python {params.scripts}/merge_insertions.py -f ambiguous_insertion && "
          "python {params.scripts}/merge_deletions.py -f ambiguous_deletion && "
          "cd ../"