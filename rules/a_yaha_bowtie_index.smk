base=args['REFERENCE'].rsplit('.', 1)[0]
#basepath=args['REFERENCE'].rsplit('/', 1)[0]

rule yaha_bowtie_index:
    input:
        ref = args['REFERENCE']
    output:
        '%s.nib2'% base ,
        '%s.X11_01_02000S' % base ,
        '%s.rev.1.bt2' % args['REFERENCE'] ,
        '%s.rev.2.bt2' % args['REFERENCE'] ,
        '%s.1.bt2' % args['REFERENCE'] ,
        '%s.2.bt2' % args['REFERENCE'] ,
        '%s.3.bt2' % args['REFERENCE'] ,
        '%s.4.bt2' % args['REFERENCE']
    params:
        basename=args['REFERENCE']
    conda:
        "envs/tepid.yaml"
    shell:
        "yaha -g {input.ref} -L 11 -H 2000"+'\n'
        "bowtie2-build -f {input.ref} --threads 12 {params.basename}"