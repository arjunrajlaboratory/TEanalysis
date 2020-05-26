#!/bin/bash
module load STAR/2.7.1a

#genomeDirSTAR=/project/arjunrajlab/refs/STAR/hg38_rmsk/
genomeFasta=/project/arjunrajlab/refs/hg38/hg38.fa
GTFfile=/project/arjunrajlab/resources/TEtoolkit/hg38_genesAndTEs.sorted.gtf
nCPU=8
overhang=100

cmdToRun="STAR \
	--runThreadN $nCPU \
	--runMode genomeGenerate \
	--genomeDir ./ \
	--genomeFastaFiles $genomeFasta \
	--sjdbGTFfile $GTFfile \
	--sjdbOverhang $overhang" 

bsub -M "120000" -J "makeSTARIndex" -o "hg38_rmsk.$(date +%Y-%m-%d_%H-%M).starIndex.bsub.stdout" -e "hg38_rmsk.$(date +%Y-%m-%d_%H-%M).starIndex.bsub.sterr" -n 8 "$cmdToRun"