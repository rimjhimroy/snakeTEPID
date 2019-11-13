rule tepid_refine:
    input:
        inbed  = "output/merged/insertions.bed",
        inpoly = "output/merged/insertions_poly_te.bed",
        delbed  = "output/merged/deletions.bed",
        bam   = 'output/merged/{individual}/{individual}.bam',
        split = 'output/merged/{individual}/{individual}.split.bam'
    output:
        ambin      = "output/merged/{individual}/ambiguous_insertion_{individual}.bed",
        ambdel     = "output/merged/{individual}/ambiguous_deletion_{individual}.bed",
        spin       = "output/merged/{individual}/second_pass_insertion_{individual}.bed",
        spinreads  = "output/merged/{individual}/second_pass_reads_insertion_{individual}.txt",
        spdel      = "output/merged/{individual}/second_pass_deletion_{individual}.bed",
        spdelreads = "output/merged/{individual}/second_pass_reads_deletion_{individual}.txt"
    params:
        tedb = args['TEDB'],
        individual = args['IND'],
        inbed  = "../insertions.bed",
        inpoly = "../insertions_poly_te.bed",
        delbed  = "../deletions.bed",
        bam   = '{individual}.bam',
        split = '{individual}.split.bam',
        basepath=args['BASEPATH']
    conda:
        "envs/tepid.yaml"
    threads: int(CLUSTER['tepid_refine']['cpu'])
    shell:"""
          cd output/merged/{wildcards.individual}
          {params.basepath}/tepid-refine \
          -i {params.inbed} \
          -d {params.delbed} \
          -p {threads} \
          -t {params.tedb} \
          -n {wildcards.individual} \
          -c {params.bam} \
          -s {params.split} \
          -a <(echo {params.individual} | tr ' ' '\n')
          cd ../../../
          """
          