#!/usr/local/bin/python3
# Script to reformat the Shetland Island VCF file to conform to the 1000 Genomes VCF file format
# Writes description lines i.e lines starting with "#"
# Writes header lines i.e lines starting with "chr"
# Reformats the body i.e lines with 0/0:... to 0|0

# Load necessary modules
import gzip
import zipfile
import os, sys, subprocess

# Open file to write out to 
#f= gzip.open("reformatted_Shetland_tr.vcf.gz", "wt")
f= open("reformatted_Shetland.vcf", "w")
# Initialise empty lists
desc= []
body= []

#cmd= 'zcat Shetland.hg38.VQSR.VEP.vcf.gz > /exports/eddie/scratch/s2210624/Shetland.hg38.VQSR.VEP.vcf'
#subprocess.call(cmd, shell=True)

# Open and read shetland VCF file
#with gzip.open("Shetland.hg38.VQSR.VEP.vcf.gz", "rt") as fd:
#with zipfile.ZipFile("Shetland.hg38.VQSR.VEP.subset_2.vcf.gz", mode="r") as fd:
with open("/exports/eddie/scratch/s2210624/Shetland.hg38.VQSR.VEP.vcf", "r") as fd:
	for line in fd:
		if line.startswith("#"):
			desc.append(line)
		if line.startswith("chr"):
			body.append(line)
f.writelines(desc)
f.close()

#f = gzip.open("reformatted_Shetland_tr.vcf.gz", "at")
f= open("reformatted_Shetland.vcf", "a") 

for x in range(len(body)):
	sample = ''
	body_m = ''
	header_m= ''
	sample = body[x].split("\t")
	body_m= sample[9:]
	header_m= sample[0:9]
	string= ''.join([str(item) for item in header_m])
	f.write("\n")
	f.write(str(string))
	for i in range(len(body_m)):
		sample_2=''
		sample_3=''
		sample_4=''
		sample_2 = body_m[i].split(":")
		sample_3= sample_2[0]
		sample_4 = sample_3.replace("/", "|")
		f.write(str(sample_4))
		f.write("\t")

f.close()

cmd1= 'gzip reformatted_Shetland.vcf'
subprocess.call(cmd1, shell=True)

cmd2= 'gzip /exports/eddie/scratch/s2210624/Shetland.hg38.VQSR.VEP.vcf'
subprocess.call(cmd2, shell=True)
