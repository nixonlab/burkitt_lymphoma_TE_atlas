#! /usr/bin/env python
# -*- coding utf-8 -*-

########################### DOWNLOADED BAMS TO FASTQS ###########################

rule bam_to_fastq:
    conda: "../envs/utils.yaml"
    output:
        R1 = temp('samples/{samid}_1.fastq'),
        R2 = temp('samples/{samid}_2.fastq')
    input: "samples/{samid}/original.bam"
    threads: workflow.cores
    benchmark: "benchmarks/bam_to_fastq/{samid}_bam_to_fastq.tsv"
    params:
        tmp = config['local_tmp']
    shell:
        """
        picard -Xmx10g SamToFastq --I {input} --FASTQ {output.R1} --SECOND_END_FASTQ {output.R2} --TMP_DIR {params.tmp}
        chmod 660 {output.R1} {output.R2}
        """
