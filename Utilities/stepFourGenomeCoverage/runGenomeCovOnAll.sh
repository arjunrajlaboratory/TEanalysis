#!/bin/bash
# run from within repo 

EXPERIMENT=$1
codeHomeDir=$2
chrLengthsFile=$3
#FLAGS=${@:4} 

CURRENTEXPNUMBER=1
CURRENTSAMPLENUMBER=1
for fileName in $EXPERIMENT/analyzed/* ; do
    echo "Working on sample $CURRENTSAMPLENUMBER of experiment $CURRENTEXPNUMBER"
    SAMPLEID=`basename "$fileName"`

    fullCmd="$codeHomeDir/TEanalysis/Utilities/stepFourGenomeCoverage/allGenomeCoverage.sh $EXPERIMENT $SAMPLEID $codeHomeDir $chrLengthsFile"
    echo "$fullCmd"
    bsub -M "96000" -J "$EXPERIMENT.genomeCov.$CURRENTSAMPLENUMBER" -o "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).genomeCov.bsub.stdout" -e "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).genomeCov.bsub.stderr" -n 4 "$fullCmd"
    echo ""

    CURRENTSAMPLENUMBER=$((CURRENTSAMPLENUMBER+1))
done
echo "Submitted all samples to genomeCov"