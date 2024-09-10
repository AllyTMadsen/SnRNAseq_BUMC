#!/usr/bin/env nextflow

process INDEX {
    tag "Index Genome"
    label 'process_high'
    publishDir params.refDir, mode:'copy'

    input:
    path(gtf)
    path(genome)

    output:
    path 'cellranger_index'

    script:
    """
    cellranger mkref --genome=cellranger_index --fasta=$genome --genes=$gtf
    """
}