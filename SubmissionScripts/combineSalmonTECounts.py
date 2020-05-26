#Script to combine count data after running SalmonTE. 

import os, shutil
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
	header = "experiment\tinfo\tsample\tgene_id\tcount"

	outFile = os.path.join(args.experiment, "SalmonTECounts_{}.tsv".format(args.info))
else:
	header = "experiment\tsample\tgene_id\tcount"

	outFile = os.path.join(args.experiment, "SalmonTECounts.tsv")

#Copy clade info from first sample to experiment directory
shutil.copy2(os.path.join(sampleDirs[0], "salmonTE", 'clades.csv'), os.path.join(args.experiment, "SalmonTE_clades.csv"))

with open(outFile, 'w') as out:
	out.write(header)
	for i in sampleDirs:
		sampleName = os.path.basename(i)	
		countFile = "{}/salmonTE/EXPR.csv".format(i)
		with open(countFile, 'r') as infile:
			skipHeader = infile.readline()
			sampleInfo = [args.experiment] + [args.info] + [sampleName]
			for line in infile:
				out.write('\n' + '\t'.join(sampleInfo) + '\t')
				out.write('\t'.join(line.strip().split(',')))