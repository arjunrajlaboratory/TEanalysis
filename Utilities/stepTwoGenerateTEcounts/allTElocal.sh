#!/bin/bash
# run from within "repo" directory

EXPERIMENT=$1
codeHomeDir=$2
SAMPLEID=$3
gtfFile=$4
gtfFileTE=$5
TEdb=$6

ALIGNMENT_TOOL_NAME=star

# Create index for all STAR alignment (bam) files. This is just for loading into IGV or other software requiring an index.
# echo "Starting ..."
# fullCmd="$codeHomeDir/TEanalysis/Utilities/stepTwoGenerateTEcounts/indexBam.sh \
#     $EXPERIMENT $SAMPLEID star"
# echo "$fullCmd"
# eval "$fullCmd"
# echo "Done ..."

# Add insert size and flags for paired reads to alignment file. I don't know if this is necessary for TElocal. Can try without and see if you get any errors. 
# echo "Starting ..."
# fullCmd="$codeHomeDir/TEanalysis/Utilities/stepTwoGenerateTEcounts/fixmate.sh \
#     $EXPERIMENT $SAMPLEID star"
# echo "$fullCmd"
# eval "$fullCmd"
# echo "Done ..."

# Run TElocal with first rmsk GTF file
echo "Starting ..."
fullCmd="$codeHomeDir/TEanalysis/Utilities/stepTwoGenerateTEcounts/runTElocal_uniq.sh \
    $EXPERIMENT $SAMPLEID $gtfFile $gtfFileTE $TEdb"
echo "$fullCmd"
eval "$fullCmd"
echo "Done ..."