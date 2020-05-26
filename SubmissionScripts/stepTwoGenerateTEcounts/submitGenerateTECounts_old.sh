#!
# run from within repo

cmdToRun="$codeHomeDir/rajlabseqtools/Utilities/stepTwoGenerateTEcounts/allTElocal.sh $EXPERIMENT $codeHomeDir $PROJECT $gtfFile $gtfFileTE $TEdb"

JOB_ARRAY_PARAMETER_TEMPLATE="generateCounts[1-tk]"

#The expression within ${} below replaces "tk" with the correct number of samples (defined in the setEnvironmentVariables.sh script)
bsub -M 64000 -J ${JOB_ARRAY_PARAMETER_TEMPLATE/tk/$N_SAMPLES} -o out.%I -e err.%I $cmdToRun
