#Concatanate fastq files for each sample across multiple lanes. 
#Written for 07/2015-08/2015 EGFR sort data on PMACS 
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
for i in inputDirectories:
	samplePaths = glob.glob(os.path.join(i, '*'))
	for j in samplePaths:
		fastqFiles = glob.glob(os.path.join(j, '*.fastq.gz'))
		sampleName = sampleNameRegex.search(os.path.basename(fastqFiles[0])).group()
		sampleOutDir = os.path.join(args.outDir, sampleName)
		if not os.path.exists(sampleOutDir):
			os.makedirs(sampleOutDir)
		sampleOutFile = os.path.join(sampleOutDir, sampleName + '_R1.fastq.gz')
		print sampleOutFile
		with open(sampleOutFile, 'w') as out:
			for k in fastqFiles:
				print k
				shutil.copyfileobj(open(k, 'r'), out)



# sampleNames = list(set([i[0:laneRegex.search(i).span()[0]-1] for i in oldSampleDirectories]))

# sampleRegex = re.compile(r'(WM9-)') 
# if sampleRegex.match(args.sampleName):
# 	outFile = os.path.join(args.outDir, args.sampleName.replace('WM9', 'WM989') + '.fastq.gz')
# else:
# 	outFile = os.path.join(args.outDir, args.sampleName + '.fastq.gz')		
# with open(outFile, 'w') as out:
# 	for i in inputDirectories:
# 		inFiles = glob.glob(os.path.join(i, args.sampleName, args.sampleName + '*.fastq.gz'))
# 		print inFiles
# 		for j in inFiles:
# 			shutil.copyfileobj(open(j, 'r'), out)