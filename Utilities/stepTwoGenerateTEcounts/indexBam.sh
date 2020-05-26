#!
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2

ALIGNMENT_TOOL_NAME=star

if [[ ! -z "$3" ]]; then
    ALIGNMENT_TOOL_NAME="$3"
fi

COMMANDNAME=samtools

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi

JOURNAL=$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).$COMMANDNAME.log

INDEXCOMMAND="samtools index \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted.bam \
    $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted.bai"

echo "Starting..." >> $JOURNAL

date >> $JOURNAL
echo $INDEXCOMMAND >> $JOURNAL
eval $INDEXCOMMAND

date >> $JOURNAL
echo "Done" >> $JOURNAL