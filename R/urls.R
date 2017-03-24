#
#%vjcair> s3cmd ls s3://1000genomes/
#                       DIR   s3://1000genomes/alignment_indices/
#                       DIR   s3://1000genomes/changelog_details/
#                       DIR   s3://1000genomes/complete_genomics_indices/
#                       DIR   s3://1000genomes/data/
#                       DIR   s3://1000genomes/hgsv_sv_discovery/
#                       DIR   s3://1000genomes/phase1/
#                       DIR   s3://1000genomes/phase3/
#                       DIR   s3://1000genomes/pilot_data/
#                       DIR   s3://1000genomes/release/
#                       DIR   s3://1000genomes/sequence_indices/
#                       DIR   s3://1000genomes/technical/
#2015-09-08 21:16      1663   s3://1000genomes/20131219.populations.tsv
#2015-09-08 21:17        97   s3://1000genomes/20131219.superpopulations.tsv
#2015-09-08 15:01    257098   s3://1000genomes/CHANGELOG
#2014-09-02 15:39     15977   s3://1000genomes/README.alignment_data
#2014-01-30 11:13      5289   s3://1000genomes/README.analysis_history
#2014-01-31 03:44      5967   s3://1000genomes/README.complete_genomics_data
#2014-08-29 00:22       563   s3://1000genomes/README.crams
#2013-08-06 16:11       935   s3://1000genomes/README.ebi_aspera_info
#2013-08-06 16:11      8408   s3://1000genomes/README.ftp_structure
#2014-09-02 21:19      2082   s3://1000genomes/README.pilot_data
#2014-09-03 12:33      1938   s3://1000genomes/README.populations
#2013-08-06 16:11      7857   s3://1000genomes/README.sequence_data
#2015-06-18 18:28       672   s3://1000genomes/README_missing_files_20150612
#2015-06-03 19:43       136   s3://1000genomes/README_phase3_alignments_sequence_20150526
#2015-06-18 16:34       273   s3://1000genomes/README_phase3_data_move_20150612
#2014-09-03 12:34   3579471   s3://1000genomes/alignment.index
#2014-09-03 12:32  54743580   s3://1000genomes/analysis.sequence.index
#2014-09-03 12:34   3549051   s3://1000genomes/exome.alignment.index
#2014-09-03 12:35  67069489   s3://1000genomes/sequence.index

#' produce a list of templates for URLs of interest
#' @export
templates = function() 
  list(
    release_20130502_vcf = "http://1000genomes.s3.amazonaws.com/release/20130502/ALL.chr%%NUM%%.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz"
  )

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
 
