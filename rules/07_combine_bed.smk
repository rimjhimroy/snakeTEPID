rule combine_bed:
    input:
        inbed      = "output/merged/{individual}/insertions_{individual}.bed",
        delbed     = "output/merged/{individual}/deletions_{individual}.bed",
        spin       = "output/merged/{individual}/second_pass_insertion_{individual}.bed",
        spdel      = "output/merged/{individual}/second_pass_deletion_{individual}.bed"
    output:
        refin  = "output/merged/{individual}/refined_insertions_{individual}.bed",
        refdel = "output/merged/{individual}/refined_deletions_{individual}.bed"
    params:
        scripts = args['SCRIPTS']
    conda:
        "envs/tepid.yaml"
    shell:"""
          cat {input.spin} {input.inbed} > {output.refin}
          cat {input.spdel} {input.delbed} > {output.refdel}
          """