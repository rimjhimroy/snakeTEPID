rule tepid_discover:
   message: """
            --- Runs tepid discover on the individual {wildcards.individual}
            """
   input:
      bam   = 'output/merged/{individual}/{individual}.bam',
      split = 'output/merged/{individual}/{individual}.split.bam'
   output:
      inbed    ='output/merged/{individual}/insertions_{individual}.bed',
      inreads  ='output/merged/{individual}/insertion_reads_{individual}.txt',
      delbed   ='output/merged/{individual}/deletions_{individual}.bed',
      delreads ='output/merged/{individual}/deletion_reads_{individual}.txt',
      logs     = 'output/merged/{individual}/tepid_discover_log_{individual}.txt'
   log:  
      "output/logs/discover/{individual}.log"
   benchmark:
      "benchmarks/discover/{individual}.json"
   params:
      tedb = args['TEDB'],
      scriptpath=args['SCRIPTS'],
      basepath=args['BASEPATH']
   conda:
      "envs/tepid.yaml"
   threads: int(CLUSTER['tepid_discover']['cpu'])
   shell:"""
      {params.basepath}/tepid-discover -p {threads} -n {wildcards.individual} -c {input.bam} -s {input.split} -t {params.tedb}
      mv insertions_{wildcards.individual}.bed {output.inbed}
      mv insertion_reads_{wildcards.individual}.txt {output.inreads}
      mv deletions_{wildcards.individual}.bed {output.delbed}
      mv deletion_reads_{wildcards.individual}.txt {output.delreads}
      mv tepid_discover_log_{wildcards.individual}.txt {output.logs}
      """
