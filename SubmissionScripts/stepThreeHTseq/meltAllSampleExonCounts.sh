#!/bin/bash
# run in interactive session from within repo

echo "...generating melted data"
meltCmd="$codeHomeDir/TEanalysis/Utilities/stepThreeHTseq/meltHTSeqData.pl $EXPERIMENT/analyzed/*/htseq/*.htseq.exon.stdout > /project/arjunrajlab/$PROJECT/repo/$EXPERIMENT/${EXPERIMENT}_meltedData_exon.tsv"
eval "$meltCmd"
echo "done"