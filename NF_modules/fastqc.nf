#!/usr/bin/env nextflow

process FASTQC {
    tag "FASTQC on $sample_id"
    label 'process_medium'
    conda "envs/fastqc.yml"
    publishDir params.outDir, mode: 'copy'

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("*.html"), emit: html
    tuple val(sample_id), path("*.zip")

    script:
    """
    fastqc -t 2 ${reads}
    
    """
}