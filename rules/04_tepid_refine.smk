rule tepid_refine:
    input:
        inbed  = "align/insertions.bed",
        inpoly = "align/insertions_poly_te.bed",
        delbed  = "align/deletions.bed",
        bam   = 'align/{sample}/{sample}.bam',
        split = 'align/{sample}/{sample}.split.bam'
    output:
        ambin      = "align/{sample}/ambiguous_insertion_{sample}.bed",
        ambdel     = "align/{sample}/ambiguous_deletion_{sample}.bed",
        spin       = "align/{sample}/second_pass_insertion_{sample}.bed",
        spinreads  = "align/{sample}/second_pass_reads_insertion_{sample}.txt",
        spdel      = "align/{sample}/second_pass_deletion_{sample}.bed",
        spdelreads = "align/{sample}/second_pass_reads_deletion_{sample}.txt"
    params:
        tedb = TEDB,
        samples = SAMPLES,
        inbed  = "../insertions.bed",
        inpoly = "../insertions_poly_te.bed",
        delbed  = "../deletions.bed",
        bam   = '{sample}.bam',
        split = '{sample}.split.bam'
    shell:
          "cd align/{wildcards.sample} &&"
          "tepid-refine "
          " -i {params.inbed}"
          " -d {params.delbed}"
          " -p 12"
          " -t {params.tedb}"
          " -n {wildcards.sample}"
          " -c {params.bam}"
          " -s {params.split}"
          " -a <(echo {params.samples} | tr ' ' '\n')"
          #" mv ambiguous_insertion_{wildcards.sample}.bed {output.ambin} &&"
          #" mv ambiguous_deletion_{wildcards.sample}.bed {output.ambdel} &&"
          #" mv second_pass_insertion_{wildcards.sample}.bed {output.spin} &&"
          #" mv second_pass_reads_insertion_{wildcards.sample}.txt {output.spinreads} &&"
          #" mv second_pass_deletion_{wildcards.sample}.bed {output.spdel} &&"
          #" mv second_pass_reads_deletion_{wildcards.sample}.txt {output.spdelreads}"