# survey1kg
tools for exploring 1000 genomes with R

This is an R package that contains some metadata and some functions to
interrogate aspects of the S3 bucket containing 1000 genomes sequencing
and variant data.

Currently we have

* `get_readme` to retrieve README text files to the R session
* `lowcov_bam_urls` to generate URLs to low coverage alignment files in BAM format

A vignette is available with more details.
