#!/bin/bash
# run from within repo 

EXPERIMENT=$1

SAMPLEID=$2
PAIRED_OR_SINGLE_END_FRAGMENTS=$3
genomeDirSTAR=$4

ARRIBAFLAGS=${@:5} # pass all arguments after the first four

fullCmd="/home/bemert/TEanalysis/Utilities/stepFiveDetectFusions/runSTARArriba.sh $EXPERIMENT $SAMPLEID $PAIRED_OR_SINGLE_END_FRAGMENTS $genomeDirSTAR $ARRIBAFLAGS"
echo "$fullCmd"
bsub -M "96000" -J "$EXPERIMENT.ARRIBASTAR.test" -o "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).arribastar.test.bsub.stdout" -e "$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).arribastar.test.sub.stderr" -n 8 "$fullCmd"