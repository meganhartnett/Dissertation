#!/usr/bin/env Rscript 

# A script to produce the individual PCA plots
args <- commandArgs(trailingOnly=TRUE)

file <- args[1]
print(file)
fname <- args[2]
print(fname)
plotname <- args[3]

library(Matrix)
library(irlba)
library(ggfortify)

#p <- pipe("sed /^#/d $file  | cut -f '10-' | ./a.out | cut -f '1-2'")

#x <- read.table(p, colClasses=c("integer","integer"), fill=TRUE, row.names=NULL)

#chr1 <- sparseMatrix(i=x[,2], j=x[,1], x=1.0)
#print(dim(chr1))

#p = prcomp_irlba(chr1, n=2)
#print(summary(p))

#tiff(filename=paste(str(fname),".tiff"), units="in", width=8, height=8, res=300)
#autoplot(p, main=str(plotname), label=TRUE) +
#theme(plot.title = element_text(hjust = 0.5)) +
#geom_point(colour="blue")
#dev.off()
