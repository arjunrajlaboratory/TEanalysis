#!/bin/bash
# run from within repo 

cmdToRun="$codeHomeDir/TEanalysis/Utilities/stepFourGenomeCoverage/runGenomeCovOnAll.sh $EXPERIMENT $codeHomeDir $chrLengthsFile"

echo "$cmdToRun"
eval "$cmdToRun"
echo "done submitting star jobs, wait until all jobs are complete before proceeding to the next step. use the bjobs command to monitor their progress."

