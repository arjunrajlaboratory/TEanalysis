#!
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2
gtfFile=$3
gtfFileTE=$4
TEdb=$5

ALIGNMENT_TOOL_NAME=star

commandNAME=runTElocal

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi

JOURNAL=$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).$commandNAME.$TEdb.log


if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/TElocal ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/TElocal
fi

#inputFile="$EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.nameSorted.mateFixed.bam" #This is the name sorted mate fixed file created by fixmate.sh
inputFile="$EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.Aligned.out.bam" #This is the name sorted file created by runStar.sh

outPrefix="$EXPERIMENT/analyzed/$SAMPLEID/TElocal/$SAMPLEID.TElocal.$TEdb"

#TElocal command. Assumed input bam is name sorted or unsorted. If coordinate sorted add --sortByPos
TElocalCommand="TElocal \
	--format BAM \
	--mode multi \
	-b $inputFile \
	--GTF $gtfFile \
	--TE $gtfFileTE \
	--project $outPrefix"

echo "Starting..." >> $JOURNAL
date >> $JOURNAL
echo "$TElocalCommand" >> $JOURNAL
eval "$TElocalCommand"

date >> $JOURNAL
echo "Done" >> $JOURNAL