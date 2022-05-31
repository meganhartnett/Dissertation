#!/usr/local/bin/python3
# Specifying a condition to split the lines of a chunk on
import gzip
def rows(f, chunksize=2000, sep='chr'):
	row=''
	chunk = f.read(chunksize)
	i= chunk.find(sep)
	while chunk != '':
		if i == -1:
			yield row + chunk[:i]
			chunk = chunk[:i]
			row= ''
		row += chunk
		if i != -1:
			yield row + chunk[:i]
			chunk = chunk[i+1:]
			row= ''
		row += chunk
	yield row

text_file=[]

with gzip.open("Shetland.hg38.VQSR.VEP.subset_2.vcf.gz", "r") as fd:
	for r in rows(fd):
		text_file.append(r)

print(text_file[4])
