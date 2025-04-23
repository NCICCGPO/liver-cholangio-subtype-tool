#!/usr/bin/env python
import pandas as pd
from glob import glob
import json
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("--sample_sheet", help='path to sample sheet')
parser.add_argument("--dir", help='path where the GDC files are saved')
parser.add_argument("--out", help='output file name of tsv')
args = parser.parse_args()

# Open sample sheet - filter for useful cols
sample_df = pd.read_csv(args.sample_sheet, sep='\t')
sample_df = sample_df[['File ID', 'File Name', 'Sample ID']]

data = {}
index = 0
# Pull measured data (gene expression data) from all files in directory
for file in glob('{}/*/*.tsv'.format(args.dir), recursive = True):
    with open(file, 'r') as fh:
        # Grab last dir and file name
        file_id, file_name = file.strip().split('/')[-2:]
        # Find SampleID based on fileid/name
        s1 = sample_df[sample_df['File ID']==file_id].reset_index(drop=True)
        assert s1['File Name'][0]== file_name
        sample= s1['Sample ID'][0]
        # Results: add sample name as key
        assert sample not in data, 'ERROR This sample has already been seen'
        data[sample]={}
        # Parse file
        for line in fh:
            line = line.strip().split()
            # Only consider measured data lines (ex gene expression)
            if line[0].startswith('ENSG'):
                # only protein coding
                if line[2]== 'protein_coding':
                    gene = line[0]
                    # remove gene version
                    gene = gene.split('.')[0]
                    measured_data = line[3]
                    # Results: add measured data (ex gene expression)
                    data[sample][gene]=measured_data
        index+=1

# save row:cols genes:samples
pd.DataFrame.from_dict(data).transpose().to_csv(args.out, sep='\t')
