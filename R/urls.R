
#' produce a list of templates for URLs of interest
#' @export
templates = function() {
  list(
    release_20130502_vcf = "http://1000genomes.s3.amazonaws.com/release/20130502/ALL.chr%%NUM%%.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz",
    phase3_lowcoverage = "http://1000genomes.s3.amazonaws.com/phase3/data/%%ID%%/alignment/%%ID%%.mapped.ILLUMINA.bwa.%%POP%%.low_coverage.%%DATE%%.bam"
 )
}

#s3://1000genomes/phase3/data/NA12878/alignment/NA12878.mapped.ILLUMINA.bwa.CEU.low_coverage.20121211.bam
#s3://1000genomes/phase3/data/NA12812/alignment/NA12812.unmapped.ILLUMINA.bwa.CEU.low_coverage.20130415.bam

getpop = function(id) {
 data(igsr_samples)
 igsr_samples[igsr_samples[,1]==id,]$Population.code
}

#' generate URLs for bam files of low coverage DNA sequence alignment, based on NA* or HG* sample ids
#' @param ids character vector with sample identifiers
#' @param dates character vector with date tags for samples
#' @examples
#' lowcov_bam_urls(c("NA12878", "NA12812"), c("20121211", "20130415"))
#' @export
lowcov_bam_urls = function (ids, dates) 
{
    stopifnot(length(ids)==length(dates))
    tmpl = templates()$phase3_lowcoverage
    tvec = sapply(ids, function(curid) gsub("%%ID%%", curid, 
        tmpl))
    for (i in 1:length(tvec)) tvec[i] =  gsub("%%POP%%", getpop(ids[i]), 
        tvec[i])
    for (i in 1:length(tvec)) tvec[i] =  gsub("%%DATE%%", dates[i], 
        tvec[i])
    chk = grep("%%", tvec)
    if (length(chk)>0) warning("some returned strings seem to lack appropriate substitutions")
    tvec
}

.readmes = function() {
 suffs = c(".alignment_data", ".analysis_history", ".complete_genomics_data",
  ".crams", ".ebi_aspera_info", ".ftp_structure", ".pilot_data",
  ".populations", ".sequence_data", "_missing_files_20150612", 
  "_phase3_alignments_sequence_20150526", "_phase3_data_move_20150612")
 pref =     "http://1000genomes.s3.amazonaws.com/README"
 rurls = paste0(pref, suffs)
 names(rurls) = sub("^.", "", suffs)
 rurls
}

#' list or retrieve README documents at top level of bucket
#' @param which character tag, suffix of README...
#' @param justList logical, if TRUE, just list the possible values of 'which'
#' @param render a function that will operate on readLines output
#' @examples
#' get_readme(justList=TRUE)
#' get_readme()
#' @export
get_readme = function(which="populations", justList=FALSE, render=function(x) cat(x, sep="\n")) {
 rs = .readmes()
 if (justList) return(names(rs))
 stopifnot(which %in% names(rs))
 render(readLines(rs[which]))
}
 
