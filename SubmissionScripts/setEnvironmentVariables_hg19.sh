#!/bin/bash
# run this script before running any submission scripts!

## Do not change this section of code unless you want to change software versions!
# within an interactive node (type "bsub -Is bash" to get to one), 
# you can see the list of available software versions by typing "module avail"
module load STAR/2.5.2a
module load samtools-0.1.19
module load ngsutils-0.5.7
STARFLAGS="--readFilesCommand zcat --outSAMtype BAM Unsorted --outFilterMultimapNmax 100 --winAnchorMultimapNmax 100"
genomeDirSTAR="/home/apps/STAR/indexes/hg19"    # This file contains an index used by the STAR aligner. Change the index if you're not using the hg38 reference genome. For hg19, use /home/apps/STAR/indexes/hg19
gtfFile="/project/arjunrajlab/resources/htseq/hg19/hg19.gtf" # Genic gtf file. Not for transposable elements. 
gtfFileTE="/project/arjunrajlab/resources/TEtoolkit/hg19_rmsk_TE.gtf"
TEdb="hg19_rmsk"
chrLengthsFile="/project/arjunrajlab/refs/STAR/hg19/chrNameLength.txt"
#######################

## Update these variables below to your project name, experiment name, number of samples,
#  code home directory (where your "rajlabseqtools/Utilities" folder is. if it's in your
#  home directory (e.g. /home/esanford), you can leave the "~" symbol)
PROJECT="CRISPR_KO_TEanalysis"
EXPERIMENT="WM989_KOs"
#RAWDATA_DIRECTORY="/home/bemert/"
N_SAMPLES=285
PAIRED_OR_SINGLE_END_FRAGMENTS="paired"  # this variable must be "single" or "paired". change to "paired" if your reads... are paired.
codeHomeDir=~                            # "~" is a shortcut for your home directory. alternatively you can use /home/<YOUR_PMACS_USERNAME>