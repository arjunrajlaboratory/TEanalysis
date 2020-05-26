#!/bin/bash
# run from within repo 
CURRENTEXPNUMBER=1
CURRENTSAMPLENUMBER=1
for fileName in $EXPERIMENT/analyzed/* ; do
    echo "Working on sample $CURRENTSAMPLENUMBER of experiment $CURRENTEXPNUMBER"
    SAMPLEID=`basename "$fileName"`

    fullCmd="$codeHomeDir/TEanalysis/Utilities/stepTwoGenerateTEcounts/allTElocal.sh $EXPERIMENT $codeHomeDir $SAMPLEID $gtfFile $gtfFileTE $TEdb"
    echo "$fullCmd"
    bsub -M "96000" -J "$EXPERIMENT.TElocal.$CURRENTSAMPLENUMBER" -o "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).TElocal.bsub.stdout" -e "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).TElocal.bsub.stderr" "$fullCmd"
    echo ""

    CURRENTSAMPLENUMBER=$((CURRENTSAMPLENUMBER+1))
done
echo "Submitted all samples to TElocal"