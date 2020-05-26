 #!
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2
gtfFile=$3

commandNAME=runHTSeqExon

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi

JOURNAL=$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).$commandNAME.log


if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/htseq ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/htseq
fi

inputFile="$EXPERIMENT/analyzed/$SAMPLEID/htseq/$SAMPLEID.mapped.unique.mateFixed.bam"

countsOutFile="$EXPERIMENT/analyzed/$SAMPLEID/htseq/$SAMPLEID.htseq.exon.stdout"
logOutFile="$EXPERIMENT/analyzed/$SAMPLEID/htseq/$SAMPLEID.htseq.exon.stderr"

htseqCommand="python -m HTSeq.scripts.count \
	--format=bam \
	--idattr=exon_id \
	--mode=union \
	--stranded=no \
	--type=exon \
	--order=name \
	$inputFile \
	$gtfFile \
	1> $countsOutFile \
	2> $logOutFile"

echo "Starting..." >> $JOURNAL
date >> $JOURNAL
echo "$htseqCommand" >> $JOURNAL
eval "$htseqCommand"

date >> $JOURNAL
echo "Done" >> $JOURNAL
