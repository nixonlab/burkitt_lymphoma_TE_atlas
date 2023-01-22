#! /usr/bin/env python
# -*- coding: utf-8 -*-

################################# DOWNLOAD BAMS #################################


rule gdc_download:
    """ Download BAM from Genomic Data Commons (GDC)
    """
    input:
        token = config['gdc_token_file']
    output: temp("samples/{samid}_original.bam")
    benchmark: "benchmarks/gdc_download/{samid}_gdc_download.tsv"
    params:
        uuid = lambda wc: METADATA[wc.samid]['file_id'],
        md5sum = lambda wc: METADATA[wc.samid]['md5sum']
    shell:
        '''
mkdir -p $(dirname {output[0]})
curl\
 -H "X-Auth-Token: $(<{input[0]})"\
 https://api.gdc.cancer.gov/data/{params.uuid}\
 > {output[0]}
echo {params.md5sum} {output[0]} | md5sum -c -
chmod 660 {output[0]}
        '''

rule download_complete:
    input:
        expand("samples/{samid}_original.bam", samid = METADATA.keys())
