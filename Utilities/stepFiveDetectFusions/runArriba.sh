#!/bin/bash
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2
gtfCombined=$3
genomeFasta=$4
ARRIBABLACKLIST=$5
ARRIBAFLAGS=${@:6} # pass all arguments after the first two

toolNAME=arriba

if [ ! -d $EXPERIMENT/analyzed ]; then
    mkdir $EXPERIMENT/analyzed
fi

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID
fi

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi


destinationDir="$EXPERIMENT/analyzed/$SAMPLEID/arriba/"
if [ ! -d $destinationDir ]; then
    mkdir "$destinationDir"
fi

inputFile="$EXPERIMENT/analyzed/$SAMPLEID/arriba/${SAMPLEID}.Aligned.out.bam"
outFile="$EXPERIMENT/analyzed/$SAMPLEID/arriba/${SAMPLEID}.arriba.fusions.out"
discardedOut="$EXPERIMENT/analyzed/$SAMPLEID/arriba/${SAMPLEID}.arriba.fusions.discarded.out"

cmdToRun="arriba \
	-x $inputFile \
	-g $gtfCombined \
	-a $genomeFasta \
	-b $ARRIBABLACKLIST \
	-o $outFile \
	-O $discardedOut \
	-s no \
	$ARRIBAFLAGS"

JOURNAL=$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).$toolNAME.log
echo "Starting..." >> $JOURNAL
date >> $JOURNAL
echo "$cmdToRun" >> $JOURNAL
eval "$cmdToRun"
date >> $JOURNAL
echo "Done" >> $JOURNAL
