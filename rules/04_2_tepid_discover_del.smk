rule tepid_discover_del:
   message: """
            --- Runs tepid discover on the individual {wildcards.individual}
            """
   input:
      rules.mergemapped.output,
      bam   = 'output/merged/{individual}/{individual}.bam',
      split = 'output/merged/{individual}/{individual}.split.bam'
   output:
      delbed   ='output/merged/{individual}/deletions_{individual}.bed',
      delreads ='output/merged/{individual}/deletion_reads_{individual}.txt'
   log:  
      "output/logs/mergemapped/{individual}.log"
   benchmark:
      "benchmarks/mergemapped/{individual}.json"
   params:
      tedb = args['TEDB'],
      scriptpath=args['SCRIPTS'],
      basepath=args['BASEPATH']
   conda:
      "envs/tepid.yaml"
   threads: int(CLUSTER['tepid_discover']['cpu'])
   shell:"""
      {params.basepath}/tepid-discover -p {threads} -n {wildcards.individual} -c {input.bam} -s {input.split} -t {params.tedb}
      mv deletions_{wildcards.individual}.bed {output.delbed}
      mv deletion_reads_{wildcards.individual}.txt {output.delreads}
      mv tepid_discover_log_{wildcards.individual}.txt {output.logs}
      """