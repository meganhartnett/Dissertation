#!/usr/local/bin/python3

import sys
import re
import gzip
import time


#start timer
#start = time.perf_counter()
#print(start)

file= gzip.open("SRR5293429_1.fastq.gz", "r")
f= open("tr_2_SRR5293429_1.fastq", "a")

print("FILES ARE OPENED")

for line in file:
	line_s = str( line, 'utf-8' )
	if line_s.startswith("ATC"):
		line_split= re.split(r'^ATCCAGCAG', line_s)
		line_new= line_split[1]
		line_new_new= line_new[2:26]
		f.write(str(line_new_new))
		f.write("\n")
		
	else:
		f.write(line_s)
		f.write("\n")
f.close()
print("done")

#finish = time.perf_counter()
#print(f"Finished in {round(finish-start, 2)} second(s)")
