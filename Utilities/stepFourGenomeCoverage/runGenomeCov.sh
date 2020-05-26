#!
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2
chrLengthsFile=$3

ALIGNMENT_TOOL_NAME=star

COMMANDNAME=genomeCov

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi

JOURNAL=$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).$COMMANDNAME.log

#COMMAND="bedtools genomecov -bga -ibam $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted.mateFixed.bam \
#	-g $chrLengthsFile > $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.bedgraph"

COMMAND="bedtools genomecov -bga -ibam $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.sorted.mateFixed.bam \
	> $EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.bedgraph"

echo "Starting..." >> $JOURNAL

date >> $JOURNAL
echo $COMMAND >> $JOURNAL
eval $COMMAND