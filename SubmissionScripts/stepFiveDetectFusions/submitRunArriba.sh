#!/bin/bash
# run from within repo 
CURRENTEXPNUMBER=1
CURRENTSAMPLENUMBER=1
for fileName in $EXPERIMENT/analyzed/* ; do
    echo "Working on sample $CURRENTSAMPLENUMBER of experiment $CURRENTEXPNUMBER"
    SAMPLEID=`basename "$fileName"`

    fullCmd="$codeHomeDir/TEanalysis/Utilities/stepFiveDetectFusions/runArriba.sh $EXPERIMENT $SAMPLEID $gtfCombined $genomeFasta $ARRIBABLACKLIST $ARRIBAFLAGS"
    echo "$fullCmd"
    bsub -M "96000" -J "$EXPERIMENT.Arriba.$CURRENTSAMPLENUMBER" -o "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).Arriba.bsub.stdout" -e "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).Arriba.bsub.stderr" "$fullCmd"
    echo ""

    CURRENTSAMPLENUMBER=$((CURRENTSAMPLENUMBER+1))
done
echo "Submitted all samples to Arriba"