rule sample_bed_merge:
    input:
        expand("output/align/{sample}/insertions_{sample}.bed",sample=SAMPLES),
        expand("output/align/{sample}/deletions_{sample}.bed",sample=SAMPLES)
    output:
        inbed  = "output/align/insertions.bed",
        inpoly = "output/align/insertions_poly_te.bed",
        delbed  = "output/align/deletions.bed"
    params:
        scripts = args['SCRIPTS']
    shell:
        "cd align &&"
        "python {params.scripts}/merge_insertions.py -f insertions &&"
        "python {params.scripts}/merge_deletions.py -f deletions &&"
        "cd ../"