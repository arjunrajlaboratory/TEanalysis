#Script to combine count data after running TElocal. 

import os
from argparse import ArgumentParser
import glob
import regex as re

#Command line parser
parser = ArgumentParser()
parser.add_argument("-e", "--experiment", help = "Specify experiment directory", type = str)
parser.add_argument("-I", "--info", help = "Option to specify metadata for a Info column. Recommend including description of gtf file used for TElocal", type = str, default = None)
args = parser.parse_args()

#Get list of sample paths. 
sampleDirs = glob.glob("{}/analyzed/*".format(args.experiment))

if args.info is not None:
	TEcountHeader = "experiment\tinfo\tsample\tgene_id\tfamily_id\tclass_id\tcount"
	geneCountHeader = "experiment\tinfo\tsample\tgene_id\tcount"

	outFileGeneCounts = os.path.join(args.experiment, "TElocalGeneCounts_{}.tsv".format(args.info))
	outFileTECounts = os.path.join(args.experiment, "TElocalCounts_{}.tsv".format(args.info))
else:
	TEcountHeader = "experiment\tsample\tgene_id\tfamily_id\tclass_id\tcount"
	geneCountHeader = "experiment\tsample\tgene_id\tcount"

	outFileGeneCounts = os.path.join(args.experiment, "TElocalGeneCounts.tsv")
	outFileTECounts = os.path.join(args.experiment, "TElocalCounts.tsv")

ensemblRegex = re.compile(r'ENSG')

with open(outFileGeneCounts, 'w') as outGene:
	outGene.write(geneCountHeader)
	with open(outFileTECounts, 'w') as outTE:
		outTE.write(TEcountHeader)
		for i in sampleDirs:
			sampleName = os.path.basename(i)	
			countFile = glob.glob("{}/TElocal/{}*.uniq.cntTable".format(i, sampleName))
			with open(countFile[0], 'r') as infile:
				skipHeader = infile.readline()
				sampleInfo = [args.experiment] + [args.info] + [sampleName]
				for line in infile:
					line = line.strip().split('\t')
					line[0] = line[0].strip('"') #Get rid of extra ""
					if ensemblRegex.match(line[0]):
						outGene.write('\n' + '\t'.join(sampleInfo) + '\t')
						outGene.write('\t'.join(line))
					else:
						outTE.write('\n' + '\t'.join(sampleInfo) + '\t')
						outTE.write('\t'.join(line[0].split(':')) + '\t')
						outTE.write(line[1])