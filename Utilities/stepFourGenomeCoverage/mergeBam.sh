#!/bin/bash
# run from within "repo" directory

EXPERIMENT=$1

ALIGNMENT_TOOL_NAME=star

if [[ ! -z "$2" ]]; then
    ALIGNMENT_TOOL_NAME="$2"
fi

commandName=mergeBam

JOURNAL=$EXPERIMENT/logs/$(date +%Y-%m-%d_%H-%M).$commandName.log

mergeBamCmd="samtools merge \
    $EXPERIMENT/$EXPERIMENT.star.combined.bam \
    $EXPERIMENT/analyzed/*/$ALIGNMENT_TOOL_NAME/*.coordSorted.bam"

indexBam="samtools index $EXPERIMENT/$EXPERIMENT.star.combined.bam"

echo "Starting..." >> $JOURNAL
date >> $JOURNAL
echo "$mergeBamCmd" >> $JOURNAL
eval "$mergeBamCmd"
echo "$indexBam" >> $JOURNAL
eval "$indexBam"
