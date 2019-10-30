CLUSTER = json.load(open("config/cluster.json"))
base=args['REFERENCE'].rsplit('.', 1)[0]
#basepath=args['REFERENCE'].rsplit('/', 1)[0]

rule yaha_bowtie_index:
    message: """
             --- Creates yaha and bowtie index for the reference {input.ref}
             """
    input:
        ref = args['REFERENCE']
    output:
        '%s.nib2'% base ,
        '%s.X11_01_02000S' % base ,
        '%s.rev.1.bt2' % base ,
        '%s.rev.2.bt2' % base ,
        '%s.1.bt2' % base ,
        '%s.2.bt2' % base ,
        '%s.3.bt2' % base ,
        '%s.4.bt2' % base
    params:
        basename=base
    log:  
        "output/logs/index/index.log"
    benchmark:
        "benchmarks/index/index.json"
    conda:
        "envs/tepid.yaml"
    threads: int(CLUSTER['yaha_bowtie_index']['cpu'])
    shell:"""
        yaha -g {input.ref} -L 11 -H 2000
        bowtie2-build -f {input.ref} --threads {threads} {params.basename}
        """