rule combine_bed:
    input:
        inbed      = "align/{sample}/insertions_{sample}.bed",
        delbed     = "align/{sample}/deletions_{sample}.bed",
        spin       = "align/{sample}/second_pass_insertion_{sample}.bed",
        spdel      = "align/{sample}/second_pass_deletion_{sample}.bed"
    output:
        refin  = "align/{sample}/refined_insertions_{sample}.bed",
        refdel = "align/{sample}/refined_deletions_{sample}.bed"
    params:
        scripts = SCRIPTS
    shell:
          "cat {input.spin} {input.inbed} > {output.refin} && "
          "cat {input.spdel} {input.delbed} > {output.refdel}"