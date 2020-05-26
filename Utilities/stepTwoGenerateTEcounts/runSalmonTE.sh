#!
# run from within "repo" directory

EXPERIMENT=$1
SAMPLEID=$2
PAIRED_OR_SINGLE_END_FRAGMENTS=$3
TEdb=hs

if [[ ! -z "$4" ]]; then
    TEdb="$4"
fi

commandNAME=salmonTE

if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/log ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/log
fi

JOURNAL=$EXPERIMENT/analyzed/$SAMPLEID/log/$(date +%Y-%m-%d_%H-%M).$commandNAME.$TEdb.log


if [ ! -d $EXPERIMENT/analyzed/$SAMPLEID/salmonTE ]; then
    mkdir $EXPERIMENT/analyzed/$SAMPLEID/salmonTE
fi

read1File="$EXPERIMENT/raw/$SAMPLEID/${SAMPLEID}_R1.fastq.gz" #SalmonTE will read all fastq files in this directory and should automatically determine if single end or paired end reads
read2File="$EXPERIMENT/raw/$SAMPLEID/${SAMPLEID}_R2.fastq.gz"

outdir="$EXPERIMENT/analyzed/$SAMPLEID/salmonTE/"

#salmonTE command. Outputs normalized count estimates. Chage --exprtype=TPM to --exprtype=count for count estimates
if [ $PAIRED_OR_SINGLE_END_FRAGMENTS = "single" ]; then
	salmonTEcommand="SalmonTE.py quant \
		--reference=$TEdb \
		--outpath=$outdir\
		--exprtype=TPM \
		--num_threads=4 \
		$read1File"
fi

if [ $PAIRED_OR_SINGLE_END_FRAGMENTS = "paired" ]; then
	salmonTEcommand="SalmonTE.py quant \
		--reference=$TEdb \
		--outpath=$outdir\
		--exprtype=TPM \
		--num_threads=4 \
		$read1File $read2File"
fi

echo "Starting..." >> $JOURNAL
date >> $JOURNAL
echo "$salmonTEcommand" >> $JOURNAL
eval "$salmonTEcommand"

date >> $JOURNAL
echo "Done" >> $JOURNAL