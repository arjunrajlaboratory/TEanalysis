#!
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2

ALIGNMENT_TOOL_NAME=star

if [[ ! -z "$3" ]]; then
    ALIGNMENT_TOOL_NAME="$3"
fi

COMMANDNAME=fixmate

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi

JOURNAL=$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).$COMMANDNAME.log

#Create bam index for reading into IGV
INDEXCOMMAND="samtools index \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.Aligned.sortedByCoord.out.bam \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.Aligned.sortedByCoord.out.bai"

#name sort in order to run fixmate
readNameSortCmd="samtools sort -n \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.Aligned.sortedByCoord.out.bam \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.nameSorted"

#Run fixmate to annotate paired reads. Not necessary for single end sequencing
fixMateCmd="samtools fixmate \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.nameSorted.bam \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.nameSorted.mateFixed.bam"

coordSortCmd="samtools sort \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.nameSorted.mateFixed.bam \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted"

INDEXCOMMAND="samtools index \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted.bam \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted.bai"

echo "Starting..." >> $JOURNAL

date >> $JOURNAL
echo $INDEXCOMMAND >> $JOURNAL
eval $INDEXCOMMAND

date >> $JOURNAL
echo $readNameSortCmd >> $JOURNAL
eval $readNameSortCmd

date >> $JOURNAL
echo $fixMateCmd >> $JOURNAL
eval $fixMateCmd

# date >> $JOURNAL
# echo $coordSortCmd >> $JOURNAL
# eval $coordSortCmd

date >> $JOURNAL
echo "Done" >> $JOURNAL