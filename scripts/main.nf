#!/usr/bin/env nextflow

log.info """\
    s n R N A S E Q - N F   P I P E L I N E
    =======================================
    ref transcriptome        : ${params.transcriptome}
    reads        : ${params.reads}
    outdir       : ${params.outDir}
    """
    .stripIndent()

include { FASTQC } from './module/fastqc.nf'
include { MULTIQC } from './module/multiqc.nf'
include { INDEX } from './module/index.nf'
include { ALIGN } from './module/align.nf'
include { LOOM } from './module/loom.nf'

workflow {
    Channel
        .fromFilePairs(params.reads, checkIfExists: true)
        .set { read_pairs_ch }
    Channel
        .fromPath(params.countsDir, type: 'dir', glob: true)
        .set { loom_ch }

    fastqc_ch = FASTQC(read_pairs_ch)
    MULTIQC(FASTQC.out.html.collect())
    index_ch = INDEX(params.gtf, params.genome)
    ALIGN(read_pairs_ch, params.sampleDir, index_ch)
    LOOM(loom_ch, params.gtf)
}