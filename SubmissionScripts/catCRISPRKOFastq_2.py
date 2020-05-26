#Concatanate fastq files for each sample across multiple lanes. 
#Written for et_CRISPR-RNAseq KO data on PMACS 

import os, shutil
from argparse import ArgumentParser
import glob
import regex as re

#Command line parser
parser = ArgumentParser()
parser.add_argument("-i", "--inDirs", help = "Specify the input directories.", nargs = '+')
parser.add_argument("-o", "--outDir", help = "Specify the output directory")
args = parser.parse_args()

inputDirectories = args.inDirs
if not os.path.exists(args.outDir):
	os.makedirs(args.outDir)

sampleNameRegex = re.compile('.+?(?=_S)')
for i, run in enumerate(inputDirectories):
	samplePaths = glob.glob(os.path.join(run, 'melanoma-*'))
	for j in samplePaths:
		fastqFiles_R1 = sorted(glob.glob(os.path.join(j, '*_R1_*.fastq.gz')))
		fastqFiles_R2 = sorted(glob.glob(os.path.join(j, '*_R2_*.fastq.gz')))
		sampleName = sampleNameRegex.search(os.path.basename(fastqFiles_R1[0])).group()
		sampleOutDir = os.path.join(args.outDir, sampleName)
		if not os.path.exists(sampleOutDir):
			os.makedirs(sampleOutDir)
		sampleOutFile_R1 = os.path.join(sampleOutDir, sampleName + '_R1.fastq.gz')
		sampleOutFile_R2 = os.path.join(sampleOutDir, sampleName + '_R2.fastq.gz')
		if i == 0:
			print sampleOutFile_R1
			with open(sampleOutFile_R1, 'w') as out_R1:
				for k1 in fastqFiles_R1:
					print k1
					shutil.copyfileobj(open(k1, 'r'), out_R1)
			print sampleOutFile_R2
			with open(sampleOutFile_R2, 'w') as out_R2:
				for k2 in fastqFiles_R2:
					print k2
					shutil.copyfileobj(open(k2, 'r'), out_R2)
		elif i > 0:
			print sampleOutFile_R1
			with open(sampleOutFile_R1, 'a') as out_R1:
				for k1 in fastqFiles_R1:
					print k1
					shutil.copyfileobj(open(k1, 'r'), out_R1)
			print sampleOutFile_R2
			with open(sampleOutFile_R2, 'a') as out_R2:
				for k2 in fastqFiles_R2:
					print k2
					shutil.copyfileobj(open(k2, 'r'), out_R2)
