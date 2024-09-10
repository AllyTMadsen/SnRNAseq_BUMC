#!/usr/bin/env nextflow

process ALIGN {
    tag "aligning $sample_id"
    label 'process_high'
    publishDir params.outDir, mode:'copy'

    input:
    tuple val(sample_id), path(reads)
    path(sampleDir)
    path(transcriptome)

    output:
    path "$sample_id"

    script:
    """
    cellranger count --id=$sample_id --sample=$sample_id --fastqs=$sampleDir --transcriptome=$transcriptome
    """

}