#!/bin/bash
# run from within "repo" directory

EXPERIMENT=$1
codeHomeDir=$2
PROJECT=$3
gtfFile=$4
ALIGNMENT_TOOL_NAME=star


allSamplePaths=( ${EXPERIMENT}/analyzed/* )
thisSampleNumber=$((LSB_JOBINDEX-1))
thisSamplePath=${allSamplePaths[$thisSampleNumber]}
sampleID=`basename "$thisSamplePath"`


# This section takes the sam files and converts them to sorted bam.
# echo "Starting ..."
# fullCmd="$codeHomeDir/rajlabseqtools/Utilities/stepThreeGenerateCounts/samToSortedBam.sh \
#     $EXPERIMENT $sampleID star"
# echo "$fullCmd"
# eval "$fullCmd"
# echo "Done ..."


# This runs the bamutils portion of the process
# echo "Starting ..."
# fullCmd="$codeHomeDir/TEanalysis/Utilities/stepThreeHTseq/keepSTARUniquelyMappedBam.sh \
#     $EXPERIMENT $sampleID star"
# echo "$fullCmd"
# eval "$fullCmd"
# echo "Done ..."


# # This is everything in HTseq array steps
# echo "... Preparing Sam for HTSeq"
# fullCmd="$codeHomeDir/TEanalysis/Utilities/stepThreeHTseq/prepareSamForHTSeq.sh $EXPERIMENT $sampleID $ALIGNMENT_TOOL_NAME"
# eval "$fullCmd"

# echo "... running HTSeq"
# fullCmd="$codeHomeDir/TEanalysis/Utilities/stepThreeHTseq/runHTSeq.sh $EXPERIMENT $sampleID $gtfFile"
# eval "$fullCmd"

echo "... running HTSeqExon"
fullCmd="$codeHomeDir/TEanalysis/Utilities/stepThreeHTseq/runHTSeqExon.sh $EXPERIMENT $sampleID $gtfFile"
eval "$fullCmd"

# echo "... removing temporary Sams/bams prepared for HTSeq"
# fullCmd="$codeHomeDir/TEanalysis/Utilities/stepThreeHTseq/teardownSamForHTSeq.sh $EXPERIMENT $sampleID"
# eval "$fullCmd"

# echo "...generating melted data"
# fullCmd="$codeHomeDir/rajlabseqtools/Utilities/stepThreeGenerateCounts/meltHTSeqData.pl $EXPERIMENT/analyzed/*/htseq/*.htseq.stdout > /project/arjunrajlab/$PROJECT/repo/$EXPERIMENT/meltedData.tsv"
