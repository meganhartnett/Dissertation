#!/usr/local/bin/python3
# Script to reformat the Shetland Island VCF file to conform to the 1000 Genomes VCF file format
# Writes description lines i.e lines starting with "#"
# Writes header lines i.e lines starting with "chr"
# Reformats the body i.e lines with 0/0:... to 0|0

# Load necessary modules
import gzip
import zipfile
import os, sys, subprocess
import multiprocessing as mp


pool = mp.Pool(processes=None)
jobs = []

def process(line):
	f= open("reformatted_Shetland.vcf", "w")
	desc= []
	body= []
	if line.startswith("#"):
		desc.append(line)
	if line.startswith("chr"):
		body.append(line)
	f.writelines(desc)
	f.close()
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

with open("/exports/eddie/scratch/s2210624/Shetland.hg38.VQSR.VEP.tr.vcf") as f:
	for line in f:
		jobs.append(pool.apply_async(process,(line)))

for job in jobs:
	job.get()

pool.close()

cmd1= 'gzip reformatted_Shetland.vcf'
subprocess.call(cmd1, shell=True)

cmd2= 'gzip /exports/eddie/scratch/s2210624/Shetland.hg38.VQSR.VEP.tr.vcf'
subprocess.call(cmd2, shell=True)
