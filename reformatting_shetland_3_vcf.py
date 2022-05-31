#!/usr/local/bin/python3
#Script to reformat the Shetland Island VCF file to conform to the 1000 Genomes VCF file format
# Writes description lines i.e lines starting with "#"
# Writes header lines i.e lines starting with "chr"
# Reformats the body i.e lines with 0/0:... to 0|0

# Load necessary modules
import gzip
import zipfile
import os, sys, subprocess
import re
# Open file to write out to
#f= gzip.open("reformatted_Shetland_tr.vcf.gz", "wt")
#f= open("reformatted_Shetland.vcf", "w")
# Initialise empty lists
#desc= []
body= []


def read_in_chunks(file_object, chunk_size=4000):
        while True:
                data = file_object.read(chunk_size)
                if not data:
                        break
                yield data

#cmd= 'zcat Shetland.hg38.VQSR.VEP.vcf.gz > /exports/eddie/scratch/s2210624/Shetland.hg38.VQSR.VEP.vcf'
#subprocess.call(cmd, shell=True)

files=[]

# Open and read shetland VCF file
#with gzip.open("Shetland.hg38.VQSR.VEP.vcf.gz", "rt") as fd:
#with zipfile.ZipFile("Shetland.hg38.VQSR.VEP.subset_2.vcf.gz", mode="r") as fd:
with gzip.open("Shetland.hg38.VQSR.VEP.vcf.gz", "r") as fd:
	#listedchunks = []
	for chunk in read_in_chunks(fd):
        	# start saving chunks to chromose{list}
                if '\n' in chunk:
                	# Start of a new chromosone has been found
                	# Splitting at the start of the new chromosone
			x = chunk.split('\n')
			m1 = re.search("#*", x[0])
			if m1:
				print(m1)
			m2 = re.search("#*", x[1])
			if m2:
				print(m2.group())
			#print("+"*20, x[0])
			#print("-"*30)
			#print("="*20, x[1])
                else:
			#listedchunks.append(chunk)
			continue
                        # Otherwise save it to the previous chromosone

#print(files[200])


