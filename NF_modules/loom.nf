process LOOM {
    tag "creating loom files"
    label 'process_high'
    publishDir params.countsDir, mode:'copy'

    input:
    path(countsDir)
    path(gtf)

    output:
    path("*/velocyto/*.loom")

    script:
    """
    velocyto run10x $countsDir $gtf
    """

}