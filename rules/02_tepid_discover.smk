rule tepid_discover:
   input:
      rules.tepid_map.output,
      bam   = 'output/align/{sample}/{sample}.bam',
      split = 'output/align/{sample}/{sample}.split.bam'
   output:
      inbed    ='output/align/{sample}/insertions_{sample}.bed',
      inreads  ='output/align/{sample}/insertion_reads_{sample}.txt',
      delbed   ='output/align/{sample}/deletions_{sample}.bed',
      delreads ='output/align/{sample}/deletion_reads_{sample}.txt',
      logs     ='output/logs/tepid_discover_log_{sample}.txt'
   params:
      tedb = args['TEDB'],
      scriptpath=args['SCRIPTS']
   conda:
      "envs/tepid.yaml"
   shell:
      "{params.scriptpath}/tepid-discover -p 12 -n {wildcards.sample} -c {input.bam} -s {input.split} -t {params.tedb} &&"
      "mv insertions_{wildcards.sample}.bed {output.inbed} &&"
      "mv insertion_reads_{wildcards.sample}.txt {output.inreads} &&"
      "mv deletions_{wildcards.sample}.bed {output.delbed} &&"
      "mv deletion_reads_{wildcards.sample}.txt {output.delreads} &&"
      "mv tepid_discover_log_{wildcards.sample}.txt {output.logs}"