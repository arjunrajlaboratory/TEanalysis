#!/bin/bash
# run this script before running any submission scripts!

## Do not change this section of code unless you want to change software versions!
# within an interactive node (type "bsub -Is bash" to get to one), 
# you can see the list of available software versions by typing "module avail"
module load STAR/2.7.1a
module load samtools-0.1.19
module load ngsutils-0.5.7
STARFLAGS="--readFilesCommand zcat --outSAMtype BAM Unsorted --outFilterMultimapNmax 100 --winAnchorMultimapNmax 100"
genomeDirSTAR="/project/arjunrajlab/refs/STAR/hg38_rmsk"    # This file contains an index used by the STAR aligner. Change the index if you're not using the hg38 reference genome. For hg19, use /home/apps/STAR/indexes/hg19
genomeFasta="/project/arjunrajlab/refs/hg38/hg38.fa"
gtfFile="/project/arjunrajlab/refs/hg38/hg38.gtf" # Genic gtf file. Not for transposable elements. 
gtfFileTE="/project/arjunrajlab/resources/TEtoolkit/GRCh38_Ensembl_rmsk_TE.gtf"
gtfCombined="/project/arjunrajlab/resources/TEtoolkit/hg38_genesAndTEs.sorted.gtf"
TEdb="GRCh38_rmsk"
chrLengthsFile="/project/arjunrajlab/refs/STAR/hg38/chrNameLength.txt"
ARRIBASTARFLAGS="--readFilesCommand zcat --outSAMtype BAM Unsorted --outFilterMultimapNmax 100 --winAnchorMultimapNmax 100 --outSAMunmapped Within --outBAMcompression 0 \
	--outFilterMismatchNmax 3 --chimSegmentMin 10 --chimOutType WithinBAM SoftClip --chimJunctionOverhangMin 10 \
	--chimScoreMin 1 --chimScoreDropMax 30 --chimScoreJunctionNonGTAG 0 --chimScoreSeparation 1 --alignSJstitchMismatchNmax 5 -1 5 5 --chimSegmentReadGapMax 3"
ARRIBABLACKLIST="/home/bemert/miniconda2/pkgs/arriba-1.2.0-h248197f_1/var/lib/arriba/blacklist_hg38_GRCh38_2018-11-04.tsv.gz"
ARRIBAFLAGS=""
#######################

## Update these variables below to your project name, experiment name, number of samples,
#  code home directory (where your "rajlabseqtools/Utilities" folder is. if it's in your
#  home directory (e.g. /home/esanford), you can leave the "~" symbol)
PROJECT="CRISPR_KO_TEanalysis"
EXPERIMENT="WM989_KOs"
#RAWDATA_DIRECTORY="/home/bemert/"
N_SAMPLES=288
PAIRED_OR_SINGLE_END_FRAGMENTS="paired"  # this variable must be "single" or "paired". change to "paired" if your reads... are paired.
codeHomeDir=~                            # "~" is a shortcut for your home directory. alternatively you can use /home/<YOUR_PMACS_USERNAME>