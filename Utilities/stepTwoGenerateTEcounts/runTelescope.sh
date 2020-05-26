#!
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2
gtfFileTE=$3
TEdb=$4

ALIGNMENT_TOOL_NAME=star

commandNAME=runTelescope

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi

JOURNAL=$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).$commandNAME.$TEdb.log


if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/telescope ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/telescope
fi

inputFile="$EXPERIMENT/analyzed/$SAMPLEID/$ALIGNMENT_TOOL_NAME/$SAMPLEID.nameSorted.mateFixed.bam" #This is the name sorted mate fixed file created by fixmate.sh

outPrefix="$EXPERIMENT/analyzed/$SAMPLEID/Telescope/$SAMPLEID.Telescope.$TEdb"
outLog="$EXPERIMENT/analyzed/$SAMPLEID/Telescope/$SAMPLEID.Telescope.$TEdb.log"

#Telescope command. Assumed input bam is name sorted or unsorted. If coordinate sorted add --sortByPos
TelescopeCommand="telescope assign\
	$inputFile \
	$gtfFileTE \
	--outdir=$outPrefix \
	--logfile=$outLog \
	--reassign_mode=average"

echo "Starting..." >> $JOURNAL
date >> $JOURNAL
echo "$TelescopeCommand" >> $JOURNAL
eval "$TelescopeCommand"

date >> $JOURNAL
echo "Done" >> $JOURNAL