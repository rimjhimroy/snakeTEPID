rule sample_bed_merge:
    input:
        expand("align/{sample}/insertions_{sample}.bed",sample=SAMPLES),
        expand("align/{sample}/deletions_{sample}.bed",sample=SAMPLES)
    output:
        inbed  = "align/insertions.bed",
        inpoly = "align/insertions_poly_te.bed",
        delbed  = "align/deletions.bed"
    params:
        scripts = SCRIPTS
    shell:
          "cd align &&"
          "python {params.scripts}/merge_insertions.py -f insertions &&"
          "python {params.scripts}/merge_deletions.py -f deletions &&"
          "cd ../"