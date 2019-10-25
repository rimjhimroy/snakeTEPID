rule tepid_discover:
     input:
        bam   = 'output/align/{sample}/{sample}.bam',
        split = 'output/align/{sample}/{sample}.split.bam'
     output:
        'output/align/{sample}/insertions_{sample}.bed',
        'output/align/{sample}/insertion_reads_{sample}.txt',
        'output/align/{sample}/deletions_{sample}.bed',
        'output/align/{sample}/deletion_reads_{sample}.txt',
        'output/logs/tepid_discover_log_{sample}.txt'
     params:
        tedb = args['TEDB']
     shell:
        "tepid-discover -p 12 -n {wildcards.sample} -c {input.bam} -s {input.split} -t {params.tedb} &&"
        "mv insertions_{wildcards.sample}.bed {output.inbed} &&"
        "mv insertion_reads_{wildcards.sample}.txt {output.inreads} &&"
        "mv deletions_{wildcards.sample}.bed {output.delbed} &&"
        "mv deletion_reads_{wildcards.sample}.txt {output.delreads} &&"
        "mv tepid_discover_log_{wildcards.sample}.txt {output.logs}"