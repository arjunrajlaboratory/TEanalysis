#!
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2

ALIGNMENT_TOOL_NAME=star

COMMANDNAME=bamCoverage

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi

JOURNAL=$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).$COMMANDNAME.log

COMMAND="bamCoverage -b $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted.mateFixed.bam -p 4 -o \
	$EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.bw"

echo "Starting..." >> $JOURNAL

date >> $JOURNAL
echo $COMMAND >> $JOURNAL
eval $COMMAND