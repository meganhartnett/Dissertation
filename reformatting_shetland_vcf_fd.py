#!/usr/local/bin/python3
# Script to reformat the Shetland Island VCF file to conform to the 1000 Genomes VCF file format
# Writes description lines i.e lines starting with "#"
# Writes header lines i.e lines starting with "chr"
# Reformats the body i.e lines with 0/0:... to 0|0

# Load necessary modules
import gzip
import zipfile
import os, sys, subprocess
import time 


#start timer
start = time.perf_counter()
print(start)

# Open empty file for writing lines to
f= open("/exports/eddie/scratch/s2210624/reformatted_Shetland.vcf", "a")

# Open and read shetland VCF file
file= open("/exports/eddie/scratch/s2210624/Shetland.hg38.VQSR.VEP.vcf", "r")
for line in file:
	if line.startswith('#'):
		f.write(str(line))
	if line.startswith("chr"):
		sample = ''
		body_m = ''
		header_m= ''
		sample= line.split("\t")
		body_m= sample[9:]
		header_m= sample[0:9]
		string= '\t'.join([str(item) for item in header_m])
		f.write("\n")
		f.write(str(string))
		for i in range(len(body_m)):
			sample_2=''
			sample_3=''
			sample_4=''
			sample_2= body_m[i].split(":")
			sample_3= sample_2[0]
			sample_4= sample_3.replace("/", "|")
			f.write(str(sample_4))
			f.write("\t")

	
f.close()

finish = time.perf_counter()
print(finish)

timer= finish-start


print("time:", timer)

print(f"Finished in {round(finish-start, 2)} second(s)")

cmd1= 'gzip /exports/eddie/scratch/s2210624/reformatted_Shetland.vcf'
subprocess.call(cmd1, shell=True)

#cmd2= 'gzip /exports/eddie/scratch/s2210624/Shetland.hg38.VQSR.VEP.vcf'
#subprocess.call(cmd2, shell=True)

exit()
