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

# Open and read shetland VCF file
#with gzip.open("Shetland.hg38.VQSR.VEP.vcf.gz", "rt") as fd:
#with zipfile.ZipFile("Shetland.hg38.VQSR.VEP.subset_2.vcf.gz", mode="r") as fd:
with gzip.open("Shetland.hg38.VQSR.VEP.vcf.gz", "r") as fd:
	counter = 0
	while counter <= 3:
		counter += 1
		for chunk in read_in_chunks(fd):
			# start saving chunks to chromose{list}			
			if '\n' in chunk:
				# Start of a new chromosone has been found
				# Splitting at the start of the new chromosone 
				x = chunk.splitlines(True)
				print("+"*20, x[0])
			else:
				# Otherwise save it to the previous chromosone
				
				
			#if chunk.startswith("chr"):
			#body.append(line)
				#print("Chr:", line)
			#else:
				#print("="*15, line)				
#f.writelines(desc)
#f.close()

#f = gzip.open("reformatted_Shetland_tr.vcf.gz", "at")
#f= open("reformatted_Shetland_tr.vcf", "a") 

#for x in range(len(body)):
	#sample = ''
	#body_m = ''
	#header_m= ''
	#sample = body[x].split("\t")
	#body_m= sample[9:]
	#header_m= sample[0:9]
	#string= ''.join([str(item) for item in header_m])
	#f.write("\n")
	#f.write(str(string))
	#for i in range(len(body_m)):
		#sample_2=''
		#sample_3=''
		#sample_4=''
		#sample_2 = body_m[i].split(":")
		#sample_3= sample_2[0]
		#sample_4 = sample_3.replace("/", "|")
		#f.write(str(sample_4))
		#f.write("\t")

#f.close()

#cmd1= 'gzip reformatted_Shetland_tr.vcf'
#subprocess.call(cmd1, shell=True)

#cmd2= 'gzip /exports/eddie/scratch/s2210624/Shetland.hg38.VQSR.VEP.vcf'
#subprocess.call(cmd2, shell=True)
#################################################################################################
