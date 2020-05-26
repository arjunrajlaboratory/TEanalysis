#Create metadata table of sample names, gene targets and sgRNA names

import os
import glob as glob
import regex as re

sampleDirs = glob.glob('/project/arjunrajlab/CRISPR_KO_TEanalysis/repo/WM989_KOs/raw/melanoma*')

outList = []

sampleNameRegex = re.compile('.+?(?=_R1)')
geneRegex = re.compile('[^-]+$')

for i in sampleDirs:
	fastqFile = glob.glob(os.path.join(i, "*_R1.fastq.gz"))
	sample = os.path.basename(i)
	target = geneRegex.search(sample).group()
	sgRNA = sampleNameRegex.search(os.path.basename(fastqFile[0])).group()
	outList.append('{}\t{}\t{}'.format(sample, target, sgRNA))

outFile = '/project/arjunrajlab/CRISPR_KO_TEanalysis/repo/WM989_KOs/sampleTable.txt'

with open(outFile, 'w') as f:
	f.write("sample\ttarget\tsgRNA\n")
	f.write("\n".join(outList))


