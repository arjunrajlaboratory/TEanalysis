#!/bin/bash
# run from within repo 

EXPERIMENT=$1
SAMPLEID=$2
gtfCombined=$3
genomeFasta=$4
ARRIBABLACKLIST=$5
ARRIBAFLAGS=${@:6} # pass all arguments after the first two

fullCmd="/home/bemert/TEanalysis/Utilities/stepFiveDetectFusions/runArriba.sh $EXPERIMENT $SAMPLEID $gtfCombined $genomeFasta $ARRIBABLACKLIST $ARRIBAFLAGS"
echo "$fullCmd"
bsub -M "96000" -J "$EXPERIMENT.ARRIBA.test" -o "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).arriba.test.bsub.stdout" -e "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).arriba.test.sub.stderr" -n 8 "$fullCmd"