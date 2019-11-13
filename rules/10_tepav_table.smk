rule tepid_tepav:
    input:
        genoin  = "output/merged/genotyped_insertions.bed",
        genodel  = "output/merged/genotyped_deletions.bed"
    output:
        tepavins = "output/merged/tepav_ins.txt",
        tepavdel = "output/merged/tepav_del.txt",
        delflip = "output/merged/genotyped_deletions_flipped.bed"
    params:
        individuals = args['IND'],
        tedb = args['TEDB']
    conda:
        "../envs/tepid.yaml"
    shell:"""
        python scripts/reformat_tepav_matrix_ins.py \
        -i {input.genoin} \
        -r {params.tedb} \
        -n <(echo {params.individuals} | tr ' ' '\n') > {output.tepavins} 

        awk ' {{ t = $7; $7 = $6; $6 = t; print; }} ' {input.genodel} |  tr ' ' '\t' > {output.delflip}
        python scripts/reformat_tepav_matrix_del.py \
        -i {output.delflip} \
        -r {params.tedb} \
        -n <(echo {params.individuals} | tr ' ' '\n') > {output.tepavdel} \
        """
