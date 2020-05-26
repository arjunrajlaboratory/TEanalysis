#!/bin/bash
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2
codeHomeDir=$3
chrLengthsFile=$4
#FLAGS=${@:5} 

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi

#Coord sort mate fixed alignments and index
echo "Starting ..."
fullCmd="$codeHomeDir/TEanalysis/Utilities/stepFourGenomeCoverage/coordSortBam.sh \
    $EXPERIMENT $SAMPLEID"
echo "$fullCmd"
eval "$fullCmd"
echo "Done ..."

#Calculate coverage using bedtools genomecov
echo "Starting ..."
fullCmd="$codeHomeDir/TEanalysis/Utilities/stepFourGenomeCoverage/runGenomeCov.sh \
    $EXPERIMENT $SAMPLEID $chrLengthsFile"
echo "$fullCmd"
eval "$fullCmd"
echo "Done ..."

#Calculate coverage using deeptools bamcoverage
echo "Starting ..."
fullCmd="$codeHomeDir/TEanalysis/Utilities/stepFourGenomeCoverage/runBamCov.sh \
    $EXPERIMENT $SAMPLEID"
echo "$fullCmd"
eval "$fullCmd"
echo "Done ..."

