#!/usr/bin/env nextflow

process MULTIQC {
    tag "Run MultiQC"
    label 'process_medium'
    conda "envs/multiqc.yml"
    publishDir params.outDir, mode:'copy'

    input:
    file 'params.outDir/*.html'

    output:
    file 'multiqc_report.html' 
    file "multiqc_data"

    script:
    """
    multiqc $params.outDir
    """
}