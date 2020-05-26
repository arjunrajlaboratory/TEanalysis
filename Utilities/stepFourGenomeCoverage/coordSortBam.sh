#!
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2

ALIGNMENT_TOOL_NAME=star

COMMANDNAME=samtoolsSort

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi

JOURNAL=$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).$COMMANDNAME.log

COMMAND="samtools sort $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.nameSorted.mateFixed.bam \
	$EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted.mateFixed"


INDEXCOMMAND="samtools index \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted.mateFixed.bam \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted.mateFixed.bai"

echo "Starting..." >> $JOURNAL

date >> $JOURNAL
echo $COMMAND >> $JOURNAL
eval $COMMAND

date >> $JOURNAL
echo $INDEXCOMMAND >> $JOURNAL
eval $INDEXCOMMAND