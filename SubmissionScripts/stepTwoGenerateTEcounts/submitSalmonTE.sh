#!/bin/bash
# run from within repo 
TEdb=hs

if [[ ! -z "$1" ]]; then
    TEdb=$1
fi

CURRENTEXPNUMBER=1
CURRENTSAMPLENUMBER=1
for fileName in $EXPERIMENT/analyzed/* ; do
    echo "Working on sample $CURRENTSAMPLENUMBER of experiment $CURRENTEXPNUMBER"
    SAMPLEID=`basename "$fileName"`

    fullCmd="$codeHomeDir/TEanalysis/Utilities/stepTwoGenerateTEcounts/runSalmonTE.sh $EXPERIMENT $SAMPLEID $PAIRED_OR_SINGLE_END_FRAGMENTS $TEdb"
    echo "$fullCmd"
    bsub -M "96000" -n "4" -J "$EXPERIMENT.salmonTE.$CURRENTSAMPLENUMBER" -o "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).salmonTE.bsub.stdout" -e "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).salmonTE.bsub.stderr" "$fullCmd"
    echo ""

    CURRENTSAMPLENUMBER=$((CURRENTSAMPLENUMBER+1))
done
echo "Submitted all samples to salmonTE"